import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../engine/stats.dart';

/// Tournament detail: fixtures, points table, leaderboards.
class TournamentDetailScreen extends ConsumerWidget {
  const TournamentDetailScreen({required this.tournamentId, super.key});

  final String tournamentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(tournamentRepositoryProvider);
    final teamNames = ref.watch(teamNamesProvider).value ?? const {};
    String tn(String id) => teamNames[id] ?? id;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder(
            future: repo.get(tournamentId),
            builder: (c, snap) => Text(snap.data?.name ?? 'Tournament'),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Fixtures'),
              Tab(text: 'Points table'),
              Tab(text: 'Leaderboards'),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'New match',
              icon: const Icon(Icons.add),
              onPressed: () => context.pushNamed(
                'setup',
                queryParameters: {'tournamentId': tournamentId},
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // Fixtures
            FutureBuilder(
              future: repo.fixtures(tournamentId),
              builder: (c, snap) {
                final fixtures = snap.data;
                if (fixtures == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (fixtures.isEmpty) {
                  return const Center(
                    child: Text('No fixtures (knockout generated on demand).'),
                  );
                }
                return ListView(
                  children: [
                    for (final f in fixtures)
                      ListTile(
                        leading: CircleAvatar(child: Text('${f.round ?? '-'}')),
                        title: Text('${tn(f.teamAId)}  vs  ${tn(f.teamBId)}'),
                        subtitle: Text(f.status),
                      ),
                  ],
                );
              },
            ),
            // Points table
            Consumer(
              builder: (c, ref, _) {
                final table = ref.watch(pointsTableProvider(tournamentId));
                return table.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (rows) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Team')),
                        DataColumn(label: Text('P'), numeric: true),
                        DataColumn(label: Text('W'), numeric: true),
                        DataColumn(label: Text('L'), numeric: true),
                        DataColumn(label: Text('T'), numeric: true),
                        DataColumn(label: Text('NR'), numeric: true),
                        DataColumn(label: Text('Pts'), numeric: true),
                        DataColumn(label: Text('NRR'), numeric: true),
                      ],
                      rows: [
                        for (final r in rows)
                          DataRow(
                            cells: [
                              DataCell(Text(tn(r.teamId))),
                              DataCell(Text('${r.played}')),
                              DataCell(Text('${r.won}')),
                              DataCell(Text('${r.lost}')),
                              DataCell(Text('${r.tied}')),
                              DataCell(Text('${r.noResult}')),
                              DataCell(Text('${r.points}')),
                              DataCell(Text(r.nrr.toStringAsFixed(3))),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            // Leaderboards
            Consumer(
              builder: (c, ref, _) {
                final stats = ref.watch(tournamentStatsProvider(tournamentId));
                final names = ref.watch(playerNamesProvider).value ?? const {};
                return stats.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (table) => _Leaderboards(table: table, names: names),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Leaderboards extends StatelessWidget {
  const _Leaderboards({required this.table, required this.names});

  final Map<String, PlayerCareerStat> table;
  final Map<String, String> names;

  @override
  Widget build(BuildContext context) {
    final byRuns = table.values.toList()
      ..sort((a, b) => b.runs.compareTo(a.runs));
    final byWickets = table.values.toList()
      ..sort((a, b) => b.wickets.compareTo(a.wickets));
    String nm(String id) => names[id] ?? id;

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _board(context, 'Most runs', [
          for (final s in byRuns.take(5))
            if (s.runs > 0) '${nm(s.playerId)} — ${s.runs}',
        ]),
        const SizedBox(height: 12),
        _board(context, 'Most wickets', [
          for (final s in byWickets.take(5))
            if (s.wickets > 0) '${nm(s.playerId)} — ${s.wickets}',
        ]),
      ],
    );
  }

  Widget _board(BuildContext context, String title, List<String> rows) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const Divider(),
          if (rows.isEmpty) const Text('No data yet.'),
          for (final r in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(r),
            ),
        ],
      ),
    ),
  );
}
