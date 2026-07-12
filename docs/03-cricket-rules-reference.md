# 03 — Cricket Rules Reference (for scoring)

Authoritative, scoring-focused summary of the rules the app must enforce. This is the source
of truth the engine implements. Where informal/gully rules differ, see `05-gully-cricket-rules.md`.
Terms are defined precisely in `11-glossary.md`.

> Scope: limited-overs cricket (T20/ODI/custom overs). We ignore Test/multi-day and DLS in v1.

## 1. The basics

- Two teams. A match has one or more **innings**. In limited-overs, each side bats **one innings**.
- The batting side tries to score **runs**; the bowling side tries to take **wickets** and
  restrict runs.
- An **over** = 6 **legal** deliveries bowled by one bowler from one end.
- An innings ends when: (a) the overs are completed, (b) the batting side is **all out**
  (loses all available wickets), or (c) the target is reached (2nd innings).
- The side with more runs wins. If equal → **tie** → resolved by **Super Over** (if enabled) or
  declared a tie.

## 2. Runs

- **Off the bat:** batters run between wickets; each completed length = 1 run. Runs are
  credited to the **striker**.
- **Boundary four (4):** ball reaches the boundary after bouncing/rolling → 4 runs.
- **Boundary six (6):** ball clears the boundary on the full → 6 runs.
- Runs off the bat count toward the striker's individual score **and** the team total.

## 3. Extras (runs not credited to a batter)

Five types: **no-ball, wide, bye, leg-bye, penalty**. All add to the **team total** as extras.

| Extra | Team runs | Counts as a legal ball? | Charged to bowler? | Ball re-bowled? |
|---|---|---|---|---|
| **Wide (wd)** | 1 + any run/boundary from the wide | ❌ No | ✅ Yes | ✅ Yes |
| **No-ball (nb)** | 1 penalty (+ any runs off bat or as byes) | ❌ No | ✅ (the 1 penalty; bat runs to striker) | ✅ Yes |
| **Bye (b)** | runs the batters take (or 4 if to boundary) | ✅ Yes | ❌ No | ❌ No |
| **Leg-bye (lb)** | runs the batters take (or 4 if to boundary) | ✅ Yes | ❌ No | ❌ No |
| **Penalty (pen)** | 5 (or as awarded) | n/a | ❌ No | n/a |

### 3.1 Wide
- Ball passes too wide/high for the striker to hit from a normal stance → umpire signals wide.
- Batting side gets **1 run** minimum. If batters run additional runs or the ball goes to the
  boundary as a wide, those add too (e.g., wide + 4 = 5 wides).
- **Not** a legal ball → an extra delivery is bowled.
- A batter **can** be dismissed off a wide by: stumped, run out, hit wicket, obstructing.
- (T20 house rule variant: a wide is often called more strictly, incl. leg-side wides.)

### 3.2 No-ball
- Illegal delivery (front-foot overstep, above-waist full toss, throw, etc.).
- **1-run penalty** to the batting side; the delivery does **not** count in the over.
- The striker **may** hit it: runs off the bat are credited to the striker (plus the 1 penalty
  to extras).
- The **next legal delivery** (in most limited-overs comps) is a **free hit**: the striker
  cannot be dismissed except by run out (and a few rare modes). See §6.
- Dismissals possible off a no-ball: **run out, obstructing, handled ball (obstruction),
  hit the ball twice** — **not** bowled/caught/LBW/stumped/hit wicket.

### 3.3 Bye
- Legal ball the striker misses (no bat/body contact), batters run → runs recorded as **byes**.
- Ball to boundary = **4 byes**. Counts as a legal ball; not charged to the bowler.

### 3.4 Leg-bye
- Ball hits the striker's body (not bat), and they run → **leg-byes** — but only if the striker
  offered a shot or tried to avoid the ball. Otherwise (no attempt) runs are disallowed
  (dead-ball) in the strict laws; many amateur games still award them. Make this a rule flag.
- Ball to boundary off the body = **4 leg-byes**. Legal ball; not charged to the bowler.

### 3.5 Penalty runs
- Awarded for various offences (e.g., ball hitting fielding helmet on ground). Rare in amateur
  play. Support as a manual "+5 penalty to batting/fielding side" action.

## 4. Wickets (dismissals)

The ten modes; the common ones the app must make one-tap easy are **bold**.

1. **Bowled** — ball hits and dislodges the stumps off a legal (or no-ball? no—see below) delivery.
2. **Caught** — fielder catches the ball off the bat (or glove holding bat) before it bounces.
3. **LBW (leg before wicket)** — ball would have hit the stumps but struck the pad first
   (with conditions). *Often disabled in gully.*
4. **Run out** — a batter is out of the crease when the stumps are broken while attempting a run.
5. **Stumped** — keeper breaks the stumps while the striker is out of the crease and not attempting a run.
6. Hit wicket — striker dislodges own stumps while playing/setting off.
7. Handled the ball / **Obstructing the field** — (merged in current laws as obstructing).
8. Hit the ball twice — deliberately.
9. Timed out — new batter not ready in time.
10. Retired out — batter retires without permission (retired–hurt/absent does NOT count as a wicket).

### 4.1 Who is credited
- **Bowler credited:** bowled, caught, LBW, stumped, hit wicket.
- **Bowler NOT credited (team dismissal):** run out, obstructing, handled, hit twice, timed out, retired out.
- **Caught:** record the **fielder** (catcher). **Stumped/run out:** record keeper/fielder.
- **Run out:** record **which batter is out** (striker or non-striker) — engine must ask.

### 4.2 Batter dismissed → what carries over
- On a wicket, a **new batter** comes in at the fallen batter's end (unless a run-out completed
  a run that swapped ends — engine handles crossing).
- Track **fall of wickets** (score & over at each wicket) and **partnerships**.

## 5. Over mechanics & strike

- 6 legal balls = 1 over. Wides and no-balls do **not** count → they add a re-bowl.
- **End of over:** strike rotates (non-striker becomes striker). A new bowler bowls from the
  other end; **a bowler cannot bowl two overs in a row**.
- **Odd runs** (1, 3, 5 off the bat or as byes/leg-byes) rotate strike within the over.
- **Boundaries (4/6)** do not rotate strike (batters didn't run an odd number).
- Combine: at end of over, if an odd number was run on the last ball, the *other* batter is on
  strike, then the over-change swap applies — engine must compute net striker correctly.
- **Bowling limits:** per-bowler over cap (e.g., T20 = 20% of innings = 4 overs; ODI = 10).
  Make it a rule config: `maxOversPerBowler`.

## 6. Free hit

- Follows a no-ball (in comps that use it). On a free hit, the striker can only be out **run
  out** (and obstruction/handled/hit-twice) — not bowled/caught/LBW/stumped.
- If the free-hit delivery is itself a wide/no-ball, the free hit **carries over** to the next
  delivery. Make free-hit support a rule flag: `freeHitAfterNoBall`.

## 7. Innings end & result

- **All out:** wickets lost = availableWickets (usually players − 1; but see last-man rules).
- **Overs done:** legal balls bowled = overs × 6.
- **Target reached** (2nd innings): batting side passes the first side's total → win immediately.
- **Result types:** win by runs (team batting first wins → margin = runs), win by wickets
  (team batting second wins → margin = wickets in hand), tie, no-result (abandoned).

## 8. Powerplay & fielding restrictions (limited-overs)

- **T20 powerplay:** first **6 overs**, only 2 fielders allowed outside the 30-yard circle.
- **ODI powerplays:** overs 1–10 (max 2 outside), 11–40 (max 4), 41–50 (max 5). Config-driven.
- The app does **not** enforce field placement (no fielders on a map) but **should mark the
  powerplay overs** on the scorecard/Manhattan and let the scorer toggle them. Rule config:
  `powerplayOvers`.

## 9. Super Over (tie-breaker, optional)

- Each side bats **one over (6 balls)**; loses 2 wickets max; highest score wins.
- If still tied → repeat / count boundaries (config). Support as an optional add-on innings.

## 10. Rain / DLS

- **Out of scope for v1.** Do not implement DLS. If a match is shortened, allow the scorer to
  manually set reduced overs; result stays as-scored.

## Implementation notes for the engine

- Model each of the above as explicit fields on a `BallEvent` + `MatchRules` (see 04 & 06).
- Never infer strike/over-completion from UI; compute deterministically from events.
- Every rule with a "house variant" above becomes a boolean/enum in `MatchRules`.

## Sources

- [Extras in cricket — Wikipedia](https://en.wikipedia.org/wiki/Extra_(cricket))
- [Extras explained — SportRulez](https://sportrulez.com/extras-in-cricket/)
- [Cricket scoring rules — SportRulez](https://sportrulez.com/cricket-scoring-rules/)
- [Cricket scoring basics — Cork County CC](https://www.corkcountycricketclub.com/about/cricket-scoring-basics/)
- [Powerplay rules — SportRulez](https://sportrulez.com/powerplay-restrictions/)
- [T20 jargon buster — Sky Sports](https://www.skysports.com/cricket/news/12123/13144322/t20-world-cup-jargon-buster-learn-about-powerplays-finishers-drop-in-pitches-dls-drs-and-more)
