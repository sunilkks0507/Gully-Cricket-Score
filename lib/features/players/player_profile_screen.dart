import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../engine/stats.dart';
import '../../shared/confirm.dart';

/// Player profile: overall batting / bowling / fielding aggregates.
class PlayerProfileScreen extends ConsumerWidget {
  const PlayerProfileScreen({required this.playerId, super.key});

  final String playerId;

  Future<void> _delete(BuildContext context, WidgetRef ref, String name) async {
    final messenger = ScaffoldMessenger.of(context);
    final repo = ref.read(playerRepositoryProvider);
    final uses = await repo.matchAppearances(playerId);
    if (uses > 0) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            "Can't delete $name — used in $uses "
            "match${uses == 1 ? '' : 'es'}.",
          ),
        ),
      );
      return;
    }
    if (!context.mounted) return;
    final ok = await confirmDelete(
      context,
      ref,
      title: 'Delete player?',
      message: '$name will be removed from the pool.',
    );
    if (!ok) return;
    await repo.deletePlayer(playerId);
    ref.invalidate(playersProvider);
    ref.invalidate(playerNamesProvider);
    ref.invalidate(overallStatsProvider);
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.watch(playersProvider).value ?? const [];
    final matches = players.where((p) => p.id == playerId);
    final player = matches.isEmpty ? null : matches.first;
    final name = player?.name ?? 'Player';
    final stats = ref.watch(overallStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
            tooltip: 'Edit player',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.pushNamed(
              'playerEdit',
              pathParameters: {'id': playerId},
            ),
          ),
          IconButton(
            tooltip: 'Delete player',
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _delete(context, ref, name),
          ),
        ],
      ),
      body: stats.when(
        data: (table) {
          final s = table[playerId] ?? PlayerCareerStat(playerId);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (player != null) ...[
                _ProfileHeader(player: player),
                const SizedBox(height: 16),
              ],
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

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.player});

  final dynamic player; // Player row

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPhoto =
        player.photoPath != null &&
        File(player.photoPath as String).existsSync();

    final details = <String>[];
    if (player.jerseyNo != null) details.add('Jersey #${player.jerseyNo}');
    if (player.role != null) {
      details.add(_roleLabel(player.role.name as String));
    }
    final batting = _handLabel(player.battingStyle as String?, 'bat');
    if (batting != null) details.add(batting);
    final bowling = _handLabel(player.bowlingStyle as String?, 'arm');
    if (bowling != null) details.add(bowling);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              backgroundImage: hasPhoto
                  ? FileImage(File(player.photoPath as String))
                  : null,
              child: hasPhoto
                  ? null
                  : Text(
                      (player.name as String).isEmpty
                          ? '?'
                          : (player.name as String)[0].toUpperCase(),
                      style: theme.textTheme.headlineSmall,
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name as String,
                    style: theme.textTheme.titleLarge,
                  ),
                  if (player.nickname != null &&
                      (player.nickname as String).isNotEmpty)
                    Text(
                      '"${player.nickname}"',
                      style: theme.textTheme.bodyMedium,
                    ),
                  if (details.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        details.join(' · '),
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  if (player.email != null &&
                      (player.email as String).isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        player.email as String,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _roleLabel(String r) => switch (r) {
    'batter' => 'Batter',
    'bowler' => 'Bowler',
    'allRounder' => 'All-rounder',
    'keeper' => 'Wicketkeeper',
    _ => r,
  };

  static String? _handLabel(String? name, String what) {
    if (name == null) return null;
    final side = name == 'left' ? 'Left' : 'Right';
    return '$side-hand $what';
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
