import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../shared/confirm.dart';

class TournamentsScreen extends ConsumerWidget {
  const TournamentsScreen({super.key});

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    String id,
    String name,
  ) async {
    final ok = await confirmDelete(
      context,
      ref,
      title: 'Delete tournament?',
      message:
          '$name, its fixtures and points table will be removed. '
          'Matches played under it are kept as standalone matches.',
    );
    if (!ok) return;
    await ref.read(tournamentRepositoryProvider).deleteTournament(id);
    ref.invalidate(tournamentsProvider);
    ref.invalidate(matchesProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournaments = ref.watch(tournamentsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Tournaments')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed('tournamentCreate'),
        icon: const Icon(Icons.add),
        label: const Text('New Tournament'),
      ),
      body: tournaments.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          if (list.isEmpty) {
            return const Center(
              child: Text('No tournaments yet. Create one below.'),
            );
          }
          return ListView(
            children: [
              for (final t in list)
                Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.emoji_events_outlined),
                    title: Text(t.name),
                    subtitle: Text(t.format.name),
                    trailing: PopupMenuButton<String>(
                      onSelected: (v) {
                        if (v == 'delete') _delete(context, ref, t.id, t.name);
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
                      'tournamentDetail',
                      pathParameters: {'id': t.id},
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
