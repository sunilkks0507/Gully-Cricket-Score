import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'wicket.freezed.dart';
part 'wicket.g.dart';

/// A dismissal recorded on a [BallEvent].
///
/// `outBatterId` is the batter who is out — for a run out this may be either the
/// striker or the non-striker, so it is captured explicitly rather than assumed.
@freezed
abstract class Wicket with _$Wicket {
  const factory Wicket({
    required DismissalType type,

    /// The batter dismissed (striker or non-striker; run outs can be either).
    required String outBatterId,

    /// Catcher / keeper / thrower, when applicable.
    String? fielderId,

    /// Bowler credited with the wicket; null for team dismissals (run out,
    /// obstructing, timed out, retired out).
    String? bowlerId,

    /// Runs completed by the batters before the dismissal on this ball
    /// (relevant for run outs).
    @Default(0) int runsCompletedBeforeOut,

    /// Gully "one tip one hand" catch flag (metadata for the scorecard label).
    @Default(false) bool oneTipOneHand,

    /// Whether the batters had crossed when the dismissal occurred. Drives which
    /// end the surviving batter is at (e.g. a caught dismissal where they crossed
    /// in the air). For run outs the crossing is derived from completed runs, but
    /// this flag can override it.
    @Default(false) bool battersCrossed,
  }) = _Wicket;

  factory Wicket.fromJson(Map<String, dynamic> json) => _$WicketFromJson(json);
}
