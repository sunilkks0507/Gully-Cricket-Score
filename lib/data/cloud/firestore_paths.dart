/// The **only** place Firestore path strings are constructed.
///
/// Nothing else in the app should concatenate group/match path fragments by
/// hand. Keeping every path here means the layout documented in
/// `docs/13-firestore-schema.md` and enforced in `firestore.rules` can only
/// drift in one file, and the paths are unit-testable without Firebase.
///
/// Every id is validated: Firestore document ids may not be empty, may not
/// contain a slash, may not be `.` or `..`, and may not be wrapped in double
/// underscores (reserved). An invalid id would otherwise silently create a
/// *different* path — an id containing a slash nests a document one level
/// deeper and can land outside the collection the security rules protect.
library;

/// The synced entity collections that live directly under a group.
///
/// Used by the outbox so a queued change carries its destination collection
/// without hard-coding a string at every call site.
enum SyncedEntity {
  player('players'),
  team('teams'),
  tournament('tournaments'),
  match('matches');

  const SyncedEntity(this.collection);

  /// The collection id under a group document.
  final String collection;

  static SyncedEntity fromCollection(String collection) {
    for (final entity in SyncedEntity.values) {
      if (entity.collection == collection) return entity;
    }
    throw ArgumentError.value(collection, 'collection', 'Unknown collection');
  }
}

/// Builders for every collection and document path in the cloud schema.
class FirestorePaths {
  const FirestorePaths._();

  // --- Collection ids (also referenced verbatim in firestore.rules) ---------

  static const String users = 'users';
  static const String groups = 'groups';
  static const String members = 'members';
  static const String invites = 'invites';
  static const String players = 'players';
  static const String teams = 'teams';
  static const String tournaments = 'tournaments';
  static const String matches = 'matches';
  static const String events = 'events';

  /// Subcollection holding a user's private fields (email, notification
  /// tokens). Readable only by that user — see [userPrivate].
  static const String private = 'private';

  /// Document id of the single private-profile document.
  static const String privateProfileDoc = 'profile';

  // --- Users ----------------------------------------------------------------

  /// The public-profile collection (displayName + photoUrl only).
  static String usersCollection() => users;

  /// A user's public profile document.
  static String user(String uid) => '$users/${_id(uid, 'uid')}';

  /// A user's private profile document — email and anything else that must not
  /// be readable by every signed-in user.
  static String userPrivate(String uid) =>
      '${user(uid)}/$private/$privateProfileDoc';

  // --- Groups & membership --------------------------------------------------

  /// The groups collection.
  static String groupsCollection() => groups;

  /// A group document.
  static String group(String groupId) => '$groups/${_id(groupId, 'groupId')}';

  /// A group's members subcollection.
  static String membersCollection(String groupId) =>
      '${group(groupId)}/$members';

  /// A single membership document — the access check the security rules
  /// perform with a single `exists()`.
  static String member(String groupId, String uid) =>
      '${membersCollection(groupId)}/${_id(uid, 'uid')}';

  /// The collection-group id used to answer "which groups am I in?" with one
  /// query: a collection-group query over `members` filtered on `uid`.
  static String membersCollectionGroup() => members;

  // --- Invites --------------------------------------------------------------

  /// The invites collection — top level, because a redeemer does not yet know
  /// (or have read access to) the group.
  static String invitesCollection() => invites;

  /// A single invite, keyed by its join code.
  static String invite(String code) => '$invites/${_id(code, 'code')}';

  // --- Group content --------------------------------------------------------

  /// The collection for any [SyncedEntity] under a group.
  static String entityCollection(String groupId, SyncedEntity entity) =>
      '${group(groupId)}/${entity.collection}';

  /// A single document for any [SyncedEntity] under a group.
  static String entity(String groupId, SyncedEntity entity, String id) =>
      '${entityCollection(groupId, entity)}/${_id(id, 'id')}';

  /// A group's players collection.
  static String playersCollection(String groupId) =>
      entityCollection(groupId, SyncedEntity.player);

  /// A single player in a group.
  static String player(String groupId, String playerId) =>
      entity(groupId, SyncedEntity.player, playerId);

  /// A group's teams collection.
  static String teamsCollection(String groupId) =>
      entityCollection(groupId, SyncedEntity.team);

  /// A single team in a group.
  static String team(String groupId, String teamId) =>
      entity(groupId, SyncedEntity.team, teamId);

  /// A group's tournaments collection.
  static String tournamentsCollection(String groupId) =>
      entityCollection(groupId, SyncedEntity.tournament);

  /// A single tournament in a group.
  static String tournament(String groupId, String tournamentId) =>
      entity(groupId, SyncedEntity.tournament, tournamentId);

  /// A group's matches collection.
  static String matchesCollection(String groupId) =>
      entityCollection(groupId, SyncedEntity.match);

  /// A single match in a group.
  static String match(String groupId, String matchId) =>
      entity(groupId, SyncedEntity.match, matchId);

  // --- The event log --------------------------------------------------------

  /// A match's append-only event subcollection.
  static String eventsCollection(String groupId, String matchId) =>
      '${match(groupId, matchId)}/$events';

  /// A single event, keyed by uuid — never by `seq` — so a re-sent event
  /// overwrites itself instead of duplicating.
  static String event(String groupId, String matchId, String eventUuid) =>
      '${eventsCollection(groupId, matchId)}/${_id(eventUuid, 'eventUuid')}';

  // --- Validation -----------------------------------------------------------

  /// Whether [id] is a legal Firestore document/collection id.
  static bool isValidId(String id) {
    if (id.isEmpty || id.length > 1500) return false;
    if (id.contains('/')) return false;
    if (id == '.' || id == '..') return false;
    if (id.startsWith('__') && id.endsWith('__')) return false;
    return true;
  }

  static String _id(String value, String label) {
    if (!isValidId(value)) {
      throw ArgumentError.value(
        value,
        label,
        'Not a valid Firestore document id',
      );
    }
    return value;
  }
}
