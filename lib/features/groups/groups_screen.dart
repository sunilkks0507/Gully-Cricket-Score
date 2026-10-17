import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/auth_providers.dart';
import '../../application/group_providers.dart';
import '../../data/cloud/cloud.dart';
import '../../data/groups/group_service.dart';

/// Shared groups: pick where new data is shared, create a group, or join one
/// with a code. "Personal" (this phone only) is always available.
class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final groups = ref.watch(myGroupsProvider);
    final activeId = ref.watch(activeGroupProvider)?.group.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Groups')),
      body: user == null
          ? const Center(child: Text('Sign in to share with a group.'))
          : RadioGroup<String>(
              groupValue: activeId ?? _personal,
              onChanged: (v) => ref
                  .read(activeGroupIdProvider.notifier)
                  .select(v == _personal ? null : v),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: Text(
                      'New players, teams and matches are saved to the '
                      'selected group.',
                    ),
                  ),
                  const RadioListTile<String>(
                    value: _personal,
                    title: Text('Personal'),
                    subtitle: Text('This phone only — never uploaded'),
                    secondary: Icon(Icons.phone_android),
                  ),
                  const Divider(),
                  ...groups.when(
                    loading: () => const [
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ],
                    error: (e, _) => [
                      ListTile(
                        leading: const Icon(Icons.cloud_off),
                        title: const Text("Couldn't load your groups"),
                        subtitle: Text('$e'),
                      ),
                    ],
                    data: (list) => [
                      if (list.isEmpty)
                        const ListTile(
                          title: Text('No groups yet'),
                          subtitle: Text(
                            'Create one for your club, or join with a code.',
                          ),
                        ),
                      for (final g in list)
                        RadioListTile<String>(
                          value: g.group.id,
                          title: Text(g.group.name),
                          subtitle: Text(roleLabel(g.myRole)),
                          secondary: IconButton(
                            tooltip: 'Group details',
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () => context.pushNamed(
                              'groupDetail',
                              pathParameters: {'id': g.group.id},
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 96),
                ],
              ),
            ),
      floatingActionButton: user == null
          ? null
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'join',
                  onPressed: () => _join(context, ref),
                  icon: const Icon(Icons.vpn_key_outlined),
                  label: const Text('Join with code'),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  heroTag: 'create',
                  onPressed: () => _create(context, ref),
                  icon: const Icon(Icons.group_add),
                  label: const Text('New group'),
                ),
              ],
            ),
    );
  }

  static const _personal = '__personal__';

  Future<void> _create(BuildContext context, WidgetRef ref) async {
    final name = await promptText(
      context,
      title: 'New group',
      label: 'Group name',
      hint: 'e.g. Sunday Warriors CC',
      action: 'Create',
    );
    if (name == null || name.trim().isEmpty || !context.mounted) return;
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    await runGroupAction(context, () async {
      final group = await ref
          .read(groupServiceProvider)
          .createGroup(name: name, owner: user);
      await ref.read(activeGroupIdProvider.notifier).select(group.id);
    }, done: 'Group created');
  }

  Future<void> _join(BuildContext context, WidgetRef ref) async {
    final code = await promptText(
      context,
      title: 'Join a group',
      label: 'Invite code',
      hint: '10 letters and numbers',
      action: 'Find',
      capitalise: true,
    );
    if (code == null || code.trim().isEmpty || !context.mounted) return;
    final service = ref.read(groupServiceProvider);

    CloudInvite? invite;
    await runGroupAction(context, () async {
      invite = await service.findInvite(code);
      if (invite == null) {
        throw const GroupException('No invite matches that code.');
      }
      final why = GroupCodes.whyUnusable(invite!, DateTime.now());
      if (why != null) throw GroupException(why);
    });
    final found = invite;
    if (found == null || !context.mounted) return;

    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Join ${found.groupName}?'),
        content: Text(
          "You'll join as ${roleLabel(found.role).toLowerCase()}. "
          '${roleHelp(found.role)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(c, true),
            child: const Text('Join'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    await runGroupAction(context, () async {
      await service.redeemInvite(found, user);
      await ref.read(activeGroupIdProvider.notifier).select(found.groupId);
    }, done: 'Joined ${found.groupName}');
  }
}

String roleLabel(MemberRole role) => switch (role) {
  MemberRole.owner => 'Owner',
  MemberRole.editor => 'Editor',
  MemberRole.viewer => 'Viewer',
};

String roleHelp(MemberRole role) => switch (role) {
  MemberRole.owner => 'Manages members and everything in the group.',
  MemberRole.editor => 'Can add players, teams and matches, and score.',
  MemberRole.viewer => 'Can follow matches but not change anything.',
};

/// Run a group action, showing its [GroupException] (or [done]) in a
/// snackbar. Returns whether it succeeded.
Future<bool> runGroupAction(
  BuildContext context,
  Future<void> Function() action, {
  String? done,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  try {
    await action();
    if (done != null) messenger.showSnackBar(SnackBar(content: Text(done)));
    return true;
  } on GroupException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.message)));
    return false;
  }
}

/// A one-field text prompt; returns the text, or null if cancelled.
Future<String?> promptText(
  BuildContext context, {
  required String title,
  required String label,
  required String action,
  String? hint,
  String? initial,
  bool capitalise = false,
}) => showDialog<String>(
  context: context,
  builder: (_) => _PromptDialog(
    title: title,
    label: label,
    action: action,
    hint: hint,
    initial: initial,
    capitalise: capitalise,
  ),
);

/// Owns its controller, so it lives until the dialog's exit animation ends
/// (disposing it when the dialog's future completes crashes mid-animation).
class _PromptDialog extends StatefulWidget {
  const _PromptDialog({
    required this.title,
    required this.label,
    required this.action,
    required this.capitalise,
    this.hint,
    this.initial,
  });

  final String title;
  final String label;
  final String action;
  final String? hint;
  final String? initial;
  final bool capitalise;

  @override
  State<_PromptDialog> createState() => _PromptDialogState();
}

class _PromptDialogState extends State<_PromptDialog> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: TextField(
      controller: _controller,
      autofocus: true,
      textCapitalization: widget.capitalise
          ? TextCapitalization.characters
          : TextCapitalization.words,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
      ),
      onSubmitted: (v) => Navigator.pop(context, v),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(context, _controller.text),
        child: Text(widget.action),
      ),
    ],
  );
}
