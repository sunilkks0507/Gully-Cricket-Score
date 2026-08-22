import 'dart:async';

import 'package:cricket_scoring/application/auth_providers.dart';
import 'package:cricket_scoring/data/auth/app_user.dart';
import 'package:cricket_scoring/data/auth/auth_exception.dart';
import 'package:cricket_scoring/data/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'fake_auth_service.dart';

void main() {
  late FakeAuthService auth;
  late ProviderContainer container;

  ProviderContainer makeContainer(AuthService service) {
    final c = ProviderContainer(
      overrides: [authServiceProvider.overrideWithValue(service)],
    );
    addTearDown(c.dispose);
    return c;
  }

  setUp(() {
    auth = FakeAuthService();
    addTearDown(auth.dispose);
    container = makeContainer(auth);
  });

  test('starts signed out when no one has signed in', () async {
    // Keep the stream alive while we await it.
    final sub = container.listen(authStateProvider, (_, _) {});
    addTearDown(sub.close);

    await container.read(authStateProvider.future);
    expect(container.read(currentUserProvider), isNull);
    expect(container.read(isSignedInProvider), isFalse);
  });

  test('picks up a user pushed by the backend', () async {
    final sub = container.listen(authStateProvider, (_, _) {});
    addTearDown(sub.close);
    await container.read(authStateProvider.future);

    const user = AppUser(uid: 'u1', displayName: 'Rohit');
    auth.emit(user);
    await pumpEventQueue();

    expect(container.read(currentUserProvider), user);
    expect(container.read(isSignedInProvider), isTrue);
  });

  group('AuthController', () {
    test('signInWithGoogle drives the service and ends in AsyncData', () async {
      final sub = container.listen(authStateProvider, (_, _) {});
      addTearDown(sub.close);
      await container.read(authStateProvider.future);

      await container.read(authControllerProvider.notifier).signInWithGoogle();
      await pumpEventQueue();

      expect(auth.signInCalls, 1);
      expect(container.read(authControllerProvider), isA<AsyncData<void>>());
      expect(container.read(isSignedInProvider), isTrue);
    });

    test('a failed sign-in surfaces as AsyncError, not a crash', () async {
      auth.failWith = AuthException.notConfigured;

      await container.read(authControllerProvider.notifier).signInWithGoogle();

      final state = container.read(authControllerProvider);
      expect(state, isA<AsyncError<void>>());
      expect('${state.error}', contains('not configured'));
      // Failing to sign in must not pretend we are signed in.
      expect(container.read(isSignedInProvider), isFalse);
    });

    test(
      'is loading while the flow is in flight, and ignores double taps',
      () async {
        auth.gate = Completer<void>();
        final notifier = container.read(authControllerProvider.notifier);

        final first = notifier.signInWithGoogle();
        await pumpEventQueue();
        expect(container.read(authControllerProvider).isLoading, isTrue);

        // Second tap while the picker is open must not start another flow.
        await notifier.signInWithGoogle();
        expect(auth.signInCalls, 1);

        auth.gate!.complete();
        await first;
        expect(container.read(authControllerProvider), isA<AsyncData<void>>());
      },
    );

    test('signOut calls through', () async {
      await container.read(authControllerProvider.notifier).signOut();
      expect(auth.signOutCalls, 1);
      expect(container.read(authControllerProvider), isA<AsyncData<void>>());
    });
  });

  test('mock service: providers read from whatever AuthService is bound', () {
    final mock = MockAuthService();
    when(
      () => mock.authStateChanges(),
    ).thenAnswer((_) => Stream<AppUser?>.value(const AppUser(uid: 'mocked')));
    final c = makeContainer(mock);
    final sub = c.listen(authStateProvider, (_, _) {});
    addTearDown(sub.close);

    verify(() => mock.authStateChanges()).called(1);
  });
}
