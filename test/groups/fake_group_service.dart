import 'dart:async';

import 'package:cricket_scoring/application/group_providers.dart';
import 'package:cricket_scoring/data/auth/app_user.dart';
import 'package:cricket_scoring/data/cloud/cloud.dart';
import 'package:cricket_scoring/data/groups/group_service.dart';

/// An in-memory [GroupService] with the same rules as `firestore.rules` for
/// the paths the UI uses, so widget tests never need Firebase.
class FakeGroupService implements GroupService {
  final groups = <String, CloudGroup>{};

  /// groupId -> uid -> membership
  final members = <String, Map<String, CloudMembership>>{};
  final invites = <String, CloudInvite>{};
  final profiles = <String, AppUser>{};

  final _changes = StreamController<void>.broadcast();
  var _ids = 0;

  void _changed() => _changes.add(null);

  /// Re-emit [compute] now and whenever anything changes.
  Stream<T> _live<T>(T Function() compute) => Stream<T>.multi((c) {
    c.add(compute());
    final sub = _changes.stream.listen((_) => c.add(compute()));
    c.onCancel = sub.cancel;
  });

  MemberRole? roleOf(String groupId, String uid) =>
      members[groupId]?[uid]?.role;

  /// Seed a group owned by [owner] directly.
  CloudGroup seedGroup(String name, AppUser owner) {
    final now = DateTime.now();
    final g = CloudGroup(
      id: 'g${++_ids}',
      name: name,
      ownerUid: owner.uid,
      createdAt: now,
      updatedAt: now,
    );
    groups[g.id] = g;
    members[g.id] = {
      owner.uid: CloudMembership(
        groupId: g.id,
        uid: owner.uid,
        role: MemberRole.owner,
        joinedAt: now,
        displayName: owner.label,
      ),
    };
    _changed();
    return g;
  }

  /// Seed a membership directly.
  void seedMember(String groupId, AppUser user, MemberRole role) {
    members[groupId]![user.uid] = CloudMembership(
      groupId: groupId,
      uid: user.uid,
      role: role,
      joinedAt: DateTime.now(),
      displayName: user.label,
    );
    _changed();
  }

  @override
  Stream<List<GroupSummary>> watchMyGroups(String uid) => _live(
    () => [
      for (final g in groups.values)
        if (members[g.id]?[uid] != null)
          GroupSummary(group: g, myRole: members[g.id]![uid]!.role),
    ]..sort((a, b) => a.group.name.compareTo(b.group.name)),
  );

  @override
  Future<CloudGroup> createGroup({
    required String name,
    required AppUser owner,
  }) async {
    if (name.trim().isEmpty) {
      throw const GroupException('Group names must be 1–60 characters.');
    }
    return seedGroup(name.trim(), owner);
  }

  @override
  Future<void> renameGroup(String groupId, String name) async {
    groups[groupId] = groups[groupId]!.copyWith(name: name.trim());
    _changed();
  }

  @override
  Stream<List<CloudMembership>> watchMembers(String groupId) => _live(
    () =>
        (members[groupId]?.values.toList() ?? [])
          ..sort((a, b) => b.role.rank.compareTo(a.role.rank)),
  );

  @override
  Future<void> setRole(String groupId, String uid, MemberRole role) async {
    final m = members[groupId]![uid]!;
    members[groupId]![uid] = m.copyWith(role: role);
    _changed();
  }

  @override
  Future<void> removeMember(String groupId, String uid) async {
    if (groups[groupId]!.ownerUid == uid) {
      throw const GroupException(
        "You don't have permission to do that in this group.",
      );
    }
    members[groupId]!.remove(uid);
    _changed();
  }

  @override
  Future<CloudInvite> createInvite({
    required CloudGroup group,
    required MemberRole role,
    required String createdByUid,
    int maxUses = 1,
    Duration ttl = CloudInvite.defaultTtl,
  }) async {
    if (!(roleOf(group.id, createdByUid)?.canEdit ?? false)) {
      throw const GroupException(
        "You don't have permission to do that in this group.",
      );
    }
    final now = DateTime.now();
    final invite = CloudInvite(
      code: GroupCodes.generate(),
      groupId: group.id,
      groupName: group.name,
      role: role,
      createdByUid: createdByUid,
      createdAt: now,
      expiresAt: now.add(ttl),
      maxUses: maxUses,
    );
    invites[invite.code] = invite;
    _changed();
    return invite;
  }

  @override
  Stream<List<CloudInvite>> watchInvites(String groupId) =>
      _live(() => invites.values.where((i) => i.groupId == groupId).toList());

  @override
  Future<void> revokeInvite(String code) async {
    invites[code] = invites[code]!.copyWith(revoked: true);
    _changed();
  }

  @override
  Future<CloudInvite?> findInvite(String code) async =>
      invites[GroupCodes.normalise(code)];

  @override
  Future<void> redeemInvite(CloudInvite invite, AppUser user) async {
    if (members[invite.groupId]?[user.uid] != null) return;
    final why = GroupCodes.whyUnusable(invite, DateTime.now());
    if (why != null) throw GroupException(why);
    seedMember(invite.groupId, user, invite.role);
    invites[invite.code] = invite.copyWith(
      useCount: invite.useCount + 1,
      redeemedByUids: [...invite.redeemedByUids, user.uid],
    );
    profiles[user.uid] = user;
    _changed();
  }

  @override
  Future<void> saveProfile(AppUser user) async => profiles[user.uid] = user;
}

/// In-memory [ActiveGroupStore].
class MemoryActiveGroupStore implements ActiveGroupStore {
  final values = <String, String?>{};

  @override
  Future<String?> read(String uid) async => values[uid];

  @override
  Future<void> write(String uid, String? groupId) async =>
      values[uid] = groupId;
}
