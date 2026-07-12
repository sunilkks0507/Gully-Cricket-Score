// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_dao.dart';

// ignore_for_file: type=lint
mixin _$PlayerDaoMixin on DatabaseAccessor<AppDb> {
  $PlayersTable get players => attachedDatabase.players;
  $TeamPlayersTable get teamPlayers => attachedDatabase.teamPlayers;
  PlayerDaoManager get managers => PlayerDaoManager(this);
}

class PlayerDaoManager {
  final _$PlayerDaoMixin _db;
  PlayerDaoManager(this._db);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db.attachedDatabase, _db.players);
  $$TeamPlayersTableTableManager get teamPlayers =>
      $$TeamPlayersTableTableManager(_db.attachedDatabase, _db.teamPlayers);
}
