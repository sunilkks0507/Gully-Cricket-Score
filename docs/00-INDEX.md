# Cricket Scoring App — Documentation Index

Read `../CLAUDE.md` first. This folder is the full context pack for building the app.

## Reading order

| # | File | What it covers | When to read |
|---|------|----------------|--------------|
| 01 | [Product Requirements](01-product-requirements.md) | Vision, users, goals, scope, success criteria | First |
| 02 | [Market Research](02-market-research.md) | Competitor apps, what they do well, our gaps to fill | Positioning |
| 03 | [Cricket Rules Reference](03-cricket-rules-reference.md) | Authoritative rules of cricket relevant to scoring | Before engine work |
| 04 | [Scoring Engine Spec](04-scoring-engine-spec.md) | The ball-by-ball engine: inputs, state, outputs, tests | Core build |
| 05 | [Gully / Street Rules](05-gully-cricket-rules.md) | Custom & informal rule variants + config model | Rules config |
| 06 | [Data Model](06-data-model.md) | Entities, schema, event sourcing, DB tables | Before DB work |
| 07 | [Architecture](07-architecture.md) | Flutter structure, packages, layers, folders | Scaffold |
| 08 | [Feature Specs](08-feature-specs.md) | Feature-by-feature functional specs + acceptance | Each feature |
| 09 | [Stats & Tournament](09-stats-and-tournament.md) | Stat formulas, NRR, points table, fixtures | Stats/tourney |
| 10 | [Build Roadmap](10-build-roadmap.md) | Phased plan, milestones, definition of done | Planning |
| 11 | [Glossary](11-glossary.md) | Cricket terms with precise meanings | Reference |

## Quick facts

- **Stack:** Flutter, Riverpod, Drift (SQLite), go_router, freezed.
- **Data:** offline / local-only in v1.
- **Formats:** limited-overs (T20/ODI/custom) + gully/street.
- **Architecture principle:** every ball is an immutable event; state is derived.

## Conventions

- All rule-affecting behaviour flows from a `MatchRules` config object — never hard-coded.
- The engine (`lib/engine/`) has **zero Flutter imports** and 100% of its logic unit-tested.
- Cricket terms are used exactly as defined in the glossary.
- ADRs (architecture decision records) go in `docs/adr/NNNN-title.md`.
