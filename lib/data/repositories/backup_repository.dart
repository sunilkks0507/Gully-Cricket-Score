import 'dart:convert';

import '../db/app_db.dart';

/// Exports/imports all local data as a single JSON document (F10 — the manual
/// substitute for cloud sync in v1). Round-trips through Drift row JSON.
class BackupRepository {
  BackupRepository(this._db);

  final AppDb _db;

  static const _version = 1;

  Future<String> exportJson() async {
    final data = <String, dynamic>{
      'version': _version,
      'players': (await _db.select(_db.players).get())
          .map((r) => r.toJson())
          .toList(),
      'teams': (await _db.select(_db.teams).get())
          .map((r) => r.toJson())
          .toList(),
      'teamPlayers': (await _db.select(_db.teamPlayers).get())
          .map((r) => r.toJson())
          .toList(),
      'matches': (await _db.select(_db.matches).get())
          .map((r) => r.toJson())
          .toList(),
      'matchPlayers': (await _db.select(_db.matchPlayers).get())
          .map((r) => r.toJson())
          .toList(),
      'events': (await _db.select(_db.events).get())
          .map((r) => r.toJson())
          .toList(),
      'tournaments': (await _db.select(_db.tournaments).get())
          .map((r) => r.toJson())
          .toList(),
      'tournamentTeams': (await _db.select(_db.tournamentTeams).get())
          .map((r) => r.toJson())
          .toList(),
      'fixtures': (await _db.select(_db.fixtures).get())
          .map((r) => r.toJson())
          .toList(),
    };
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  /// Restore from a previously exported document. Existing rows with the same
  /// primary key are overwritten.
  Future<void> importJson(String jsonStr) async {
    final data = jsonDecode(jsonStr) as Map<String, dynamic>;
    List<Map<String, dynamic>> rows(String key) =>
        ((data[key] as List?) ?? const [])
            .map((e) => (e as Map).cast<String, dynamic>())
            .toList();

    await _db.transaction(() async {
      for (final j in rows('players')) {
        await _db.into(_db.players).insertOnConflictUpdate(Player.fromJson(j));
      }
      for (final j in rows('teams')) {
        await _db.into(_db.teams).insertOnConflictUpdate(Team.fromJson(j));
      }
      for (final j in rows('teamPlayers')) {
        await _db
            .into(_db.teamPlayers)
            .insertOnConflictUpdate(TeamPlayer.fromJson(j));
      }
      for (final j in rows('matches')) {
        await _db
            .into(_db.matches)
            .insertOnConflictUpdate(MatchRow.fromJson(j));
      }
      for (final j in rows('matchPlayers')) {
        await _db
            .into(_db.matchPlayers)
            .insertOnConflictUpdate(MatchPlayer.fromJson(j));
      }
      for (final j in rows('events')) {
        await _db.into(_db.events).insertOnConflictUpdate(Event.fromJson(j));
      }
      for (final j in rows('tournaments')) {
        await _db
            .into(_db.tournaments)
            .insertOnConflictUpdate(Tournament.fromJson(j));
      }
      for (final j in rows('tournamentTeams')) {
        await _db
            .into(_db.tournamentTeams)
            .insertOnConflictUpdate(TournamentTeam.fromJson(j));
      }
      for (final j in rows('fixtures')) {
        await _db
            .into(_db.fixtures)
            .insertOnConflictUpdate(Fixture.fromJson(j));
      }
    });
  }
}
