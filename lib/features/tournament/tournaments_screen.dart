import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';

class TournamentsScreen extends ConsumerWidget {
  const TournamentsScreen({super.key});

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
                    trailing: const Icon(Icons.chevron_right),
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
