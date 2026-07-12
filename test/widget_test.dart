import 'package:cricket_scoring/app/app.dart';
import 'package:cricket_scoring/application/providers.dart';
import 'package:cricket_scoring/data/db/app_db.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App boots to the CricScore home', (WidgetTester tester) async {
    final db = AppDb(NativeDatabase.memory());
    addTearDown(db.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDbProvider.overrideWithValue(db)],
        child: const CricketScoringApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('CricScore'), findsWidgets);
    expect(find.text('New Match'), findsOneWidget);
    expect(find.byIcon(Icons.sports_cricket), findsWidgets);
  });
}
