import 'package:freezed_annotation/freezed_annotation.dart';

import 'ball_event.dart';
import 'enums.dart';
import 'match_rules.dart';

part 'game_event.freezed.dart';
part 'game_event.g.dart';

/// The event stream the engine folds into a [MatchState]. Every non-ball setup
/// action plus each delivery is an immutable event; state is derived, never
/// mutated. Stored in the `Events` table (`type` + serialised payload).
///
/// See docs/04-scoring-engine-spec.md §5.
@freezed
sealed class GameEvent with _$GameEvent {
  /// Match setup: rules, sides, toss. Produces the initial [MatchState].
  const factory GameEvent.matchCreated({
    required String matchId,
    required MatchRules rules,
    required String teamAId,
    required String teamBId,
    String? tossWinnerTeamId,
    TossDecision? tossDecision,
  }) = MatchCreatedEvent;

  /// Start of an innings: opening pair + opening bowler.
  const factory GameEvent.inningsStarted({
    required int inningsIndex,
    required String battingTeamId,
    required String bowlingTeamId,
    required String strikerId,
    required String nonStrikerId,
    required String bowlerId,
  }) = InningsStartedEvent;

  /// A delivery.
  const factory GameEvent.ball(BallEvent ball) = BallDelivery;

  /// Manual penalty runs awarded to the batting side of [inningsIndex].
  const factory GameEvent.penalty({
    required int inningsIndex,
    required int runs,
  }) = PenaltyEvent;

  /// A batter leaves (retired hurt / substitute) and another comes in, without a
  /// wicket. Also used to fill an end left empty by a wicket.
  const factory GameEvent.batterReplaced({
    required int inningsIndex,
    required String outgoingId,
    required String incomingId,
    @Default(false) bool retiredHurt,
    @Default(true) bool incomingOnStrike,
  }) = BatterReplacedEvent;

  /// Manually swap the striker and non-striker (scorer correction).
  const factory GameEvent.swapStrike({required int inningsIndex}) =
      SwapStrikeEvent;

  /// Explicitly set who is bowling — used to pick the next over's bowler and to
  /// swap the bowler mid-over (injury / scorer correction). Deliveries alone may
  /// not change the bowler mid-over, so this records the intent.
  const factory GameEvent.bowlerChanged({
    required int inningsIndex,
    required String bowlerId,
  }) = BowlerChangedEvent;

  /// Manually end the current innings (forfeit / declaration — not typical v1).
  const factory GameEvent.endInnings({required int inningsIndex}) =
      EndInningsEvent;

  factory GameEvent.fromJson(Map<String, dynamic> json) =>
      _$GameEventFromJson(json);
}
