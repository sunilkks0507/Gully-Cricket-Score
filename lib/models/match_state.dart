import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';
import 'innings_state.dart';
import 'match_result.dart';
import 'match_rules.dart';

part 'match_state.freezed.dart';
part 'match_state.g.dart';

/// The full derived state of a match. Rebuildable by folding its event log.
/// See docs/04-scoring-engine-spec.md §3.
@freezed
abstract class MatchState with _$MatchState {
  const MatchState._();

  const factory MatchState({
    /// Owning match id (uuid). Links the derived state back to its event log.
    required String matchId,
    required MatchRules rules,

    /// 0 = first innings in progress/next, 1 = second, higher for super overs.
    @Default(0) int currentInnings,

    /// First innings; null until it starts.
    InningsState? innings1,

    /// Second innings; null until it starts.
    InningsState? innings2,

    @Default(MatchStatus.notStarted) MatchStatus status,
    MatchResult? result,
  }) = _MatchState;

  factory MatchState.fromJson(Map<String, dynamic> json) =>
      _$MatchStateFromJson(json);

  /// The innings currently being scored, if any.
  InningsState? get activeInnings => currentInnings == 0 ? innings1 : innings2;
}
