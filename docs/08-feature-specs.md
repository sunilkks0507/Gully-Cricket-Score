# 08 — Feature Specs

Feature-by-feature functional specs with screens, behaviour, and acceptance criteria. Build in
the order of `10-build-roadmap.md`. Each feature lists **Screen(s)**, **Behaviour**, **Edge
cases**, **Acceptance**.

---

## F1. Teams & Players

**Screens:** Players list, Player add/edit, Teams list, Team add/edit (with roster picker).

**Behaviour:**
- Create/edit/delete players (name required; nickname, batting/bowling style, role, photo optional).
- Create/edit/delete teams; add players to a team's roster (a player may be in many teams).
- Search/filter players by name.

**Edge cases:** duplicate names allowed (distinguish by nickname); deleting a player used in a
completed match is soft-hidden, not hard-deleted (history integrity).

**Acceptance:** can create a team of 11 in under a minute; roster reusable across matches.

---

## F2. Match Setup

**Screens:** New Match → (1) pick format/preset, (2) pick/confirm both teams & XI, (3) toss,
(4) review rules → Start.

**Behaviour:**
- Choose a **preset** (T20/ODI/Gully Classic/Box/Tape-ball/Custom) → seeds `MatchRules`.
- "Customise rules" exposes every `MatchRules` field with validation (overs ≥1, players ≥2,
  bowler cap ≥1, toggles for LBW/free-hit/last-man-stands/six-and-out/keeper, wide & no-ball
  penalties/re-bowl).
- Select playing XI for each team; mark captain & keeper.
- Record **toss**: winner + decision (bat/bowl) → determines batting order.
- Choose opening striker, non-striker, and opening bowler to begin innings 1.

**Edge cases:** fewer players than `playersPerSide` (warn but allow for gully); same player in
both teams (joker — warn, allow).

**Acceptance:** setup for a saved team ≤ 60s; starting the match creates `MatchCreated` +
`InningsStarted` events and lands on the live screen.

---

## F3. Live Scoring (core)

**Screen:** Live Scoring — top **live header**, middle **this-over strip**, bottom **scoring pad**.

**Live header shows:** batting team, `runs/wickets`, `overs (x.y)`, CRR; innings 2 adds
`target`, `need R off B`, RRR; striker & non-striker with `runs(balls)` and `*` on striker;
current bowler figures `O-M-R-W`.

**Scoring pad (primary row):** `0 1 2 3 4 6` and `W` (wicket). **Secondary:** `Wide`, `No ball`,
`Bye`, `Leg bye`, `5/7 (odd)`, `Undo`, `Retire`, `More`.

**Ball entry flow (common case = 1–2 taps):**
- Tap a run button → records a legal ball with that many off-bat runs; engine handles strike/over.
- Wide/No-ball → opens a small modifier (extra runs / off-bat runs for no-ball) then confirm.
- Bye/Leg-bye → tap how many were run.
- **W** → wicket sheet: pick dismissal type (filtered by rules & free-hit context), then the
  out batter (for run-out), fielder (for caught/stumped/run-out), then the **new batter**.
- **Free hit** state clearly indicated on the header/pad; only legal dismissals shown.

**End of over:** prompt for next bowler (cannot be the same as the just-finished bowler; enforce
cap); strike auto-swaps.

**Undo/Redo:** Undo reverts the last event and restores full state (strike, bowler eligibility,
FOW). Redo re-applies. Multi-level.

**Autosave:** every ball persisted; killing the app and reopening resumes exactly.

**Edge cases:** last-man-stands, all-out, target reached mid-over, super over, retired hurt
(replace batter, not a wicket).

**Acceptance:** a full 20-over innings scores with correct totals/extras/strike without manual
correction; app-kill mid-over resumes to the same ball.

---

## F4. Scorecard

**Screen:** Scorecard (tabs: Innings 1 / Innings 2 / Info).

**Shows:** full batting card (R,B,4s,6s,SR,dismissal text), bowling card (O,M,R,W,Econ,wd,nb),
extras breakdown & total, fall of wickets, partnerships, powerplay markers, result line.

**Behaviour:** live-updates during the match; read-only after completion (edits only via undo
during play). Shareable/exportable (see F9).

**Acceptance:** numbers reconcile exactly with the live header at all times (property test:
sum of batter runs + extras == team total).

---

## F5. Commentary / Ball log (optional but recommended)

**Screen:** Commentary feed (reverse chronological), grouped by over.

**Behaviour:** auto-generate a text line per ball ("12.3 Bowler to Striker, FOUR, ..."); scorer
can edit a line. Derived from events; regenerates on undo.

**Acceptance:** feed matches the event log; editing persists as event metadata.

---

## F6. Player Profiles & Career Stats

**Screen:** Player profile — header (name/photo/style), Batting stats, Bowling stats, Fielding,
Recent matches.

**Batting:** matches, innings, runs, HS, average, strike rate, 50s, 100s, 4s, 6s, not-outs.
**Bowling:** overs/balls, runs, wickets, best figures, average, economy, strike rate, 3w/5w hauls.
**Fielding:** catches, stumpings, run-outs.

**Behaviour:** aggregates computed from all completed matches (projection table, rebuilt on match
completion). Formulas in `09-stats-and-tournament.md`.

**Acceptance:** stats update after a completed match; recomputing from scratch yields identical
numbers (rebuild test).

---

## F7. Match History

**Screen:** History list (search/filter by team/player/date/tournament) → tap opens Scorecard.

**Behaviour:** lists completed & in-progress matches with scoreline & result; resume in-progress;
delete (with confirm) removes match + events (and triggers stat recompute).

**Acceptance:** search returns correct matches; opening shows the exact preserved scorecard.

---

## F8. Tournament Mode

**Screens:** Tournament list, Tournament detail (Teams / Fixtures / Points table / Stats).

**Behaviour:**
- Create tournament (name, format/rules, points config, tie-break order).
- Add teams; **auto-generate fixtures** (round-robin; optional double round-robin).
- Link a scored match to a fixture; on completion, **points table** & **NRR** auto-update.
- Points table columns: P, W, L, T, N/R, Pts, NRR. Tie-break per configured order.
- Tournament-level leaderboards (most runs/wickets).

**Acceptance:** NRR & points match manual calculation on a worked example (see 09 §NRR test).

---

## F9. Export / Share

**Behaviour:** share scorecard as **image** (screenshot of a formatted card), **PDF**, and
**CSV** (per-innings + tournament stats). Uses `share_plus`.

**Acceptance:** exported artefact contains complete, correct scorecard data.

---

## F10. Backup / Restore

**Behaviour:** export all data (or a match) to a JSON file the user saves/shares; import restores
it. This is the manual substitute for cloud sync in v1.

**Acceptance:** export→wipe→import reproduces identical matches, players, stats.

---

## F11. Settings

**Behaviour:** theme (system/light/dark), default format, default rule toggles, confirm-before-
delete, about, data management (backup/restore, clear data).

---

## Cross-cutting acceptance (property tests)

- **Total integrity:** `sum(batter runs) + extras.total == innings total` after every ball.
- **Balls integrity:** `legalBalls == 6*completedOvers + ballsThisOver`.
- **Undo integrity:** apply N events then undo N → state equals initial.
- **Rebuild integrity:** fold-from-scratch == incrementally-maintained state.
