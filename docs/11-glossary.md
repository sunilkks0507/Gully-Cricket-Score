# 11 — Cricket Glossary (precise meanings)

Use these terms exactly as defined. Ambiguity here becomes bugs in the engine.

- **All out** — batting side has lost all available wickets (usually `playersPerSide − 1`);
  innings ends.
- **Average (batting)** — runs ÷ times dismissed.
- **Average (bowling)** — runs conceded ÷ wickets taken.
- **Ball (legal/delivery)** — a delivery that counts toward the over; wides & no-balls are
  **not** legal balls.
- **Boundary** — 4 (ball reaches boundary after bouncing) or 6 (clears it on the full).
- **Bye** — runs taken when the striker misses and no bat/body contact; extra, legal ball, not
  charged to bowler.
- **CRR** — current run rate = runs ÷ overs faced (decimal).
- **Dot ball** — a legal ball off which no runs are scored.
- **Economy** — bowler runs conceded per over.
- **Extras** — runs not credited to a batter: wide, no-ball, bye, leg-bye, penalty.
- **Fall of Wicket (FOW)** — the team score and over at which each wicket fell.
- **Free hit** — delivery after a no-ball (if enabled) on which the striker can only be run out
  (plus rare modes); not bowled/caught/LBW/stumped.
- **Innings** — a team's batting turn. Limited-overs = one innings per side.
- **Leg-bye** — runs off the striker's body (not bat) when a shot was offered/avoidance
  attempted; extra, legal ball, not charged to bowler.
- **Maiden over** — over with no runs charged to the bowler.
- **Net Run Rate (NRR)** — (runs scored ÷ overs faced) − (runs conceded ÷ overs bowled) across a
  tournament; all-out teams counted as using full allotted overs.
- **No-ball** — illegal delivery; 1-run penalty, not a legal ball, striker may hit it, usually
  triggers a free hit.
- **Non-striker** — the batter at the bowler's end.
- **Not out** — a batter who finished the innings undismissed.
- **Over** — 6 legal deliveries from one end by one bowler.
- **Overs (display vs decimal)** — display `x.y` (y = balls in current over); decimal = balls/6.
- **Partnership** — runs added while a specific pair batted together.
- **Penalty runs** — runs awarded for offences (e.g. +5); rare in amateur play.
- **Powerplay** — overs with fielding restrictions (T20: first 6; ODI phased). App marks them;
  doesn't enforce field placement.
- **Required Run Rate (RRR)** — runs still needed ÷ overs remaining (innings 2).
- **Retired hurt / absent** — batter leaves undismissed; **not** a wicket; may return.
- **Retired out** — batter retires without permission; counts as a wicket (no bowler credit).
- **Run out** — a batter dismissed by the stumps being broken while out of the crease during a run.
- **Strike rate (batting)** — 100 × runs ÷ balls faced.
- **Strike rotation** — swap of striker/non-striker when an odd number of runs is physically run,
  and at the end of each over.
- **Striker** — the batter facing the current delivery.
- **Stumped** — keeper breaks the stumps while the striker is out of the crease and not
  attempting a run.
- **Super Over** — one-over-per-side tie-breaker.
- **Target** — runs the chasing side needs to win = first innings total + 1.
- **Tie** — both sides finish on exactly equal totals.
- **Wagon wheel / Manhattan / Worm** — scoring charts (phase 2): shot directions, runs-per-over
  bars, cumulative run curve.
- **Wicket** — a dismissal; also the stumps; also the pitch (context-dependent — code uses
  "dismissal" for clarity).
- **Wide** — delivery too wide/high to hit; 1+ run extra, not a legal ball, re-bowled; batter can
  be stumped/run out off it.

## Gully-specific
- **One tip one hand** — one-handed catch after one bounce = out.
- **Last man stands** — lone remaining batter continues, often must run in pairs.
- **Joker** — shared extra player batting for both sides when numbers are uneven.
- **Six and out** — hitting a six dismisses the striker (box cricket, ball leaves the area).
- **Tip and run** — batter must run whenever the ball touches the bat.
