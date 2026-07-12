import 'package:go_router/go_router.dart';

import '../features/history/history_screen.dart';
import '../features/home/home_screen.dart';
import '../features/live_scoring/live_scoring_screen.dart';
import '../features/match_setup/match_setup_screen.dart';
import '../features/players/player_profile_screen.dart';
import '../features/players/players_screen.dart';
import '../features/scorecard/scorecard_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/stats/stats_screen.dart';
import '../features/tournament/tournament_create_screen.dart';
import '../features/tournament/tournament_detail_screen.dart';
import '../features/tournament/tournaments_screen.dart';

/// Declarative routes for CricScore.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', name: 'home', builder: (c, s) => const HomeScreen()),
    GoRoute(
      path: '/players',
      name: 'players',
      builder: (c, s) => const PlayersScreen(),
    ),
    GoRoute(
      path: '/players/:id',
      name: 'playerProfile',
      builder: (c, s) => PlayerProfileScreen(playerId: s.pathParameters['id']!),
    ),
    GoRoute(
      path: '/setup',
      name: 'setup',
      builder: (c, s) =>
          MatchSetupScreen(tournamentId: s.uri.queryParameters['tournamentId']),
    ),
    GoRoute(
      path: '/match/:id',
      name: 'match',
      builder: (c, s) => LiveScoringScreen(matchId: s.pathParameters['id']!),
    ),
    GoRoute(
      path: '/match/:id/scorecard',
      name: 'scorecard',
      builder: (c, s) => ScorecardScreen(matchId: s.pathParameters['id']!),
    ),
    GoRoute(
      path: '/history',
      name: 'history',
      builder: (c, s) => const HistoryScreen(),
    ),
    GoRoute(
      path: '/tournaments',
      name: 'tournaments',
      builder: (c, s) => const TournamentsScreen(),
    ),
    GoRoute(
      path: '/tournaments/new',
      name: 'tournamentCreate',
      builder: (c, s) => const TournamentCreateScreen(),
    ),
    GoRoute(
      path: '/tournaments/:id',
      name: 'tournamentDetail',
      builder: (c, s) =>
          TournamentDetailScreen(tournamentId: s.pathParameters['id']!),
    ),
    GoRoute(
      path: '/stats',
      name: 'stats',
      builder: (c, s) => const StatsScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (c, s) => const SettingsScreen(),
    ),
  ],
);
