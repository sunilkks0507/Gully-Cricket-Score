import 'package:cricket_scoring/application/auth_providers.dart';
import 'package:cricket_scoring/data/auth/app_user.dart';
import 'package:cricket_scoring/data/auth/auth_exception.dart';
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

  Future<void> pumpScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authServiceProvider.overrideWithValue(auth)],
        child: const MaterialApp(home: SignInScreen()),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('signed out: offers Google and an opt-out', (tester) async {
    await pumpScreen(tester);

    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Continue without an account'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping Google runs the sign-in flow', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();

    expect(auth.signInCalls, 1);
    expect(find.textContaining('Signed in'), findsWidgets);
  });

  testWidgets('a failure is shown in plain language, screen stays alive', (
    tester,
  ) async {
    auth.failWith = AuthException.notConfigured;
    await pumpScreen(tester);

    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Cloud sync is not configured yet'),
      findsOneWidget,
    );
    // Still offering the button — the scorer can retry or walk away.
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('already signed in: shows the account and a sign-out', (
    tester,
  ) async {
    auth = FakeAuthService(
      initialUser: const AppUser(uid: 'u1', displayName: 'Rohit Sharma'),
    );
    addTearDown(auth.dispose);
    await pumpScreen(tester);

    expect(find.textContaining('Rohit Sharma'), findsOneWidget);
    expect(find.text('Sign out'), findsOneWidget);

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();

    expect(auth.signOutCalls, 1);
    expect(find.text('Continue with Google'), findsOneWidget);
  });
}
