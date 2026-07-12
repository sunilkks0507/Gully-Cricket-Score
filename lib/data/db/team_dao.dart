import 'package:drift/drift.dart';

import 'app_db.dart';
import 'tables.dart';

part 'team_dao.g.dart';

@DriftAccessor(tables: [Teams])
class TeamDao extends DatabaseAccessor<AppDb> with _$TeamDaoMixin {
  TeamDao(super.db);

  Future<void> upsertTeam(TeamsCompanion team) =>
      into(teams).insertOnConflictUpdate(team);

  Future<Team?> getTeam(String id) =>
      (select(teams)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<Team>> allTeams() =>
      (select(teams)..orderBy([(t) => OrderingTerm(expression: t.name)])).get();
}
