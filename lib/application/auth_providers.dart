import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth/app_user.dart';
import '../data/auth/auth_service.dart';
import '../data/auth/firebase_auth_service.dart';

/// The cloud-identity backend (Phase A of `docs/12-cloud-sync-plan.md`).
///
/// Kept behind a provider so tests — and any future "cloud disabled" build —
/// can swap in a different [AuthService] without touching a single widget.
final authServiceProvider = Provider<AuthService>(
  (ref) => FirebaseAuthService(),
);

/// Live sign-in state.
///
/// "Signed out" and "Firebase is not configured in this build" both surface as
/// `AsyncData(null)`, deliberately: the app is offline-first, so the UI has one
/// code path for "no account" and never treats it as an error.
final authStateProvider = StreamProvider<AppUser?>(
  (ref) => ref.watch(authServiceProvider).authStateChanges(),
);

/// The signed-in user, or `null` while loading / signed out.
///
/// Riverpod 3 dropped `AsyncValue.valueOrNull`; `.value` is the nullable
/// accessor now.
final currentUserProvider = Provider<AppUser?>(
  (ref) => ref.watch(authStateProvider).value,
);

/// Convenience gate for widgets that only care whether an account is attached.
final isSignedInProvider = Provider<bool>(
  (ref) => ref.watch(currentUserProvider) != null,
);

/// Drives the sign-in / sign-out buttons.
///
/// Separate from [authStateProvider] on purpose: that one answers "who is
/// signed in", this one answers "is an action in flight, and did it fail".
/// Keeping them apart means a failed sign-in never blanks out a session that is
/// actually still valid.
class AuthController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> signInWithGoogle() =>
      _run(() => ref.read(authServiceProvider).signInWithGoogle());

  Future<void> signOut() => _run(() => ref.read(authServiceProvider).signOut());

  /// Runs [action], mapping it onto loading/data/error. Re-entrant taps are
  /// swallowed so a double-tap cannot open two Google account pickers.
  Future<void> _run(Future<void> Function() action) async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    try {
      await action();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError<void>(e, st);
    }
  }
}

final authControllerProvider =
    NotifierProvider<AuthController, AsyncValue<void>>(AuthController.new);
