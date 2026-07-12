# 09 — Stats Formulas, NRR & Tournament Math

Exact formulas so the engine/projections compute stats correctly. All derive from the event log.

## Overs notation

- Overs are stored as **legal balls**; display as `overs.balls` where `overs = balls ~/ 6`,
  `remainder = balls % 6` → e.g. 112 balls = `18.4`.
- **Decimal overs** (for rates) = `balls / 6` (e.g. 112/6 = 18.6667). Use decimal for CRR/econ/NRR.

## Batting stats (per player, per innings; aggregate = sum across innings)

- **Runs (R):** sum of `runsOffBat` credited to the batter.
- **Balls faced (B):** legal balls faced by the batter **plus** no-balls faced (a no-ball is
  faced but not a legal delivery — by convention balls-faced counts deliveries the striker
  received that were legal OR no-ball; **wides are NOT faced**). Decide convention and keep it
  consistent: **B = deliveries received excluding wides.**
- **Strike rate (SR):** `100 * R / B` (0 if B=0).
- **Average (Avg):** `R / dismissals` (innings where out). Not-outs don't count as dismissals.
  Career avg = `careerRuns / careerDismissals`.
- **Not out (NO):** innings where the batter finished undismissed.
- **HS (high score):** max innings runs; annotate `*` if not out that innings.
- **50s / 100s:** count innings with 50–99 / ≥100.
- **4s / 6s:** counts of boundary outcomes.

## Bowling stats

- **Overs bowled:** from legal balls bowled by the bowler → `balls/6` display.
- **Runs conceded (R):** off-bat runs + wides + no-ball penalties + (runs off no-ball bat) hit
  off that bowler. **Byes & leg-byes are NOT charged to the bowler.**
- **Wickets (W):** dismissals credited to bowler (bowled, caught, LBW, stumped, hit wicket).
- **Economy (Econ):** `runsConceded / oversDecimal` (runs per over).
- **Bowling average:** `runsConceded / wickets` (∞/– if 0 wickets).
- **Bowling strike rate:** `legalBallsBowled / wickets`.
- **Maiden (M):** an over in which **0 runs charged to the bowler** were conceded (byes/leg-byes
  in the over don't break a maiden; wides/no-balls DO because they're charged to the bowler).
- **Best bowling (BB):** best `W/R` (more wickets first; fewer runs breaks ties).
- **wd / nb:** counts bowled by that bowler.

## Fielding stats

- **Catches:** fielder recorded on `caught`.
- **Stumpings:** keeper on `stumped`.
- **Run-outs:** fielder(s) credited on `runOut` (v1: single fielder credit is fine).

## Team / innings rates

- **CRR (current run rate):** `totalRuns / oversDecimalFaced`.
- **RRR (required run rate, innings 2):** `runsNeeded / oversRemainingDecimal`,
  where `runsNeeded = target - currentRuns`, `oversRemaining = (maxBalls - legalBalls)/6`.
- **Target:** `innings1.total + 1`.
- **Projected score:** `CRR * totalOvers` (nice-to-have on live header).

## Result determination

- Batting-first team wins → **win by runs**, margin = `firstTotal - secondTotal`.
- Chasing team wins → **win by wickets**, margin = `availableWickets - wicketsLost`.
- Equal totals → **tie** → super over if enabled, else recorded tie.
- Abandoned/insufficient → **no result**.

## Net Run Rate (NRR) — tournament

**NRR = (total runs scored / total overs faced) − (total runs conceded / total overs bowled)**,
summed across **all** tournament matches for the team.

Critical rules:
1. Use **decimal overs** (balls/6), not the `x.y` display.
2. **All-out adjustment:** if a team is **bowled out** before using its full overs, use the
   **full allotted overs** (e.g. 20.0) as the "overs faced/bowled", NOT the actual overs used.
   (This is the standard ICC rule and the most common NRR bug — implement and test it.)
3. Only count matches with a result (skip no-results for NRR).
4. Aggregate numerators and denominators across matches, then subtract once (do **not** average
   per-match NRRs).

**Worked test (put in unit tests):**
- Match: Team A 180/6 in 20 overs; Team B all out 150 in 18 overs.
- A's NRR contribution: for = 180/20 = 9.00; against = 150/**20** (B all out → full 20) = 7.50 →
  A NRR from this match = +1.50.
- B's: for = 150/**20** = 7.50; against = 180/20 = 9.00 → B NRR = −1.50.
- Assert engine reproduces ±1.50 exactly.

## Points table

- Columns: **P** (played), **W**, **L**, **T** (tie), **NR** (no result), **Pts**, **NRR**.
- Points: win = `pointsWin` (default 2), tie = `pointsTie` (1), no-result = `pointsNoResult` (1),
  loss = 0. All configurable per tournament.
- **Sort:** by Pts desc, then by `tieBreakOrder` (default: NRR desc → head-to-head → alphabetical).

## Fixtures generation

- **Single round-robin:** every team plays every other once → `n*(n-1)/2` matches. Standard
  circle method for balanced rounds.
- **Double round-robin:** twice (home/away) → `n*(n-1)`.
- Optional: knockout bracket (phase 2).
- Byes when `n` is odd (one team rests each round).

## Aggregate recompute

- Maintain `PlayerCareerStat` as a projection, recomputed when a match completes or is deleted.
- Provide a "rebuild all stats" maintenance action (fold every completed match) — used to verify
  the incremental path (they must match).

## Sources

- [Net run rate — how it's calculated](https://cricbex.com/story/what-is-net-run-rate-and-how-is-it-calculated/)
- [Powerplay & NRR context — SportRulez](https://sportrulez.com/powerplay-restrictions/)
