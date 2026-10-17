import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/auth_providers.dart';
import '../../application/group_providers.dart';

/// Settings entry for shared groups: shows where new data is saved and opens
/// the Groups screen. Hidden while signed out — groups need an account.
class GroupsSection extends ConsumerWidget {
  const GroupsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(isSignedInProvider)) return const SizedBox.shrink();
    final active = ref.watch(activeGroupProvider);
    return ListTile(
      leading: const Icon(Icons.groups_outlined),
      title: const Text('Sharing'),
      subtitle: Text(
        active == null
            ? 'Personal — this phone only'
            : 'Saving to ${active.group.name}',
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.pushNamed('groups'),
    );
  }
}
