# 05 — Gully / Street Cricket Rules & Config

Gully (street/box) cricket has no single rulebook — **rules are agreed before each match**.
Our differentiator is treating these as **first-class presets** the organiser picks at setup,
all expressed through the `MatchRules` config (see 04/06). This doc lists the common variants
and how to model them.

## Design approach

- Ship a few **presets** (Gully Classic, Box/Tennis-ball, Tape-ball, Last-Man-Stands) that
  set sensible `MatchRules` values.
- Let the organiser **customise** any field before starting.
- The engine already reads every rule from config, so gully = a different config, not new code.
- Where a rule can't be auto-detected (e.g. one-tip-one-hand catch), the scorer records the
  outcome; the app just needs the right dismissal options available.

## Common gully rules and how to model them

### 1. One tip one hand (out)
- A one-handed catch after **one bounce** is a legal dismissal.
- Model: allow a `caught` dismissal with a flag `oneTipOneHand = true` on the wicket, or an
  extra dismissal reason label "Caught (one tip one hand)". `rules.oneTipOneHand` enables the
  option in the wicket picker. Engine treats it as a caught-type (bowler credited? usually the
  bowler is credited as a normal catch — make it a caught dismissal).

### 2. No LBW
- Very common (no neutral umpire). Model: `rules.lbwEnabled = false` → LBW hidden from the
  wicket picker.

### 3. Last man stands (single batter continues)
- When only one batter remains (partner "out" but team keeps batting), the last batter bats
  alone and must **run in pairs** (odd runs may be disallowed or counted differently).
- Model: `rules.lastManStands = true`. Engine: after wickets == available-1, don't end innings;
  keep the last batter as striker; a run-out of the lone batter ends the innings. Optionally
  `lastManMustRunTwo = true` (a single run is void / counts as dot — configurable).

### 4. Joker / extra player bats for both sides
- With uneven numbers, a "joker" bats for both teams (often also keeps wickets).
- Model: `rules.jokerBatsBothSides = true`; represent the joker as a player linked to both
  line-ups. This is mostly a **setup/roster** concern; the engine just sees a batter id. Keep
  simple in v1: allow selecting the same player in both teams' batting lists (warn, don't block).

### 5. Custom overs / players
- Gully games are often 4–8 overs, 4–8 players.
- Model: `oversPerInnings`, `playersPerSide`, `maxOversPerBowler` fully configurable (min 1).

### 6. One-hand-one-bounce off walls / boundaries (box cricket)
- Box cricket uses walls; "direct hit to wall on full = out" or "6 & out" (hitting six loses
  wicket because ball leaves the box).
- Model: `rules.sixAndOut = true` (a six also dismisses the striker) and/or
  `rules.oneHandOneBounceWall`. Engine: if `sixAndOut`, a `six` outcome also records a wicket
  (dismissal type `retiredOut`-like / a dedicated `sixOut` reason). Keep as a flag with a clear
  dismissal label.

### 7. First-ball / trial ball
- Some games give the first ball as a no-run "trial". Model: skip — let scorer just not record,
  or `rules.trialBallFirst` (dot that doesn't count). Low priority.

### 8. Automatic wicketkeeper / no keeper
- Affects stumped availability. Model: `rules.keeperPresent`; if false, hide `stumped`.

### 9. Runs behind the stumps disallowed / only straight
- "No runs on the leg side", "only straight drives count", etc. Too varied to model precisely —
  these are scorer discretion. Don't over-engineer; the scorer records the runs they judge valid.

### 10. Tip-and-run (must run if bat touches ball)
- Model: metadata note only; scorer records the outcome (often causes run-outs). No engine change.

### 11. No-ball / wide gully variants
- Some gully games: no-ball = 2 runs, or no free hit, or wides not counted at all.
- Model: `noBallPenalty` (1 or 2), `freeHitAfterNoBall` (false in gully), `wideRun` (0/1),
  `wideReBowled` (sometimes false — a wide is just a run and the ball counts). All already in config.

### 12. Single-side batting / continuous
- Some formats: everyone bats a fixed number of balls regardless of dismissals ("retire on
  X runs", "each pair bats 2 overs"). Phase-2 preset: `rules.pairMode` (each pair bats N overs,
  minus runs on wicket). Note as future; not in v1 core unless quick.

## Preset table (initial `MatchRules` values)

| Preset | overs | players | maxOvers/bowler | LBW | freeHit | lastManStands | sixAndOut | keeper |
|---|---|---|---|---|---|---|---|---|
| **T20 (standard)** | 20 | 11 | 4 | ✅ | ✅ | ❌ | ❌ | ✅ |
| **ODI (standard)** | 50 | 11 | 10 | ✅ | ✅ | ❌ | ❌ | ✅ |
| **Gully Classic** | 6 | 6 | 2 | ❌ | ❌ | ✅ | ❌ | optional |
| **Box / Tennis-ball** | 4 | 6 | 1 | ❌ | ❌ | ✅ | ✅ | ❌ |
| **Tape-ball** | 8 | 8 | 2 | ❌ | ❌ | ❌ | ✅ | ✅ |
| **Custom** | user | user | user | user | user | user | user | user |

(Adjust defaults with the user; these are reasonable starting points.)

## What to build in v1

- Preset picker on the match-setup screen (list above).
- A "Customise rules" screen exposing every `MatchRules` field with sane inputs & validation.
- Engine honours: custom overs/players/bowler-cap, lbwEnabled, freeHitAfterNoBall, wide/no-ball
  penalties & re-bowl flags, lastManStands, sixAndOut, keeperPresent.
- Defer: pairMode, joker-both-sides advanced linking, wall rules → phase 2 (keep config additive).

## Sources

- [Gully cricket rules — CricJosh](https://cricjosh.in/blog/gully-cricket-rules-street-cricket-india)
- [10 gully cricket rules — Playo](https://blog.playo.co/gully-cricket-rules/)
- [Guide to gully cricket — Sportskeeda](https://www.sportskeeda.com/cricket/comprehensive-guide-to-gully-cricket-india)
- [Backyard cricket — Wikipedia](https://en.wikipedia.org/wiki/Backyard_cricket)
