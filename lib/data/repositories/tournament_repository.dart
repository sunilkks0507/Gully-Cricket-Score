import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../engine/tournament_math.dart';
import '../../models/models.dart';
import '../db/app_db.dart';
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
    final completed = <CompletedMatch>[];
    for (final row in rows) {
      final state = await _matchRepo.loadState(row.id);
      final cm = CompletedMatch.fromMatch(state);
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
