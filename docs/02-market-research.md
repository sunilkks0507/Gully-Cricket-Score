# 02 — Market Research: Popular Cricket Scoring Apps

Snapshot of the leading amateur/grassroots scoring apps, what they do well, and where an
offline-first, gully-friendly app can differentiate. Use this to prioritise features and
avoid reinventing solved UX.

## The main players

### CricHeroes — the market leader
- ~40M+ users, 10M+ matches scored, 4.7+ rating; positions as the #1 free grassroots app.
- **Strengths:** ball-by-ball live scoring; rich analytics (Wagon Wheel, Manhattan, Worm,
  Run Rate, MVP); live streaming (phone or OBS/vMix); world-class player profiles with
  badges/awards/leaderboards across city/state/national levels; full tournament management
  (points table, schedule, boundary tracker, smart auto-scheduler, NRR calculator);
  AI-generated highlights.
- **Trade-offs for our audience:** heavily online/account-driven; social ecosystem is the
  point; can feel heavy for a quick private gully match.

### STUMPS — The Cricket Scorer
- **Strengths:** clean, intuitive ball-by-ball scoring; real-time updates; graphical charts
  (wagon wheel, over comparison, runs comparison); export tournament stats as CSV; Hall of
  Fame; season & quarterly player stats; fully free.
- **Trade-offs:** still oriented to sharing/analysis online; less focus on improvised gully rules.

### Others seen in the market
- **CricPulse, CricScorer, iScore Cricket, Cricket Line Guru** — variations on live scoring,
  stats, and tournament tools. Cricket Line Guru is known more for fast live *scores/lines*
  than for being a full scoring tool.

## Feature comparison (what to benchmark against)

| Capability | CricHeroes | STUMPS | **Our v1 target** |
|---|---|---|---|
| Ball-by-ball scoring | ✅ | ✅ | ✅ core |
| Works fully offline | Partial | Partial | ✅ **first-class** |
| Custom overs / players | ✅ | ✅ | ✅ |
| Gully / house rules presets | Limited | Limited | ✅ **differentiator** |
| Player profiles & career stats | ✅ (cloud) | ✅ | ✅ (local) |
| Match history | ✅ | ✅ | ✅ (local, private) |
| Tournament mode + NRR | ✅ | ✅ | ✅ |
| Charts (wagon wheel, Manhattan, worm) | ✅ | ✅ | ⚠️ phase 2 (basic first) |
| Live streaming | ✅ | ❌ | ❌ (non-goal) |
| Accounts / social / cloud | ✅ | ✅ | ❌ v1 (future) |
| Export scorecard (image/PDF/CSV) | ✅ | ✅ (CSV) | ✅ |

## What users value (distilled)

1. **Speed of scoring** — minimal taps per ball; forgiving undo.
2. **Correctness** — extras, free hits, over completion, strike rotation handled automatically.
3. **A good-looking scorecard** they can share.
4. **Player stats that accumulate** across matches (profiles, averages, leaderboards).
5. **Tournament tables that "just work"** (points + NRR without manual math).

## Our differentiation (where we win)

1. **True offline-first.** No signal, no account, instant start. Private by default.
2. **Gully / street cricket as a first-class citizen** — presets for one-tip-one-hand,
   last-man-stands (joker), no-LBW, custom extras, box-cricket boundaries. Most big apps
   treat these as edge cases; we make them a preset you pick in setup.
3. **One-handed, sub-2-tap scoring pad** tuned for scoring alone on the boundary.
4. **Bulletproof undo/redo + crash-safe autosave** (event-sourced; see data model).

## Anti-goals learned from competitors

- Don't force sign-up before a first match.
- Don't require connectivity to score or view your own data.
- Don't bury the "undo" — it's the most-used control.
- Don't hard-code pro rules that break for gully play.

## Sources

- [Best Cricket Scoring App 2026 — comparison](https://livecricketscoring.com/blog/best-cricket-scoring-app)
- [CricHeroes — Google Play](https://play.google.com/store/apps/details?id=com.cricheroes.cricheroes.alpha)
- [CricHeroes — global site](https://cricheroes.com/global)
- [STUMPS — official site](https://stumpsapp.com/)
- [STUMPS — Google Play](https://play.google.com/store/apps/details?id=com.diyas.android.stumps)
- [Top cricket score software 2026](https://worldmetrics.org/best/cricket-score-software/)
- [Cricket Scoring App alternatives — Product Hunt](https://www.producthunt.com/products/cricket-scoring-app-cricheroes/alternatives)
