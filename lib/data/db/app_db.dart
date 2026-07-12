import 'package:drift/drift.dart';

import '../../models/enums.dart';
import 'event_dao.dart';
import 'match_dao.dart';
import 'player_dao.dart';
import 'tables.dart';
import 'team_dao.dart';

part 'app_db.g.dart';

/// The app's local SQLite database (Drift). The [Events] table is the
/// append-only source of truth; the rest are relational tables and (later)
/// rebuildable projections. See docs/06-data-model.md and ADR 0001.
@DriftDatabase(
  tables: [
    Players,
    Teams,
    TeamPlayers,
    Matches,
    MatchPlayers,
    Events,
    Tournaments,
    TournamentTeams,
    Fixtures,
  ],
  daos: [PlayerDao, TeamDao, MatchDao, EventDao],
)
class AppDb extends _$AppDb {
  AppDb(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    beforeOpen: (details) async {
      // Enforce foreign keys and integrity for the local store.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
