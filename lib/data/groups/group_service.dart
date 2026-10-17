import 'dart:math';

import '../auth/app_user.dart';
import '../cloud/cloud.dart';

/// A group the signed-in user belongs to, with their role in it.
class GroupSummary {
  const GroupSummary({required this.group, required this.myRole});

  final CloudGroup group;
  final MemberRole myRole;
}

/// A group action failed for a reason the user can act on (bad code, expired
/// invite, no permission, offline). [message] is safe to show as-is.
class GroupException implements Exception {
  const GroupException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Shared groups and invites (Phase B of docs/12-cloud-sync-plan.md).
///
/// An interface so widgets and tests never need Firebase; the app binds
/// `FirestoreGroupService`. Every method throws [GroupException] — and only
/// that — on a failure the user should see. The security rules in
/// `firestore.rules` are the real enforcement; checks here only exist to give
/// a readable message instead of PERMISSION_DENIED.
abstract class GroupService {
  /// The groups [uid] is a member of, kept live.
  Stream<List<GroupSummary>> watchMyGroups(String uid);

  /// Create a group owned by [owner] and claim the owner membership.
  Future<CloudGroup> createGroup({
    required String name,
    required AppUser owner,
  });

  /// Rename a group (owner only).
  Future<void> renameGroup(String groupId, String name);

  /// A group's members, kept live.
  Stream<List<CloudMembership>> watchMembers(String groupId);

  /// Change a member's role (owner only; never to or from owner).
  Future<void> setRole(String groupId, String uid, MemberRole role);

  /// Remove a member. A member may also remove themselves (leave the group).
  Future<void> removeMember(String groupId, String uid);

  /// Create a join code for [group] granting [role].
  Future<CloudInvite> createInvite({
    required CloudGroup group,
    required MemberRole role,
    required String createdByUid,
    int maxUses = 1,
    Duration ttl = CloudInvite.defaultTtl,
  });

  /// A group's invites, newest first, kept live (owner/editor only).
  Stream<List<CloudInvite>> watchInvites(String groupId);

  /// Kill an invite immediately.
  Future<void> revokeInvite(String code);

  /// Look up a code, or null if there is no such invite.
  Future<CloudInvite?> findInvite(String code);

  /// Join [invite]'s group as [user]. Joining a group you are already in is a
  /// no-op.
  Future<void> redeemInvite(CloudInvite invite, AppUser user);

  /// Publish [user]'s public profile (name + photo) for member lists.
  Future<void> saveProfile(AppUser user);
}

/// Helpers shared by every [GroupService] implementation.
abstract final class GroupCodes {
  static final _random = Random.secure();

  /// A fresh join code: [CloudInvite.codeLength] characters from the
  /// unambiguous [CloudInvite.codeAlphabet].
  static String generate() => String.fromCharCodes(
    List.generate(
      CloudInvite.codeLength,
      (_) => CloudInvite.codeAlphabet.codeUnitAt(
        _random.nextInt(CloudInvite.codeAlphabet.length),
      ),
    ),
  );

  /// Normalise what a user typed: trim, drop spaces/dashes, uppercase.
  static String normalise(String typed) =>
      typed.replaceAll(RegExp(r'[\s-]'), '').toUpperCase();

  /// Explain why [invite] can't be used right now, or null if it can.
  static String? whyUnusable(CloudInvite invite, DateTime now) {
    if (invite.revoked) return 'This invite has been cancelled.';
    if (!now.isBefore(invite.expiresAt)) return 'This invite has expired.';
    if (invite.useCount >= invite.maxUses) {
      return 'This invite has already been used.';
    }
    return null;
  }
}
