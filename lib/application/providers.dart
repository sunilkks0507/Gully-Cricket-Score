import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db/app_db.dart';
import '../data/db/connection.dart';
import '../data/repositories/backup_repository.dart';
import '../data/repositories/match_repository.dart';
import '../data/repositories/player_repository.dart';
import '../data/repositories/team_repository.dart';
import '../data/repositories/tournament_repository.dart';
import '../engine/stats.dart';
import '../models/models.dart';

/// Single on-device database, closed when the root scope disposes.
final appDbProvider = Provider<AppDb>((ref) {
  final db = openAppDatabase();
  ref.onDispose(db.close);
  return db;
});

final matchRepositoryProvider = Provider<MatchRepository>(
  (ref) => MatchRepository(ref.watch(appDbProvider)),
);
final playerRepositoryProvider = Provider<PlayerRepository>(
  (ref) => PlayerRepository(ref.watch(appDbProvider)),
);
final teamRepositoryProvider = Provider<TeamRepository>(
  (ref) => TeamRepository(ref.watch(appDbProvider)),
);
final tournamentRepositoryProvider = Provider<TournamentRepository>(
  (ref) => TournamentRepository(
    ref.watch(appDbProvider),
    ref.watch(matchRepositoryProvider),
  ),
);
final backupRepositoryProvider = Provider<BackupRepository>(
  (ref) => BackupRepository(ref.watch(appDbProvider)),
);

// --- Read models for the UI (auto-refresh on invalidation) ---

final playersProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(playerRepositoryProvider).all(),
);
final playerNamesProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(playerRepositoryProvider).namesById(),
);
final teamsProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(teamRepositoryProvider).all(),
);
final teamNamesProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(teamRepositoryProvider).namesById(),
);
final matchesProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(matchRepositoryProvider).allMatches(),
);
final inProgressMatchProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(matchRepositoryProvider).inProgressMatch(),
);
final tournamentsProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(tournamentRepositoryProvider).all(),
);

/// A fully-loaded match session (state + events + names) for the scorecard.
final matchSessionProvider = FutureProvider.autoDispose.family(
  (ref, String matchId) =>
      ref.watch(matchRepositoryProvider).loadSession(matchId),
);

/// Aggregate stats across every completed match (overall leaderboards/profiles).
final overallStatsProvider =
    FutureProvider.autoDispose<Map<String, PlayerCareerStat>>((ref) async {
      final db = ref.watch(appDbProvider);
      final matchRepo = ref.watch(matchRepositoryProvider);
      final rows = await db.matchDao.completedMatches();
      final states = <MatchState>[];
      for (final row in rows) {
        states.add(await matchRepo.loadState(row.id));
      }
      return StatsEngine.aggregate(states);
    });

/// Points table for one tournament.
final pointsTableProvider = FutureProvider.autoDispose.family(
  (ref, String tournamentId) =>
      ref.watch(tournamentRepositoryProvider).pointsTable(tournamentId),
);

/// Tournament-scoped player stats.
final tournamentStatsProvider = FutureProvider.autoDispose.family((
  ref,
  String tournamentId,
) async {
  final states = await ref
      .watch(tournamentRepositoryProvider)
      .completedStates(tournamentId);
  return StatsEngine.aggregate(states);
});
