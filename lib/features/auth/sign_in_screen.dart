import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/auth_providers.dart';

/// Optional Google sign-in (Phase A of `docs/12-cloud-sync-plan.md`).
///
/// Signing in is never required: CricScore scores, saves and shows history with
/// no account at all. This screen exists only so a scorer can *opt in* to the
/// cloud layer, so the copy leads with that and the escape hatch is always one
/// tap away.
///
/// Not wired into `lib/app/router.dart` yet — it is pushed directly by
/// [AccountSection] so Phase A stays additive. Add a `/sign-in` route when the
/// group/invite flows in Phase B need to deep-link to it.
class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);
    final action = ref.watch(authControllerProvider);
    final busy = action.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Cloud sync')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    user == null ? Icons.cloud_outlined : Icons.cloud_done,
                    size: 64,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    user == null ? 'Sign in to share' : 'Signed in',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user == null
                        ? 'An account lets you share players, teams and live '
                              'matches with your club. Scoring works offline '
                              'either way — you can skip this.'
                        : 'You are signed in as ${user.label}. Your matches '
                              'stay on this device until you add them to a '
                              'group.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  if (user == null)
                    FilledButton.icon(
                      onPressed: busy
                          ? null
                          : () => ref
                                .read(authControllerProvider.notifier)
                                .signInWithGoogle(),
                      icon: busy
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.login),
                      label: Text(
                        busy ? 'Signing in…' : 'Continue with Google',
                      ),
                    )
                  else
                    OutlinedButton.icon(
                      onPressed: busy
                          ? null
                          : () => ref
                                .read(authControllerProvider.notifier)
                                .signOut(),
                      icon: const Icon(Icons.logout),
                      label: const Text('Sign out'),
                    ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: Text(
                      user == null ? 'Continue without an account' : 'Done',
                    ),
                  ),
                  if (action.hasError) ...[
                    const SizedBox(height: 16),
                    _AuthErrorBanner(message: '${action.error}'),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Shows the already-friendly `AuthException.message` (its `toString` is the
/// message), so no error mapping happens in the widget layer.
class _AuthErrorBanner extends StatelessWidget {
  const _AuthErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: scheme.onErrorContainer, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: scheme.onErrorContainer),
            ),
          ),
        ],
      ),
    );
  }
}
