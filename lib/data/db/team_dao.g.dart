// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_dao.dart';

// ignore_for_file: type=lint
mixin _$TeamDaoMixin on DatabaseAccessor<AppDb> {
  $TeamsTable get teams => attachedDatabase.teams;
  TeamDaoManager get managers => TeamDaoManager(this);
}

class TeamDaoManager {
  final _$TeamDaoMixin _db;
  TeamDaoManager(this._db);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
}
