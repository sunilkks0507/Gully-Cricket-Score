import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'match_rules.freezed.dart';
part 'match_rules.g.dart';

/// All rule-affecting behaviour flows from this config object — never hard-coded
/// in the engine (golden rule #4). New variants are new configs, not new code.
/// Fields are **additive**: a field absent from stored JSON falls back to its
/// default, so adding a rule flag needs no DB migration.
///
/// See docs/04-scoring-engine-spec.md §2 and docs/05-gully-cricket-rules.md.
@freezed
abstract class MatchRules with _$MatchRules {
  const MatchRules._();

  const factory MatchRules({
    /// Which preset this config was derived from ('t20', 'gully_classic',
    /// 'custom', ...). Metadata for display; the engine reads the fields below.
    @Default('custom') String presetId,

    /// Human-readable name, e.g. "T20 (standard)".
    @Default('Custom') String label,

    // ---- Format ----
    /// Overs per innings. 0 = unlimited (not used in v1).
    @Default(20) int oversPerInnings,
    @Default(11) int playersPerSide,
    @Default(4) int maxOversPerBowler,

    // ---- No-ball / wide ----
    @Default(true) bool freeHitAfterNoBall,
    @Default(1) int noBallPenalty,
    @Default(1) int wideRun,

    /// A wide is re-bowled (does not count as a legal ball). Some gully games
    /// set this false (a wide is just a run and the ball counts).
    @Default(true) bool wideReBowled,
    @Default(true) bool noBallReBowled,

    // ---- Dismissals ----
    @Default(true) bool lbwEnabled,

    /// Strict laws: leg-byes only count if the batter offered a shot / evaded.
    @Default(true) bool legByeRequiresShot,

    /// A wicketkeeper is present (enables stumped).
    @Default(true) bool keeperPresent,

    // ---- Powerplay ----
    @Default(<int>[]) List<int> powerplayOvers,

    // ---- Gully / street variants (docs/05) ----
    /// Last batter bats alone after the 2nd-last wicket instead of ending.
    @Default(false) bool lastManStands,

    /// With last-man-stands, a single run is void (batters must run in pairs).
    @Default(false) bool lastManMustRunTwo,

    /// A "six" also dismisses the striker (box cricket — ball leaves the box).
    @Default(false) bool sixAndOut,

    /// One player bats for both sides (uneven numbers). Mostly a roster concern.
    @Default(false) bool jokerBatsBothSides,

    /// One-tip-one-hand catches are legal dismissals (enables the picker option).
    @Default(false) bool oneTipOneHand,

    /// One-hand-one-bounce off a wall counts (box cricket) — metadata for v1.
    @Default(false) bool oneHandOneBounceWall,

    // ---- Tie resolution ----
    @Default(SuperOverRule.none) SuperOverRule superOver,
  }) = _MatchRules;

  factory MatchRules.fromJson(Map<String, dynamic> json) =>
      _$MatchRulesFromJson(json);

  /// Legal balls in a full innings (overs × 6). 0 when unlimited.
  int get ballsPerInnings => oversPerInnings * 6;

  /// Maximum wickets a side can lose before being all out. With last-man-stands
  /// the innings continues to the final batter, so one more "wicket" is allowed.
  int get maxWickets => lastManStands ? playersPerSide : playersPerSide - 1;
}
