import 'cloud_json.dart';
import 'member_role.dart';

/// One person's membership of one group — the **source of truth for access**.
///
/// Firestore document: `groups/{groupId}/members/{uid}`.
///
/// The document id is the member's Firebase Auth uid, so the security rules can
/// answer "is the caller a member?" with a single `exists()` on a path they can
/// build from the request alone (no query, no scan).
///
/// [uid] and [groupId] are duplicated into the body because "which groups am I
/// in?" is answered by a **collection-group query** over `members` filtered on
/// `uid == auth.uid`; a collection-group query cannot filter on the parent path.
/// See `firestore.indexes.json`.
///
/// [displayName] / [photoUrl] are denormalised copies of the member's
/// `users/{uid}` profile so the members screen renders from one query instead of
/// N extra document reads. They are a cache: stale names are cosmetic, and the
/// member refreshes their own copy on sign-in.
class CloudMembership {
  const CloudMembership({
    required this.groupId,
    required this.uid,
    required this.role,
    required this.joinedAt,
    this.displayName,
    this.photoUrl,
    this.invitedByUid,
    this.inviteCode,
  });

  final String groupId;

  /// Firebase Auth uid; also the document id.
  final String uid;

  final MemberRole role;

  final DateTime joinedAt;

  /// Denormalised from `users/{uid}` for cheap member lists.
  final String? displayName;

  /// Denormalised from `users/{uid}` for cheap member lists.
  final String? photoUrl;

  /// Who issued the invite that was redeemed (null for the founding owner).
  final String? invitedByUid;

  /// The invite code this membership was created from. **Load-bearing:** the
  /// security rules read it back to verify the join was legitimate — a client
  /// cannot mint a membership for a group it was never invited to, because the
  /// rule re-fetches `invites/{inviteCode}` and checks the group, role, expiry
  /// and remaining uses. Null only for the founding owner, whose membership is
  /// authorised by `groups/{gid}.ownerUid` instead.
  final String? inviteCode;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'groupId': groupId,
    'uid': uid,
    'role': role.wireName,
    'joinedAt': CloudJson.millis(joinedAt),
    if (displayName != null) 'displayName': displayName,
    if (photoUrl != null) 'photoUrl': photoUrl,
    if (invitedByUid != null) 'invitedByUid': invitedByUid,
    if (inviteCode != null) 'inviteCode': inviteCode,
  };

  factory CloudMembership.fromJson(Map<String, dynamic> json) =>
      CloudMembership(
        groupId: CloudJson.requireString(json, 'groupId'),
        uid: CloudJson.requireString(json, 'uid'),
        role: MemberRole.fromWire(CloudJson.requireString(json, 'role')),
        joinedAt: CloudJson.requireTime(json, 'joinedAt'),
        displayName: CloudJson.optionalString(json, 'displayName'),
        photoUrl: CloudJson.optionalString(json, 'photoUrl'),
        invitedByUid: CloudJson.optionalString(json, 'invitedByUid'),
        inviteCode: CloudJson.optionalString(json, 'inviteCode'),
      );

  CloudMembership copyWith({
    String? groupId,
    String? uid,
    MemberRole? role,
    DateTime? joinedAt,
    Object? displayName = cloudUnset,
    Object? photoUrl = cloudUnset,
    Object? invitedByUid = cloudUnset,
    Object? inviteCode = cloudUnset,
  }) => CloudMembership(
    groupId: groupId ?? this.groupId,
    uid: uid ?? this.uid,
    role: role ?? this.role,
    joinedAt: joinedAt ?? this.joinedAt,
    displayName: identical(displayName, cloudUnset)
        ? this.displayName
        : displayName as String?,
    photoUrl: identical(photoUrl, cloudUnset)
        ? this.photoUrl
        : photoUrl as String?,
    invitedByUid: identical(invitedByUid, cloudUnset)
        ? this.invitedByUid
        : invitedByUid as String?,
    inviteCode: identical(inviteCode, cloudUnset)
        ? this.inviteCode
        : inviteCode as String?,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloudMembership &&
          other.groupId == groupId &&
          other.uid == uid &&
          other.role == role &&
          other.joinedAt == joinedAt &&
          other.displayName == displayName &&
          other.photoUrl == photoUrl &&
          other.invitedByUid == invitedByUid &&
          other.inviteCode == inviteCode;

  @override
  int get hashCode => Object.hash(
    groupId,
    uid,
    role,
    joinedAt,
    displayName,
    photoUrl,
    invitedByUid,
    inviteCode,
  );

  @override
  String toString() => 'CloudMembership($uid @ $groupId as ${role.wireName})';
}
