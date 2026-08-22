import 'package:cricket_scoring/data/cloud/cloud.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const gid = 'group-1';
  const matchId = 'match-9';

  group('FirestorePaths', () {
    test('builds the documented user paths', () {
      expect(FirestorePaths.usersCollection(), 'users');
      expect(FirestorePaths.user('abc'), 'users/abc');
      expect(FirestorePaths.userPrivate('abc'), 'users/abc/private/profile');
    });

    test('builds the documented group and membership paths', () {
      expect(FirestorePaths.groupsCollection(), 'groups');
      expect(FirestorePaths.group(gid), 'groups/group-1');
      expect(FirestorePaths.membersCollection(gid), 'groups/group-1/members');
      expect(FirestorePaths.member(gid, 'u1'), 'groups/group-1/members/u1');
      expect(FirestorePaths.membersCollectionGroup(), 'members');
    });

    test('builds top-level invite paths (not nested under the group)', () {
      expect(FirestorePaths.invitesCollection(), 'invites');
      expect(FirestorePaths.invite('ABCDEFGHJK'), 'invites/ABCDEFGHJK');
      // A redeemer has no group access yet, so the code must be addressable
      // without knowing the group id.
      expect(FirestorePaths.invite('X').contains('groups'), isFalse);
    });

    test('builds the group content collections', () {
      expect(FirestorePaths.playersCollection(gid), 'groups/group-1/players');
      expect(FirestorePaths.player(gid, 'p1'), 'groups/group-1/players/p1');
      expect(FirestorePaths.teamsCollection(gid), 'groups/group-1/teams');
      expect(FirestorePaths.team(gid, 't1'), 'groups/group-1/teams/t1');
      expect(
        FirestorePaths.tournamentsCollection(gid),
        'groups/group-1/tournaments',
      );
      expect(
        FirestorePaths.tournament(gid, 'tr1'),
        'groups/group-1/tournaments/tr1',
      );
      expect(FirestorePaths.matchesCollection(gid), 'groups/group-1/matches');
      expect(
        FirestorePaths.match(gid, matchId),
        'groups/group-1/matches/match-9',
      );
    });

    test('keys events by uuid under the match, never by seq', () {
      expect(
        FirestorePaths.eventsCollection(gid, matchId),
        'groups/group-1/matches/match-9/events',
      );
      expect(
        FirestorePaths.event(gid, matchId, 'uuid-abc'),
        'groups/group-1/matches/match-9/events/uuid-abc',
      );
    });

    test('entity() agrees with the named helpers', () {
      expect(
        FirestorePaths.entity(gid, SyncedEntity.player, 'p1'),
        FirestorePaths.player(gid, 'p1'),
      );
      expect(
        FirestorePaths.entity(gid, SyncedEntity.match, matchId),
        FirestorePaths.match(gid, matchId),
      );
      expect(
        FirestorePaths.entityCollection(gid, SyncedEntity.tournament),
        FirestorePaths.tournamentsCollection(gid),
      );
    });

    test(
      'every path has an odd/even segment count matching doc vs collection',
      () {
        // Firestore invariant: collections have an odd number of segments,
        // documents an even one. Getting this wrong is a runtime type error.
        int segments(String path) => path.split('/').length;

        expect(segments(FirestorePaths.groupsCollection()).isOdd, isTrue);
        expect(segments(FirestorePaths.membersCollection(gid)).isOdd, isTrue);
        expect(
          segments(FirestorePaths.eventsCollection(gid, matchId)).isOdd,
          isTrue,
        );
        expect(segments(FirestorePaths.invitesCollection()).isOdd, isTrue);

        expect(segments(FirestorePaths.group(gid)).isEven, isTrue);
        expect(segments(FirestorePaths.member(gid, 'u1')).isEven, isTrue);
        expect(segments(FirestorePaths.match(gid, matchId)).isEven, isTrue);
        expect(
          segments(FirestorePaths.event(gid, matchId, 'e1')).isEven,
          isTrue,
        );
        expect(segments(FirestorePaths.userPrivate('u1')).isEven, isTrue);
      },
    );
  });

  group('FirestorePaths id validation', () {
    test('accepts ordinary uuids and join codes', () {
      expect(
        FirestorePaths.isValidId('9f1c1a3e-6a1b-4a5c-8d2e-2b7f0c9d1e4a'),
        isTrue,
      );
      expect(FirestorePaths.isValidId('ABCDEFGHJK'), isTrue);
    });

    test('rejects ids that would silently change the path', () {
      expect(FirestorePaths.isValidId(''), isFalse);
      expect(FirestorePaths.isValidId('a/b'), isFalse);
      expect(FirestorePaths.isValidId('.'), isFalse);
      expect(FirestorePaths.isValidId('..'), isFalse);
      expect(FirestorePaths.isValidId('__name__'), isFalse);
      expect(FirestorePaths.isValidId('x' * 1501), isFalse);
    });

    test('throws rather than building a path that escapes its collection', () {
      // 'a/../../evil' would land outside groups/{gid}, where the security
      // rules no longer apply.
      expect(() => FirestorePaths.group('a/b'), throwsA(isA<ArgumentError>()));
      expect(
        () => FirestorePaths.member(gid, ''),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => FirestorePaths.event(gid, matchId, 'has/slash'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('SyncedEntity', () {
    test('maps to the collection ids used in firestore.rules', () {
      expect(SyncedEntity.player.collection, 'players');
      expect(SyncedEntity.team.collection, 'teams');
      expect(SyncedEntity.tournament.collection, 'tournaments');
      expect(SyncedEntity.match.collection, 'matches');
    });

    test('round-trips through fromCollection', () {
      for (final entity in SyncedEntity.values) {
        expect(SyncedEntity.fromCollection(entity.collection), entity);
      }
      expect(
        () => SyncedEntity.fromCollection('nope'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
