import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'data/auth/firebase_bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cloud sync is strictly additive: CricScore is offline-first and every
  // feature works without an account (CLAUDE.md golden rule #3). A missing or
  // misconfigured Firebase project must therefore never stop the app starting,
  // so a failed init is logged and ignored rather than rethrown.
  try {
    await initializeFirebase();
  } catch (error, stackTrace) {
    debugPrint('Firebase init skipped — running local-only: $error');
    if (kDebugMode) debugPrintStack(stackTrace: stackTrace);
  }

  runApp(const ProviderScope(child: CricketScoringApp()));
}
