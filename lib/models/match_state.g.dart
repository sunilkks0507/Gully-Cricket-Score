// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchState _$MatchStateFromJson(Map<String, dynamic> json) => _MatchState(
  matchId: json['matchId'] as String,
  rules: MatchRules.fromJson(json['rules'] as Map<String, dynamic>),
  currentInnings: (json['currentInnings'] as num?)?.toInt() ?? 0,
  innings1: json['innings1'] == null
      ? null
      : InningsState.fromJson(json['innings1'] as Map<String, dynamic>),
  innings2: json['innings2'] == null
      ? null
      : InningsState.fromJson(json['innings2'] as Map<String, dynamic>),
  status:
      $enumDecodeNullable(_$MatchStatusEnumMap, json['status']) ??
      MatchStatus.notStarted,
  result: json['result'] == null
      ? null
      : MatchResult.fromJson(json['result'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MatchStateToJson(_MatchState instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'rules': instance.rules.toJson(),
      'currentInnings': instance.currentInnings,
      'innings1': instance.innings1?.toJson(),
      'innings2': instance.innings2?.toJson(),
      'status': _$MatchStatusEnumMap[instance.status]!,
      'result': instance.result?.toJson(),
    };

const _$MatchStatusEnumMap = {
  MatchStatus.notStarted: 'notStarted',
  MatchStatus.inProgress: 'inProgress',
  MatchStatus.inningsBreak: 'inningsBreak',
  MatchStatus.completed: 'completed',
  MatchStatus.abandoned: 'abandoned',
};
