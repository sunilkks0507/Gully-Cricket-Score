import 'package:cricket_scoring/application/providers.dart';
import 'package:cricket_scoring/data/db/app_db.dart';
import 'package:cricket_scoring/data/repositories/match_repository.dart';
import 'package:cricket_scoring/features/live_scoring/live_scoring_screen.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// The next batter must be picked while anyone is still waiting, and an end
/// left empty can be filled from the live screen.
void main() {
  late AppDb db;
  late MatchRepository repo;
  late String matchId;

  setUp(() async {
    db = AppDb(NativeDatabase.memory());
    repo = MatchRepository(db);
    for (final p in ['a1', 'a2', 'a3', 'a4', 'b1', 'b2']) {
      await db.playerDao.upsertPlayer(
        PlayersCompanion.insert(
          id: p,
          name: 'P ${p.toUpperCase()}',
          createdAt: DateTime.now(),
        ),
      );
    }
    for (final t in ['teamA', 'teamB']) {
      await db.teamDao.upsertTeam(
        TeamsCompanion.insert(id: t, name: t, createdAt: DateTime.now()),
      );
    }
    matchId = await repo.startMatch(
      const MatchSetupData(
        rules: MatchRules(
          oversPerInnings: 5,
          playersPerSide: 4,
          maxOversPerBowler: 5,
          lbwEnabled: false,
          lastManStands: true,
        ),
        matchType: MatchType.standalone,
        teamAId: 'teamA',
        teamBId: 'teamB',
        xiA: ['a1', 'a2', 'a3', 'a4'],
        xiB: ['b1', 'b2'],
        battingFirstTeamId: 'teamA',
        strikerId: 'a1',
        nonStrikerId: 'a2',
        openingBowlerId: 'b1',
      ),
    );
  });

  tearDown(() => db.close());

  Future<void> pumpScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDbProvider.overrideWithValue(db)],
        child: MaterialApp(home: LiveScoringScreen(matchId: matchId)),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('wicket cannot be confirmed until the next batter is picked', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tester.tap(find.text('W'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('bowled'));
    await tester.pumpAndSettle();

    final confirm = find.widgetWithText(FilledButton, 'Confirm dismissal');
    await tester.ensureVisible(confirm);
    expect(tester.widget<FilledButton>(confirm).onPressed, isNull);

    await tester.tap(find.text('Next batter in'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('P A3').last);
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(confirm).onPressed, isNotNull);

    await tester.tap(confirm);
    await tester.pumpAndSettle();
    final inn = (await repo.loadState(matchId)).activeInnings!;
    expect(inn.strikerId, 'a3');
    expect(inn.nonStrikerId, 'a2');
  });

  testWidgets('an empty end can be filled with "Bring in batter"', (
    tester,
  ) async {
    // Last-man-stands off, and a wicket recorded without a next batter.
    await repo.appendEvent(
      matchId,
      const GameEvent.rulesChanged(
        rules: MatchRules(
          oversPerInnings: 5,
          playersPerSide: 4,
          maxOversPerBowler: 5,
          lbwEnabled: false,
        ),
      ),
    );
    await repo.appendEvent(
      matchId,
      const GameEvent.ball(
        BallEvent(
          inningsIndex: 0,
          strikerId: 'a1',
          nonStrikerId: 'a2',
          bowlerId: 'b1',
          wicket: Wicket(type: DismissalType.bowled, outBatterId: 'a1'),
        ),
      ),
    );
    await pumpScreen(tester);

    expect(find.text('An end is empty.'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Bring in batter'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Batter coming in'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('P A4').last);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Bring in batter').last);
    await tester.pumpAndSettle();

    final inn = (await repo.loadState(matchId)).activeInnings!;
    expect(inn.strikerId, 'a4');
    expect(inn.nonStrikerId, 'a2');
    expect(inn.batters['a2']!.isRetiredNotOut, isFalse);
    expect(find.text('An end is empty.'), findsNothing);
  });
}
