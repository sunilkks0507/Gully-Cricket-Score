import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
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
        onPressed: () => context.pushNamed('playerCreate'),
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
                    final hasPhoto =
                        p.photoPath != null && File(p.photoPath!).existsSync();
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: hasPhoto
                            ? FileImage(File(p.photoPath!))
                            : null,
                        child: hasPhoto
                            ? null
                            : Text(
                                p.name.isEmpty ? '?' : p.name[0].toUpperCase(),
                              ),
                      ),
                      title: Text(
                        p.nickname == null || p.nickname!.isEmpty
                            ? p.name
                            : '${p.name} "${p.nickname}"',
                      ),
                      subtitle: Text(_subtitle(p)),
                      trailing: PopupMenuButton<String>(
                        onSelected: (v) {
                          if (v == 'edit') {
                            context.pushNamed(
                              'playerEdit',
                              pathParameters: {'id': p.id},
                            );
                          } else if (v == 'delete') {
                            _deletePlayer(p.id, p.name);
                          }
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(
                            value: 'edit',
                            child: ListTile(
                              leading: Icon(Icons.edit_outlined),
                              title: Text('Edit'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
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

  static String _subtitle(dynamic p) {
    final parts = <String>[];
    if (p.jerseyNo != null) parts.add('#${p.jerseyNo}');
    if (p.role != null) parts.add(p.role.name as String);
    return parts.join(' · ');
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
