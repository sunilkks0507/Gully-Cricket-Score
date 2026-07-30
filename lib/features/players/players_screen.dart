import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../models/enums.dart';
import '../../shared/confirm.dart';

/// The player pool: list, search, add. Players are reusable across teams/matches.
class PlayersScreen extends ConsumerStatefulWidget {
  const PlayersScreen({super.key});

  @override
  ConsumerState<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends ConsumerState<PlayersScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final players = ref.watch(playersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Players')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addPlayer,
        icon: const Icon(Icons.person_add),
        label: const Text('Add player'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search players',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _query = v.toLowerCase()),
            ),
          ),
          Expanded(
            child: players.when(
              data: (list) {
                final filtered = list
                    .where((p) => p.name.toLowerCase().contains(_query))
                    .toList();
                if (filtered.isEmpty) {
                  return const Center(child: Text('No players yet.'));
                }
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (c, i) {
                    final p = filtered[i];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          p.name.isEmpty ? '?' : p.name[0].toUpperCase(),
                        ),
                      ),
                      title: Text(p.name),
                      subtitle: p.role == null ? null : Text(p.role!.name),
                      trailing: PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'delete') _deletePlayer(p.id, p.name);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(
                            value: 'delete',
                            child: ListTile(
                              leading: Icon(Icons.delete_outline),
                              title: Text('Delete'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => context.pushNamed(
                        'playerProfile',
                        pathParameters: {'id': p.id},
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addPlayer() async {
    final result = await showDialog<({String name, PlayerRole? role})>(
      context: context,
      builder: (_) => const _AddPlayerDialog(),
    );
    if (result == null || result.name.trim().isEmpty) return;
    await ref
        .read(playerRepositoryProvider)
        .createPlayer(name: result.name.trim(), role: result.role);
    ref.invalidate(playersProvider);
    ref.invalidate(playerNamesProvider);
  }

  Future<void> _deletePlayer(String id, String name) async {
    final messenger = ScaffoldMessenger.of(context);
    final repo = ref.read(playerRepositoryProvider);
    final uses = await repo.matchAppearances(id);
    if (!mounted) return;
    if (uses > 0) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            "Can't delete $name — used in $uses match${uses == 1 ? '' : 'es'}. "
            'Delete those matches first.',
          ),
        ),
      );
      return;
    }
    final ok = await confirmDelete(
      context,
      ref,
      title: 'Delete player?',
      message: '$name will be removed from the pool.',
    );
    if (!ok) return;
    await repo.deletePlayer(id);
    ref.invalidate(playersProvider);
    ref.invalidate(playerNamesProvider);
    ref.invalidate(overallStatsProvider);
  }
}

class _AddPlayerDialog extends StatefulWidget {
  const _AddPlayerDialog();

  @override
  State<_AddPlayerDialog> createState() => _AddPlayerDialogState();
}

class _AddPlayerDialogState extends State<_AddPlayerDialog> {
  final _controller = TextEditingController();
  PlayerRole? _role;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add player'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<PlayerRole?>(
            initialValue: _role,
            decoration: const InputDecoration(labelText: 'Role (optional)'),
            items: [
              const DropdownMenuItem(value: null, child: Text('—')),
              for (final r in PlayerRole.values)
                DropdownMenuItem(value: r, child: Text(r.name)),
            ],
            onChanged: (v) => setState(() => _role = v),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () =>
              Navigator.pop(context, (name: _controller.text, role: _role)),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
