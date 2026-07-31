import 'package:cricket_scoring/application/providers.dart';
import 'package:cricket_scoring/data/db/app_db.dart';
import 'package:cricket_scoring/data/repositories/match_repository.dart';
import 'package:cricket_scoring/engine/projections.dart';
import 'package:cricket_scoring/features/scorecard/scorecard_screen.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// End-to-end check that a finished match shows TEAM NAMES, never raw uuids,
/// through the real repository (uuid team ids, exactly as the app creates them).
void main() {
  late AppDb db;
  late MatchRepository repo;

  setUp(() {
    db = AppDb(NativeDatabase.memory());
    repo = MatchRepository(db);
  });
  tearDown(() => db.close());

  /// Plays a 1-over match that the chasing side wins, returning the session.
  Future<MatchSession> playCompletedMatch() async {
    final teamRepo = db.teamDao;
    // Real uuid-ish ids, like TeamRepository.createTeam produces.
    const teamA = 'e6f1c2d4-aaaa-4bbb-8ccc-111111111111';
    const teamB = 'e6f1c2d4-bbbb-4ccc-8ddd-222222222222';
    await teamRepo.upsertTeam(
      TeamsCompanion.insert(
        id: teamA,
        name: 'Strikers',
        createdAt: DateTime.now(),
      ),
    );
    await teamRepo.upsertTeam(
      TeamsCompanion.insert(
        id: teamB,
        name: 'Chargers',
        createdAt: DateTime.now(),
      ),
    );
    for (final p in ['a1', 'a2', 'b1', 'b2']) {
      await db.playerDao.upsertPlayer(
        PlayersCompanion.insert(
          id: p,
          name: 'Player $p',
          createdAt: DateTime.now(),
        ),
      );
    }

    final matchId = await repo.startMatch(
      MatchSetupData(
        rules: const MatchRules(
          presetId: 'box_cricket',
          oversPerInnings: 1,
          playersPerSide: 2,
          maxOversPerBowler: 5,
          lbwEnabled: false,
        ),
        matchType: MatchType.standalone,
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

    Future<void> bowl(int runs, {int innings = 0}) async {
      final state = await repo.loadState(matchId);
      final inn = state.activeInnings!;
      await repo.appendEvent(
        matchId,
        GameEvent.ball(
          BallEvent(
            inningsIndex: innings,
            strikerId: inn.strikerId!,
            nonStrikerId: inn.nonStrikerId!,
            bowlerId: inn.bowlerId!,
            runsOffBat: runs,
          ),
        ),
      );
    }

    // Innings 1: Strikers make 2 off the over.
    await bowl(2);
    for (var i = 0; i < 5; i++) {
      await bowl(0);
    }

    // Innings 2: Chargers chase it down.
    await repo.appendEvent(
      matchId,
      const GameEvent.inningsStarted(
        inningsIndex: 1,
        battingTeamId: teamB,
        bowlingTeamId: teamA,
        strikerId: 'b1',
        nonStrikerId: 'b2',
        bowlerId: 'a1',
      ),
    );
    await bowl(4, innings: 1); // passes the target

    return repo.loadSession(matchId);
  }

  test('result text names the winning team (no raw id)', () async {
    final session = await playCompletedMatch();
    expect(session.state.status, MatchStatus.completed);

    final text = Projections.resultText(
      session.state.result,
      session.teamNameOf,
    );
    expect(text, contains('Chargers'));
    expect(text, isNot(contains('-')), reason: 'no uuid fragments');
    expect(text, 'Chargers won by 1 wicket');
  });

  test('session resolves both team names', () async {
    final session = await playCompletedMatch();
    expect(session.teamNames.values, containsAll(['Strikers', 'Chargers']));
  });

  testWidgets('scorecard header shows team names, not ids', (tester) async {
    final session = await playCompletedMatch();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDbProvider.overrideWithValue(db)],
        child: MaterialApp(home: ScorecardScreen(matchId: session.matchId)),
      ),
    );
    await tester.pumpAndSettle();

    // Innings 1 tab: batting team name in the header, plus the result line.
    expect(find.textContaining('Strikers'), findsWidgets);
    expect(find.textContaining('Chargers won by'), findsOneWidget);
    // Nothing on screen should contain a uuid.
    final texts = tester
        .widgetList<Text>(find.byType(Text))
        .map((t) => t.data ?? '')
        .toList();
    expect(
      texts.where((t) => t.contains('e6f1c2d4')),
      isEmpty,
      reason: 'raw team uuid leaked into the UI',
    );
  });
}
