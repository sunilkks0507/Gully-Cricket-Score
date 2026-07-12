import 'dart:convert';

import 'package:cricket_scoring/data/db/app_db.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDb db;

  setUp(() => db = AppDb(NativeDatabase.memory()));
  tearDown(() => db.close());

  DateTime ts(int s) => DateTime.utc(2026, 7, 12, 15, 0, s);

  Future<void> seedMatch({String id = 'm1', String? tournamentId}) async {
    await db.playerDao.upsertPlayer(
      PlayersCompanion.insert(id: 'p1', name: 'Rohit', createdAt: ts(0)),
    );
    await db.teamDao.upsertTeam(
      TeamsCompanion.insert(id: 'teamA', name: 'Strikers', createdAt: ts(0)),
    );
    await db.matchDao.upsertMatch(
      MatchesCompanion.insert(
        id: id,
        format: 'box_cricket',
        rulesJson: jsonEncode(MatchPresets.boxCricket.toJson()),
        teamAId: 'teamA',
        teamBId: 'teamB',
        dateLocal: ts(0),
        createdAt: ts(0),
        updatedAt: ts(0),
        jokerPlayerId: const Value('p1'),
        matchType: Value(
          tournamentId == null ? MatchType.standalone : MatchType.tournament,
        ),
        tournamentId: Value(tournamentId),
      ),
    );
  }

  test(
    'insert and read Player, Team, Match (with joker & tournament)',
    () async {
      await seedMatch(tournamentId: 't1');

      expect((await db.playerDao.getPlayer('p1'))!.name, 'Rohit');
      expect((await db.teamDao.getTeam('teamA'))!.name, 'Strikers');

      final match = await db.matchDao.getMatch('m1');
      expect(match!.jokerPlayerId, 'p1');
      expect(match.matchType, MatchType.tournament);
      expect(match.tournamentId, 't1');
      // rulesJson deserialises back to the box-cricket rules.
      final rules = MatchRules.fromJson(
        jsonDecode(match.rulesJson) as Map<String, dynamic>,
      );
      expect(rules.lbwEnabled, isFalse);
    },
  );

  BallEvent ballOf(int runs) => BallEvent(
    inningsIndex: 0,
    strikerId: 'p1',
    nonStrikerId: 'p2',
    bowlerId: 'p11',
    runsOffBat: runs,
  );

  Future<void> appendBall(int runs) => db.eventDao.appendEvent(
    matchId: 'm1',
    type: 'ball',
    payloadJson: jsonEncode(ballOf(runs).toJson()),
  );

  test('events append in order and read back; payload -> BallEvent', () async {
    await seedMatch();
    await appendBall(1);
    await appendBall(4);
    await appendBall(6);

    final events = await db.eventDao.liveEvents('m1');
    expect(events.map((e) => e.seq), [1, 2, 3]);

    final restored = BallEvent.fromJson(
      jsonDecode(events.last.payloadJson) as Map<String, dynamic>,
    );
    expect(restored.runsOffBat, 6);

    final match = await db.matchDao.getMatch('m1');
    expect(match!.eventCursor, 3, reason: 'cursor advances with each append');
  });

  test('undo moves the cursor and hides the tail; redo restores it', () async {
    await seedMatch();
    await appendBall(1);
    await appendBall(4);
    await appendBall(6);

    final afterUndo = await db.eventDao.undo('m1');
    expect(afterUndo, 2);
    // Live events now exclude seq 3, though it still physically exists.
    expect((await db.eventDao.liveEvents('m1')).map((e) => e.seq), [1, 2]);
    expect((await db.eventDao.allEvents('m1')).length, 3);

    final afterRedo = await db.eventDao.redo('m1');
    expect(afterRedo, 3);
    expect((await db.eventDao.liveEvents('m1')).map((e) => e.seq), [1, 2, 3]);
  });

  test('appending after an undo drops the redo tail', () async {
    await seedMatch();
    await appendBall(1);
    await appendBall(4);
    await appendBall(6); // seq 3

    await db.eventDao.undo('m1'); // cursor -> 2
    await appendBall(2); // overwrites the tail: new seq 3, old seq-3 dropped

    final live = await db.eventDao.liveEvents('m1');
    expect(live.map((e) => e.seq), [1, 2, 3]);
    final last = BallEvent.fromJson(
      jsonDecode(live.last.payloadJson) as Map<String, dynamic>,
    );
    expect(last.runsOffBat, 2, reason: 'the 6 was overwritten by the new ball');
    expect(await db.eventDao.redo('m1'), isNull, reason: 'no tail to redo');
  });
}
