import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../engine/tournament_math.dart';
import '../../models/models.dart';
import '../db/app_db.dart';
import '../db/tables.dart';
import 'match_repository.dart';

class TournamentRepository {
  TournamentRepository(this._db, this._matchRepo);

  final AppDb _db;
  final MatchRepository _matchRepo;
  static const _uuid = Uuid();

  Future<String> createTournament({
    required String name,
    required TournamentFormat format,
    required MatchRules rules,
    required List<String> teamIds,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();
    await _db
        .into(_db.tournaments)
        .insert(
          TournamentsCompanion.insert(
            id: id,
            name: name,
            format: Value(format),
            rulesJson: jsonEncode(rules.toJson()),
            createdAt: now,
          ),
        );
    for (final teamId in teamIds) {
      await _db
          .into(_db.tournamentTeams)
          .insert(
            TournamentTeamsCompanion.insert(tournamentId: id, teamId: teamId),
          );
    }
    // League / round-robin → generate a round-robin schedule. Knockout later.
    if (format != TournamentFormat.knockout) {
      final specs = TournamentMath.roundRobin(teamIds, tournamentId: id);
      for (final f in specs) {
        await _db
            .into(_db.fixtures)
            .insert(
              FixturesCompanion.insert(
                id: f.id,
                tournamentId: id,
                teamAId: f.teamAId,
                teamBId: f.teamBId,
                round: Value(f.round),
              ),
            );
      }
    }
    return id;
  }

  Future<List<Tournament>> all() => (_db.select(
    _db.tournaments,
  )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();

  Future<Tournament?> get(String id) => (_db.select(
    _db.tournaments,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<String>> teamIds(String tournamentId) =>
      (_db.select(_db.tournamentTeams)
            ..where((t) => t.tournamentId.equals(tournamentId)))
          .map((r) => r.teamId)
          .get();

  Future<List<Fixture>> fixtures(String tournamentId) =>
      (_db.select(_db.fixtures)
            ..where((f) => f.tournamentId.equals(tournamentId))
            ..orderBy([(f) => OrderingTerm(expression: f.round)]))
          .get();

  /// Compute the points table from this tournament's completed matches.
  Future<List<PointsRow>> pointsTable(String tournamentId) async {
    final t = await get(tournamentId);
    final teams = await teamIds(tournamentId);
    final rows = await _db.matchDao.completedForTournament(tournamentId);
    final alias = await _teamAliases(tournamentId, rows);
    final completed = <CompletedMatch>[];
    for (final row in rows) {
      final state = await _matchRepo.loadState(row.id);
      final cm = CompletedMatch.fromMatch(state, teamAlias: alias);
      if (cm != null) completed.add(cm);
    }
    return TournamentMath.pointsTable(
      teams,
      completed,
      pointsWin: t?.pointsWin ?? 2,
      pointsTie: t?.pointsTie ?? 1,
      pointsNoResult: t?.pointsNoResult ?? 1,
      pointsLoss: t?.pointsLoss ?? 0,
    );
  }

  /// Older tournament matches were saved against throwaway teams created at
  /// setup instead of the tournament's own teams. Map each such team id to the
  /// tournament team with the same name (case-insensitive), so those results
  /// still count. Derived only — the stored match and its events are untouched.
  Future<Map<String, String>> _teamAliases(
    String tournamentId,
    List<MatchRow> matches,
  ) async {
    final ids = (await teamIds(tournamentId)).toSet();
    final names = await _teamNames();
    String key(String? name) => (name ?? '').trim().toLowerCase();
    final byName = <String, String>{};
    for (final id in ids) {
      byName.putIfAbsent(key(names[id]), () => id);
    }
    final alias = <String, String>{};
    for (final m in matches) {
      for (final id in [m.teamAId, m.teamBId]) {
        if (ids.contains(id)) continue;
        final match = byName[key(names[id])];
        if (match != null) alias[id] = match;
      }
    }
    return alias;
  }

  Future<Map<String, String>> _teamNames() async {
    final teams = await _db.teamDao.allTeams();
    return {for (final t in teams) t.id: t.name};
  }

  /// Link older matches (played before fixtures were linked at setup) to
  /// their unplayed fixture, matching teams by name. Idempotent.
  Future<void> linkLegacyMatches(String tournamentId) async {
    final matches = await (_db.select(
      _db.matches,
    )..where((m) => m.tournamentId.equals(tournamentId))).get();
    final all = await fixtures(tournamentId);
    final linked = {for (final f in all) f.matchId}..remove(null);
    final pending = matches.where((m) => !linked.contains(m.id)).toList();
    if (pending.isEmpty) return;
    final alias = await _teamAliases(tournamentId, pending);
    String team(String id) => alias[id] ?? id;

    final open = all.where((f) => f.matchId == null).toList();
    for (final m in pending) {
      final a = team(m.teamAId);
      final b = team(m.teamBId);
      final i = open.indexWhere(
        (f) =>
            (f.teamAId == a && f.teamBId == b) ||
            (f.teamAId == b && f.teamBId == a),
      );
      if (i < 0) continue;
      final f = open.removeAt(i);
      await (_db.update(_db.fixtures)..where((x) => x.id.equals(f.id))).write(
        FixturesCompanion(
          matchId: Value(m.id),
          status: Value(
            m.status == MatchStatus.completed
                ? FixtureStatus.completed
                : FixtureStatus.inProgress,
          ),
        ),
      );
    }
  }

  /// Delete a tournament and its fixtures/team links. Any matches that were
  /// played under it are detached (kept in history as standalone matches).
  Future<void> deleteTournament(String id) async {
    await _db.transaction(() async {
      await (_db.update(
        _db.matches,
      )..where((m) => m.tournamentId.equals(id))).write(
        const MatchesCompanion(
          tournamentId: Value<String?>(null),
          matchType: Value(MatchType.standalone),
        ),
      );
      await (_db.delete(
        _db.fixtures,
      )..where((f) => f.tournamentId.equals(id))).go();
      await (_db.delete(
        _db.tournamentTeams,
      )..where((t) => t.tournamentId.equals(id))).go();
      await (_db.delete(_db.tournaments)..where((t) => t.id.equals(id))).go();
    });
  }

  /// Completed [MatchState]s for tournament-level stats/leaderboards.
  Future<List<MatchState>> completedStates(String tournamentId) async {
    final rows = await _db.matchDao.completedForTournament(tournamentId);
    final states = <MatchState>[];
    for (final row in rows) {
      states.add(await _matchRepo.loadState(row.id));
    }
    return states;
  }
}
