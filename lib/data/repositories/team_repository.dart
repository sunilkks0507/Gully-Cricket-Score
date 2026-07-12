import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db/app_db.dart';

class TeamRepository {
  TeamRepository(this._db);

  final AppDb _db;
  static const _uuid = Uuid();

  Future<String> createTeam({required String name, String? shortName}) async {
    final id = _uuid.v4();
    await _db.teamDao.upsertTeam(
      TeamsCompanion.insert(
        id: id,
        name: name,
        shortName: Value(shortName),
        createdAt: DateTime.now(),
      ),
    );
    return id;
  }

  Future<void> setRoster(String teamId, List<String> playerIds) async {
    for (final pid in playerIds) {
      await _db.playerDao.addPlayerToTeam(
        TeamPlayersCompanion.insert(teamId: teamId, playerId: pid),
      );
    }
  }

  Future<List<Team>> all() => _db.teamDao.allTeams();

  Future<Team?> get(String id) => _db.teamDao.getTeam(id);

  Future<List<Player>> players(String teamId) =>
      _db.playerDao.playersForTeam(teamId);

  Future<Map<String, String>> namesById() async {
    final teams = await _db.teamDao.allTeams();
    return {for (final t in teams) t.id: t.name};
  }
}
