import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';
import 'wicket.dart';

part 'ball_event.freezed.dart';
part 'ball_event.g.dart';

/// A single delivery in a match — the atomic, immutable unit of scoring.
///
/// State is derived by folding these (plus setup/non-ball events); a [BallEvent]
/// is never mutated. See docs/04-scoring-engine-spec.md §2.
@freezed
abstract class BallEvent with _$BallEvent {
  const factory BallEvent({
    /// 0 = first innings, 1 = second, higher for super overs.
    required int inningsIndex,
    required String strikerId,
    required String nonStrikerId,
    required String bowlerId,

    /// Runs scored off the bat (credited to the striker). 0..6.
    @Default(0) int runsOffBat,

    /// The extra on this delivery, if any.
    @Default(ExtraType.none) ExtraType extraType,

    /// Additional runs from the extra (e.g. wide + 4 byes → extraRuns = 4;
    /// byes/leg-byes run → extraRuns; penalty runs → extraRuns).
    @Default(0) int extraRuns,

    /// True if this delivery is a free hit.
    @Default(false) bool isFreeHit,

    /// The dismissal on this delivery, if any.
    Wicket? wicket,

    /// The batter coming in after a dismissal on this ball (placed at the out
    /// batter's end). Null when no wicket, or when the innings ends (all out /
    /// last-man). The engine requires the vacated end filled before the next ball.
    String? newBatterId,

    /// Local timestamp — metadata only, never used by engine logic.
    DateTime? tsLocal,
  }) = _BallEvent;

  factory BallEvent.fromJson(Map<String, dynamic> json) =>
      _$BallEventFromJson(json);
}
