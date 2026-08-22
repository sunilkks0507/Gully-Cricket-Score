import 'package:cricket_scoring/application/auth_providers.dart';
import 'package:cricket_scoring/data/auth/app_user.dart';
import 'package:cricket_scoring/features/auth/account_section.dart';
import 'package:cricket_scoring/features/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_auth_service.dart';

void main() {
  late FakeAuthService auth;

  setUp(() {
    auth = FakeAuthService();
    addTearDown(auth.dispose);
  });

  // Mirrors how SettingsScreen would embed it: inside an existing ListView.
  Future<void> pumpInSettingsList(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authServiceProvider.overrideWithValue(auth)],
        child: MaterialApp(
          home: Scaffold(body: ListView(children: const [AccountSection()])),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('signed out: invites sign-in without blocking local use', (
    tester,
  ) async {
    await pumpInSettingsList(tester);

    expect(find.text('Account'), findsOneWidget);
    expect(find.text('Not signed in'), findsOneWidget);
    expect(find.textContaining('Matches stay on this device'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping the tile opens the sign-in screen', (tester) async {
    await pumpInSettingsList(tester);

    await tester.tap(find.text('Not signed in'));
    await tester.pumpAndSettle();

    expect(find.byType(SignInScreen), findsOneWidget);
  });

  testWidgets('signed in: shows the account and signs out', (tester) async {
    auth = FakeAuthService(
      initialUser: const AppUser(
        uid: 'u1',
        displayName: 'Rohit Sharma',
        email: 'rohit@example.com',
      ),
    );
    addTearDown(auth.dispose);
    await pumpInSettingsList(tester);

    expect(find.text('Rohit Sharma'), findsOneWidget);
    expect(find.text('rohit@example.com'), findsOneWidget);

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();

    expect(auth.signOutCalls, 1);
    expect(find.text('Not signed in'), findsOneWidget);
  });

  testWidgets('renders inside a ListView without overflow', (tester) async {
    await pumpInSettingsList(tester);
    expect(tester.takeException(), isNull);
  });
}
