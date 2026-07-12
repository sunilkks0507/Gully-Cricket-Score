import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../application/settings_provider.dart';
import '../../models/enums.dart';

/// Match history: completed & in-progress matches; resume or delete.
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final matches = ref.watch(matchesProvider);
    final teamNames = ref.watch(teamNamesProvider).value ?? const {};

    return Scaffold(
      appBar: AppBar(title: const Text('Match History')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by team',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _query = v.toLowerCase()),
            ),
          ),
          Expanded(
            child: matches.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (list) {
                final filtered = list.where((m) {
                  final a = (teamNames[m.teamAId] ?? '').toLowerCase();
                  final b = (teamNames[m.teamBId] ?? '').toLowerCase();
                  return a.contains(_query) || b.contains(_query);
                }).toList();
                if (filtered.isEmpty) {
                  return const Center(child: Text('No matches.'));
                }
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (c, i) {
                    final m = filtered[i];
                    final title =
                        '${teamNames[m.teamAId] ?? 'Team A'} vs '
                        '${teamNames[m.teamBId] ?? 'Team B'}';
                    return Dismissible(
                      key: ValueKey(m.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Theme.of(context).colorScheme.errorContainer,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete),
                      ),
                      confirmDismiss: (_) => _confirmDelete(title),
                      onDismissed: (_) async {
                        await ref
                            .read(matchRepositoryProvider)
                            .deleteMatch(m.id);
                        ref.invalidate(matchesProvider);
                        ref.invalidate(inProgressMatchProvider);
                        ref.invalidate(overallStatsProvider);
                      },
                      child: ListTile(
                        title: Text(title),
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
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _confirmDelete(String title) async {
    if (!ref.read(confirmDeleteProvider)) return true;
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete match?'),
        content: Text('$title will be permanently removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return ok ?? false;
  }

  static String _statusLabel(MatchStatus s) => switch (s) {
    MatchStatus.inProgress => 'In progress',
    MatchStatus.inningsBreak => 'Innings break',
    MatchStatus.completed => 'Completed',
    MatchStatus.abandoned => 'Abandoned',
    MatchStatus.notStarted => 'Not started',
  };
}
