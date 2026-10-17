import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/auth_providers.dart';
import '../../application/group_providers.dart';
import '../../data/cloud/cloud.dart';
import '../../data/groups/group_service.dart';
import 'groups_screen.dart';

final groupMembersProvider = StreamProvider.autoDispose
    .family<List<CloudMembership>, String>(
      (ref, groupId) => ref.watch(groupServiceProvider).watchMembers(groupId),
    );

final groupInvitesProvider = StreamProvider.autoDispose
    .family<List<CloudInvite>, String>(
      (ref, groupId) => ref.watch(groupServiceProvider).watchInvites(groupId),
    );

/// One group: its members (owner manages roles), its invite codes
/// (owner/editor), and leaving.
class GroupDetailScreen extends ConsumerWidget {
  const GroupDetailScreen({required this.groupId, super.key});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(currentUserProvider);
    final groups = ref.watch(myGroupsProvider).value ?? const [];
    GroupSummary? summary;
    for (final g in groups) {
      if (g.group.id == groupId) summary = g;
    }
    if (me == null || summary == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Group')),
        body: const Center(child: Text("You're not a member of this group.")),
      );
    }
    final group = summary.group;
    final myRole = summary.myRole;
    final service = ref.read(groupServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        actions: [
          if (myRole.canManageMembers)
            IconButton(
              tooltip: 'Rename',
              icon: const Icon(Icons.edit_outlined),
              onPressed: () async {
                final name = await promptText(
                  context,
                  title: 'Rename group',
                  label: 'Group name',
                  action: 'Save',
                  initial: group.name,
                );
                if (name == null || !context.mounted) return;
                await runGroupAction(
                  context,
                  () => service.renameGroup(group.id, name),
                );
              },
            ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.badge_outlined),
            title: Text('You are ${roleLabel(myRole).toLowerCase()}'),
            subtitle: Text(roleHelp(myRole)),
          ),
          _heading(context, 'Members'),
          ...ref
              .watch(groupMembersProvider(group.id))
              .when(
                loading: () => [const LinearProgressIndicator()],
                error: (e, _) => [ListTile(title: Text('$e'))],
                data: (members) => [
                  for (final m in members)
                    _MemberTile(
                      member: m,
                      isMe: m.uid == me.uid,
                      canManage:
                          myRole.canManageMembers && m.role != MemberRole.owner,
                      onRole: (role) => runGroupAction(
                        context,
                        () => service.setRole(group.id, m.uid, role),
                      ),
                      onRemove: () => runGroupAction(
                        context,
                        () => service.removeMember(group.id, m.uid),
                        done: 'Removed ${m.displayName ?? 'member'}',
                      ),
                    ),
                ],
              ),
          if (myRole.canEdit) ...[
            _heading(context, 'Invites'),
            ListTile(
              leading: const Icon(Icons.person_add_alt_1),
              title: const Text('Invite people'),
              subtitle: const Text('Make a code to share with your club'),
              onTap: () => _invite(context, ref, group, me.uid),
            ),
            ...ref
                .watch(groupInvitesProvider(group.id))
                .when(
                  loading: () => [const LinearProgressIndicator()],
                  error: (e, _) => [ListTile(title: Text('$e'))],
                  data: (invites) => [
                    for (final i in invites)
                      _InviteTile(
                        invite: i,
                        onRevoke: () => runGroupAction(
                          context,
                          () => service.revokeInvite(i.code),
                          done: 'Invite cancelled',
                        ),
                      ),
                  ],
                ),
          ],
          if (myRole != MemberRole.owner) ...[
            const Divider(height: 32),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.error,
              ),
              title: const Text('Leave group'),
              subtitle: const Text('Data already on this phone stays here.'),
              onTap: () => _leave(context, ref, group, me.uid),
            ),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _heading(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );

  Future<void> _invite(
    BuildContext context,
    WidgetRef ref,
    CloudGroup group,
    String uid,
  ) async {
    final choice = await showDialog<(MemberRole, int)>(
      context: context,
      builder: (_) => const _InviteDialog(),
    );
    if (choice == null || !context.mounted) return;
    CloudInvite? invite;
    final ok = await runGroupAction(context, () async {
      invite = await ref
          .read(groupServiceProvider)
          .createInvite(
            group: group,
            role: choice.$1,
            maxUses: choice.$2,
            createdByUid: uid,
          );
    });
    if (!ok || invite == null || !context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Invite code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectableText(
              formatCode(invite!.code),
              style: Theme.of(c).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Joins as ${roleLabel(invite!.role).toLowerCase()} · '
              'valid 7 days · ${invite!.maxUses} '
              '${invite!.maxUses == 1 ? 'use' : 'uses'}',
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => _copy(c, invite!.code),
            icon: const Icon(Icons.copy),
            label: const Text('Copy'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(c),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Future<void> _leave(
    BuildContext context,
    WidgetRef ref,
    CloudGroup group,
    String uid,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Leave ${group.name}?'),
        content: const Text(
          "You'll need a new invite to rejoin. Data already on this phone "
          'stays here.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(c, true),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final left = await runGroupAction(
      context,
      () => ref.read(groupServiceProvider).removeMember(group.id, uid),
      done: 'Left ${group.name}',
    );
    if (!left) return;
    // Await the stored value: if nothing has watched the provider yet it is
    // still loading, and a plain .value would read null and skip the reset.
    if (await ref.read(activeGroupIdProvider.future) == group.id) {
      await ref.read(activeGroupIdProvider.notifier).select(null);
    }
    if (context.mounted) Navigator.of(context).maybePop();
  }
}

/// "ABCDE-FGHJK" — easier to read aloud than ten characters in a row.
String formatCode(String code) =>
    code.length == 10 ? '${code.substring(0, 5)}-${code.substring(5)}' : code;

void _copy(BuildContext context, String code) {
  Clipboard.setData(ClipboardData(text: code));
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text('Code copied')));
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({
    required this.member,
    required this.isMe,
    required this.canManage,
    required this.onRole,
    required this.onRemove,
  });

  final CloudMembership member;
  final bool isMe;
  final bool canManage;
  final ValueChanged<MemberRole> onRole;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final name = member.displayName ?? 'Member';
    final photo = member.photoUrl;
    return ListTile(
      leading: CircleAvatar(
        foregroundImage: photo == null ? null : NetworkImage(photo),
        onForegroundImageError: photo == null ? null : (_, _) {},
        child: Text(name.isEmpty ? '?' : name.substring(0, 1).toUpperCase()),
      ),
      title: Text(isMe ? '$name (you)' : name),
      subtitle: Text(roleLabel(member.role)),
      trailing: canManage && !isMe
          ? PopupMenuButton<String>(
              onSelected: (v) {
                switch (v) {
                  case 'editor':
                    onRole(MemberRole.editor);
                  case 'viewer':
                    onRole(MemberRole.viewer);
                  case 'remove':
                    onRemove();
                }
              },
              itemBuilder: (_) => [
                if (member.role != MemberRole.editor)
                  const PopupMenuItem(
                    value: 'editor',
                    child: Text('Make editor'),
                  ),
                if (member.role != MemberRole.viewer)
                  const PopupMenuItem(
                    value: 'viewer',
                    child: Text('Make viewer'),
                  ),
                const PopupMenuItem(
                  value: 'remove',
                  child: Text('Remove from group'),
                ),
              ],
            )
          : null,
    );
  }
}

class _InviteTile extends StatelessWidget {
  const _InviteTile({required this.invite, required this.onRevoke});

  final CloudInvite invite;
  final VoidCallback onRevoke;

  @override
  Widget build(BuildContext context) {
    final why = GroupCodes.whyUnusable(invite, DateTime.now());
    final status =
        why ??
        '${invite.useCount}/${invite.maxUses} used · expires '
            '${MaterialLocalizations.of(context).formatShortDate(invite.expiresAt)}';
    return ListTile(
      leading: Icon(why == null ? Icons.key : Icons.key_off),
      title: Text(formatCode(invite.code)),
      subtitle: Text('${roleLabel(invite.role)} · $status'),
      trailing: why != null
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Copy code',
                  icon: const Icon(Icons.copy),
                  onPressed: () => _copy(context, invite.code),
                ),
                IconButton(
                  tooltip: 'Cancel invite',
                  icon: const Icon(Icons.block),
                  onPressed: onRevoke,
                ),
              ],
            ),
    );
  }
}

class _InviteDialog extends StatefulWidget {
  const _InviteDialog();

  @override
  State<_InviteDialog> createState() => _InviteDialogState();
}

class _InviteDialogState extends State<_InviteDialog> {
  MemberRole _role = MemberRole.editor;
  int _uses = 1;

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Invite people'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('They join as'),
        const SizedBox(height: 8),
        SegmentedButton<MemberRole>(
          segments: const [
            ButtonSegment(value: MemberRole.editor, label: Text('Editor')),
            ButtonSegment(value: MemberRole.viewer, label: Text('Viewer')),
          ],
          selected: {_role},
          onSelectionChanged: (s) => setState(() => _role = s.first),
        ),
        const SizedBox(height: 4),
        Text(roleHelp(_role), style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 16),
        const Text('How many people can use it'),
        const SizedBox(height: 8),
        SegmentedButton<int>(
          segments: const [
            ButtonSegment(value: 1, label: Text('1')),
            ButtonSegment(value: 5, label: Text('5')),
            ButtonSegment(value: 20, label: Text('20')),
          ],
          selected: {_uses},
          onSelectionChanged: (s) => setState(() => _uses = s.first),
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(context, (_role, _uses)),
        child: const Text('Create code'),
      ),
    ],
  );
}
