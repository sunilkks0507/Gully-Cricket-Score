# CLAUDE.md — Cricket Scoring App

> This file is the entry point for Claude Code. Read it first, then read `docs/00-INDEX.md`.
> It tells you what we're building, the rules of the road, and where to find detail.

## What we are building

A **mobile cricket scoring app** for amateur / local club and gully (street) cricket.
Scorers run a live match ball-by-ball; the app produces a live scorecard, full stats,
player profiles, match history, and a tournament mode — all **offline, on-device**.

- **Platform:** Flutter (iOS + Android from one codebase).
- **Data:** 100% offline / local-first. No backend in v1. Local DB only.
- **Formats:** Limited-overs (T20 / ODI / custom overs) + Gully / street cricket variants.
- **Audience:** Amateur & local clubs. Free. No ads or monetization in v1.
- **"Multi-user":** multiple **scorer + player profiles on the same device** (not live
  cross-device sharing). The data model must be built so a cloud-sync / live-share
  phase can be added later without a rewrite. See `docs/07-architecture.md`.

## Golden rules for this codebase

1. **The scoring engine is the heart of the app. It must be pure Dart, fully unit-tested,
   and framework-independent.** No Flutter imports in the engine. See `docs/04-scoring-engine-spec.md`.
2. **Every ball is an immutable event.** State is derived by folding events, never mutated
   in place. This gives us free undo/redo and an audit trail. See `docs/06-data-model.md`.
3. **Offline-first.** Assume no network, ever, in v1. All writes go to the local DB and must
   survive app kill / crash mid-over (autosave every ball).
4. **Rules are data, not hard-code.** Match rules (overs, players, wide/no-ball behaviour,
   gully rules) live in a `MatchRules` config object so new variants don't require engine
   surgery. See `docs/05-gully-cricket-rules.md`.
5. **Test the rules, not the UI first.** Before wiring screens, get the engine passing the
   scenario tests in `docs/04-scoring-engine-spec.md` §Test Cases.
6. Prefer **small, surgical changes**. Don't refactor unrelated code. Follow the existing
   folder structure in `docs/07-architecture.md`.

## Tech stack (decided)

- **Language / UI:** Dart + Flutter (latest stable).
- **State management:** Riverpod (with `riverpod_generator`).
- **Local database:** Drift (SQLite) for relational stats/queries; store the raw ball-event
  stream as rows so we can rebuild any scorecard. (Alternative considered: Isar — see
  `docs/07-architecture.md` for why Drift.)
- **Navigation:** go_router.
- **Models / immutability:** freezed + json_serializable.
- **Testing:** flutter_test + mocktail; golden tests for the scorecard widget.

If you (Claude Code) have a strong reason to deviate, note it in an ADR under `docs/adr/`
before changing course — don't silently swap the stack.

## Build order (see docs/10-build-roadmap.md for detail)

1. Project scaffold + folder structure + CI.
2. Data model + local DB + `MatchRules`.
3. **Scoring engine (pure Dart) + full unit tests.** ← do not skip tests here.
4. Match setup flow (teams, players, toss, rules).
5. Live scoring screen wired to the engine.
6. Scorecard + commentary + undo/redo.
7. Player profiles, history, aggregate stats.
8. Tournament mode (points table, NRR, fixtures).
9. Gully-cricket rule presets.
10. Polish, export/share (image/PDF/CSV), settings, backup.

## How to work

- Start each session by reading `docs/00-INDEX.md`.
- When implementing a feature, open its spec in `docs/08-feature-specs.md` first.
- Keep the glossary (`docs/11-glossary.md`) open — cricket terms have precise meanings.
- Write tests alongside code. The engine must stay green.
- Commit in small logical units with clear messages.

## Non-goals for v1 (do NOT build these yet)

- No login / accounts / cloud sync / live-streaming.
- No DLS (Duckworth-Lewis-Stern) rain calculations.
- No Test / multi-day format.
- No monetization, ads, or analytics SDKs.
- No social feed. (All are future phases — keep the data model friendly to them.)
