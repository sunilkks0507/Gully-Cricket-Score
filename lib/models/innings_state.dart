import 'package:freezed_annotation/freezed_annotation.dart';

import 'cards.dart';
import 'extras.dart';
import 'fall_of_wicket.dart';
import 'wicket.dart';

part 'innings_state.freezed.dart';
part 'innings_state.g.dart';

/// Derived state for a single innings, held in memory for fast UI. Rebuildable
/// by folding the event log. See docs/04-scoring-engine-spec.md §3.
@freezed
abstract class InningsState with _$InningsState {
  const InningsState._();

  const factory InningsState({
    required String battingTeamId,
    required String bowlingTeamId,
    @Default(0) int totalRuns,
    @Default(0) int wickets,

    /// Legal balls bowled so far. overs = legalBalls ~/ 6 . legalBalls % 6.
    @Default(0) int legalBalls,

    String? strikerId,
    String? nonStrikerId,
    String? bowlerId,

    /// Bowler of the previous over (may not bowl two in a row).
    String? previousBowlerId,

    @Default(Extras()) Extras extras,

    /// Batter figures keyed by playerId.
    @Default(<String, BatterCard>{}) Map<String, BatterCard> batters,

    /// Bowler figures keyed by playerId.
    @Default(<String, BowlerCard>{}) Map<String, BowlerCard> bowlers,

    @Default(<FallOfWicket>[]) List<FallOfWicket> fow,
    @Default(<Partnership>[]) List<Partnership> partnerships,

    /// The dismissal for each out batter, keyed by playerId (for scorecard text).
    @Default(<String, Wicket>{}) Map<String, Wicket> dismissals,

    /// Second-innings target (innings1.totalRuns + 1); null in the first innings.
    int? target,

    /// The next legal delivery is a free hit.
    @Default(false) bool freeHitPending,

    /// Legal balls bowled in the current over (0..5); resets each over.
    @Default(0) int ballsThisOver,

    /// Runs charged to the current bowler in the current over (for maiden
    /// detection); resets each over.
    @Default(0) int runsConcededThisOver,
  }) = _InningsState;

  factory InningsState.fromJson(Map<String, dynamic> json) =>
      _$InningsStateFromJson(json);

  /// Completed overs.
  int get completedOvers => legalBalls ~/ 6;

  /// Overs string, e.g. "18.4".
  String get oversText => '${legalBalls ~/ 6}.${legalBalls % 6}';

  /// Current run rate (runs per over). 0 before any legal ball.
  double get runRate => legalBalls == 0 ? 0 : (totalRuns * 6) / legalBalls;

  /// Runs still required to win (second innings only).
  int? get runsRequired => target == null ? null : target! - totalRuns;
}
