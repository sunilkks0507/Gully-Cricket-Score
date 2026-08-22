import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/auth_providers.dart';
import '../../data/auth/app_user.dart';
import 'sign_in_screen.dart';

/// The "Account" block for the Settings list.
///
/// Deliberately a standalone widget rather than an edit to `SettingsScreen`:
/// Phase A must stay additive, so the settings screen can adopt this by
/// dropping `const AccountSection()` into its `ListView` children (between the
/// Data and About sections) whenever we are ready — one line, no other change.
///
/// It renders a `Column` of `ListTile`s with no scrolling of its own, so it
/// composes inside an existing `ListView`.
class AccountSection extends ConsumerWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authStateProvider);
    final action = ref.watch(authControllerProvider);
    final user = authState.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Account',
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        if (authState.isLoading && user == null)
          const ListTile(
            leading: SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            title: Text('Checking sign-in…'),
          )
        else if (user == null)
          ListTile(
            leading: const Icon(Icons.cloud_off_outlined),
            title: const Text('Not signed in'),
            subtitle: const Text(
              'Matches stay on this device. Sign in to share with your club.',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openSignIn(context),
          )
        else ...[
          ListTile(
            leading: _Avatar(user: user),
            title: Text(user.label),
            subtitle: Text(user.email ?? 'Signed in'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            subtitle: const Text('Your on-device data is kept.'),
            enabled: !action.isLoading,
            onTap: () => ref.read(authControllerProvider.notifier).signOut(),
          ),
        ],
        if (action.hasError)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              '${action.error}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }

  /// Pushed with a plain [MaterialPageRoute] rather than a named go_router
  /// route, so this widget works without touching `lib/app/router.dart`.
  void _openSignIn(BuildContext context) => Navigator.of(
    context,
  ).push(MaterialPageRoute<void>(builder: (_) => const SignInScreen()));
}

/// Google profile photo when we have one, initials otherwise. Falls back to
/// initials if the image cannot be fetched (offline is the normal case here).
class _Avatar extends StatelessWidget {
  const _Avatar({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final photo = user.photoUrl;
    return CircleAvatar(
      foregroundImage: photo == null ? null : NetworkImage(photo),
      onForegroundImageError: photo == null ? null : (_, _) {},
      child: Text(user.initials),
    );
  }
}
