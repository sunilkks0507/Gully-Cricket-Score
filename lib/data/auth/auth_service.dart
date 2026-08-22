import 'app_user.dart';

/// The whole surface the app has on cloud identity (Phase A of
/// `docs/12-cloud-sync-plan.md`).
///
/// It is an interface rather than a concrete class for two reasons:
///  * tests must never need a real Firebase connection — they bind a fake;
///  * ADR 0002 keeps cloud optional, so a build with no Firebase project can
///    bind an implementation that simply always reports "signed out".
abstract class AuthService {
  /// Emits the current user whenever it changes, and `null` when signed out.
  ///
  /// Implementations must emit at least once (an initial `null` is fine) so the
  /// UI never hangs on a perpetual loading state.
  Stream<AppUser?> authStateChanges();

  /// The user as of right now, or `null` when signed out. Synchronous so
  /// widgets can branch without awaiting.
  AppUser? get currentUser;

  /// Runs the interactive Google flow and returns the signed-in user.
  ///
  /// Throws [AuthException] — and only [AuthException] — on every failure,
  /// including "cloud sync is not configured yet" and user cancellation.
  Future<AppUser> signInWithGoogle();

  /// Signs out of both Firebase and Google. Safe to call when already signed
  /// out; local (on-device) data is never touched.
  Future<void> signOut();
}
