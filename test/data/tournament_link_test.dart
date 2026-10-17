import 'package:cricket_scoring/data/db/app_db.dart';
import 'package:cricket_scoring/data/db/tables.dart';
import 'package:cricket_scoring/data/repositories/match_repository.dart';
import 'package:cricket_scoring/data/repositories/team_repository.dart';
import 'package:cricket_scoring/data/repositories/tournament_repository.dart';
import 'package:cricket_scoring/engine/tournament_math.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Tournament matches must count on the points table and link to fixtures.
void main() {
  late AppDb db;
  late MatchRepository matches;
  late TeamRepository teams;
  late TournamentRepository tournaments;
  late String tId;
  late String lions, tigers, bears;

  const rules = MatchRules(
    oversPerInnings: 1,
    playersPerSide: 2,
    maxOversPerBowler: 1,
  );

  setUp(() async {
    db = AppDb(NativeDatabase.memory());
    matches = MatchRepository(db);
    teams = TeamRepository(db);
    tournaments = TournamentRepository(db, matches);
    for (final p in ['a1', 'a2', 'b1', 'b2']) {
      await db.playerDao.upsertPlayer(
        PlayersCompanion.insert(id: p, name: p, createdAt: DateTime.now()),
      );
    }
    lions = await teams.createTeam(name: 'Lions');
    tigers = await teams.createTeam(name: 'Tigers');
    bears = await teams.createTeam(name: 'Bears');
    tId = await tournaments.createTournament(
      name: 'Cup',
      format: TournamentFormat.roundRobin,
      rules: rules,
      teamIds: [lions, tigers, bears],
    );
  });

  tearDown(() => db.close());

  Future<String> start(String teamA, String teamB, {String? tournament}) =>
      matches.startMatch(
        MatchSetupData(
          rules: rules,
          matchType: MatchType.tournament,
          tournamentId: tournament ?? tId,
          teamAId: teamA,
          teamBId: teamB,
          xiA: const ['a1', 'a2'],
          xiB: const ['b1', 'b2'],
          battingFirstTeamId: teamA,
          strikerId: 'a1',
          nonStrikerId: 'a2',
          openingBowlerId: 'b1',
        ),
      );

  /// Team A scores 4 off the first ball and closes; team B scores 0 and closes.
  Future<void> finish(String matchId, String teamA, String teamB) async {
    await matches.appendEvent(
      matchId,
      const GameEvent.ball(
        BallEvent(
          inningsIndex: 0,
          strikerId: 'a1',
          nonStrikerId: 'a2',
          bowlerId: 'b1',
          runsOffBat: 4,
        ),
      ),
    );
    await matches.appendEvent(
      matchId,
      const GameEvent.endInnings(inningsIndex: 0),
    );
    await matches.appendEvent(
      matchId,
      GameEvent.inningsStarted(
        inningsIndex: 1,
        battingTeamId: teamB,
        bowlingTeamId: teamA,
        strikerId: 'b1',
        nonStrikerId: 'b2',
        bowlerId: 'a1',
        battingSquadSize: 2,
      ),
    );
    await matches.appendEvent(
      matchId,
      const GameEvent.endInnings(inningsIndex: 1),
    );
  }

  Future<Fixture> fixtureFor(String a, String b) async =>
      (await tournaments.fixtures(tId)).singleWhere(
        (f) =>
            (f.teamAId == a && f.teamBId == b) ||
            (f.teamAId == b && f.teamBId == a),
      );

  test(
    'a tournament match links to its fixture and counts on the table',
    () async {
      final id = await start(lions, tigers);
      var f = await fixtureFor(lions, tigers);
      expect(f.matchId, id);
      expect(f.status, FixtureStatus.inProgress);

      await finish(id, lions, tigers);
      f = await fixtureFor(lions, tigers);
      expect(f.status, FixtureStatus.completed);

      final table = await tournaments.pointsTable(tId);
      final byTeam = {for (final r in table) r.teamId: r};
      expect(byTeam.keys, unorderedEquals([lions, tigers, bears]));
      expect(byTeam[lions]!.won, 1);
      expect(byTeam[lions]!.points, 2);
      expect(byTeam[tigers]!.lost, 1);
      expect(byTeam[bears]!.played, 0);
    },
  );

  test('undo reopens the fixture; deleting the match frees it', () async {
    final id = await start(tigers, lions); // reversed pairing still matches
    await finish(id, tigers, lions);
    await matches.undo(id);
    expect((await fixtureFor(lions, tigers)).status, FixtureStatus.inProgress);

    await matches.deleteMatch(id);
    final f = await fixtureFor(lions, tigers);
    expect(f.matchId, isNull);
    expect(f.status, FixtureStatus.scheduled);
  });

  test('older matches on throwaway teams count by team name', () async {
    // Before the fix, setup created fresh teams for every match.
    final oldLions = await teams.createTeam(name: 'lions ');
    final oldBears = await teams.createTeam(name: 'Bears');
    final id = await start(oldLions, oldBears);
    expect(
      (await fixtureFor(lions, bears)).matchId,
      isNull,
      reason: 'ids differ, so setup could not link it',
    );
    await finish(id, oldLions, oldBears);

    final table = await tournaments.pointsTable(tId);
    final byTeam = {for (final r in table) r.teamId: r};
    expect(byTeam.keys, unorderedEquals([lions, tigers, bears]));
    expect(byTeam[lions]!.won, 1);
    expect(byTeam[bears]!.lost, 1);

    await tournaments.linkLegacyMatches(tId);
    final f = await fixtureFor(lions, bears);
    expect(f.matchId, id);
    expect(f.status, FixtureStatus.completed);
  });

  test('NRR treats a short-handed side as all out by its real squad', () {
    // 6 players configured but only 3 batted: 2 wickets is all out.
    const r = MatchRules(oversPerInnings: 2, playersPerSide: 6);
    final state = MatchState(
      matchId: 'm',
      rules: r,
      status: MatchStatus.completed,
      innings1: const InningsState(
        battingTeamId: 'A',
        bowlingTeamId: 'B',
        totalRuns: 10,
        wickets: 2,
        legalBalls: 6,
        battingSquadSize: 3,
      ),
      innings2: const InningsState(
        battingTeamId: 'B',
        bowlingTeamId: 'A',
        totalRuns: 5,
        wickets: 1,
        legalBalls: 12,
        battingSquadSize: 6,
      ),
      result: const MatchResult(
        type: MatchResultType.winByRuns,
        winnerTeamId: 'A',
        summary: 'A won',
      ),
    );
    final cm = CompletedMatch.fromMatch(state)!;
    expect(cm.first.allOut, isTrue);
    expect(cm.first.oversForNrr, 2.0, reason: 'full allotment when all out');
    expect(cm.second.allOut, isFalse);
  });
}
