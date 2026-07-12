import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../models/enums.dart';
import '../db/app_db.dart';

class PlayerRepository {
  PlayerRepository(this._db);

  final AppDb _db;
  static const _uuid = Uuid();

  Future<String> createPlayer({
    required String name,
    String? nickname,
    PlayerRole? role,
  }) async {
    final id = _uuid.v4();
    await _db.playerDao.upsertPlayer(
      PlayersCompanion.insert(
        id: id,
        name: name,
        nickname: Value(nickname),
        role: Value(role),
        createdAt: DateTime.now(),
      ),
    );
    return id;
  }

  Future<List<Player>> all() => _db.playerDao.allPlayers();

  Future<Player?> get(String id) => _db.playerDao.getPlayer(id);

  Future<Map<String, String>> namesById() async {
    final players = await _db.playerDao.allPlayers();
    return {for (final p in players) p.id: p.name};
  }
}
