/// Shared enums for the scoring domain. Pure Dart — no Flutter imports.
///
/// These serialize by *name* (json_serializable default), so renaming a value
/// is a breaking change for stored data. Add new values at the end.
library;

/// Off-the-bat classification of a delivery's runs. Derived convenience; the
/// canonical value stored on a [BallEvent] is `runsOffBat`.
enum DeliveryOutcome { dot, runs, four, six }

/// The kind of extra on a delivery. `none` means a normal (possibly scoring)
/// legal ball off the bat.
enum ExtraType { none, wide, noBall, bye, legBye, penalty }

/// How a batter was dismissed. `retiredHurt` / `absent` are NOT wickets and are
/// tracked separately (a batter leaving without the team losing a wicket), so
/// they are not part of this enum. `sixOut` covers the gully "six and out" rule.
enum DismissalType {
  bowled,
  caught,
  lbw,
  runOut,
  stumped,
  hitWicket,
  obstructing,
  hitBallTwice,
  timedOut,
  retiredOut,
  sixOut,
}

/// Lifecycle of a match.
enum MatchStatus { notStarted, inProgress, inningsBreak, completed, abandoned }

/// Toss decision by the winning captain.
enum TossDecision { bat, bowl }

/// A player's primary role (used for profiles / setup hints).
enum PlayerRole { batter, bowler, allRounder, keeper }

/// Batting hand.
enum BattingHand { right, left }

/// How a tie is resolved.
enum SuperOverRule { none, oneOver, boundaryCountback }

/// Category of a completed-match result.
enum MatchResultType { winByRuns, winByWickets, tie, noResult, superOver }

/// Whether a match is a one-off or part of a tournament. A tournament match also
/// carries a `tournamentId`; a standalone match does not affect any points table.
enum MatchType { standalone, tournament }

/// How a tournament's fixtures are structured (CricScore design).
enum TournamentFormat { league, roundRobin, knockout }
