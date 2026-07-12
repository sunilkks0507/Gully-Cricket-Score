// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_dao.dart';

// ignore_for_file: type=lint
mixin _$MatchDaoMixin on DatabaseAccessor<AppDb> {
  $MatchesTable get matches => attachedDatabase.matches;
  $MatchPlayersTable get matchPlayers => attachedDatabase.matchPlayers;
  MatchDaoManager get managers => MatchDaoManager(this);
}

class MatchDaoManager {
  final _$MatchDaoMixin _db;
  MatchDaoManager(this._db);
  $$MatchesTableTableManager get matches =>
      $$MatchesTableTableManager(_db.attachedDatabase, _db.matches);
  $$MatchPlayersTableTableManager get matchPlayers =>
      $$MatchPlayersTableTableManager(_db.attachedDatabase, _db.matchPlayers);
}
