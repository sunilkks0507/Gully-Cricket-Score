import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../models/enums.dart';

/// CricScore home: resume-in-progress, New Match, quick access, recent matches.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final inProgress = ref.watch(inProgressMatchProvider);
    final matches = ref.watch(matchesProvider);
    final teamNames = ref.watch(teamNamesProvider).value ?? const {};

    return Scaffold(
      appBar: AppBar(
        title: const Text('CricScore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.pushNamed('settings'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(inProgressMatchProvider);
          ref.invalidate(matchesProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            inProgress.when(
              data: (m) => m == null
                  ? const SizedBox.shrink()
                  : Card(
                      color: theme.colorScheme.primaryContainer,
                      child: ListTile(
                        leading: const Icon(Icons.play_circle_fill),
                        title: const Text('Match in progress'),
                        subtitle: Text(
                          '${teamNames[m.teamAId] ?? 'Team A'} vs '
                          '${teamNames[m.teamBId] ?? 'Team B'}',
                        ),
                        trailing: FilledButton(
                          onPressed: () => context.pushNamed(
                            'match',
                            pathParameters: {'id': m.id},
                          ),
                          child: const Text('Resume'),
                        ),
                      ),
                    ),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primary,
                  child: Icon(
                    Icons.sports_cricket,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                title: const Text('New Match'),
                subtitle: const Text('Box cricket · standalone or tournament'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.pushNamed('setup'),
              ),
            ),
            const SizedBox(height: 16),
            Text('Quick access', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.4,
              children: [
                _QuickTile(
                  icon: Icons.history,
                  label: 'Match History',
                  onTap: () => context.pushNamed('history'),
                ),
                _QuickTile(
                  icon: Icons.groups_outlined,
                  label: 'Players',
                  onTap: () => context.pushNamed('players'),
                ),
                _QuickTile(
                  icon: Icons.emoji_events_outlined,
                  label: 'Tournaments',
                  onTap: () => context.pushNamed('tournaments'),
                ),
                _QuickTile(
                  icon: Icons.leaderboard_outlined,
                  label: 'Stats',
                  onTap: () => context.pushNamed('stats'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Recent matches', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            matches.when(
              data: (list) {
                if (list.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text('No matches yet. Start a new match above.'),
                    ),
                  );
                }
                return Column(
                  children: [
                    for (final m in list.take(6))
                      Card(
                        child: ListTile(
                          title: Text(
                            '${teamNames[m.teamAId] ?? 'Team A'} vs '
                            '${teamNames[m.teamBId] ?? 'Team B'}',
                          ),
                          subtitle: Text(_statusLabel(m.status)),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            if (m.status == MatchStatus.completed) {
                              context.pushNamed(
                                'scorecard',
                                pathParameters: {'id': m.id},
                              );
                            } else {
                              context.pushNamed(
                                'match',
                                pathParameters: {'id': m.id},
                              );
                            }
                          },
                        ),
                      ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
            ),
          ],
        ),
      ),
    );
  }

  static String _statusLabel(MatchStatus s) => switch (s) {
    MatchStatus.inProgress => 'In progress',
    MatchStatus.inningsBreak => 'Innings break',
    MatchStatus.completed => 'Completed',
    MatchStatus.abandoned => 'Abandoned',
    MatchStatus.notStarted => 'Not started',
  };
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(child: Text(label, style: theme.textTheme.titleSmall)),
            ],
          ),
        ),
      ),
    );
  }
}
