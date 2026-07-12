// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dao.dart';

// ignore_for_file: type=lint
mixin _$EventDaoMixin on DatabaseAccessor<AppDb> {
  $EventsTable get events => attachedDatabase.events;
  $MatchesTable get matches => attachedDatabase.matches;
  EventDaoManager get managers => EventDaoManager(this);
}

class EventDaoManager {
  final _$EventDaoMixin _db;
  EventDaoManager(this._db);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db.attachedDatabase, _db.events);
  $$MatchesTableTableManager get matches =>
      $$MatchesTableTableManager(_db.attachedDatabase, _db.matches);
}
