# 04 — Scoring Engine Spec

The engine is the core of the app. **Pure Dart, no Flutter imports, 100% unit-tested.**
It takes the current match state + a `BallEvent` and returns the next state, deterministically.

Location: `lib/engine/`. Depends only on Dart + `models/` (freezed data classes).

## 1. Design principles

1. **Event-sourced.** The canonical record is an ordered list of `BallEvent`s (+ setup +
   non-ball events). Any derived state (score, scorecard, stats) is a **fold** over events.
2. **Deterministic & pure.** `apply(state, event) -> state`. No I/O, no time, no randomness.
3. **Immutable.** State and events are `freezed` immutable classes; `apply` returns a new state.
4. **Undo/redo = pop/replay.** Undo removes the last event and re-folds; redo re-applies.
5. **Rules injected.** All variant behaviour comes from `MatchRules`, passed into the engine.

## 2. Core types (sketch — finalise in models/)

```dart
enum DeliveryOutcome { dot, runs, four, six }        // off-the-bat result
enum ExtraType { none, wide, noBall, bye, legBye, penalty }
enum DismissalType {
  bowled, caught, lbw, runOut, stumped, hitWicket,
  obstructing, hitBallTwice, timedOut, retiredOut,   // retiredHurt/absent tracked separately (not a wicket)
}

class BallEvent {
  final int inningsIndex;            // 0 or 1 (or more if super over)
  final int strikerId;
  final int nonStrikerId;
  final int bowlerId;
  final int runsOffBat;              // 0..6 (runs credited to striker)
  final ExtraType extraType;         // none/wide/noBall/bye/legBye/penalty
  final int extraRuns;               // additional runs from the extra (e.g. wide+4 => 4)
  final bool isFreeHit;              // this delivery is a free hit
  final Wicket? wicket;              // null if no dismissal
  final DateTime? tsLocal;           // metadata only, not used by engine logic
}

class Wicket {
  final DismissalType type;
  final int outBatterId;             // striker or non-striker (run out can be either)
  final int? fielderId;              // catcher / keeper / thrower
  final int? bowlerId;               // credited bowler (null for team dismissals)
  final int runsCompletedBeforeOut;  // runs completed on a run-out ball
}
```

`MatchRules` (see also 05 & 06):

```dart
class MatchRules {
  final int oversPerInnings;         // e.g. 20; 0 = unlimited (not used v1)
  final int playersPerSide;          // e.g. 11
  final int maxOversPerBowler;       // e.g. 4
  final bool freeHitAfterNoBall;     // T20 yes
  final int noBallPenalty;           // usually 1
  final int wideRun;                 // usually 1
  final bool wideReBowled;           // true
  final bool noBallReBowled;         // true
  final bool lbwEnabled;             // gully often false
  final bool legByeRequiresShot;     // strict laws true
  final List<int> powerplayOvers;    // e.g. [1..6]
  final bool lastManStands;          // gully: batting continues with last batter
  final bool jokerBatsBothSides;     // gully joker rule
  final bool oneTipOneHand;          // gully catch rule (metadata/validation aid)
  final int? runsPerNoBallExtraOnGully; // e.g. some gully games give 2 for no-ball
  final SuperOverRule superOver;     // none / oneOver / boundaryCountback
  // ...extend as needed; keep additive.
}
```

## 3. Match state (derived, held for fast UI)

```dart
class MatchState {
  final MatchRules rules;
  final int currentInnings;
  final InningsState innings1;
  final InningsState innings2;       // null until 2nd innings starts
  final MatchStatus status;          // notStarted, inProgress, inningsBreak, completed
  final MatchResult? result;
}

class InningsState {
  final int battingTeamId, bowlingTeamId;
  final int totalRuns, wickets;
  final int legalBalls;              // 0.. (overs = legalBalls ~/ 6 . legalBalls % 6)
  final int strikerId, nonStrikerId, bowlerId;
  final Extras extras;               // wides, noBalls, byes, legByes, penalties
  final Map<int, BatterCard> batters;
  final Map<int, BowlerCard> bowlers;
  final List<FallOfWicket> fow;
  final List<Partnership> partnerships;
  final int? target;                 // innings2 only = innings1.totalRuns + 1
  final bool freeHitPending;         // next legal delivery is a free hit
}
```

## 4. The `apply` algorithm (per BallEvent)

Given `state` + `event`, produce next `state`. Order matters:

1. **Validate** event against `rules` and current state (see §7). Reject illegal events.
2. **Compute runs to team total:**
   - Off the bat: `runsOffBat` (also to striker's score & bowler's runs-conceded).
   - Wide: `wideRun + extraRuns` → extras.wides; charged to bowler; not a legal ball.
   - No-ball: `noBallPenalty` → extras.noBalls; `runsOffBat` to striker (charged to bowler);
     any run byes on a no-ball go to byes but are still off a no-ball (not a legal ball).
   - Bye: `extraRuns` → extras.byes; legal ball; not charged to bowler.
   - Leg-bye: `extraRuns` → extras.legByes; legal ball; not charged to bowler.
   - Penalty: `extraRuns` (usually 5) → extras.penalties.
3. **Legal ball?** `isLegal = extraType != wide && extraType != noBall`.
   - If legal: `legalBalls += 1`; increment bowler's balls; count toward over.
4. **Free hit:**
   - If `event.extraType == noBall && rules.freeHitAfterNoBall` → set `freeHitPending = true`.
   - Else if this delivery was legal and consumed a pending free hit → clear it.
   - If a free-hit delivery is wide/no-ball → free hit **carries** (keep pending).
5. **Wicket:** if present and **allowed** in current context (free hit, no-ball) →
   - Increment `wickets` (unless it's retiredHurt/absent — not a wicket).
   - Credit bowler if applicable (§4.1 of rules doc).
   - Record FOW (score, over) and close current partnership; start a new one.
   - Bring in next batter at correct end (respect run-out crossing & last-man rules).
6. **Strike rotation:**
   - Count "running runs" that rotate strike = `runsOffBat` (if odd) XOR byes/leg-byes ran odd.
     Precisely: strike swaps if the **number of runs physically run** is odd. Boundaries (4/6
     hit, or 4 byes to fence) are not "run" → no swap from the boundary itself.
   - On a wide/no-ball, batters may still run extra → those runs can rotate strike.
   - Apply run-out end changes first, then running-run swaps.
7. **Over completion:** if `legalBalls % 6 == 0` after a legal ball →
   - Swap strike (end of over), enforce new bowler (`bowlerId` must change; validate not same
     as last over's bowler), reset over ball-count. Emit `OverCompleted`.
8. **Innings end check:** overs done (`legalBalls == oversPerInnings*6`) OR all out OR target
   reached → set status to `inningsBreak` (after innings1) or `completed` (after innings2) and
   compute `MatchResult`.
9. Return new immutable `MatchState`.

## 5. Non-ball events (also part of the event stream)

- `MatchСreatedEvent` (setup: teams, players, toss, rules).
- `InningsStartedEvent` (opening batters, opening bowler).
- `BatterReplacedEvent` (retired hurt / substitute).
- `PenaltyRunsEvent`.
- `EndInningsEvent` (manual, e.g. declaration—not v1—or forfeit).
- `UndoEvent` is **not** stored; undo pops the last event from the log.

## 6. Undo / redo

- Maintain `List<Event> log` and an integer `cursor`.
- **Undo:** `cursor--`; rebuild `MatchState` by folding `log[0..cursor]`.
- **Redo:** `cursor++`; fold again. New action after undo truncates the redo tail.
- Rebuilds are cheap (a match ≤ ~1500 events); optionally memoise snapshots every N events.
- **Autosave:** persist the event log to the DB after every applied event (crash-safe).

## 7. Validation rules (reject / warn)

- Bowler cannot bowl two consecutive overs.
- Bowler cannot exceed `maxOversPerBowler`.
- Striker ≠ non-striker; both must be not-out batters of the batting side.
- Wicket type must be legal for context (no bowled/caught/LBW/stumped on free hit; limited set
  on no-ball).
- `runsOffBat` must be 0 on a wide (a wide can't be hit off the bat by definition).
- Cannot score off bat as `four`/`six` **and** also mark bye (mutually exclusive off-bat vs bye).
- Innings cannot exceed `oversPerInnings` legal overs.
- New batter required after a wicket before next ball (unless all out / last-man rule).

## 8. Outputs the engine must expose (for UI & stats)

- Live: totalRuns, wickets, overs string (`12.3`), CRR, RRR & target (innings2), this-over
  balls (`. 1 4 W wd 2`), striker/non-striker with runs(balls), current bowler figures.
- Scorecard: batting card (R, B, 4s, 6s, SR, dismissal text), bowling card (O, M, R, W, Econ,
  wd, nb), extras breakdown, total, FOW, partnerships.
- Per-innings arrays for charts: runs-per-over (Manhattan), cumulative worm, wagon-wheel
  points (phase 2 — capture zone/angle on boundaries if provided).

## 9. Test cases (write these first — engine must pass before UI)

Represent each as a sequence of events → assert resulting state. Minimum set:

1. **Dot ball:** score 0, balls 1, strike unchanged.
2. **Single:** +1 to striker & team, strike swaps.
3. **Two runs:** +2, strike unchanged.
4. **Four / Six:** +4/+6 to striker, no swap, 4s/6s counters increment.
5. **Wide:** +1 extra, ball NOT counted, re-bowl, bowler charged, no strike swap.
6. **Wide + 2 byes run:** +3 to extras(wides=3), still not a legal ball, strike may swap (odd run).
7. **No-ball, no run:** +1 extra, not a legal ball, free hit pending next ball.
8. **No-ball + 4 off bat:** +1 extra +4 to striker, bowler charged 5, free hit next.
9. **Bye 1 / Leg-bye 3:** legal ball, extras updated, bowler not charged, correct strike swap.
10. **Bowled:** wicket, bowler credited, new batter at striker end, partnership closed, FOW logged.
11. **Caught:** wicket + fielder recorded; if batters crossed before catch, new batter end logic.
12. **Run out (striker out, 1 completed):** +1 run, correct batter removed, ends handled.
13. **Run out (non-striker out):** engine asks who; correct removal.
14. **Stumped off a wide:** wicket allowed on wide; not a legal ball still.
15. **Free hit — bowled:** NOT out (only run out possible); runs still count.
16. **Free hit is itself a no-ball:** free hit carries to next delivery.
17. **End of over strike swap** + odd-run-on-last-ball combined → correct net striker.
18. **Bowler two overs in a row:** rejected by validation.
19. **Bowler over cap exceeded:** rejected.
20. **All out** at `playersPerSide-1` wickets → innings ends.
21. **Overs completed** exactly → innings ends.
22. **Target reached mid-over (innings2)** → match ends immediately, result = win by wickets.
23. **Tie** → status tie / trigger super over if enabled.
24. **Undo a wicket** → batter restored, FOW removed, counters correct.
25. **Undo across an over boundary** → strike & bowler eligibility restored.
26. **Last-man-stands (gully):** after 2nd-last wicket, last batter continues; runs must be even
    or run-out ends innings (config).

Add gully-specific cases from `05-gully-cricket-rules.md`.

## 10. Performance

- `apply` O(1)/event amortised; full rebuild O(n) events, n ≤ ~1500. Fine for undo.
- Keep the hot path allocation-light; batter/bowler maps updated via copyWith on touched keys.
