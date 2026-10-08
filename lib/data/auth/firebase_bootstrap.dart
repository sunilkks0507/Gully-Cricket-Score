import 'package:firebase_core/firebase_core.dart';

/// One-time Firebase start-up for CricScore.
///
/// HOW THIS INITIALISES WITHOUT `firebase_options.dart`
/// ----------------------------------------------------
/// On Android and iOS the native Firebase SDK reads the project config from the
/// platform config file that ships inside the app bundle
/// (`android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`),
/// so `Firebase.initializeApp()` needs no `options` argument. That keeps
/// `flutterfire configure` — which authenticates with the project owner's own
/// Google account — off the critical path (ADR 0002 §Consequences).
///
/// Those config files are gitignored because the repo is public and they carry
/// per-project API keys; each developer downloads their own from the Firebase
/// console. See `docs/12-cloud-sync-plan.md` §0.
///
/// On **web** there is no native config file, so this throws unless a generated
/// `firebase_options.dart` is wired in. That is deliberate and harmless: the
/// caller in `lib/main.dart` swallows the failure, [isFirebaseInitialised]
/// stays `false`, the auth layer reports "signed out", and the app behaves
/// exactly as it always has — local-only, offline-first, no account required.
///
/// Calling this more than once is safe.
Future<void> initializeFirebase() async {
  if (Firebase.apps.isNotEmpty) return;
  await Firebase.initializeApp();
}

/// Whether a Firebase app is live in this process.
///
/// Reads the in-memory app registry only — no platform channel, no network — so
/// it is safe to call from plain `flutter test` runs.
bool isFirebaseInitialised() => Firebase.apps.isNotEmpty;
