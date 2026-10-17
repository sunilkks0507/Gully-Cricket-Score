import 'package:cricket_scoring/application/auth_providers.dart';
import 'package:cricket_scoring/application/group_providers.dart';
import 'package:cricket_scoring/data/auth/app_user.dart';
import 'package:cricket_scoring/features/groups/groups_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../auth/fake_auth_service.dart';
import 'fake_group_service.dart';

void main() {
  Future<FakeGroupService> pump(WidgetTester tester, AppUser? user) async {
    final groups = FakeGroupService();
    final store = MemoryActiveGroupStore();
    if (user != null) {
      final g = groups.seedGroup('Lions CC', user);
      store.values[user.uid] = g.id;
    }
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authServiceProvider.overrideWithValue(
            FakeAuthService(initialUser: user),
          ),
          groupServiceProvider.overrideWithValue(groups),
          activeGroupStoreProvider.overrideWithValue(store),
        ],
        child: const MaterialApp(home: Scaffold(body: GroupsSection())),
      ),
    );
    await tester.pumpAndSettle();
    return groups;
  }

  testWidgets('hidden while signed out', (tester) async {
    await pump(tester, null);
    expect(find.text('Sharing'), findsNothing);
  });

  testWidgets('shows the active group when signed in', (tester) async {
    await pump(tester, const AppUser(uid: 'u1', displayName: 'Sam'));
    expect(find.text('Sharing'), findsOneWidget);
    expect(find.text('Saving to Lions CC'), findsOneWidget);
  });
}
