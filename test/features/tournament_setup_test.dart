import 'package:cricket_scoring/application/providers.dart';
import 'package:cricket_scoring/data/db/app_db.dart';
import 'package:cricket_scoring/data/repositories/match_repository.dart';
import 'package:cricket_scoring/data/repositories/team_repository.dart';
import 'package:cricket_scoring/data/repositories/tournament_repository.dart';
import 'package:cricket_scoring/features/match_setup/match_setup_screen.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Starting a fixture opens setup with both tournament teams and their saved
/// squads filled in.
void main() {
  testWidgets('fixture start pre-fills tournament teams and squads', (
    tester,
  ) async {
    final db = AppDb(NativeDatabase.memory());
    addTearDown(db.close);
    // Tall enough that the lazily-built ListView builds every section.
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    late String tId, lions, tigers;

    await tester.runAsync(() async {
      for (final p in ['Ann', 'Bob', 'Cat', 'Dan', 'Eve']) {
        await db.playerDao.upsertPlayer(
          PlayersCompanion.insert(id: p, name: p, createdAt: DateTime.now()),
        );
      }
      final teams = TeamRepository(db);
      lions = await teams.createTeam(name: 'Lions');
      tigers = await teams.createTeam(name: 'Tigers');
      await teams.setRoster(lions, ['Ann', 'Bob']);
      await teams.setRoster(tigers, ['Cat', 'Dan']);
      tId = await TournamentRepository(db, MatchRepository(db))
          .createTournament(
            name: 'Cup',
            format: TournamentFormat.roundRobin,
            rules: const MatchRules(),
            teamIds: [lions, tigers],
          );
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDbProvider.overrideWithValue(db)],
        child: MaterialApp(
          home: MatchSetupScreen(
            tournamentId: tId,
            teamAId: lions,
            teamBId: tigers,
          ),
        ),
      ),
    );
    for (var i = 0; i < 5; i++) {
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      await tester.pumpAndSettle();
    }

    expect(find.text('Tournament team'), findsNWidgets(2));
    expect(find.text('Lions'), findsWidgets);
    expect(find.text('Tigers'), findsWidgets);

    bool selected(String name, int section) => tester
        .widgetList<FilterChip>(find.widgetWithText(FilterChip, name))
        .elementAt(section)
        .selected;
    // Each name appears once in Team A's picker and once in Team B's.
    expect(selected('Ann', 0), isTrue);
    expect(selected('Bob', 0), isTrue);
    expect(selected('Cat', 0), isFalse);
    expect(selected('Cat', 1), isTrue);
    expect(selected('Dan', 1), isTrue);
    expect(selected('Eve', 1), isFalse);
  });
}
