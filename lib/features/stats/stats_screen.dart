import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';

/// Overall leaderboards across all completed matches (tournament + standalone).
class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(overallStatsProvider);
    final names = ref.watch(playerNamesProvider).value ?? const {};
    String nm(String id) => names[id] ?? id;

    return Scaffold(
      appBar: AppBar(title: const Text('Stats & Leaderboards')),
      body: stats.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (table) {
          if (table.isEmpty) {
            return const Center(child: Text('No completed matches yet.'));
          }
          final byRuns = table.values.toList()
            ..sort((a, b) => b.runs.compareTo(a.runs));
          final byWickets = table.values.toList()
            ..sort((a, b) => b.wickets.compareTo(a.wickets));

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              _board(context, 'Most Runs', Icons.sports_cricket, [
                for (final s in byRuns.take(10))
                  if (s.runs > 0)
                    _LeaderRow(
                      playerId: s.playerId,
                      name: nm(s.playerId),
                      value: '${s.runs}',
                      sub: 'SR ${s.strikeRate.toStringAsFixed(1)}',
                    ),
              ]),
              const SizedBox(height: 12),
              _board(context, 'Most Wickets', Icons.sports_baseball, [
                for (final s in byWickets.take(10))
                  if (s.wickets > 0)
                    _LeaderRow(
                      playerId: s.playerId,
                      name: nm(s.playerId),
                      value: '${s.wickets}',
                      sub: 'Econ ${s.economy.toStringAsFixed(2)}',
                    ),
              ]),
            ],
          );
        },
      ),
    );
  }

  Widget _board(
    BuildContext context,
    String title,
    IconData icon,
    List<_LeaderRow> rows,
  ) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const Divider(),
          if (rows.isEmpty) const Text('No data yet.'),
          ...rows,
        ],
      ),
    ),
  );
}

class _LeaderRow extends StatelessWidget {
  const _LeaderRow({
    required this.playerId,
    required this.name,
    required this.value,
    required this.sub,
  });

  final String playerId;
  final String name;
  final String value;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(name),
      subtitle: Text(sub),
      trailing: Text(
        value,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onTap: () =>
          context.pushNamed('playerProfile', pathParameters: {'id': playerId}),
    );
  }
}
