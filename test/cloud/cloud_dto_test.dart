import 'dart:convert';

import 'package:cricket_scoring/data/cloud/cloud.dart';
import 'package:flutter_test/flutter_test.dart';

/// Round-trip and contract tests for the plain-Dart Firestore DTOs.
///
/// These are the shapes `firestore.rules` validates, so a change here that is
/// not mirrored in the rules will fail closed in production — keep the two in
/// sync (see docs/13-firestore-schema.md).
void main() {
  final createdAt = DateTime.utc(2026, 8, 1, 10, 30);
  final updatedAt = DateTime.utc(2026, 8, 2, 18, 5);

  group('MemberRole', () {
    test('wire names match the strings compared in firestore.rules', () {
      expect(MemberRole.owner.wireName, 'owner');
      expect(MemberRole.editor.wireName, 'editor');
      expect(MemberRole.viewer.wireName, 'viewer');
    });

    test('round-trips through the wire name', () {
      for (final role in MemberRole.values) {
        expect(MemberRole.fromWire(role.wireName), role);
      }
    });

    test('an unknown role is loud, never silently downgraded', () {
      expect(() => MemberRole.fromWire('admin'), throwsFormatException);
      expect(MemberRole.tryFromWire('admin'), isNull);
      expect(MemberRole.tryFromWire(null), isNull);
    });

    test('viewers can never edit or score', () {
      expect(MemberRole.viewer.canEdit, isFalse);
      expect(MemberRole.viewer.canScore, isFalse);
      expect(MemberRole.viewer.isReadOnly, isTrue);
      expect(MemberRole.viewer.canManageMembers, isFalse);
      expect(MemberRole.viewer.canDeleteGroup, isFalse);
    });

    test('editors edit and score but do not administer', () {
      expect(MemberRole.editor.canEdit, isTrue);
      expect(MemberRole.editor.canScore, isTrue);
      expect(MemberRole.editor.canManageMembers, isFalse);
      expect(MemberRole.editor.canDeleteGroup, isFalse);
    });

    test('only the owner administers and deletes', () {
      expect(MemberRole.owner.canEdit, isTrue);
      expect(MemberRole.owner.canScore, isTrue);
      expect(MemberRole.owner.canManageMembers, isTrue);
      expect(MemberRole.owner.canDeleteGroup, isTrue);
    });

    test('atLeast orders owner > editor > viewer', () {
      expect(MemberRole.owner.atLeast(MemberRole.editor), isTrue);
      expect(MemberRole.editor.atLeast(MemberRole.editor), isTrue);
      expect(MemberRole.editor.atLeast(MemberRole.owner), isFalse);
      expect(MemberRole.viewer.atLeast(MemberRole.editor), isFalse);
    });
  });

  group('CloudGroup', () {
    final cloudGroup = CloudGroup(
      id: 'g1',
      name: 'Sunday Warriors CC',
      ownerUid: 'uid-owner',
      createdAt: createdAt,
      updatedAt: updatedAt,
      description: 'Weekend box cricket',
    );

    test('round-trips through JSON', () {
      expect(CloudGroup.fromJson(cloudGroup.toJson()), cloudGroup);
    });

    test('round-trips through a real JSON encode/decode', () {
      final decoded =
          jsonDecode(jsonEncode(cloudGroup.toJson())) as Map<String, dynamic>;
      expect(CloudGroup.fromJson(decoded), cloudGroup);
    });

    test('carries its own id so the rules can check body against path', () {
      expect(cloudGroup.toJson()['id'], 'g1');
    });

    test('timestamps cross the wire as epoch millis, not DateTime', () {
      expect(
        cloudGroup.toJson()['createdAt'],
        createdAt.millisecondsSinceEpoch,
      );
      expect(cloudGroup.toJson()['createdAt'], isA<int>());
    });

    test('omits an absent description rather than writing null', () {
      final bare = cloudGroup.copyWith(description: null);
      expect(bare.toJson().containsKey('description'), isFalse);
      expect(CloudGroup.fromJson(bare.toJson()).description, isNull);
    });

    test('copyWith leaves a nullable field alone unless it is passed', () {
      expect(
        cloudGroup.copyWith(name: 'Renamed').description,
        cloudGroup.description,
      );
      expect(cloudGroup.copyWith(name: 'Renamed').name, 'Renamed');
    });

    test('defaults schemaVersion when an older document lacks it', () {
      final json = cloudGroup.toJson()..remove('schemaVersion');
      expect(
        CloudGroup.fromJson(json).schemaVersion,
        CloudGroup.currentSchemaVersion,
      );
    });

    test('rejects a document missing a required field', () {
      final json = cloudGroup.toJson()..remove('ownerUid');
      expect(() => CloudGroup.fromJson(json), throwsFormatException);
    });
  });

  group('CloudMembership', () {
    final membership = CloudMembership(
      groupId: 'g1',
      uid: 'uid-2',
      role: MemberRole.editor,
      joinedAt: createdAt,
      displayName: 'Ravi',
      photoUrl: 'https://example.test/r.png',
      invitedByUid: 'uid-owner',
      inviteCode: 'ABCDEFGHJK',
    );

    test('round-trips through JSON', () {
      expect(CloudMembership.fromJson(membership.toJson()), membership);
    });

    test('stores the role as its wire name', () {
      expect(membership.toJson()['role'], 'editor');
    });

    test('carries uid and groupId for the collection-group query', () {
      // collectionGroup('members').where('uid', isEqualTo: me) cannot filter on
      // the parent path, so both must live in the body.
      expect(membership.toJson()['uid'], 'uid-2');
      expect(membership.toJson()['groupId'], 'g1');
    });

    test('carries the inviteCode the rules re-check on create', () {
      expect(membership.toJson()['inviteCode'], 'ABCDEFGHJK');
    });

    test('the founding owner has no invite code', () {
      final founder = CloudMembership(
        groupId: 'g1',
        uid: 'uid-owner',
        role: MemberRole.owner,
        joinedAt: createdAt,
      );
      expect(founder.toJson().containsKey('inviteCode'), isFalse);
      expect(CloudMembership.fromJson(founder.toJson()), founder);
    });

    test('rejects an unknown role', () {
      final json = membership.toJson()..['role'] = 'superuser';
      expect(() => CloudMembership.fromJson(json), throwsFormatException);
    });

    test('copyWith can clear a denormalised field explicitly', () {
      expect(membership.copyWith(photoUrl: null).photoUrl, isNull);
      expect(
        membership.copyWith(displayName: 'Ravi K').photoUrl,
        membership.photoUrl,
      );
    });
  });

  group('CloudInvite', () {
    final invite = CloudInvite(
      code: 'ABCDEFGHJK',
      groupId: 'g1',
      groupName: 'Sunday Warriors CC',
      role: MemberRole.viewer,
      createdByUid: 'uid-owner',
      createdAt: createdAt,
      expiresAt: createdAt.add(CloudInvite.defaultTtl),
      maxUses: 5,
      useCount: 2,
      redeemedByUids: const ['uid-2', 'uid-3'],
    );

    test('round-trips through JSON', () {
      expect(CloudInvite.fromJson(invite.toJson()), invite);
    });

    test('round-trips the redeemer list', () {
      final decoded =
          jsonDecode(jsonEncode(invite.toJson())) as Map<String, dynamic>;
      expect(CloudInvite.fromJson(decoded).redeemedByUids, ['uid-2', 'uid-3']);
    });

    test(
      'carries the group name so a non-member can see what they are joining',
      () {
        // At redeem time the user cannot read groups/{gid} yet.
        expect(invite.toJson()['groupName'], 'Sunday Warriors CC');
      },
    );

    test('is redeemable while unexpired, unrevoked and under maxUses', () {
      expect(invite.isRedeemableAt(createdAt), isTrue);
    });

    test('is not redeemable after expiry', () {
      expect(
        invite.isRedeemableAt(createdAt.add(const Duration(days: 8))),
        isFalse,
      );
    });

    test('is not redeemable once uses are exhausted', () {
      expect(invite.copyWith(useCount: 5).isRedeemableAt(createdAt), isFalse);
    });

    test('revoking kills it immediately', () {
      expect(invite.copyWith(revoked: true).isRedeemableAt(createdAt), isFalse);
    });

    test('tracks who has already redeemed', () {
      expect(invite.wasRedeemedBy('uid-2'), isTrue);
      expect(invite.wasRedeemedBy('uid-9'), isFalse);
    });

    test('defaults to a single use when the field is absent', () {
      final json = invite.toJson()..remove('maxUses');
      expect(CloudInvite.fromJson(json).maxUses, 1);
    });

    test('an unambiguous code alphabet avoids 0/O and 1/I/L confusion', () {
      for (final char in ['0', 'O', '1', 'I', 'L']) {
        expect(
          CloudInvite.codeAlphabet.contains(char),
          isFalse,
          reason: 'codes are read aloud and typed from photos',
        );
      }
      expect(CloudInvite.codeLength, greaterThanOrEqualTo(8));
    });
  });

  group('CloudEventEnvelope', () {
    final envelope = CloudEventEnvelope(
      eventUuid: 'e-uuid-1',
      groupId: 'g1',
      matchId: 'm1',
      seq: 42,
      revision: 42,
      type: 'ball',
      payloadJson: '{"runtimeType":"ball","ball":{"runs":4}}',
      authorUid: 'uid-2',
      createdAt: createdAt,
    );

    test('round-trips through JSON', () {
      expect(CloudEventEnvelope.fromJson(envelope.toJson()), envelope);
    });

    test(
      'keeps the payload byte-identical so both devices fold the same bytes',
      () {
        final decoded =
            jsonDecode(jsonEncode(envelope.toJson())) as Map<String, dynamic>;
        expect(
          CloudEventEnvelope.fromJson(decoded).payloadJson,
          envelope.payloadJson,
        );
      },
    );

    test('the payload stays an opaque string, never a parsed map', () {
      expect(envelope.toJson()['payloadJson'], isA<String>());
    });

    test('knows the ten event kinds the engine folds today', () {
      // Mirrors the freezed union in lib/models/game_event.dart.
      expect(
        CloudEventEnvelope.knownTypes,
        containsAll(<String>[
          'matchCreated',
          'inningsStarted',
          'ball',
          'penalty',
          'batterReplaced',
          'swapStrike',
          'bowlerChanged',
          'rulesChanged',
          'endInnings',
        ]),
      );
      expect(envelope.isKnownType, isTrue);
      expect(envelope.copyWith(type: 'superOverStart').isKnownType, isFalse);
    });

    test('body agrees with its own path (what the rules assert)', () {
      final json = envelope.toJson();
      expect(
        FirestorePaths.event(
          json['groupId'] as String,
          json['matchId'] as String,
          json['eventUuid'] as String,
        ),
        'groups/g1/matches/m1/events/e-uuid-1',
      );
    });

    test('sorts by seq, then by revision so a re-scored ball wins', () {
      // Undo does not delete cloud events; the replacement reuses the seq with
      // a higher revision, and the fold keeps the highest revision per seq.
      final abandoned = envelope.copyWith(eventUuid: 'e-old', revision: 42);
      final replacement = envelope.copyWith(eventUuid: 'e-new', revision: 57);
      final ordered = <CloudEventEnvelope>[replacement, abandoned]
        ..sort(CloudEventEnvelope.compare);
      expect(ordered.map((e) => e.eventUuid), ['e-old', 'e-new']);
    });

    test('orders across different seqs before comparing revisions', () {
      final first = envelope.copyWith(seq: 1, revision: 99);
      final second = envelope.copyWith(seq: 2, revision: 1);
      expect(CloudEventEnvelope.compare(first, second), lessThan(0));
    });

    test('rejects a document missing the uuid', () {
      final json = envelope.toJson()..remove('eventUuid');
      expect(() => CloudEventEnvelope.fromJson(json), throwsFormatException);
    });
  });

  group('CloudJson', () {
    test('reads timestamps written as millis, ISO strings or DateTime', () {
      final millis = <String, dynamic>{'t': createdAt.millisecondsSinceEpoch};
      final iso = <String, dynamic>{'t': createdAt.toIso8601String()};
      final native = <String, dynamic>{'t': createdAt};

      expect(CloudJson.requireTime(millis, 't'), createdAt);
      expect(CloudJson.requireTime(iso, 't'), createdAt);
      expect(CloudJson.requireTime(native, 't'), createdAt);
    });

    test('normalises timestamps to UTC', () {
      final local = <String, dynamic>{'t': DateTime(2026, 8, 1, 10, 30)};
      expect(CloudJson.requireTime(local, 't').isUtc, isTrue);
    });

    test('accepts a whole number written as a double by another client', () {
      expect(CloudJson.requireInt(<String, dynamic>{'n': 7.0}, 'n'), 7);
    });

    test('treats an empty string as an absent optional field', () {
      expect(CloudJson.optionalString(<String, dynamic>{'s': ''}, 's'), isNull);
    });

    test('rejects malformed values loudly', () {
      expect(
        () => CloudJson.requireString(<String, dynamic>{'s': 3}, 's'),
        throwsFormatException,
      );
      expect(
        () => CloudJson.requireTime(<String, dynamic>{'t': 'not-a-date'}, 't'),
        throwsFormatException,
      );
      expect(
        () => CloudJson.stringList(<String, dynamic>{
          'l': [1, 2],
        }, 'l'),
        throwsFormatException,
      );
    });

    test('prunes nulls so absent fields are never written explicitly', () {
      expect(
        CloudJson.pruneNulls(<String, dynamic>{'a': 1, 'b': null}),
        <String, dynamic>{'a': 1},
      );
    });
  });
}
