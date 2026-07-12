# 06 — Data Model & Persistence

Local-only (SQLite via **Drift**). The design is **event-sourced**: the ball/match event log is
the source of truth; scorecards and stats are projections. This gives crash-safe autosave, free
undo, and a clean path to future cloud sync (sync the event log).

## Entities (relational tables)

### Player
- `id` (PK, local uuid), `name`, `nickname?`, `battingStyle?` (RH/LH), `bowlingStyle?`,
  `role?` (batter/bowler/all-rounder/keeper), `photoPath?`, `createdAt`.

### Team
- `id`, `name`, `shortName?`, `logoPath?`, `createdAt`.

### TeamPlayer (roster link)
- `teamId` (FK), `playerId` (FK), `jerseyNo?`. (A player can belong to many teams.)

### Match
- `id`, `title?`, `format` (t20/odi/custom/gully preset id), `rulesJson` (serialised `MatchRules`),
  `teamAId`, `teamBId`, `venue?`, `dateLocal`, `tossWinnerTeamId?`, `tossDecision?` (bat/bowl),
  `status` (notStarted/inProgress/inningsBreak/completed/abandoned), `resultJson?`,
  `tournamentId?` (FK, nullable), `createdAt`, `updatedAt`.

### MatchPlayer (playing XI for this match)
- `matchId`, `teamId`, `playerId`, `battingOrder?`, `isCaptain?`, `isKeeper?`.

### Event (the log — heart of persistence)
- `id` (autoincrement, ordering), `matchId` (FK), `seq` (int, per-match order),
  `type` (matchCreated/inningsStarted/ball/penalty/batterReplaced/endInnings/superOverStart...),
  `payloadJson` (the full `BallEvent`/event serialised), `createdAt`.
- **Append-only.** Undo is a `cursor` on `seq` (store `Match.eventCursor`); redo re-advances it.
  Physically keep events beyond the cursor until a new event overwrites the tail (then delete
  seq > cursor).

### Projections (optional cached tables for fast lists; always rebuildable from Event)
- `MatchSummary` (cached): matchId, teamA/B names, scoreline string, result string, date.
- `PlayerCareerStat` (cached aggregate): playerId, matches, innings, runs, balls, HS, avg, SR,
  50s, 100s, wickets, ballsBowled, runsConceded, bestBowling, econ, catches, stumpings, runOuts.
  Rebuild by folding all completed matches' events. Recompute on match completion.

### Tournament
- `id`, `name`, `format`, `rulesJson`, `startDate?`, `endDate?`, `pointsWin` (default 2),
  `pointsTie` (1), `pointsNoResult` (1), `pointsLoss` (0), `tieBreakOrder` (json: [nrr, headToHead, ...]),
  `createdAt`.
- `TournamentTeam`: `tournamentId`, `teamId`.
- `Fixture`: `id`, `tournamentId`, `round?`, `teamAId`, `teamBId`, `scheduledDate?`, `matchId?`
  (set once played), `status`.

## Key serialised objects (stored as JSON in columns)

### MatchRules
See `04-scoring-engine-spec.md` §2. Stored in `Match.rulesJson` / `Tournament.rulesJson`.

### BallEvent / Wicket
See `04-scoring-engine-spec.md` §2. Stored in `Event.payloadJson` with `type = 'ball'`.

### MatchResult
```json
{
  "type": "winByRuns|winByWickets|tie|noResult|superOver",
  "winnerTeamId": 12,
  "margin": 23,                 // runs OR wickets depending on type
  "marginUnit": "runs|wickets",
  "summary": "Team A won by 23 runs"
}
```

## Derived scorecard shape (not stored; computed)

```
InningsScorecard:
  battingTeam, bowlingTeam
  total, wickets, overs (e.g. "18.4"), runRate
  batters[]: {playerId, name, runs, balls, fours, sixes, sr, dismissalText, notOut}
  bowlers[]: {playerId, name, overs, maidens, runs, wickets, econ, wides, noBalls}
  extras: {wides, noBalls, byes, legByes, penalties, total}
  fallOfWickets[]: {wicketNo, batterId, scoreAtFall, over}
  partnerships[]: {forWicket, batterAId, batterBId, runs, balls}
  target?, powerplayOvers[]
```

## Persistence rules

1. **Autosave every applied event** → insert into `Event` + bump `Match.eventCursor` +
   `updatedAt`. Wrap in a transaction.
2. On app start, **resume** any `inProgress` match by folding its events up to the cursor.
3. **Undo/redo** only moves `eventCursor`; a new event after undo deletes `seq > cursor` then
   appends.
4. **Never delete** completed match events (history + stat rebuilds depend on them).
5. **Backup/export:** dump all tables (or per-match event log) to a JSON file the user can save
   / share. Import reverses it. (Future cloud sync = ship the same event log upstream.)

## Migrations

- Use Drift schema versioning. `MatchRules` and `BallEvent` are JSON blobs → additive fields are
  free (default when absent). Only add DB migrations for new **tables/columns**, not new rule flags.

## Indices

- `Event(matchId, seq)` unique — ordering + fast fold.
- `Match(status)`, `Match(tournamentId)`, `MatchPlayer(matchId)`, `TeamPlayer(playerId)`.

## Why event-sourcing here (record for ADR)

- Free, reliable undo/redo (the #1 scorer need).
- Crash safety: replay the log to recover exact state.
- Auditability: "what happened on ball 12.3" is answerable.
- Future-proof: cloud sync/live-share = replicate the append-only log; stats never disagree with
  the scorecard because both derive from the same events.
