/// A member's role inside a [CloudGroup]. Stored on
/// `groups/{gid}/members/{uid}.role` and mirrored into the security rules,
/// which compare the raw [wireName] strings — keep the two in sync.
///
/// See docs/13-firestore-schema.md §Access matrix.
enum MemberRole {
  /// Created the group. Everything an editor can do, plus: manage members and
  /// roles, revoke invites, delete matches, delete the group, force-reassign
  /// the per-match scorer lock.
  owner('owner', 2),

  /// Can create and edit group content (players, teams, tournaments, matches)
  /// and can hold the per-match scorer lock.
  editor('editor', 1),

  /// Read-only. Can watch a match live but can never write — enforced by the
  /// rules, not just by the UI.
  viewer('viewer', 0);

  const MemberRole(this.wireName, this.rank);

  /// The exact string persisted to Firestore and matched in `firestore.rules`.
  final String wireName;

  /// Higher rank == strictly more capability. Use [atLeast] rather than
  /// comparing ranks directly.
  final int rank;

  /// Parses a persisted role, throwing on anything unknown. Unknown roles are
  /// treated as an error rather than silently downgraded to `viewer`, so a
  /// future role added by a newer client is loud instead of subtly wrong.
  static MemberRole fromWire(String value) {
    for (final role in MemberRole.values) {
      if (role.wireName == value) return role;
    }
    throw FormatException('Unknown MemberRole "$value"');
  }

  /// Lenient parse for optional/absent fields.
  static MemberRole? tryFromWire(String? value) {
    if (value == null) return null;
    for (final role in MemberRole.values) {
      if (role.wireName == value) return role;
    }
    return null;
  }

  /// May create/update group content (players, teams, tournaments, matches).
  bool get canEdit => rank >= editor.rank;

  /// May hold the per-match scorer lock and append ball events.
  ///
  /// Identical to [canEdit] today; kept separate because it is a different
  /// question and the rules check it against `match.scorerUid`, not the role
  /// alone. Holding an editor role is *necessary but not sufficient* to score:
  /// the match's `scorerUid` must also be this user.
  bool get canScore => canEdit;

  /// May add/remove members, change roles, and revoke invites.
  bool get canManageMembers => this == owner;

  /// May delete the whole group (and its subcollections).
  bool get canDeleteGroup => this == owner;

  /// Convenience inverse of [canEdit].
  bool get isReadOnly => !canEdit;

  /// True when this role is at least as privileged as [other].
  bool atLeast(MemberRole other) => rank >= other.rank;
}
