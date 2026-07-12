# 01 — Product Requirements (PRD)

## Vision

The simplest, fastest, fully-offline cricket scoring app for amateur and gully cricket.
A single scorer can set up a match in under a minute and score ball-by-ball with one hand,
producing a professional scorecard, rich stats, and player profiles — with no internet.

## Problem

Popular apps (CricHeroes, Stumps) are powerful but assume connectivity, accounts, and a
social/tournament ecosystem. Local players scoring a weekend or gully match want something
that: works with zero signal, starts instantly, handles improvised gully rules, and keeps a
private history of their own matches and player stats on-device.

## Target users

1. **The weekend scorer** — one person on the boundary scoring a club/league T20 or custom-overs
   match. Wants speed, accuracy, undo, and a shareable scorecard.
2. **The gully organiser** — runs street/box cricket with house rules (one-tip-one-hand,
   last-man-stands, custom overs). Wants flexible rules and quick setup.
3. **The stats keeper** — tracks a squad's players across many matches; wants profiles,
   averages, leaderboards, and match history.
4. **The tournament runner** — runs a small local tournament; wants fixtures, points table,
   and net run rate computed automatically.

## Goals (v1)

- Score a full limited-overs match ball-by-ball, offline, without error.
- Support custom overs, players-per-side, and common gully rule presets.
- Auto-generate a full scorecard (batting, bowling, extras, fall of wickets, partnerships).
- Maintain player profiles with career/aggregate batting & bowling stats.
- Keep searchable match history on-device.
- Tournament mode: teams, fixtures, points table with net run rate.
- Undo/redo any number of balls; survive app kill mid-match.
- Export/share a scorecard as image / PDF / CSV.

## Non-goals (v1)

- No accounts, cloud sync, or live cross-device sharing (design data model to allow it later).
- No live streaming.
- No DLS rain-rule calculations.
- No Test / multi-day cricket.
- No ads / payments / third-party analytics.

## Success criteria

- A scorer can complete a 20-over match with correct totals, extras, and stats with zero
  manual correction beyond undo.
- Match setup ≤ 60 seconds for a saved team.
- Scoring one ball ≤ 2 taps for the common case (dot / single / boundary / wicket).
- App fully usable in airplane mode.
- Data never lost on crash or force-close (autosave every ball).

## Key user stories

- As a scorer, I can create teams and players once and reuse them.
- As a scorer, I record the toss and who bats first.
- As a scorer, for each ball I record runs, extras (wide/no-ball/bye/leg-bye), and wickets
  with the correct dismissal type and fielder.
- As a scorer, I can undo the last ball (or several) if I tapped wrong.
- As a scorer, at any moment I see live: score, wickets, overs, CRR, RRR (2nd innings),
  striker/non-striker, current bowler, this over's balls.
- As a gully organiser, I pick a rules preset (or customise) so dismissals and extras match
  our house rules.
- As a stats keeper, I open any player and see matches, runs, average, strike rate, wickets,
  economy, best figures, 50s/100s.
- As a tournament runner, I create a tournament, add teams, generate fixtures, and see an
  auto-updating points table with NRR.

## Constraints & assumptions

- One active scorer per match on one device (no concurrent editing in v1).
- Portrait-first UI, one-handed reach for the scoring pad.
- Must work on mid-range Android devices (common in target market).
- All timestamps and data stored locally; user owns their data (offer local backup/export).

## Open product decisions (flag to user, default chosen)

- **Default format on new match:** T20 (20 overs, 11 players). *Default assumed.*
- **Second-innings target/RRR shown by default:** yes.
- **Store ball-by-ball commentary text:** yes (auto-generated, editable).
