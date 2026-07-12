// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ball_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BallEvent _$BallEventFromJson(Map<String, dynamic> json) => _BallEvent(
  inningsIndex: (json['inningsIndex'] as num).toInt(),
  strikerId: json['strikerId'] as String,
  nonStrikerId: json['nonStrikerId'] as String,
  bowlerId: json['bowlerId'] as String,
  runsOffBat: (json['runsOffBat'] as num?)?.toInt() ?? 0,
  extraType:
      $enumDecodeNullable(_$ExtraTypeEnumMap, json['extraType']) ??
      ExtraType.none,
  extraRuns: (json['extraRuns'] as num?)?.toInt() ?? 0,
  isFreeHit: json['isFreeHit'] as bool? ?? false,
  wicket: json['wicket'] == null
      ? null
      : Wicket.fromJson(json['wicket'] as Map<String, dynamic>),
  newBatterId: json['newBatterId'] as String?,
  tsLocal: json['tsLocal'] == null
      ? null
      : DateTime.parse(json['tsLocal'] as String),
);

Map<String, dynamic> _$BallEventToJson(_BallEvent instance) =>
    <String, dynamic>{
      'inningsIndex': instance.inningsIndex,
      'strikerId': instance.strikerId,
      'nonStrikerId': instance.nonStrikerId,
      'bowlerId': instance.bowlerId,
      'runsOffBat': instance.runsOffBat,
      'extraType': _$ExtraTypeEnumMap[instance.extraType]!,
      'extraRuns': instance.extraRuns,
      'isFreeHit': instance.isFreeHit,
      'wicket': instance.wicket?.toJson(),
      'newBatterId': instance.newBatterId,
      'tsLocal': instance.tsLocal?.toIso8601String(),
    };

const _$ExtraTypeEnumMap = {
  ExtraType.none: 'none',
  ExtraType.wide: 'wide',
  ExtraType.noBall: 'noBall',
  ExtraType.bye: 'bye',
  ExtraType.legBye: 'legBye',
  ExtraType.penalty: 'penalty',
};
