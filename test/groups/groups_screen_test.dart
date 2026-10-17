import 'package:cricket_scoring/application/auth_providers.dart';
import 'package:cricket_scoring/application/group_providers.dart';
import 'package:cricket_scoring/data/auth/app_user.dart';
import 'package:cricket_scoring/data/cloud/cloud.dart';
import 'package:cricket_scoring/data/groups/group_service.dart';
import 'package:cricket_scoring/features/groups/group_detail_screen.dart';
import 'package:cricket_scoring/features/groups/groups_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../auth/fake_auth_service.dart';
import 'fake_group_service.dart';

const alice = AppUser(uid: 'alice', displayName: 'Alice');
const bob = AppUser(uid: 'bob', displayName: 'Bob');

void main() {
  late FakeGroupService groups;
  late MemoryActiveGroupStore store;

  setUp(() {
    groups = FakeGroupService();
    store = MemoryActiveGroupStore();
  });

  Future<ProviderContainer> pump(
    WidgetTester tester, {
    AppUser user = alice,
    String initial = '/groups',
  }) async {
    final router = GoRouter(
      initialLocation: initial,
      routes: [
        GoRoute(
          path: '/groups',
          name: 'groups',
          builder: (c, s) => const GroupsScreen(),
        ),
        GoRoute(
          path: '/groups/:id',
          name: 'groupDetail',
          builder: (c, s) =>
              GroupDetailScreen(groupId: s.pathParameters['id']!),
        ),
      ],
    );
    final container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(
          FakeAuthService(initialUser: user),
        ),
        groupServiceProvider.overrideWithValue(groups),
        activeGroupStoreProvider.overrideWithValue(store),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  Future<void> enter(WidgetTester tester, String text, String button) async {
    await tester.enterText(find.byType(TextField), text);
    await tester.tap(find.widgetWithText(FilledButton, button));
    await tester.pumpAndSettle();
  }

  testWidgets('starts on Personal with no groups', (tester) async {
    final c = await pump(tester);
    expect(find.text('Personal'), findsOneWidget);
    expect(find.text('No groups yet'), findsOneWidget);
    expect(c.read(activeGroupProvider), isNull);
  });

  testWidgets('creating a group makes it active and remembers it', (
    tester,
  ) async {
    final c = await pump(tester);
    await tester.tap(find.text('New group'));
    await tester.pumpAndSettle();
    await enter(tester, 'Sunday Warriors', 'Create');

    expect(find.text('Sunday Warriors'), findsOneWidget);
    expect(find.text('Owner'), findsOneWidget);
    final active = c.read(activeGroupProvider);
    expect(active?.group.name, 'Sunday Warriors');
    expect(store.values['alice'], active!.group.id, reason: 'persisted');

    // Back to Personal.
    await tester.tap(find.text('Personal'));
    await tester.pumpAndSettle();
    expect(c.read(activeGroupProvider), isNull);
    expect(store.values['alice'], isNull);
  });

  testWidgets('joining with a code adds the group as the invited role', (
    tester,
  ) async {
    final g = groups.seedGroup('Lions CC', alice);
    final invite = await groups.createInvite(
      group: g,
      role: MemberRole.viewer,
      createdByUid: 'alice',
    );
    final c = await pump(tester, user: bob);

    await tester.tap(find.text('Join with code'));
    await tester.pumpAndSettle();
    // Typed in lower case with a dash, as people do.
    final typed = '${invite.code.substring(0, 5)}-${invite.code.substring(5)}'
        .toLowerCase();
    await enter(tester, typed, 'Find');

    expect(find.text('Join Lions CC?'), findsOneWidget);
    expect(find.textContaining('join as viewer'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Join'));
    await tester.pumpAndSettle();

    expect(groups.roleOf(g.id, 'bob'), MemberRole.viewer);
    expect(groups.invites[invite.code]!.useCount, 1);
    expect(c.read(activeGroupProvider)?.group.id, g.id);
    expect(find.text('Viewer'), findsOneWidget);
  });

  testWidgets('a wrong or used-up code explains why', (tester) async {
    final g = groups.seedGroup('Lions CC', alice);
    final used = await groups.createInvite(
      group: g,
      role: MemberRole.editor,
      createdByUid: 'alice',
    );
    groups.invites[used.code] = used.copyWith(useCount: 1);
    await pump(tester, user: bob);

    await tester.tap(find.text('Join with code'));
    await tester.pumpAndSettle();
    await enter(tester, 'NOSUCHCODE', 'Find');
    expect(find.text('No invite matches that code.'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Join with code'));
    await tester.pumpAndSettle();
    await enter(tester, used.code, 'Find');
    expect(find.text('This invite has already been used.'), findsOneWidget);
    expect(groups.roleOf(g.id, 'bob'), isNull);
  });

  testWidgets('a group you left falls back to Personal', (tester) async {
    final g = groups.seedGroup('Lions CC', alice);
    groups.seedMember(g.id, bob, MemberRole.editor);
    store.values['bob'] = g.id;
    final c = await pump(tester, user: bob);
    expect(c.read(activeGroupProvider)?.group.id, g.id);

    await groups.removeMember(g.id, 'bob'); // e.g. removed by the owner
    await tester.pumpAndSettle();
    expect(c.read(activeGroupProvider), isNull);
  });

  group('group details', () {
    testWidgets('the owner invites people and sees the code', (tester) async {
      final g = groups.seedGroup('Lions CC', alice);
      await pump(tester, initial: '/groups/${g.id}');

      expect(find.text('Alice (you)'), findsOneWidget);
      await tester.tap(find.text('Invite people'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Viewer'));
      await tester.tap(find.text('5'));
      await tester.tap(find.text('Create code'));
      await tester.pumpAndSettle();

      final invite = groups.invites.values.single;
      expect(invite.role, MemberRole.viewer);
      expect(invite.maxUses, 5);
      expect(find.text(formatCode(invite.code)), findsWidgets);
      expect(find.textContaining('5 uses'), findsOneWidget);
    });

    testWidgets('the owner changes a role and removes a member', (
      tester,
    ) async {
      final g = groups.seedGroup('Lions CC', alice);
      groups.seedMember(g.id, bob, MemberRole.viewer);
      await pump(tester, initial: '/groups/${g.id}');

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Make editor'));
      await tester.pumpAndSettle();
      expect(groups.roleOf(g.id, 'bob'), MemberRole.editor);

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Remove from group'));
      await tester.pumpAndSettle();
      expect(groups.roleOf(g.id, 'bob'), isNull);
    });

    testWidgets('viewers see no invite or member controls', (tester) async {
      final g = groups.seedGroup('Lions CC', alice);
      groups.seedMember(g.id, bob, MemberRole.viewer);
      await pump(tester, user: bob, initial: '/groups/${g.id}');

      expect(find.text('Invite people'), findsNothing);
      expect(find.byType(PopupMenuButton<String>), findsNothing);
      expect(find.text('Leave group'), findsOneWidget);
    });

    testWidgets('leaving resets the active group to Personal', (tester) async {
      final g = groups.seedGroup('Lions CC', alice);
      groups.seedMember(g.id, bob, MemberRole.editor);
      store.values['bob'] = g.id;
      final c = await pump(tester, user: bob, initial: '/groups/${g.id}');

      await tester.tap(find.text('Leave group'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Leave'));
      await tester.pumpAndSettle();

      expect(groups.roleOf(g.id, 'bob'), isNull);
      expect(store.values['bob'], isNull);
      expect(c.read(activeGroupProvider), isNull);
    });

    testWidgets('the owner has no leave option', (tester) async {
      final g = groups.seedGroup('Lions CC', alice);
      await pump(tester, initial: '/groups/${g.id}');
      expect(find.text('Leave group'), findsNothing);
    });
  });

  group('GroupCodes', () {
    test('generates unambiguous 10-character codes', () {
      final codes = {for (var i = 0; i < 200; i++) GroupCodes.generate()};
      expect(codes.length, 200, reason: 'no collisions in a small sample');
      for (final code in codes) {
        expect(code.length, CloudInvite.codeLength);
        expect(code.split('').every(CloudInvite.codeAlphabet.contains), isTrue);
      }
    });

    test('normalises what people type', () {
      expect(GroupCodes.normalise(' abcde-fghjk '), 'ABCDEFGHJK');
      expect(GroupCodes.normalise('abc de'), 'ABCDE');
    });
  });
}
