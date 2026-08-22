import 'package:cricket_scoring/data/auth/auth_exception.dart';
import 'package:cricket_scoring/data/auth/firebase_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // The whole point of Phase A: the app ships before `flutterfire configure`
  // has been run, so the auth stack must behave like "signed out" instead of
  // throwing when it touches FirebaseAuth.instance.
  group('FirebaseAuthService with Firebase not configured', () {
    FirebaseAuthService build() =>
        FirebaseAuthService(isFirebaseReady: () => false);

    test('reports no current user', () {
      expect(build().currentUser, isNull);
    });

    test('emits a single null so the UI settles on signed-out', () {
      expect(
        build().authStateChanges(),
        emitsInOrder(<Object?>[null, emitsDone]),
      );
    });

    test('signInWithGoogle throws a readable, non-crashing error', () async {
      await expectLater(
        build().signInWithGoogle(),
        throwsA(
          isA<AuthException>().having(
            (e) => e.message,
            'message',
            allOf(contains('not configured'), contains('offline')),
          ),
        ),
      );
    });

    test('signOut is a safe no-op', () async {
      // Must not throw even though there is nothing to sign out of; the Google
      // failure is swallowed inside the service.
      await expectLater(build().signOut(), completes);
    });
  });

  group('AuthException', () {
    test('toString is the user-facing message (widgets print it directly)', () {
      const e = AuthException('Boom.');
      expect('$e', 'Boom.');
    });
  });
}
