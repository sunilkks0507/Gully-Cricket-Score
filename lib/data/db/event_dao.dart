import 'package:drift/drift.dart';

import 'app_db.dart';
import 'tables.dart';

part 'event_dao.g.dart';

/// Accessor for the append-only event log. Undo/redo is a cursor on `seq`;
/// appending after an undo first deletes the redo tail (`seq > cursor`).
/// See docs/06-data-model.md §Persistence rules.
@DriftAccessor(tables: [Events, Matches])
class EventDao extends DatabaseAccessor<AppDb> with _$EventDaoMixin {
  EventDao(super.db);

  /// Append an event as the next seq for a match and advance its cursor, in one
  /// transaction (crash-safe autosave). Any redo tail (seq > cursor) is dropped
  /// first. Returns the new seq.
  Future<int> appendEvent({
    required String matchId,
    required String type,
    required String payloadJson,
    DateTime? at,
  }) {
    return transaction(() async {
      final match = await (select(
        matches,
      )..where((m) => m.id.equals(matchId))).getSingle();
      final cursor = match.eventCursor;

      // Drop any events beyond the cursor (redo tail invalidated by new action).
      await (delete(events)..where(
            (e) => e.matchId.equals(matchId) & e.seq.isBiggerThanValue(cursor),
          ))
          .go();

      final nextSeq = cursor + 1;
      await into(events).insert(
        EventsCompanion.insert(
          matchId: matchId,
          seq: nextSeq,
          type: type,
          payloadJson: payloadJson,
          createdAt: at ?? DateTime.now(),
        ),
      );
      await (update(matches)..where((m) => m.id.equals(matchId))).write(
        MatchesCompanion(
          eventCursor: Value(nextSeq),
          updatedAt: Value(at ?? DateTime.now()),
        ),
      );
      return nextSeq;
    });
  }

  /// The live events for a match (seq <= cursor), in order — fold these to
  /// rebuild [MatchState].
  Future<List<Event>> liveEvents(String matchId) async {
    final match = await (select(
      matches,
    )..where((m) => m.id.equals(matchId))).getSingle();
    return (select(events)
          ..where(
            (e) =>
                e.matchId.equals(matchId) &
                e.seq.isSmallerOrEqualValue(match.eventCursor),
          )
          ..orderBy([(e) => OrderingTerm(expression: e.seq)]))
        .get();
  }

  Future<void> deleteEventsForMatch(String matchId) =>
      (delete(events)..where((e) => e.matchId.equals(matchId))).go();

  /// All physically-stored events for a match (including any redo tail).
  Future<List<Event>> allEvents(String matchId) =>
      (select(events)
            ..where((e) => e.matchId.equals(matchId))
            ..orderBy([(e) => OrderingTerm(expression: e.seq)]))
          .get();

  /// Move the cursor back one (undo). Returns the new cursor, or null if already
  /// at the start.
  Future<int?> undo(String matchId) async {
    final match = await (select(
      matches,
    )..where((m) => m.id.equals(matchId))).getSingle();
    if (match.eventCursor <= 0) return null;
    final newCursor = match.eventCursor - 1;
    await (update(matches)..where((m) => m.id.equals(matchId))).write(
      MatchesCompanion(eventCursor: Value(newCursor)),
    );
    return newCursor;
  }

  /// Move the cursor forward one (redo) if a tail event exists. Returns the new
  /// cursor, or null if nothing to redo.
  Future<int?> redo(String matchId) async {
    final match = await (select(
      matches,
    )..where((m) => m.id.equals(matchId))).getSingle();
    final target = match.eventCursor + 1;
    final exists =
        await (select(events)
              ..where((e) => e.matchId.equals(matchId) & e.seq.equals(target)))
            .getSingleOrNull();
    if (exists == null) return null;
    await (update(matches)..where((m) => m.id.equals(matchId))).write(
      MatchesCompanion(eventCursor: Value(target)),
    );
    return target;
  }
}
