import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../engine/stats.dart';

/// Player profile: overall batting / bowling / fielding aggregates.
class PlayerProfileScreen extends ConsumerWidget {
  const PlayerProfileScreen({required this.playerId, super.key});

  final String playerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.watch(playersProvider).value ?? const [];
    final name = players
        .where((p) => p.id == playerId)
        .map((p) => p.name)
        .cast<String?>()
        .firstWhere((_) => true, orElse: () => 'Player');
    final stats = ref.watch(overallStatsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(name ?? 'Player')),
      body: stats.when(
        data: (table) {
          final s = table[playerId] ?? PlayerCareerStat(playerId);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _StatSection(
                title: 'Overall batting',
                rows: {
                  'Matches': '${s.matches}',
                  'Innings': '${s.inningsBatted}',
                  'Runs': '${s.runs}',
                  'High score': s.highScoreText,
                  'Average': s.battingAverage.toStringAsFixed(2),
                  'Strike rate': s.strikeRate.toStringAsFixed(1),
                  'Not outs': '${s.notOuts}',
                  '50s / 100s': '${s.fifties} / ${s.hundreds}',
                  '4s / 6s': '${s.fours} / ${s.sixes}',
                },
              ),
              const SizedBox(height: 16),
              _StatSection(
                title: 'Overall bowling',
                rows: {
                  'Balls': '${s.ballsBowled}',
                  'Runs': '${s.runsConceded}',
                  'Wickets': '${s.wickets}',
                  'Best': s.bestBowling,
                  'Average': s.bowlingAverage.toStringAsFixed(2),
                  'Economy': s.economy.toStringAsFixed(2),
                  'Maidens': '${s.maidens}',
                },
              ),
              const SizedBox(height: 16),
              _StatSection(
                title: 'Fielding',
                rows: {
                  'Catches': '${s.catches}',
                  'Stumpings': '${s.stumpings}',
                  'Run outs': '${s.runOuts}',
                },
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _StatSection extends StatelessWidget {
  const _StatSection({required this.title, required this.rows});

  final String title;
  final Map<String, String> rows;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            const Divider(),
            for (final e in rows.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.key),
                    Text(
                      e.value,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
