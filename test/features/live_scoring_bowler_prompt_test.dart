import 'package:cricket_scoring/application/providers.dart';
import 'package:cricket_scoring/data/db/app_db.dart';
import 'package:cricket_scoring/data/repositories/match_repository.dart';
import 'package:cricket_scoring/features/live_scoring/live_scoring_screen.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Integration test for the live screen's bowler handling:
/// when an over ends the picker must appear automatically (no hunting for a
/// button), and picking a bowler must persist so scoring can continue.
void main() {
  late AppDb db;
  late MatchRepository repo;
  late String matchId;

  setUp(() async {
    db = AppDb(NativeDatabase.memory());
    repo = MatchRepository(db);

    Future<void> addPlayer(String id, String name) => db.playerDao.upsertPlayer(
      PlayersCompanion.insert(id: id, name: name, createdAt: DateTime.now()),
    );
    for (final p in ['a1', 'a2', 'a3']) {
      await addPlayer(p, 'Bat ${p.substring(1)}');
    }
    for (final p in ['b1', 'b2', 'b3']) {
      await addPlayer(p, 'Bowl ${p.substring(1)}');
    }
    await db.teamDao.upsertTeam(
      TeamsCompanion.insert(
        id: 'teamA',
        name: 'Strikers',
        createdAt: DateTime.now(),
      ),
    );
    await db.teamDao.upsertTeam(
      TeamsCompanion.insert(
        id: 'teamB',
        name: 'Chargers',
        createdAt: DateTime.now(),
      ),
    );

    matchId = await repo.startMatch(
      MatchSetupData(
        rules: const MatchRules(
          presetId: 'box_cricket',
          oversPerInnings: 5,
          playersPerSide: 3,
          maxOversPerBowler: 5,
          lbwEnabled: false,
        ),
        matchType: MatchType.standalone,
        teamAId: 'teamA',
        teamBId: 'teamB',
        xiA: const ['a1', 'a2', 'a3'],
        xiB: const ['b1', 'b2', 'b3'],
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

  /// Bowl [count] dot balls straight through the repository.
  Future<void> bowlDots(int count) async {
    for (var i = 0; i < count; i++) {
      final state = await repo.loadState(matchId);
      final inn = state.activeInnings!;
      await repo.appendEvent(
        matchId,
        GameEvent.ball(
          BallEvent(
            inningsIndex: 0,
            strikerId: inn.strikerId!,
            nonStrikerId: inn.nonStrikerId!,
            bowlerId: inn.bowlerId!,
          ),
        ),
      );
    }
  }

  testWidgets('prompts for the next bowler automatically when an over ends', (
    tester,
  ) async {
    await bowlDots(6); // complete the over before opening the screen
    await pumpScreen(tester);

    // The picker dialog is shown without the user tapping anything.
    final dialog = find.byType(SimpleDialog);
    expect(dialog, findsOneWidget);

    // It overlays the live screen — the scorecard header is still visible
    // behind it, so the scorer never leaves the scoring screen.
    expect(find.byType(LiveScoringScreen), findsOneWidget);
    expect(find.text('0/0'), findsOneWidget, reason: 'live score still shown');
    expect(find.textContaining('This over'), findsOneWidget);
    expect(
      find.descendant(
        of: dialog,
        matching: find.text('Over complete — pick the next bowler'),
      ),
      findsOneWidget,
    );
    // The bowler who just bowled is not offered (no two overs in a row).
    expect(
      find.descendant(of: dialog, matching: find.text('Bowl 1')),
      findsNothing,
    );
    expect(
      find.descendant(of: dialog, matching: find.text('Bowl 2')),
      findsOneWidget,
    );

    // Choosing one persists it and returns to the scoring pad.
    await tester.tap(
      find.descendant(of: dialog, matching: find.text('Bowl 2')),
    );
    await tester.pumpAndSettle();
    expect(find.byType(SimpleDialog), findsNothing);

    final state = await repo.loadState(matchId);
    expect(state.activeInnings!.bowlerId, 'b2');
  });

  testWidgets('mid-over "Change bowler" swaps the bowler', (tester) async {
    await bowlDots(2); // mid-over
    await pumpScreen(tester);

    // No automatic prompt mid-over.
    expect(find.byType(SimpleDialog), findsNothing);

    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Change bowler').last);
    await tester.pumpAndSettle();

    final dialog = find.byType(SimpleDialog);
    expect(dialog, findsOneWidget);
    expect(
      find.descendant(of: dialog, matching: find.text('Change bowler')),
      findsOneWidget,
    );
    await tester.tap(
      find.descendant(of: dialog, matching: find.text('Bowl 3')),
    );
    await tester.pumpAndSettle();

    final state = await repo.loadState(matchId);
    expect(state.activeInnings!.bowlerId, 'b3');
    expect(
      state.activeInnings!.ballsThisOver,
      2,
      reason: 'same over continues',
    );
  });
}
