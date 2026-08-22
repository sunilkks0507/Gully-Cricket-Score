import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

import 'app_user.dart';
import 'auth_exception.dart';
import 'auth_service.dart';
import 'firebase_bootstrap.dart';

/// [AuthService] backed by Firebase Auth + Google Sign-In.
///
/// Every Firebase/Google type is confined to this file (hence the `fb.` prefix
/// — it makes a leak obvious at a glance). The rest of the app only ever sees
/// [AppUser] and [AuthException].
///
/// Graceful degradation is the important bit: while `flutterfire configure`
/// has not been run there is no Firebase app, so `fb.FirebaseAuth.instance`
/// would throw on first touch. We therefore never touch it unless
/// [isFirebaseInitialised] says an app exists — the service simply reports
/// "signed out", and sign-in fails with a readable message instead of crashing
/// a scorer mid-match.
class FirebaseAuthService implements AuthService {
  /// The optional arguments exist purely for tests; production uses the
  /// zero-argument form.
  FirebaseAuthService({
    fb.FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
    bool Function()? isFirebaseReady,
  }) : _injectedAuth = auth,
       _injectedGoogle = googleSignIn,
       _isFirebaseReady = isFirebaseReady ?? isFirebaseInitialised;

  final fb.FirebaseAuth? _injectedAuth;
  final GoogleSignIn? _injectedGoogle;
  final bool Function() _isFirebaseReady;

  bool _googleInitialised = false;

  /// `null` means "Firebase is not configured in this build".
  fb.FirebaseAuth? get _auth {
    final injected = _injectedAuth;
    if (injected != null) return injected;
    if (!_isFirebaseReady()) return null;
    return fb.FirebaseAuth.instance;
  }

  GoogleSignIn get _google => _injectedGoogle ?? GoogleSignIn.instance;

  @override
  Stream<AppUser?> authStateChanges() {
    final auth = _auth;
    // A single-value stream, not an empty one: the UI must settle on "signed
    // out" rather than spin forever on a loading state.
    if (auth == null) return Stream<AppUser?>.value(null);
    return auth.authStateChanges().map(_toAppUser);
  }

  @override
  AppUser? get currentUser => _toAppUser(_auth?.currentUser);

  @override
  Future<AppUser> signInWithGoogle() async {
    final auth = _auth;
    if (auth == null) throw AuthException.notConfigured;
    if (!_google.supportsAuthenticate()) {
      throw AuthException.unsupportedPlatform;
    }

    try {
      await _ensureGoogleInitialised();
      final account = await _google.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) {
        throw const AuthException(
          'Google did not return a sign-in token. Please try again.',
        );
      }
      // google_sign_in 7.x splits authentication from authorization: the ID
      // token alone is what Firebase needs to mint a session, and we request no
      // extra API scopes, so no access token is required here.
      final credential = fb.GoogleAuthProvider.credential(idToken: idToken);
      final result = await auth.signInWithCredential(credential);
      final user = _toAppUser(result.user);
      if (user == null) {
        throw const AuthException(
          'Sign-in did not complete. Please try again.',
        );
      }
      return user;
    } on GoogleSignInException catch (e) {
      throw _fromGoogle(e);
    } on fb.FirebaseAuthException catch (e) {
      throw _fromFirebase(e);
    } on AuthException {
      rethrow;
    } catch (_) {
      // Platform-channel / network noise: never let a raw error reach the UI.
      throw const AuthException(
        'Could not sign in right now. Check your connection and try again.',
      );
    }
  }

  @override
  Future<void> signOut() async {
    // Sign out of Google as well, otherwise the next sign-in silently reuses
    // the same account — which looks broken when the phone is handed over.
    try {
      await _google.signOut();
    } catch (_) {
      // Nothing to sign out of; not worth surfacing.
    }
    await _auth?.signOut();
  }

  Future<void> _ensureGoogleInitialised() async {
    if (_googleInitialised) return;
    // Picks up client ids from the platform config written by
    // `flutterfire configure` / the Google Sign-In setup; no arguments needed.
    await _google.initialize();
    _googleInitialised = true;
  }

  static AppUser? _toAppUser(fb.User? user) => user == null
      ? null
      : AppUser(
          uid: user.uid,
          displayName: user.displayName,
          email: user.email,
          photoUrl: user.photoURL,
        );

  static AuthException _fromGoogle(GoogleSignInException e) => switch (e.code) {
    GoogleSignInExceptionCode.canceled => AuthException.cancelled,
    GoogleSignInExceptionCode.clientConfigurationError ||
    GoogleSignInExceptionCode.providerConfigurationError =>
      AuthException.notConfigured,
    _ => const AuthException('Google sign-in failed. Please try again.'),
  };

  static AuthException _fromFirebase(fb.FirebaseAuthException e) =>
      switch (e.code) {
        'network-request-failed' => const AuthException(
          'No connection. CricScore keeps scoring offline — sign in later.',
        ),
        'account-exists-with-different-credential' => const AuthException(
          'That email is already linked to a different sign-in method.',
        ),
        'user-disabled' => const AuthException(
          'This account has been disabled.',
        ),
        _ => AuthException('Sign-in failed (${e.code}).'),
      };
}
