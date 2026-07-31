import 'package:cricket_scoring/application/providers.dart';
import 'package:cricket_scoring/data/db/app_db.dart';
import 'package:cricket_scoring/features/players/players_screen.dart';
import 'package:cricket_scoring/models/enums.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Regression test: rendering a player who has a role used to crash with
  // NoSuchMethodError: 'name' because PlayerRole.name (an extension) was called
  // on a `dynamic` receiver. Casting to the enum type first fixes it.
  testWidgets('players list renders a player with a role without crashing', (
    tester,
  ) async {
    final db = AppDb(NativeDatabase.memory());
    addTearDown(db.close);
    await db.playerDao.upsertPlayer(
      PlayersCompanion.insert(
        id: 'p1',
        name: 'Rohit',
        role: const Value(PlayerRole.batter),
        jerseyNo: const Value(45),
        createdAt: DateTime.utc(2026, 7, 31),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDbProvider.overrideWithValue(db)],
        child: const MaterialApp(home: PlayersScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Rohit'), findsOneWidget);
    // subtitle shows "#45 · batter"
    expect(find.textContaining('batter'), findsOneWidget);
  });
}
