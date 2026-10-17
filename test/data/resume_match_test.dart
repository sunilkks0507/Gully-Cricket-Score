import 'package:cricket_scoring/data/db/app_db.dart';
import 'package:cricket_scoring/data/repositories/match_repository.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// The home screen's "Resume" lookup.
void main() {
  late AppDb db;
  late MatchRepository repo;

  setUp(() {
    db = AppDb(NativeDatabase.memory());
    repo = MatchRepository(db);
  });
  tearDown(() => db.close());

  Future<String> start() => repo.startMatch(
    const MatchSetupData(
      rules: MatchRules(oversPerInnings: 2, playersPerSide: 2),
      matchType: MatchType.standalone,
      teamAId: 'A',
      teamBId: 'B',
      xiA: ['a1', 'a2'],
      xiB: ['b1', 'b2'],
      battingFirstTeamId: 'A',
      strikerId: 'a1',
      nonStrikerId: 'a2',
      openingBowlerId: 'b1',
    ),
  );

  test('several open matches resolve to the most recent one', () async {
    await start();
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    final latest = await start();
    expect((await repo.inProgressMatch())!.id, latest);
  });

  test('a match at the innings break can be resumed', () async {
    final id = await start();
    await repo.appendEvent(id, const GameEvent.endInnings(inningsIndex: 0));
    final m = await repo.inProgressMatch();
    expect(m!.id, id);
    expect(m.status, MatchStatus.inningsBreak);
  });

  test('a completed match is not offered', () async {
    final id = await start();
    await repo.appendEvent(id, const GameEvent.endInnings(inningsIndex: 0));
    await repo.appendEvent(
      id,
      const GameEvent.inningsStarted(
        inningsIndex: 1,
        battingTeamId: 'B',
        bowlingTeamId: 'A',
        strikerId: 'b1',
        nonStrikerId: 'b2',
        bowlerId: 'a1',
      ),
    );
    await repo.appendEvent(id, const GameEvent.endInnings(inningsIndex: 1));
    expect(await repo.inProgressMatch(), isNull);
  });
}
