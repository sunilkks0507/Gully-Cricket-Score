# 07 — Architecture

Flutter app, offline-first, layered so the **scoring engine is isolated and testable**.

## Layers

```
UI (widgets/screens)      Flutter, Riverpod consumers, go_router
        |  (reads state, sends intents)
Application (controllers)  Riverpod notifiers: orchestrate use-cases, call engine, persist
        |
Domain
  ├─ engine/              PURE DART scoring engine (no Flutter). apply(state,event)->state
  └─ models/              freezed immutable types (BallEvent, MatchRules, MatchState, ...)
        |
Data (repositories)       Drift (SQLite) DAOs, event-log store, projections, backup/export
```

Dependency rule: **inner layers never import outer**. `engine/` and `models/` import nothing
from Flutter/data. Repositories depend on models, not on the engine's private logic.

## Recommended packages

| Concern | Package | Notes |
|---|---|---|
| State mgmt | `flutter_riverpod` + `riverpod_generator` | testable, no BuildContext coupling |
| Immutable models | `freezed`, `json_serializable` | unions for events, copyWith, JSON |
| Local DB | `drift` (+ `sqlite3_flutter_libs`) | relational stats + event log; type-safe queries |
| Navigation | `go_router` | declarative routes, deep-link ready |
| DI | Riverpod providers | no separate DI framework |
| IDs | `uuid` | local ids |
| Dates | Dart `DateTime` + `intl` | formatting |
| PDF/share | `pdf`, `printing`, `share_plus`, `screenshot` | scorecard export |
| Charts (phase 2) | `fl_chart` | Manhattan/worm/wagon wheel |
| Testing | `flutter_test`, `mocktail`, `drift` in-memory | engine + widget + golden |

### Why Drift over Isar (ADR summary)
- Stats need relational joins/aggregations (players across matches, tournament tables). Drift's
  SQL is a better fit and easy to reason about. Isar is fine for pure object storage but we lean
  on ad-hoc aggregate queries. The **event log** is just a table either way. Record final choice
  in `docs/adr/0001-local-db.md`.

## Folder structure

```
lib/
  main.dart
  app/                     app root, theme, router
    router.dart
    theme.dart
  models/                  freezed types (pure)
    ball_event.dart
    wicket.dart
    match_rules.dart
    match_state.dart
    innings_state.dart
    scorecard.dart
    result.dart
  engine/                  PURE DART — no Flutter imports
    scoring_engine.dart    apply(state, event) -> state
    strike_logic.dart
    over_logic.dart
    innings_end.dart
    validation.dart
    projections.dart       build Scorecard / stats from events
  data/
    db/                    drift database + tables + daos
      app_db.dart
      tables.dart
      match_dao.dart
      event_dao.dart
      stats_dao.dart
    repositories/
      match_repository.dart
      player_repository.dart
      team_repository.dart
      tournament_repository.dart
      backup_repository.dart
  application/             riverpod notifiers/controllers
    live_match_controller.dart   holds MatchState, applies events, persists, undo/redo
    setup_controller.dart
    players_controller.dart
    tournament_controller.dart
  features/                UI grouped by feature
    home/
    match_setup/
    live_scoring/          the scoring pad + live header
    scorecard/
    players/
    history/
    tournament/
    settings/
    export/
  shared/                  widgets, formatters, extensions
test/
  engine/                  the §9 scenario tests (write first)
  data/
  features/                widget + golden tests
```

## State flow (live scoring)

1. UI dispatches an intent (e.g. "single", "wide+2", "wicket: caught by #5").
2. `LiveMatchController` builds a `BallEvent`, calls `ScoringEngine.apply(state, event)`.
3. On success: update in-memory `MatchState` (Riverpod) **and** append event to DB (transaction).
4. UI rebuilds from the new state (live header, this-over, scorecard).
5. Undo: controller moves DB cursor back, re-folds events, updates state.

## Crash safety & resume

- Every event persisted before/at the moment UI updates (single transaction). If the app dies,
  on next launch the controller finds the `inProgress` match and rebuilds state from the log.
- Consider a periodic snapshot (every 30 events) to speed rebuilds — optional.

## Theming / UX system

- Material 3, portrait-first. Large tap targets for the scoring pad (min 48dp).
- One-handed: primary run buttons (0,1,2,3,4,6) and W within thumb reach; extras/secondary
  actions on a second row or expandable sheet.
- Dark mode supported (outdoor daytime + evening).
- Accessibility: semantic labels on all pad buttons; scalable text.

## Future-proofing for cloud/live-share (do now, cheaply)

- Keep all writes as **append-only events** with a per-match `seq`.
- Use uuids for all ids (merge-friendly).
- Isolate persistence behind repositories so a future `SyncRepository` can replicate the log.
- Don't bake device-only assumptions into the engine.

## CI (set up early)

- `flutter analyze`, `dart format --set-exit-if-changed`, `flutter test` on every push.
- Engine tests must pass to merge (they are the safety net).
