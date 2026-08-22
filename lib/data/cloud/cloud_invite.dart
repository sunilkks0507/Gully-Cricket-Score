import 'cloud_json.dart';
import 'member_role.dart';

/// A join code that grants membership of one group at one role.
///
/// Firestore document: `invites/{code}` — deliberately **top-level**, not under
/// `groups/{gid}`, because a person redeeming a code does not yet know (or have
/// read access to) the group. The code alone must be enough to locate it.
///
/// Consequence: `invites/{code}` is readable by **any signed-in user** who knows
/// the code, so the code is a bearer token. Mitigations, all rules-enforced:
/// * codes are long enough to make guessing impractical (see [codeLength] and
///   [codeAlphabet]) — 32^10 ≈ 1.1e15 combinations;
/// * `list` on the collection is denied outright, so codes cannot be enumerated;
/// * every invite carries a hard [expiresAt];
/// * [maxUses] caps redemptions, and [revoked] kills a leaked code instantly.
///
/// [groupName] is denormalised so the redeem screen can say *"Join Sunday
/// Warriors CC as editor?"* before the user is a member — at that moment they
/// still cannot read `groups/{gid}`.
class CloudInvite {
  const CloudInvite({
    required this.code,
    required this.groupId,
    required this.groupName,
    required this.role,
    required this.createdByUid,
    required this.createdAt,
    required this.expiresAt,
    this.maxUses = 1,
    this.useCount = 0,
    this.revoked = false,
    this.redeemedByUids = const <String>[],
  });

  /// Number of characters in a generated code.
  static const int codeLength = 10;

  /// Unambiguous alphabet (no 0/O, 1/I/L) so codes survive being read aloud or
  /// typed from a photo. Codes are uppercase.
  static const String codeAlphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';

  /// Default lifetime the UI should suggest when creating an invite.
  static const Duration defaultTtl = Duration(days: 7);

  /// The join code — also the document id. Uppercase, [codeLength] chars.
  final String code;

  final String groupId;

  /// Denormalised group name, shown on the redeem screen.
  final String groupName;

  /// Role granted on redemption. Never [MemberRole.owner] — ownership is
  /// transferred explicitly, never handed out by a code (rules-enforced).
  final MemberRole role;

  final String createdByUid;

  final DateTime createdAt;

  final DateTime expiresAt;

  /// How many memberships this code may create. 1 = single-use personal invite;
  /// higher for a "share this with the squad" code.
  final int maxUses;

  /// Redemptions so far. Incremented by the redeeming client after its
  /// membership document is created (see docs/13-firestore-schema.md §Redeem).
  final int useCount;

  /// Kills the code immediately regardless of expiry/uses.
  final bool revoked;

  /// Audit trail of who redeemed it.
  final List<String> redeemedByUids;

  /// Client-side pre-check. The authoritative check is in `firestore.rules`;
  /// this exists so the UI can explain *why* a code was rejected instead of
  /// surfacing a bare PERMISSION_DENIED.
  bool isRedeemableAt(DateTime now) =>
      !revoked && useCount < maxUses && now.isBefore(expiresAt);

  /// True when this uid has already redeemed the code (redeeming twice is a
  /// no-op, not an error).
  bool wasRedeemedBy(String uid) => redeemedByUids.contains(uid);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'code': code,
    'groupId': groupId,
    'groupName': groupName,
    'role': role.wireName,
    'createdByUid': createdByUid,
    'createdAt': CloudJson.millis(createdAt),
    'expiresAt': CloudJson.millis(expiresAt),
    'maxUses': maxUses,
    'useCount': useCount,
    'revoked': revoked,
    'redeemedByUids': List<String>.from(redeemedByUids),
  };

  factory CloudInvite.fromJson(Map<String, dynamic> json) => CloudInvite(
    code: CloudJson.requireString(json, 'code'),
    groupId: CloudJson.requireString(json, 'groupId'),
    groupName: CloudJson.requireString(json, 'groupName'),
    role: MemberRole.fromWire(CloudJson.requireString(json, 'role')),
    createdByUid: CloudJson.requireString(json, 'createdByUid'),
    createdAt: CloudJson.requireTime(json, 'createdAt'),
    expiresAt: CloudJson.requireTime(json, 'expiresAt'),
    maxUses: CloudJson.optionalInt(json, 'maxUses', fallback: 1),
    useCount: CloudJson.optionalInt(json, 'useCount'),
    revoked: CloudJson.optionalBool(json, 'revoked'),
    redeemedByUids: CloudJson.stringList(json, 'redeemedByUids'),
  );

  CloudInvite copyWith({
    String? code,
    String? groupId,
    String? groupName,
    MemberRole? role,
    String? createdByUid,
    DateTime? createdAt,
    DateTime? expiresAt,
    int? maxUses,
    int? useCount,
    bool? revoked,
    List<String>? redeemedByUids,
  }) => CloudInvite(
    code: code ?? this.code,
    groupId: groupId ?? this.groupId,
    groupName: groupName ?? this.groupName,
    role: role ?? this.role,
    createdByUid: createdByUid ?? this.createdByUid,
    createdAt: createdAt ?? this.createdAt,
    expiresAt: expiresAt ?? this.expiresAt,
    maxUses: maxUses ?? this.maxUses,
    useCount: useCount ?? this.useCount,
    revoked: revoked ?? this.revoked,
    redeemedByUids: redeemedByUids ?? this.redeemedByUids,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloudInvite &&
          other.code == code &&
          other.groupId == groupId &&
          other.groupName == groupName &&
          other.role == role &&
          other.createdByUid == createdByUid &&
          other.createdAt == createdAt &&
          other.expiresAt == expiresAt &&
          other.maxUses == maxUses &&
          other.useCount == useCount &&
          other.revoked == revoked &&
          CloudJson.listEquals(other.redeemedByUids, redeemedByUids);

  @override
  int get hashCode => Object.hash(
    code,
    groupId,
    groupName,
    role,
    createdByUid,
    createdAt,
    expiresAt,
    maxUses,
    useCount,
    revoked,
    Object.hashAll(redeemedByUids),
  );

  @override
  String toString() =>
      'CloudInvite($code -> $groupId as ${role.wireName}, $useCount/$maxUses)';
}
