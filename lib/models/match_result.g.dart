// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchResult _$MatchResultFromJson(Map<String, dynamic> json) => _MatchResult(
  type: $enumDecode(_$MatchResultTypeEnumMap, json['type']),
  winnerTeamId: json['winnerTeamId'] as String?,
  margin: (json['margin'] as num?)?.toInt() ?? 0,
  marginUnit: json['marginUnit'] as String? ?? '',
  summary: json['summary'] as String,
);

Map<String, dynamic> _$MatchResultToJson(_MatchResult instance) =>
    <String, dynamic>{
      'type': _$MatchResultTypeEnumMap[instance.type]!,
      'winnerTeamId': instance.winnerTeamId,
      'margin': instance.margin,
      'marginUnit': instance.marginUnit,
      'summary': instance.summary,
    };

const _$MatchResultTypeEnumMap = {
  MatchResultType.winByRuns: 'winByRuns',
  MatchResultType.winByWickets: 'winByWickets',
  MatchResultType.tie: 'tie',
  MatchResultType.noResult: 'noResult',
  MatchResultType.superOver: 'superOver',
};
