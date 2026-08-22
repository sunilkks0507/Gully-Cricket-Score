import 'cloud_json.dart';

/// One entry of a match's append-only event log, as it crosses the wire.
///
/// Firestore document: `groups/{gid}/matches/{matchId}/events/{eventUuid}`.
///
/// ## Why the payload is an opaque string
/// [payloadJson] is the *verbatim* serialised `GameEvent` — the same string the
/// local `Events.payloadJson` column holds (see `lib/data/event_codec.dart`).
/// The cloud layer never looks inside it. That means:
/// * adding a new field to `BallEvent`, or an 11th event kind, needs **no**
///   Firestore schema change, no rules change and no index change;
/// * the bytes round-trip identically, so a folded scorecard on device B is
///   bit-for-bit what device A folded;
/// * we dodge Firestore's map-key restrictions and nested-depth limits for a
///   payload we would never query into anyway.
/// The cost is that events are not server-queryable by content. We never need
/// that: stats are folded on-device.
///
/// ## Why the document id is [eventUuid]
/// Keying by a stable client-generated uuid makes merging a **union**: the same
/// event written twice (retry, two devices replaying the same outbox) lands on
/// the same document id and is idempotent. There is no conflict to resolve,
/// which is the whole reason the app is event-sourced.
///
/// ## Ordering, undo and [revision]
/// [seq] is the per-match position used to fold the log. Undo does not delete
/// cloud events (they are immutable and `update`/`delete` are denied by the
/// rules); it moves `matches/{matchId}.eventCursor` back. If the scorer then
/// scores something different, the new event reuses a [seq] that an abandoned
/// event already occupies.
///
/// [revision] disambiguates that: it is a strictly increasing counter of every
/// append ever made to this match, never decremented by undo. The fold rule is:
///
/// > take events with `seq <= match.eventCursor`; where two share a `seq`, keep
/// > the one with the highest `revision`.
///
/// This is clock-free (no reliance on device time) and deterministic, and it is
/// safe precisely because the per-match single-scorer lock means only one device
/// is minting revisions at a time.
class CloudEventEnvelope {
  const CloudEventEnvelope({
    required this.eventUuid,
    required this.groupId,
    required this.matchId,
    required this.seq,
    required this.revision,
    required this.type,
    required this.payloadJson,
    required this.authorUid,
    required this.createdAt,
    this.schemaVersion = currentSchemaVersion,
  });

  /// Bumped only if the *envelope* shape changes. The payload inside is
  /// versioned by the domain models, not by this.
  static const int currentSchemaVersion = 1;

  /// The 10 event kinds the engine currently folds. Mirrors the freezed union
  /// discriminators in `lib/models/game_event.dart` (`runtimeType` in the
  /// payload). Used for cheap filtering and for sanity-checking a sync; the
  /// engine, not this list, remains the authority.
  static const Set<String> knownTypes = <String>{
    'matchCreated',
    'inningsStarted',
    'ball',
    'penalty',
    'batterReplaced',
    'swapStrike',
    'bowlerChanged',
    'rulesChanged',
    'endInnings',
  };

  /// Stable client-generated uuid; also the document id.
  final String eventUuid;

  final String groupId;

  final String matchId;

  /// 1-based per-match ordering.
  final int seq;

  /// Strictly increasing append counter (see class docs).
  final int revision;

  /// Event kind (the payload's `runtimeType` discriminator), denormalised so a
  /// listener can filter without parsing the payload.
  final String type;

  /// Verbatim serialised `GameEvent`. Opaque to this layer.
  final String payloadJson;

  /// Who appended it — the scorer at the time. Kept for the audit trail and for
  /// "who scored this over?" attribution after a handover.
  final String authorUid;

  final DateTime createdAt;

  final int schemaVersion;

  /// True when [type] is one this build understands. A `false` here means the
  /// event came from a newer client: the sync layer should stop folding rather
  /// than silently drop a ball.
  bool get isKnownType => knownTypes.contains(type);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'eventUuid': eventUuid,
    'groupId': groupId,
    'matchId': matchId,
    'seq': seq,
    'revision': revision,
    'type': type,
    'payloadJson': payloadJson,
    'authorUid': authorUid,
    'createdAt': CloudJson.millis(createdAt),
    'schemaVersion': schemaVersion,
  };

  factory CloudEventEnvelope.fromJson(Map<String, dynamic> json) =>
      CloudEventEnvelope(
        eventUuid: CloudJson.requireString(json, 'eventUuid'),
        groupId: CloudJson.requireString(json, 'groupId'),
        matchId: CloudJson.requireString(json, 'matchId'),
        seq: CloudJson.requireInt(json, 'seq'),
        revision: CloudJson.requireInt(json, 'revision'),
        type: CloudJson.requireString(json, 'type'),
        payloadJson: CloudJson.requireString(json, 'payloadJson'),
        authorUid: CloudJson.requireString(json, 'authorUid'),
        createdAt: CloudJson.requireTime(json, 'createdAt'),
        schemaVersion: CloudJson.optionalInt(
          json,
          'schemaVersion',
          fallback: currentSchemaVersion,
        ),
      );

  CloudEventEnvelope copyWith({
    String? eventUuid,
    String? groupId,
    String? matchId,
    int? seq,
    int? revision,
    String? type,
    String? payloadJson,
    String? authorUid,
    DateTime? createdAt,
    int? schemaVersion,
  }) => CloudEventEnvelope(
    eventUuid: eventUuid ?? this.eventUuid,
    groupId: groupId ?? this.groupId,
    matchId: matchId ?? this.matchId,
    seq: seq ?? this.seq,
    revision: revision ?? this.revision,
    type: type ?? this.type,
    payloadJson: payloadJson ?? this.payloadJson,
    authorUid: authorUid ?? this.authorUid,
    createdAt: createdAt ?? this.createdAt,
    schemaVersion: schemaVersion ?? this.schemaVersion,
  );

  /// Fold-ordering comparator: by [seq], then by [revision] so the surviving
  /// event of a re-scored position sorts last.
  static int compare(CloudEventEnvelope a, CloudEventEnvelope b) {
    final bySeq = a.seq.compareTo(b.seq);
    return bySeq != 0 ? bySeq : a.revision.compareTo(b.revision);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloudEventEnvelope &&
          other.eventUuid == eventUuid &&
          other.groupId == groupId &&
          other.matchId == matchId &&
          other.seq == seq &&
          other.revision == revision &&
          other.type == type &&
          other.payloadJson == payloadJson &&
          other.authorUid == authorUid &&
          other.createdAt == createdAt &&
          other.schemaVersion == schemaVersion;

  @override
  int get hashCode => Object.hash(
    eventUuid,
    groupId,
    matchId,
    seq,
    revision,
    type,
    payloadJson,
    authorUid,
    createdAt,
    schemaVersion,
  );

  @override
  String toString() => 'CloudEventEnvelope($type #$seq r$revision $eventUuid)';
}
