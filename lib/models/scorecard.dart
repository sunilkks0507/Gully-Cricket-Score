import 'package:freezed_annotation/freezed_annotation.dart';

import 'extras.dart';
import 'fall_of_wicket.dart';

part 'scorecard.freezed.dart';
part 'scorecard.g.dart';

/// A batting line on the presented scorecard.
@freezed
abstract class BatterLine with _$BatterLine {
  const factory BatterLine({
    required String playerId,
    required String name,
    required int runs,
    required int balls,
    required int fours,
    required int sixes,
    required double strikeRate,

    /// e.g. "c Sharma b Khan", "not out", "run out (Patel)".
    required String dismissalText,
    required bool notOut,
  }) = _BatterLine;

  factory BatterLine.fromJson(Map<String, dynamic> json) =>
      _$BatterLineFromJson(json);
}

/// A bowling line on the presented scorecard.
@freezed
abstract class BowlerLine with _$BowlerLine {
  const factory BowlerLine({
    required String playerId,
    required String name,
    required String oversText,
    required int maidens,
    required int runs,
    required int wickets,
    required double economy,
    required int wides,
    required int noBalls,
  }) = _BowlerLine;

  factory BowlerLine.fromJson(Map<String, dynamic> json) =>
      _$BowlerLineFromJson(json);
}

/// A fully computed innings scorecard. Not stored — derived from events.
/// See docs/06-data-model.md §Derived scorecard shape.
@freezed
abstract class InningsScorecard with _$InningsScorecard {
  const factory InningsScorecard({
    required String battingTeamId,
    required String bowlingTeamId,
    required int total,
    required int wickets,
    required String oversText,
    required double runRate,
    required List<BatterLine> batters,
    required List<BowlerLine> bowlers,
    required Extras extras,
    required List<FallOfWicket> fallOfWickets,
    required List<Partnership> partnerships,
    int? target,
    @Default(<int>[]) List<int> powerplayOvers,
  }) = _InningsScorecard;

  factory InningsScorecard.fromJson(Map<String, dynamic> json) =>
      _$InningsScorecardFromJson(json);
}
