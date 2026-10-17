import 'package:cricket_scoring/data/db/app_db.dart';
import 'package:cricket_scoring/data/repositories/match_repository.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// The joker plays for both sides: both rosters must list them, and the side
/// batting first must be able to use them and be bowled out normally.
void main() {
  late AppDb db;
  late MatchRepository repo;

  setUp(() async {
    db = AppDb(NativeDatabase.memory());
    repo = MatchRepository(db);
    for (final p in ['a1', 'a2', 'b1', 'b2', 'j']) {
      await db.playerDao.upsertPlayer(
        PlayersCompanion.insert(id: p, name: p, createdAt: DateTime.now()),
      );
    }
    for (final t in ['A', 'B']) {
      await db.teamDao.upsertTeam(
        TeamsCompanion.insert(id: t, name: t, createdAt: DateTime.now()),
      );
    }
  });

  tearDown(() => db.close());

  Future<String> start({bool lastManStands = false}) => repo.startMatch(
    MatchSetupData(
      rules: MatchRules(
        oversPerInnings: 5,
        playersPerSide: 3,
        maxOversPerBowler: 5,
        jokerBatsBothSides: true,
        lastManStands: lastManStands,
      ),
      matchType: MatchType.standalone,
      teamAId: 'A',
      teamBId: 'B',
      xiA: const ['a1', 'a2', 'j'],
      xiB: const ['b1', 'b2', 'j'],
      battingFirstTeamId: 'A',
      strikerId: 'a1',
      nonStrikerId: 'a2',
      openingBowlerId: 'b1',
      jokerPlayerId: 'j',
    ),
  );

  Future<void> bowled(String matchId, String out, {String? next}) async {
    final inn = (await repo.loadState(matchId)).activeInnings!;
    await repo.appendEvent(
      matchId,
      GameEvent.ball(
        BallEvent(
          inningsIndex: 0,
          strikerId: inn.strikerId!,
          nonStrikerId: inn.nonStrikerId,
          bowlerId: inn.bowlerId!,
          wicket: Wicket(type: DismissalType.bowled, outBatterId: out),
          newBatterId: next,
        ),
      ),
    );
  }

  test('both rosters include the joker', () async {
    final id = await start();
    final rosters = await repo.rostersFor(id);
    expect(rosters['A'], ['a1', 'a2', 'j']);
    expect(rosters['B'], ['b1', 'b2', 'j']);
  });

  test(
    'matches saved the old way (joker under team B only) are repaired',
    () async {
      final id = await start();
      // Old behaviour: the joker's single row was overwritten to team B.
      await db.matchDao.addMatchPlayer(
        MatchPlayersCompanion.insert(
          matchId: id,
          teamId: 'B',
          playerId: 'j',
          battingOrder: const Value(2),
        ),
      );
      final rosters = await repo.rostersFor(id);
      expect(rosters['A'], contains('j'));
      expect(rosters['B'], contains('j'));
    },
  );

  test('team A can bat the joker and is bowled out normally', () async {
    final id = await start();
    await bowled(id, 'a1', next: 'j');
    var s = await repo.loadState(id);
    expect(s.activeInnings!.strikerId, 'j');
    await bowled(id, 'j');
    s = await repo.loadState(id);
    expect(s.status, MatchStatus.inningsBreak, reason: 'all out at 2 of 3');
  });

  test(
    'with last man stands the last of team A bats on, then is out',
    () async {
      final id = await start(lastManStands: true);
      await bowled(id, 'a1', next: 'j');
      await bowled(id, 'j');
      var s = await repo.loadState(id);
      expect(s.status, MatchStatus.inProgress);
      expect(s.activeInnings!.strikerId, 'a2');
      expect(s.activeInnings!.nonStrikerId, isNull);
      await bowled(id, 'a2');
      s = await repo.loadState(id);
      expect(s.status, MatchStatus.inningsBreak);
    },
  );
}
