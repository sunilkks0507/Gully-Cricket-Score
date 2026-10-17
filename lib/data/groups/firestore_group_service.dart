import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../auth/app_user.dart';
import '../cloud/cloud.dart';
import 'group_service.dart';

/// [GroupService] backed by Cloud Firestore.
///
/// Every path comes from [FirestorePaths]; every document shape from the
/// `Cloud*` DTOs. The write sequences mirror docs/13-firestore-schema.md §4
/// exactly, because the security rules authorise each step against the state
/// the previous one left behind.
class FirestoreGroupService implements GroupService {
  FirestoreGroupService([FirebaseFirestore? firestore])
    : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;
  static const _uuid = Uuid();

  DocumentReference<Map<String, dynamic>> _doc(String path) => _db.doc(path);

  @override
  Stream<List<GroupSummary>> watchMyGroups(String uid) => _db
      .collectionGroup(FirestorePaths.membersCollectionGroup())
      .where('uid', isEqualTo: uid)
      .snapshots()
      .asyncMap((snap) async {
        final result = <GroupSummary>[];
        for (final d in snap.docs) {
          final membership = CloudMembership.fromJson(d.data());
          final groupSnap = await _doc(
            FirestorePaths.group(membership.groupId),
          ).get();
          final data = groupSnap.data();
          if (data == null) continue; // ownerless/deleted group: skip
          result.add(
            GroupSummary(
              group: CloudGroup.fromJson(data),
              myRole: membership.role,
            ),
          );
        }
        result.sort(
          (a, b) =>
              a.group.name.toLowerCase().compareTo(b.group.name.toLowerCase()),
        );
        return result;
      })
      .handleError((Object e) => throw _wrap(e));

  @override
  Future<CloudGroup> createGroup({
    required String name,
    required AppUser owner,
  }) => _guard(() async {
    final trimmed = name.trim();
    if (trimmed.isEmpty || trimmed.length > 60) {
      throw const GroupException('Group names must be 1–60 characters.');
    }
    final now = DateTime.now();
    final group = CloudGroup(
      id: _uuid.v4(),
      name: trimmed,
      ownerUid: owner.uid,
      createdAt: now,
      updatedAt: now,
    );
    // Two writes, not a batch: the membership rule authorises the founding
    // owner by reading the group document, which must already exist.
    await _doc(FirestorePaths.group(group.id)).set(group.toJson());
    await _doc(FirestorePaths.member(group.id, owner.uid)).set(
      CloudMembership(
        groupId: group.id,
        uid: owner.uid,
        role: MemberRole.owner,
        joinedAt: now,
        displayName: owner.label,
        photoUrl: owner.photoUrl,
      ).toJson(),
    );
    await _publishProfile(owner);
    return group;
  });

  @override
  Future<void> renameGroup(String groupId, String name) => _guard(() async {
    final trimmed = name.trim();
    if (trimmed.isEmpty || trimmed.length > 60) {
      throw const GroupException('Group names must be 1–60 characters.');
    }
    await _doc(
      FirestorePaths.group(groupId),
    ).update({'name': trimmed, 'updatedAt': CloudJson.millis(DateTime.now())});
  });

  @override
  Stream<List<CloudMembership>> watchMembers(String groupId) => _db
      .collection(FirestorePaths.membersCollection(groupId))
      .snapshots()
      .map((snap) {
        final list = snap.docs
            .map((d) => CloudMembership.fromJson(d.data()))
            .toList();
        list.sort((a, b) {
          final byRole = b.role.rank.compareTo(a.role.rank);
          return byRole != 0 ? byRole : a.joinedAt.compareTo(b.joinedAt);
        });
        return list;
      })
      .handleError((Object e) => throw _wrap(e));

  @override
  Future<void> setRole(String groupId, String uid, MemberRole role) =>
      _guard(() async {
        if (role == MemberRole.owner) {
          throw const GroupException(
            'Ownership is transferred, not assigned as a role.',
          );
        }
        await _doc(
          FirestorePaths.member(groupId, uid),
        ).update({'role': role.wireName});
      });

  @override
  Future<void> removeMember(String groupId, String uid) =>
      _guard(() => _doc(FirestorePaths.member(groupId, uid)).delete());

  @override
  Future<CloudInvite> createInvite({
    required CloudGroup group,
    required MemberRole role,
    required String createdByUid,
    int maxUses = 1,
    Duration ttl = CloudInvite.defaultTtl,
  }) => _guard(() async {
    if (role == MemberRole.owner) {
      throw const GroupException('An invite cannot make someone the owner.');
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
      maxUses: maxUses.clamp(1, 50),
    );
    await _doc(FirestorePaths.invite(invite.code)).set(invite.toJson());
    return invite;
  });

  @override
  Stream<List<CloudInvite>> watchInvites(String groupId) => _db
      .collection(FirestorePaths.invitesCollection())
      .where('groupId', isEqualTo: groupId)
      .orderBy('createdAt', descending: true)
      .limit(20)
      .snapshots()
      .map(
        (snap) => snap.docs.map((d) => CloudInvite.fromJson(d.data())).toList(),
      )
      .handleError((Object e) => throw _wrap(e));

  @override
  Future<void> revokeInvite(String code) =>
      _guard(() => _doc(FirestorePaths.invite(code)).update({'revoked': true}));

  @override
  Future<CloudInvite?> findInvite(String code) => _guard(() async {
    final normalised = GroupCodes.normalise(code);
    if (!FirestorePaths.isValidId(normalised)) return null;
    final snap = await _doc(FirestorePaths.invite(normalised)).get();
    final data = snap.data();
    return data == null ? null : CloudInvite.fromJson(data);
  });

  @override
  Future<void> redeemInvite(CloudInvite invite, AppUser user) =>
      _guard(() async {
        final memberRef = _doc(FirestorePaths.member(invite.groupId, user.uid));
        // Reading your own membership row is always allowed, even before you
        // can read anything else in the group.
        if ((await memberRef.get()).exists) return;

        final why = GroupCodes.whyUnusable(invite, DateTime.now());
        if (why != null) throw GroupException(why);

        // 1) Create the membership naming the code — the rules re-check the
        //    invite before allowing it. 2) Burn one use.
        await memberRef.set(
          CloudMembership(
            groupId: invite.groupId,
            uid: user.uid,
            role: invite.role,
            joinedAt: DateTime.now(),
            displayName: user.label,
            photoUrl: user.photoUrl,
            invitedByUid: invite.createdByUid,
            inviteCode: invite.code,
          ).toJson(),
        );
        await _doc(FirestorePaths.invite(invite.code)).update({
          'useCount': FieldValue.increment(1),
          'redeemedByUids': FieldValue.arrayUnion([user.uid]),
        });
        await _publishProfile(user);
      });

  @override
  Future<void> saveProfile(AppUser user) => _guard(
    () => _doc(FirestorePaths.user(user.uid)).set({
      'uid': user.uid,
      'displayName': user.label,
      if (user.photoUrl != null) 'photoUrl': user.photoUrl,
    }),
  );

  /// Best-effort: member lists fall back to the denormalised name on the
  /// membership row, so a failed profile write must not fail the action.
  Future<void> _publishProfile(AppUser user) async {
    try {
      await saveProfile(user);
    } on GroupException {
      // Ignored — see above.
    }
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (e) {
      throw _wrap(e);
    }
  }

  static GroupException _wrap(Object e) {
    if (e is GroupException) return e;
    if (e is FirebaseException) {
      return GroupException(switch (e.code) {
        'permission-denied' =>
          "You don't have permission to do that in this group.",
        'unavailable' => "Can't reach the server — check your connection.",
        'not-found' => 'That no longer exists.',
        _ => 'Something went wrong (${e.code}).',
      });
    }
    return GroupException('Something went wrong: $e');
  }
}
