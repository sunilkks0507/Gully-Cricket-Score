/// A sign-in failure whose [message] is safe to show to a scorer verbatim.
///
/// The auth layer catches every Firebase/Google exception and re-throws one of
/// these, so the UI never has to know about `FirebaseAuthException` codes or
/// platform channel errors.
class AuthException implements Exception {
  const AuthException(this.message);

  /// User-facing, already phrased for a dialog or a snackbar.
  final String message;

  /// Thrown when the app was built before `flutterfire configure` was run, so
  /// there is no Firebase project to talk to. This is not a bug: CricScore is
  /// offline-first and stays fully usable in this state.
  static const notConfigured = AuthException(
    'Cloud sync is not configured yet. CricScore keeps working offline — '
    'sign-in switches on once this build is connected to Firebase.',
  );

  /// The scorer dismissed the Google account picker.
  static const cancelled = AuthException('Sign-in was cancelled.');

  /// Google Sign-In has no interactive flow on this platform (e.g. web needs a
  /// rendered button instead, desktop is unsupported).
  static const unsupportedPlatform = AuthException(
    'Google sign-in is not available on this device.',
  );

  @override
  String toString() => message;
}
