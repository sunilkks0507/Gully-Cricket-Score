# ADR 0001 — Local database: Drift (SQLite)

- **Status:** Accepted (v1)
- **Date:** 2026-07-12

## Context
Offline-only app. We need (a) an append-only **event log** for crash-safe scoring & undo, and
(b) **relational aggregate queries** for player career stats and tournament points/NRR.

## Decision
Use **Drift (SQLite)**. Store the event log as an append-only `Event` table; store stats as
relational tables + rebuildable projection tables.

## Alternatives considered
- **Isar** — great object store, fast, but ad-hoc relational aggregations (players across many
  matches, tournament tables) are more awkward than SQL.
- **Hive / shared_prefs** — too low-level for our querying needs.

## Consequences
- SQL makes stats/tournament math straightforward and testable.
- Schema migrations needed for new tables/columns; rule flags live in JSON blobs (additive, no
  migration).
- Future cloud sync replicates the event log — DB choice doesn't block it.

> Record any change to this decision as a new ADR; don't silently swap the DB.
