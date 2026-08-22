import 'dart:async';

import 'package:cricket_scoring/data/auth/app_user.dart';
import 'package:cricket_scoring/data/auth/auth_exception.dart';
import 'package:cricket_scoring/data/auth/auth_service.dart';
import 'package:mocktail/mocktail.dart';

/// A scriptable [AuthService] so no test ever needs a Firebase connection.
///
/// Behaves like the real thing in the way that matters: the auth-state stream
/// is broadcast, replays the current user to late listeners, and emits on every
/// sign-in/sign-out.
class FakeAuthService implements AuthService {
  FakeAuthService({AppUser? initialUser}) : _user = initialUser;

  final _controller = StreamController<AppUser?>.broadcast();
  AppUser? _user;

  /// When set, [signInWithGoogle] throws this instead of succeeding.
  AuthException? failWith;

  /// Completer used to hold a sign-in "in flight" so tests can assert on the
  /// loading state before resolving it.
  Completer<void>? gate;

  int signInCalls = 0;
  int signOutCalls = 0;

  @override
  AppUser? get currentUser => _user;

  @override
  Stream<AppUser?> authStateChanges() {
    // Stream.multi (not async*) so the subscription to [_controller] is in
    // place synchronously at listen time — otherwise an `emit` immediately
    // after listening could slip through the gap and the test would race.
    return Stream<AppUser?>.multi((controller) {
      controller.add(_user);
      final sub = _controller.stream.listen(
        controller.add,
        onError: controller.addError,
        onDone: controller.close,
      );
      controller.onCancel = sub.cancel;
    });
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    signInCalls++;
    if (gate != null) await gate!.future;
    final failure = failWith;
    if (failure != null) throw failure;
    final user = _user ?? const AppUser(uid: 'u1', displayName: 'Test Scorer');
    emit(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    signOutCalls++;
    emit(null);
  }

  /// Pushes a new auth state, as a real backend would.
  void emit(AppUser? user) {
    _user = user;
    _controller.add(user);
  }

  Future<void> dispose() => _controller.close();
}

/// mocktail double for the cases where verifying calls is clearer than
/// scripting behaviour.
class MockAuthService extends Mock implements AuthService {}
