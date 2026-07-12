import 'package:drift/drift.dart';

import '../../models/enums.dart';

/// Relational schema. IDs are uuid strings (merge-friendly for future sync);
/// the [Events] log is the append-only source of truth. See docs/06-data-model.md.
///
/// Rule flags and ball payloads live in JSON text columns so additive changes
/// need no migration — only new tables/columns do.

/// A person who bats/bowls. Can belong to many teams.
class Players extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nickname => text().nullable()();
  TextColumn get battingStyle => text().nullable()();
  TextColumn get bowlingStyle => text().nullable()();
  TextColumn get role => textEnum<PlayerRole>().nullable()();
  TextColumn get photoPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// A club/side.
class Teams extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get shortName => text().nullable()();
  TextColumn get logoPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Roster link: a player on a team.
@TableIndex(name: 'idx_team_player_player', columns: {#playerId})
class TeamPlayers extends Table {
  TextColumn get teamId => text()();
  TextColumn get playerId => text()();
  IntColumn get jerseyNo => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {teamId, playerId};
}

/// A match. `rulesJson` holds the serialised [MatchRules]; `resultJson` the
/// serialised [MatchResult]. `eventCursor` drives undo/redo over the log.
@DataClassName('MatchRow')
@TableIndex(name: 'idx_match_status', columns: {#status})
@TableIndex(name: 'idx_match_tournament', columns: {#tournamentId})
class Matches extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().nullable()();

  /// Preset id the match was created from (e.g. 'box_cricket', 'custom').
  TextColumn get format => text()();

  /// Serialised [MatchRules].
  TextColumn get rulesJson => text()();

  TextColumn get teamAId => text()();
  TextColumn get teamBId => text()();
  TextColumn get venue => text().nullable()();
  DateTimeColumn get dateLocal => dateTime()();

  /// Standalone vs part of a tournament (CricScore prompts for this at setup).
  TextColumn get matchType =>
      textEnum<MatchType>().withDefault(const Constant('standalone'))();

  /// The pooled player designated as the joker (plays for both sides), if any.
  TextColumn get jokerPlayerId => text().nullable()();

  TextColumn get tossWinnerTeamId => text().nullable()();
  TextColumn get tossDecision => textEnum<TossDecision>().nullable()();

  TextColumn get status =>
      textEnum<MatchStatus>().withDefault(const Constant('notStarted'))();

  /// Serialised [MatchResult]; null until completed.
  TextColumn get resultJson => text().nullable()();

  TextColumn get tournamentId => text().nullable()();

  /// Undo/redo cursor: events with seq <= cursor are "live".
  IntColumn get eventCursor => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// The playing XI for a match (per team).
@TableIndex(name: 'idx_match_player_match', columns: {#matchId})
class MatchPlayers extends Table {
  TextColumn get matchId => text()();
  TextColumn get teamId => text()();
  TextColumn get playerId => text()();
  IntColumn get battingOrder => integer().nullable()();
  BoolColumn get isCaptain => boolean().withDefault(const Constant(false))();
  BoolColumn get isKeeper => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {matchId, playerId};
}

/// The append-only event log — the heart of persistence. Undo moves the match
/// cursor; new events after undo delete the tail (seq > cursor) then append.
@TableIndex(
  name: 'idx_event_match_seq',
  columns: {#matchId, #seq},
  unique: true,
)
class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get matchId => text()();

  /// Per-match ordering (1-based).
  IntColumn get seq => integer()();

  /// Event kind: matchCreated / inningsStarted / ball / penalty /
  /// batterReplaced / endInnings / superOverStart ...
  TextColumn get type => text()();

  /// Full serialised event (e.g. a [BallEvent]).
  TextColumn get payloadJson => text()();

  DateTimeColumn get createdAt => dateTime()();
}

/// A tournament grouping matches, with points/tie-break config.
class Tournaments extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// Fixture structure: league / roundRobin / knockout.
  TextColumn get format =>
      textEnum<TournamentFormat>().withDefault(const Constant('roundRobin'))();

  TextColumn get rulesJson => text()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  IntColumn get pointsWin => integer().withDefault(const Constant(2))();
  IntColumn get pointsTie => integer().withDefault(const Constant(1))();
  IntColumn get pointsNoResult => integer().withDefault(const Constant(1))();
  IntColumn get pointsLoss => integer().withDefault(const Constant(0))();

  /// JSON array of tie-break keys, e.g. ["nrr","headToHead"].
  TextColumn get tieBreakOrderJson =>
      text().withDefault(const Constant('["nrr","headToHead"]'))();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Team entry in a tournament.
class TournamentTeams extends Table {
  TextColumn get tournamentId => text()();
  TextColumn get teamId => text()();

  @override
  Set<Column<Object>> get primaryKey => {tournamentId, teamId};
}

/// A scheduled fixture; links to a [Matches] row once played.
class Fixtures extends Table {
  TextColumn get id => text()();
  TextColumn get tournamentId => text()();
  IntColumn get round => integer().nullable()();
  TextColumn get teamAId => text()();
  TextColumn get teamBId => text()();
  DateTimeColumn get scheduledDate => dateTime().nullable()();
  TextColumn get matchId => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('scheduled'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
