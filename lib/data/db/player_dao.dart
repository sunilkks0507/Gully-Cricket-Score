import 'package:drift/drift.dart';

import 'app_db.dart';
import 'tables.dart';

part 'player_dao.g.dart';

@DriftAccessor(tables: [Players, TeamPlayers])
class PlayerDao extends DatabaseAccessor<AppDb> with _$PlayerDaoMixin {
  PlayerDao(super.db);

  Future<void> upsertPlayer(PlayersCompanion player) =>
      into(players).insertOnConflictUpdate(player);

  Future<Player?> getPlayer(String id) =>
      (select(players)..where((p) => p.id.equals(id))).getSingleOrNull();

  Future<List<Player>> allPlayers() => (select(
    players,
  )..orderBy([(p) => OrderingTerm(expression: p.name)])).get();

  Future<void> addPlayerToTeam(TeamPlayersCompanion link) =>
      into(teamPlayers).insertOnConflictUpdate(link);

  /// Players on a team, ordered by name.
  Future<List<Player>> playersForTeam(String teamId) {
    final query = select(players).join([
      innerJoin(teamPlayers, teamPlayers.playerId.equalsExp(players.id)),
    ])..where(teamPlayers.teamId.equals(teamId));
    query.orderBy([OrderingTerm(expression: players.name)]);
    return query.map((row) => row.readTable(players)).get();
  }
}
