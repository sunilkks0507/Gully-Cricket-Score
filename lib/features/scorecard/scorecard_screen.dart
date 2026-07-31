import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers.dart';
import '../../data/repositories/match_repository.dart';
import '../../engine/projections.dart';
import '../../models/models.dart';

/// Full scorecard: batting/bowling/extras/FOW/partnerships per innings, plus a
/// commentary feed. Live-updates while scoring; read-only after completion.
class ScorecardScreen extends ConsumerWidget {
  const ScorecardScreen({required this.matchId, super.key});

  final String matchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(matchSessionProvider(matchId));
    return session.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (s) {
        final innings = [
          s.state.innings1,
          s.state.innings2,
        ].whereType<InningsState>().toList();
        final tabs = [
          for (var i = 0; i < innings.length; i++) 'Innings ${i + 1}',
          'Commentary',
        ];
        return DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Scorecard'),
              bottom: TabBar(
                isScrollable: true,
                tabs: [for (final t in tabs) Tab(text: t)],
              ),
            ),
            body: TabBarView(
              children: [
                for (var i = 0; i < innings.length; i++)
                  _InningsTab(session: s, innings: innings[i]),
                _CommentaryTab(session: s),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InningsTab extends StatelessWidget {
  const _InningsTab({required this.session, required this.innings});

  final MatchSession session;
  final InningsState innings;

  @override
  Widget build(BuildContext context) {
    final card = Projections.scorecard(innings, names: session.names);
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Text(
          '${session.teamNameOf(card.battingTeamId)}  '
          '${card.total}/${card.wickets}  (${card.oversText})',
          style: theme.textTheme.titleLarge,
        ),
        if (session.state.result != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              Projections.resultText(session.state.result, session.teamNameOf),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        const SizedBox(height: 12),
        _tableCard(context, 'Batting', _battingTable(context, card)),
        const SizedBox(height: 8),
        _extrasLine(context, card),
        const SizedBox(height: 12),
        _tableCard(context, 'Bowling', _bowlingTable(context, card)),
        if (card.fallOfWickets.isNotEmpty) ...[
          const SizedBox(height: 12),
          _tableCard(context, 'Fall of wickets', _fowList(context, card)),
        ],
        if (card.partnerships.isNotEmpty) ...[
          const SizedBox(height: 12),
          _tableCard(context, 'Partnerships', _partnershipList(context, card)),
        ],
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _tableCard(BuildContext context, String title, Widget child) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const Divider(),
          child,
        ],
      ),
    ),
  );

  Widget _battingTable(BuildContext context, InningsScorecard card) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16,
        headingRowHeight: 32,
        dataRowMinHeight: 30,
        dataRowMaxHeight: 44,
        columns: const [
          DataColumn(label: Text('Batter')),
          DataColumn(label: Text('R'), numeric: true),
          DataColumn(label: Text('B'), numeric: true),
          DataColumn(label: Text('4s'), numeric: true),
          DataColumn(label: Text('6s'), numeric: true),
          DataColumn(label: Text('SR'), numeric: true),
        ],
        rows: [
          for (final b in card.batters)
            DataRow(
              cells: [
                DataCell(
                  SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(b.name),
                        Text(
                          b.dismissalText,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                DataCell(Text('${b.runs}${b.notOut ? '*' : ''}')),
                DataCell(Text('${b.balls}')),
                DataCell(Text('${b.fours}')),
                DataCell(Text('${b.sixes}')),
                DataCell(Text(b.strikeRate.toStringAsFixed(1))),
              ],
            ),
        ],
      ),
    );
  }

  Widget _extrasLine(BuildContext context, InningsScorecard card) {
    final e = card.extras;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        'Extras ${e.total}  (b ${e.byes}, lb ${e.legByes}, w ${e.wides}, '
        'nb ${e.noBalls}, p ${e.penalties})',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _bowlingTable(BuildContext context, InningsScorecard card) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16,
        headingRowHeight: 32,
        dataRowMinHeight: 30,
        dataRowMaxHeight: 40,
        columns: const [
          DataColumn(label: Text('Bowler')),
          DataColumn(label: Text('O'), numeric: true),
          DataColumn(label: Text('M'), numeric: true),
          DataColumn(label: Text('R'), numeric: true),
          DataColumn(label: Text('W'), numeric: true),
          DataColumn(label: Text('Econ'), numeric: true),
        ],
        rows: [
          for (final b in card.bowlers)
            DataRow(
              cells: [
                DataCell(SizedBox(width: 130, child: Text(b.name))),
                DataCell(Text(b.oversText)),
                DataCell(Text('${b.maidens}')),
                DataCell(Text('${b.runs}')),
                DataCell(Text('${b.wickets}')),
                DataCell(Text(b.economy.toStringAsFixed(2))),
              ],
            ),
        ],
      ),
    );
  }

  Widget _fowList(BuildContext context, InningsScorecard card) => Column(
    children: [
      for (final f in card.fallOfWickets)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${f.wicketNo}. ${session.nameOf(f.batterId)}'),
              Text('${f.scoreAtFall} (${f.oversText})'),
            ],
          ),
        ),
    ],
  );

  Widget _partnershipList(BuildContext context, InningsScorecard card) =>
      Column(
        children: [
          for (final p in card.partnerships)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${p.forWicket}. ${session.nameOf(p.batterAId)} & '
                    '${session.nameOf(p.batterBId)}',
                  ),
                  Text('${p.runs} (${p.balls})'),
                ],
              ),
            ),
        ],
      );
}

class _CommentaryTab extends StatelessWidget {
  const _CommentaryTab({required this.session});
  final MatchSession session;

  @override
  Widget build(BuildContext context) {
    final idx = session.state.currentInnings;
    final lines = Projections.commentary(
      session.events,
      idx,
      names: session.names,
    );
    if (lines.isEmpty) {
      return const Center(child: Text('No commentary yet.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: lines.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(lines[i]),
      ),
    );
  }
}
