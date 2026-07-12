import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../models/models.dart';

/// Create a tournament: name, format, and teams. Fixtures + points table are
/// generated automatically for league / round-robin.
class TournamentCreateScreen extends ConsumerStatefulWidget {
  const TournamentCreateScreen({super.key});

  @override
  ConsumerState<TournamentCreateScreen> createState() =>
      _TournamentCreateScreenState();
}

class _TournamentCreateScreenState
    extends ConsumerState<TournamentCreateScreen> {
  final _name = TextEditingController();
  TournamentFormat _format = TournamentFormat.roundRobin;
  final Set<String> _teamIds = {};
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teams = ref.watch(teamsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('New Tournament')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Tournament name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Text('Format', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<TournamentFormat>(
            segments: const [
              ButtonSegment(
                value: TournamentFormat.league,
                label: Text('League'),
              ),
              ButtonSegment(
                value: TournamentFormat.roundRobin,
                label: Text('Round Robin'),
              ),
              ButtonSegment(
                value: TournamentFormat.knockout,
                label: Text('Knockout'),
              ),
            ],
            selected: {_format},
            onSelectionChanged: (s) => setState(() => _format = s.first),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Teams', style: Theme.of(context).textTheme.titleMedium),
              TextButton.icon(
                onPressed: _addTeam,
                icon: const Icon(Icons.add),
                label: const Text('Add team'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          teams.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('Error: $e'),
            data: (list) {
              if (list.isEmpty) {
                return const Text('Add teams to include in the tournament.');
              }
              return Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (final t in list)
                    FilterChip(
                      label: Text(t.name),
                      selected: _teamIds.contains(t.id),
                      onSelected: (sel) => setState(() {
                        sel ? _teamIds.add(t.id) : _teamIds.remove(t.id);
                      }),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _saving ? null : _create,
            icon: const Icon(Icons.check),
            label: Text(_saving ? 'Creating…' : 'Review & create'),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Fixtures & a points table will be generated automatically.',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addTeam() async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('New team'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(labelText: 'Team name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;
    final id = await ref
        .read(teamRepositoryProvider)
        .createTeam(name: name.trim());
    ref.invalidate(teamsProvider);
    ref.invalidate(teamNamesProvider);
    setState(() => _teamIds.add(id));
  }

  Future<void> _create() async {
    final messenger = ScaffoldMessenger.of(context);
    if (_name.text.trim().isEmpty || _teamIds.length < 2) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Enter a name and pick at least 2 teams.'),
        ),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      await ref
          .read(tournamentRepositoryProvider)
          .createTournament(
            name: _name.text.trim(),
            format: _format,
            rules: MatchPresets.boxCricket,
            teamIds: _teamIds.toList(),
          );
      ref.invalidate(tournamentsProvider);
      if (mounted) context.pop();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Could not create: $e')));
      if (mounted) setState(() => _saving = false);
    }
  }
}
