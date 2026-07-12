import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/settings_provider.dart';
import 'router.dart';
import 'theme.dart';

/// App root. Wires theming (with runtime light/dark/system selection) and the
/// go_router navigator.
class CricketScoringApp extends ConsumerWidget {
  const CricketScoringApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'CricScore',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: mode,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
