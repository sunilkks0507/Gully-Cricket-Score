// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchCreatedEvent _$MatchCreatedEventFromJson(Map<String, dynamic> json) =>
    MatchCreatedEvent(
      matchId: json['matchId'] as String,
      rules: MatchRules.fromJson(json['rules'] as Map<String, dynamic>),
      teamAId: json['teamAId'] as String,
      teamBId: json['teamBId'] as String,
      tossWinnerTeamId: json['tossWinnerTeamId'] as String?,
      tossDecision: $enumDecodeNullable(
        _$TossDecisionEnumMap,
        json['tossDecision'],
      ),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$MatchCreatedEventToJson(MatchCreatedEvent instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'rules': instance.rules.toJson(),
      'teamAId': instance.teamAId,
      'teamBId': instance.teamBId,
      'tossWinnerTeamId': instance.tossWinnerTeamId,
      'tossDecision': _$TossDecisionEnumMap[instance.tossDecision],
      'runtimeType': instance.$type,
    };

const _$TossDecisionEnumMap = {
  TossDecision.bat: 'bat',
  TossDecision.bowl: 'bowl',
};

InningsStartedEvent _$InningsStartedEventFromJson(Map<String, dynamic> json) =>
    InningsStartedEvent(
      inningsIndex: (json['inningsIndex'] as num).toInt(),
      battingTeamId: json['battingTeamId'] as String,
      bowlingTeamId: json['bowlingTeamId'] as String,
      strikerId: json['strikerId'] as String,
      nonStrikerId: json['nonStrikerId'] as String,
      bowlerId: json['bowlerId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$InningsStartedEventToJson(
  InningsStartedEvent instance,
) => <String, dynamic>{
  'inningsIndex': instance.inningsIndex,
  'battingTeamId': instance.battingTeamId,
  'bowlingTeamId': instance.bowlingTeamId,
  'strikerId': instance.strikerId,
  'nonStrikerId': instance.nonStrikerId,
  'bowlerId': instance.bowlerId,
  'runtimeType': instance.$type,
};

BallDelivery _$BallDeliveryFromJson(Map<String, dynamic> json) => BallDelivery(
  BallEvent.fromJson(json['ball'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$BallDeliveryToJson(BallDelivery instance) =>
    <String, dynamic>{
      'ball': instance.ball.toJson(),
      'runtimeType': instance.$type,
    };

PenaltyEvent _$PenaltyEventFromJson(Map<String, dynamic> json) => PenaltyEvent(
  inningsIndex: (json['inningsIndex'] as num).toInt(),
  runs: (json['runs'] as num).toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$PenaltyEventToJson(PenaltyEvent instance) =>
    <String, dynamic>{
      'inningsIndex': instance.inningsIndex,
      'runs': instance.runs,
      'runtimeType': instance.$type,
    };

BatterReplacedEvent _$BatterReplacedEventFromJson(Map<String, dynamic> json) =>
    BatterReplacedEvent(
      inningsIndex: (json['inningsIndex'] as num).toInt(),
      outgoingId: json['outgoingId'] as String,
      incomingId: json['incomingId'] as String,
      retiredHurt: json['retiredHurt'] as bool? ?? false,
      incomingOnStrike: json['incomingOnStrike'] as bool? ?? true,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$BatterReplacedEventToJson(
  BatterReplacedEvent instance,
) => <String, dynamic>{
  'inningsIndex': instance.inningsIndex,
  'outgoingId': instance.outgoingId,
  'incomingId': instance.incomingId,
  'retiredHurt': instance.retiredHurt,
  'incomingOnStrike': instance.incomingOnStrike,
  'runtimeType': instance.$type,
};

SwapStrikeEvent _$SwapStrikeEventFromJson(Map<String, dynamic> json) =>
    SwapStrikeEvent(
      inningsIndex: (json['inningsIndex'] as num).toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SwapStrikeEventToJson(SwapStrikeEvent instance) =>
    <String, dynamic>{
      'inningsIndex': instance.inningsIndex,
      'runtimeType': instance.$type,
    };

BowlerChangedEvent _$BowlerChangedEventFromJson(Map<String, dynamic> json) =>
    BowlerChangedEvent(
      inningsIndex: (json['inningsIndex'] as num).toInt(),
      bowlerId: json['bowlerId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$BowlerChangedEventToJson(BowlerChangedEvent instance) =>
    <String, dynamic>{
      'inningsIndex': instance.inningsIndex,
      'bowlerId': instance.bowlerId,
      'runtimeType': instance.$type,
    };

EndInningsEvent _$EndInningsEventFromJson(Map<String, dynamic> json) =>
    EndInningsEvent(
      inningsIndex: (json['inningsIndex'] as num).toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$EndInningsEventToJson(EndInningsEvent instance) =>
    <String, dynamic>{
      'inningsIndex': instance.inningsIndex,
      'runtimeType': instance.$type,
    };
