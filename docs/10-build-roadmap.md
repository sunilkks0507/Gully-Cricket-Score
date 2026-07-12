# 10 — Build Roadmap

Phased plan for Claude Code. Each phase has a **Definition of Done (DoD)**. Do not start a phase
before the previous phase's DoD is green. Tests-first for the engine.

## Phase 0 — Scaffold & CI
- Flutter app created; folder structure from `07-architecture.md`.
- Packages added (riverpod, freezed, drift, go_router, uuid, etc.).
- `flutter analyze`, `dart format`, `flutter test` wired in CI.
- App runs on Android emulator with a placeholder Home.
- **DoD:** clean analyze, empty test suite passes, app boots.

## Phase 1 — Models & Local DB
- Implement `models/` (freezed): `BallEvent`, `Wicket`, `MatchRules`, `MatchState`,
  `InningsState`, `Scorecard`, `MatchResult`, enums.
- Drift DB + tables (`Player`, `Team`, `TeamPlayer`, `Match`, `MatchPlayer`, `Event`,
  `Tournament`, `TournamentTeam`, `Fixture`) + DAOs.
- `MatchRules` JSON (de)serialisation + presets (T20/ODI/Gully/Box/Tape-ball).
- **DoD:** can insert/read players, teams, a match, and events; JSON round-trips; unit tests
  for serialisation & presets pass.

## Phase 2 — Scoring Engine (tests first) ★ critical
- Implement `engine/apply(state, event)` per `04-scoring-engine-spec.md`.
- Implement strike, over, free-hit, wicket, innings-end, validation, projections.
- Write **all §9 scenario tests + gully cases + property tests** (total/balls/undo/rebuild).
- **DoD:** 100% of engine scenario & property tests green; engine has zero Flutter imports.

## Phase 3 — Match Setup flow
- Screens: format/preset → teams & XI → toss → rules review → start.
- Custom-rules screen with validation.
- Creates `MatchCreated` + `InningsStarted` events; navigates to live screen.
- **DoD:** can set up a T20 and a Gully match end-to-end; events persisted; resumable.

## Phase 4 — Live Scoring
- Live header, this-over strip, scoring pad (primary + secondary rows).
- Wicket sheet (context-filtered dismissals, fielder, new batter).
- Wide/no-ball/bye/leg-bye modifiers; free-hit indication; end-of-over bowler prompt.
- Undo/redo; autosave every ball; crash-resume.
- **DoD:** score a full innings with correct live numbers; kill-app resumes to exact ball;
  undo restores state including over/bowler eligibility.

## Phase 5 — Scorecard & Commentary
- Full scorecard tabs (batting/bowling/extras/FOW/partnerships/result).
- Auto commentary feed (editable), regenerates on undo.
- **DoD:** scorecard reconciles with live header (property test); commentary matches log.

## Phase 6 — Players, History, Stats
- Player profiles with batting/bowling/fielding aggregates (formulas in 09).
- Match history list with search/filter/resume/delete.
- `PlayerCareerStat` projection + "rebuild all stats" maintenance.
- **DoD:** stats update on completion; incremental == full-rebuild (test).

## Phase 7 — Tournament Mode
- Create tournament, add teams, generate fixtures, link matches.
- Points table + NRR (with all-out adjustment) + tie-breaks; tournament leaderboards.
- **DoD:** NRR/points match the worked example in 09; fixtures correct for odd/even teams.

## Phase 8 — Export / Backup / Settings / Polish
- Share scorecard (image/PDF/CSV); backup/restore JSON; settings; theming; empty states;
  accessibility labels; large-tap ergonomics.
- **DoD:** export/import round-trips; a11y pass; UX review checklist done.

## Phase 9 (future / not v1)
- Cloud sync & live cross-device sharing (replicate event log).
- Charts (wagon wheel / Manhattan / worm) via fl_chart.
- Test/multi-day format; DLS; live streaming; accounts/social.

## Definition of Done (global)
- Feature meets its spec in `08-feature-specs.md`.
- Engine tests green; new logic covered by tests.
- `flutter analyze` clean; formatted; no TODOs left in shipped code paths.
- Manual smoke test on a real mid-range Android device where feasible.

## Suggested first prompt to Claude Code
> "Read CLAUDE.md and docs/. Do Phase 0 (scaffold + CI + folder structure). Then Phase 1 models
> and Drift DB with tests. Stop after Phase 1 DoD and show me the test output."
Then iterate phase by phase, keeping the engine tests as the safety net.
