import 'package:drift/drift.dart';

import '../../models/enums.dart';
import 'app_db.dart';
import 'tables.dart';

part 'match_dao.g.dart';

@DriftAccessor(tables: [Matches, MatchPlayers])
class MatchDao extends DatabaseAccessor<AppDb> with _$MatchDaoMixin {
  MatchDao(super.db);

  Future<void> upsertMatch(MatchesCompanion match) =>
      into(matches).insertOnConflictUpdate(match);

  Future<MatchRow?> getMatch(String id) =>
      (select(matches)..where((m) => m.id.equals(id))).getSingleOrNull();

  /// Matches, most recent first.
  Future<List<MatchRow>> allMatches() =>
      (select(matches)..orderBy([
            (m) =>
                OrderingTerm(expression: m.dateLocal, mode: OrderingMode.desc),
          ]))
          .get();

  /// The in-progress match to resume on app start, if any.
  Future<MatchRow?> firstInProgress() =>
      (select(matches)
            ..where((m) => m.status.equalsValue(MatchStatus.inProgress)))
          .getSingleOrNull();

  Future<void> addMatchPlayer(MatchPlayersCompanion player) =>
      into(matchPlayers).insertOnConflictUpdate(player);

  Future<List<MatchPlayer>> playingXi(String matchId) =>
      (select(matchPlayers)..where((mp) => mp.matchId.equals(matchId))).get();

  /// Update just the derived status/result of a match (after applying an event).
  Future<void> updateStatusResult(
    String id,
    MatchStatus status,
    String? resultJson,
  ) => (update(matches)..where((m) => m.id.equals(id))).write(
    MatchesCompanion(
      status: Value(status),
      resultJson: Value(resultJson),
      updatedAt: Value(DateTime.now()),
    ),
  );

  /// All completed matches (for stats / tournament aggregation).
  Future<List<MatchRow>> completedMatches() => (select(
    matches,
  )..where((m) => m.status.equalsValue(MatchStatus.completed))).get();

  /// Completed matches for one tournament.
  Future<List<MatchRow>> completedForTournament(String tournamentId) =>
      (select(matches)..where(
            (m) =>
                m.tournamentId.equals(tournamentId) &
                m.status.equalsValue(MatchStatus.completed),
          ))
          .get();

  Future<void> deleteMatch(String id) async {
    await (delete(matchPlayers)..where((mp) => mp.matchId.equals(id))).go();
    await (delete(matches)..where((m) => m.id.equals(id))).go();
  }
}
