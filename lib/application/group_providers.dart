import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/groups/firestore_group_service.dart';
import '../data/groups/group_service.dart';
import 'auth_providers.dart';

/// The shared-groups backend (Phase B of docs/12-cloud-sync-plan.md).
/// Only read while signed in, which implies Firebase is initialised.
final groupServiceProvider = Provider<GroupService>(
  (ref) => FirestoreGroupService(),
);

/// The groups the signed-in user belongs to; empty when signed out.
final myGroupsProvider = StreamProvider<List<GroupSummary>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value(const []);
  return ref.watch(groupServiceProvider).watchMyGroups(user.uid);
});

/// Where the chosen group is remembered on this phone, per account.
abstract class ActiveGroupStore {
  Future<String?> read(String uid);
  Future<void> write(String uid, String? groupId);
}

class SharedPrefsActiveGroupStore implements ActiveGroupStore {
  static String _key(String uid) => 'activeGroupId.$uid';

  @override
  Future<String?> read(String uid) =>
      SharedPreferencesAsync().getString(_key(uid));

  @override
  Future<void> write(String uid, String? groupId) => groupId == null
      ? SharedPreferencesAsync().remove(_key(uid))
      : SharedPreferencesAsync().setString(_key(uid), groupId);
}

final activeGroupStoreProvider = Provider<ActiveGroupStore>(
  (ref) => SharedPrefsActiveGroupStore(),
);

/// The id of the group new data is shared into, or null for "Personal"
/// (this phone only). Remembered per account; resets when signing out.
class ActiveGroupController extends AsyncNotifier<String?> {
  @override
  Future<String?> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;
    return ref.read(activeGroupStoreProvider).read(user.uid);
  }

  /// Switch to [groupId], or to Personal with null.
  Future<void> select(String? groupId) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    state = AsyncData(groupId);
    await ref.read(activeGroupStoreProvider).write(user.uid, groupId);
  }
}

final activeGroupIdProvider =
    AsyncNotifierProvider<ActiveGroupController, String?>(
      ActiveGroupController.new,
    );

/// The active group with the user's role in it, or null for Personal. A
/// remembered group the user has since left (or been removed from) falls back
/// to Personal rather than pointing at something they can't read.
final activeGroupProvider = Provider<GroupSummary?>((ref) {
  final id = ref.watch(activeGroupIdProvider).value;
  if (id == null) return null;
  final groups = ref.watch(myGroupsProvider).value ?? const [];
  for (final g in groups) {
    if (g.group.id == id) return g;
  }
  return null;
});
