import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'match_result.freezed.dart';
part 'match_result.g.dart';

/// The outcome of a completed match. Serialised into `Match.resultJson`.
@freezed
abstract class MatchResult with _$MatchResult {
  const factory MatchResult({
    required MatchResultType type,

    /// Winning team, when there is one (null for tie / no result).
    String? winnerTeamId,

    /// Margin magnitude (runs or wickets, per [marginUnit]).
    @Default(0) int margin,

    /// "runs" or "wickets" (empty for tie / no result).
    @Default('') String marginUnit,

    /// Human-readable summary, e.g. "Team A won by 23 runs".
    required String summary,
  }) = _MatchResult;

  factory MatchResult.fromJson(Map<String, dynamic> json) =>
      _$MatchResultFromJson(json);
}
