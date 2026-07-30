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
  }) => savePlayer(name: name, nickname: nickname, role: role);

  /// Create (when [id] is null) or update a full player profile. Returns the id.
  Future<String> savePlayer({
    String? id,
    required String name,
    String? nickname,
    int? jerseyNo,
    String? email,
    PlayerRole? role,
    BattingHand? battingHand,
    BattingHand? bowlingHand,
    String? photoPath,
    DateTime? createdAt,
  }) async {
    final playerId = id ?? _uuid.v4();
    await _db.playerDao.upsertPlayer(
      PlayersCompanion.insert(
        id: playerId,
        name: name,
        nickname: Value(nickname),
        jerseyNo: Value(jerseyNo),
        email: Value(email),
        role: Value(role),
        battingStyle: Value(battingHand?.name),
        bowlingStyle: Value(bowlingHand?.name),
        photoPath: Value(photoPath),
        createdAt: createdAt ?? DateTime.now(),
      ),
    );
    return playerId;
  }

  Future<List<Player>> all() => _db.playerDao.allPlayers();

  Future<Player?> get(String id) => _db.playerDao.getPlayer(id);

  /// How many matches this player appears in (used to protect history from
  /// hard-deleting a player who has already played).
  Future<int> matchAppearances(String playerId) async {
    final rows = await (_db.select(
      _db.matchPlayers,
    )..where((mp) => mp.playerId.equals(playerId))).get();
    return rows.length;
  }

  /// Permanently remove a player and their team-roster links. Callers should
  /// check [matchAppearances] first to preserve match/stat history.
  Future<void> deletePlayer(String id) async {
    await _db.transaction(() async {
      await (_db.delete(
        _db.teamPlayers,
      )..where((tp) => tp.playerId.equals(id))).go();
      await (_db.delete(_db.players)..where((p) => p.id.equals(id))).go();
    });
  }

  Future<Map<String, String>> namesById() async {
    final players = await _db.playerDao.allPlayers();
    return {for (final p in players) p.id: p.name};
  }
}
