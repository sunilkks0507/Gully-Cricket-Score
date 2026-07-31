import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../engine/scoring_engine.dart';
import '../../models/models.dart';
import '../db/app_db.dart';
import '../event_codec.dart';

/// A loaded, in-memory view of a match: derived state + its live event log +
/// player-name lookup + undo/redo availability.
class MatchSession {
  const MatchSession({
    required this.matchId,
    required this.state,
    required this.events,
    required this.names,
    required this.teamNames,
    required this.rosters,
    required this.canUndo,
    required this.canRedo,
  });

  final String matchId;
  final MatchState state;
  final List<GameEvent> events;

  /// playerId → display name.
  final Map<String, String> names;

  /// teamId → team name.
  final Map<String, String> teamNames;

  /// teamId → playing XI player ids.
  final Map<String, List<String>> rosters;
  final bool canUndo;
  final bool canRedo;

  String nameOf(String? id) => id == null ? '' : (names[id] ?? id);

  /// Team display name, falling back to a readable placeholder rather than a
  /// raw uuid if the team row is missing.
  String teamNameOf(String? id) {
    if (id == null) return '';
    final name = teamNames[id];
    if (name != null && name.isNotEmpty) return name;
    return 'Team';
  }

  List<String> rosterOf(String? teamId) => rosters[teamId] ?? const [];
}

/// Everything the setup flow gathers to start a match.
class MatchSetupData {
  const MatchSetupData({
    required this.rules,
    required this.matchType,
    required this.teamAId,
    required this.teamBId,
    required this.xiA,
    required this.xiB,
    required this.battingFirstTeamId,
    required this.strikerId,
    required this.nonStrikerId,
    required this.openingBowlerId,
    this.title,
    this.tournamentId,
    this.jokerPlayerId,
    this.tossWinnerTeamId,
    this.tossDecision,
    this.venue,
  });

  final MatchRules rules;
  final MatchType matchType;
  final String teamAId;
  final String teamBId;
  final List<String> xiA;
  final List<String> xiB;
  final String battingFirstTeamId;
  final String strikerId;
  final String nonStrikerId;
  final String openingBowlerId;
  final String? title;
  final String? tournamentId;
  final String? jokerPlayerId;
  final String? tossWinnerTeamId;
  final TossDecision? tossDecision;
  final String? venue;
}

/// Persists matches as an append-only event log and rebuilds derived state via
/// the pure [ScoringEngine]. See docs/06 & docs/07.
class MatchRepository {
  MatchRepository(this._db);

  final AppDb _db;
  static const _uuid = Uuid();

  /// Create the match rows and append MatchCreated + InningsStarted. Returns the
  /// new matchId.
  Future<String> startMatch(MatchSetupData s) async {
    final matchId = _uuid.v4();
    final now = DateTime.now();
    final bowlingFirst = s.battingFirstTeamId == s.teamAId
        ? s.teamBId
        : s.teamAId;

    await _db.matchDao.upsertMatch(
      MatchesCompanion.insert(
        id: matchId,
        title: Value(s.title),
        format: s.rules.presetId,
        rulesJson: jsonEncode(s.rules.toJson()),
        teamAId: s.teamAId,
        teamBId: s.teamBId,
        venue: Value(s.venue),
        dateLocal: now,
        matchType: Value(s.matchType),
        jokerPlayerId: Value(s.jokerPlayerId),
        tossWinnerTeamId: Value(s.tossWinnerTeamId),
        tossDecision: Value(s.tossDecision),
        status: const Value(MatchStatus.inProgress),
        tournamentId: Value(s.tournamentId),
        createdAt: now,
        updatedAt: now,
      ),
    );

    Future<void> addXi(String teamId, List<String> ids) async {
      for (var i = 0; i < ids.length; i++) {
        await _db.matchDao.addMatchPlayer(
          MatchPlayersCompanion.insert(
            matchId: matchId,
            teamId: teamId,
            playerId: ids[i],
            battingOrder: Value(i),
          ),
        );
      }
    }

    await addXi(s.teamAId, s.xiA);
    await addXi(s.teamBId, s.xiB);

    await _append(
      matchId,
      GameEvent.matchCreated(
        matchId: matchId,
        rules: s.rules,
        teamAId: s.teamAId,
        teamBId: s.teamBId,
        tossWinnerTeamId: s.tossWinnerTeamId,
        tossDecision: s.tossDecision,
      ),
    );
    await _append(
      matchId,
      GameEvent.inningsStarted(
        inningsIndex: 0,
        battingTeamId: s.battingFirstTeamId,
        bowlingTeamId: bowlingFirst,
        strikerId: s.strikerId,
        nonStrikerId: s.nonStrikerId,
        bowlerId: s.openingBowlerId,
        battingSquadSize:
            (s.battingFirstTeamId == s.teamAId ? s.xiA : s.xiB).length,
      ),
    );
    return matchId;
  }

  /// Validate [event] against current state, append it, and sync the match row.
  /// Throws [EngineException] if the event is illegal (nothing is persisted).
  Future<MatchState> appendEvent(String matchId, GameEvent event) async {
    final next = await _apply(matchId, event); // validates (may throw)
    await _append(matchId, event);
    await _syncRow(matchId, next);
    return next;
  }

  Future<MatchState> _apply(String matchId, GameEvent event) async {
    final events = await _liveEvents(matchId);
    if (events.isEmpty) return ScoringEngine.rebuild([event]);
    final state = ScoringEngine.rebuild(events);
    return ScoringEngine.apply(state, event);
  }

  Future<void> _append(String matchId, GameEvent event) async {
    final encoded = EventCodec.encode(event);
    await _db.eventDao.appendEvent(
      matchId: matchId,
      type: encoded.type,
      payloadJson: encoded.payloadJson,
    );
  }

  Future<void> _syncRow(String matchId, MatchState state) =>
      _db.matchDao.updateStatusResult(
        matchId,
        state.status,
        state.result == null ? null : jsonEncode(state.result!.toJson()),
      );

  Future<List<GameEvent>> _liveEvents(String matchId) async {
    final rows = await _db.eventDao.liveEvents(matchId);
    return rows.map((r) => EventCodec.decode(r.payloadJson)).toList();
  }

  /// Load a full [MatchSession] for the live screen / scorecard.
  Future<MatchSession> loadSession(String matchId) async {
    final events = await _liveEvents(matchId);
    final state = ScoringEngine.rebuild(events);
    final names = await namesFor(matchId);
    final rosters = await rostersFor(matchId);
    final teamNames = await teamNamesFor(matchId);
    final cursor = (await _db.matchDao.getMatch(matchId))!.eventCursor;
    final all = await _db.eventDao.allEvents(matchId);
    final maxSeq = all.isEmpty
        ? 0
        : all.map((e) => e.seq).reduce((a, b) => a > b ? a : b);
    return MatchSession(
      matchId: matchId,
      state: state,
      events: events,
      names: names,
      teamNames: teamNames,
      rosters: rosters,
      canUndo: cursor > 2, // keep MatchCreated + InningsStarted
      canRedo: cursor < maxSeq,
    );
  }

  /// teamId → team name for the two sides in this match.
  Future<Map<String, String>> teamNamesFor(String matchId) async {
    final match = await _db.matchDao.getMatch(matchId);
    if (match == null) return {};
    final result = <String, String>{};
    for (final id in {match.teamAId, match.teamBId}) {
      final team = await _db.teamDao.getTeam(id);
      if (team != null) result[id] = team.name;
    }
    return result;
  }

  /// teamId → ordered playing XI for the match.
  Future<Map<String, List<String>>> rostersFor(String matchId) async {
    final xi = await _db.matchDao.playingXi(matchId);
    final sorted = [...xi]
      ..sort((a, b) => (a.battingOrder ?? 0).compareTo(b.battingOrder ?? 0));
    final map = <String, List<String>>{};
    for (final mp in sorted) {
      map.putIfAbsent(mp.teamId, () => []).add(mp.playerId);
    }
    return map;
  }

  /// Rebuild just the derived [MatchState] (e.g. for stats).
  Future<MatchState> loadState(String matchId) async =>
      ScoringEngine.rebuild(await _liveEvents(matchId));

  Future<MatchSession> undo(String matchId) async {
    await _db.eventDao.undo(matchId);
    final state = ScoringEngine.rebuild(await _liveEvents(matchId));
    await _syncRow(matchId, state);
    return loadSession(matchId);
  }

  Future<MatchSession> redo(String matchId) async {
    await _db.eventDao.redo(matchId);
    final state = ScoringEngine.rebuild(await _liveEvents(matchId));
    await _syncRow(matchId, state);
    return loadSession(matchId);
  }

  /// playerId → display name for everyone in the match.
  Future<Map<String, String>> namesFor(String matchId) async {
    final xi = await _db.matchDao.playingXi(matchId);
    final result = <String, String>{};
    for (final mp in xi) {
      final p = await _db.playerDao.getPlayer(mp.playerId);
      if (p != null) result[p.id] = p.name;
    }
    return result;
  }

  Future<List<MatchRow>> allMatches() => _db.matchDao.allMatches();

  Future<MatchRow?> inProgressMatch() => _db.matchDao.firstInProgress();

  Future<MatchRow?> getMatch(String id) => _db.matchDao.getMatch(id);

  Future<void> deleteMatch(String id) async {
    await _db.eventDao.deleteEventsForMatch(id);
    await _db.matchDao.deleteMatch(id);
  }
}
