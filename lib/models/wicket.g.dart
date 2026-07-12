// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wicket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Wicket _$WicketFromJson(Map<String, dynamic> json) => _Wicket(
  type: $enumDecode(_$DismissalTypeEnumMap, json['type']),
  outBatterId: json['outBatterId'] as String,
  fielderId: json['fielderId'] as String?,
  bowlerId: json['bowlerId'] as String?,
  runsCompletedBeforeOut:
      (json['runsCompletedBeforeOut'] as num?)?.toInt() ?? 0,
  oneTipOneHand: json['oneTipOneHand'] as bool? ?? false,
  battersCrossed: json['battersCrossed'] as bool? ?? false,
);

Map<String, dynamic> _$WicketToJson(_Wicket instance) => <String, dynamic>{
  'type': _$DismissalTypeEnumMap[instance.type]!,
  'outBatterId': instance.outBatterId,
  'fielderId': instance.fielderId,
  'bowlerId': instance.bowlerId,
  'runsCompletedBeforeOut': instance.runsCompletedBeforeOut,
  'oneTipOneHand': instance.oneTipOneHand,
  'battersCrossed': instance.battersCrossed,
};

const _$DismissalTypeEnumMap = {
  DismissalType.bowled: 'bowled',
  DismissalType.caught: 'caught',
  DismissalType.lbw: 'lbw',
  DismissalType.runOut: 'runOut',
  DismissalType.stumped: 'stumped',
  DismissalType.hitWicket: 'hitWicket',
  DismissalType.obstructing: 'obstructing',
  DismissalType.hitBallTwice: 'hitBallTwice',
  DismissalType.timedOut: 'timedOut',
  DismissalType.retiredOut: 'retiredOut',
  DismissalType.sixOut: 'sixOut',
};
