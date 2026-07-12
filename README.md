# CricScore 🏏

An **offline, on-device box-cricket scoring app** for amateur, local-club, and gully cricket.
Score a match ball-by-ball and get a live scorecard, full stats, player profiles, match history,
and a tournament mode — all with no backend and no network required.

Built with **Flutter** (iOS + Android from one codebase).

## Features

- **New match** — standalone or attached to a tournament; box-cricket rules (configurable overs,
  players per side, optional **joker** who bats for both sides, six-and-out, last-man-stands).
- **Live scoring** — one-tap scoring pad (0–6, W, wide, no-ball, bye, leg-bye, swap), free-hit
  handling, wicket sheet with every dismissal type, over-complete bowler prompt, **multi-level
  undo/redo**, and **autosave every ball** (kill the app mid-over and resume exactly).
- **Scorecard** — full batting/bowling cards, extras, fall of wickets, partnerships, plus a
  ball-by-ball commentary feed.
- **Players & stats** — a reusable player pool, career profiles (batting/bowling/fielding), and
  overall leaderboards (most runs / most wickets).
- **Tournaments** — League / Round-robin / Knockout; auto-generated fixtures and a points table
  with **NRR** (including the standard all-out adjustment).
- **Backup/restore** — export all data to JSON and import it back.

## Architecture

The app is event-sourced: **every ball is an immutable event**, and all state (score, scorecard,
stats) is derived by folding the event log. This gives free, reliable undo/redo, crash-safe
resume, and a clean path to future cloud sync.

```
lib/
  models/       freezed immutable domain types (BallEvent, MatchRules, MatchState, GameEvent, …)
  engine/       PURE DART scoring engine — apply(state, event) -> state. Zero Flutter imports.
                + projections (scorecard/commentary), stats aggregation, tournament math (NRR/fixtures)
  data/         Drift (SQLite) database, DAOs, repositories, event codec
  application/  Riverpod providers + the live-scoring controller
  features/     UI grouped by feature (home, match_setup, live_scoring, scorecard, players,
                history, tournament, stats, settings)
  app/          root widget, router (go_router), Material 3 theme
```

**Stack:** Flutter · Riverpod · Drift (SQLite) · go_router · freezed / json_serializable · uuid.

## The scoring engine

The engine (`lib/engine/`) is the heart of the app: pure Dart, framework-independent, and fully
unit-tested. It is exercised by the 26 scenario tests from the spec plus box-cricket cases and
property tests (run-conservation, `legalBalls == Σ bowler balls`, and the undo≡rebuild law).

## Running

```bash
flutter pub get
dart run build_runner build          # generate freezed / json / drift code
flutter test                         # run the full suite
flutter run                          # launch on a device/emulator
flutter build apk --release          # build the Android APK
```

## Status

v1 is offline-only (no accounts, cloud sync, DLS, or Test format). The data model is intentionally
sync-friendly (uuid ids, append-only event log) so those can be added later without a rewrite.
