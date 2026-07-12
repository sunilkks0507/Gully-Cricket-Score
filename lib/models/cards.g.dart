// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cards.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BatterCard _$BatterCardFromJson(Map<String, dynamic> json) => _BatterCard(
  playerId: json['playerId'] as String,
  runs: (json['runs'] as num?)?.toInt() ?? 0,
  balls: (json['balls'] as num?)?.toInt() ?? 0,
  fours: (json['fours'] as num?)?.toInt() ?? 0,
  sixes: (json['sixes'] as num?)?.toInt() ?? 0,
  isOut: json['isOut'] as bool? ?? false,
  isRetiredNotOut: json['isRetiredNotOut'] as bool? ?? false,
  dismissalText: json['dismissalText'] as String?,
);

Map<String, dynamic> _$BatterCardToJson(_BatterCard instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'runs': instance.runs,
      'balls': instance.balls,
      'fours': instance.fours,
      'sixes': instance.sixes,
      'isOut': instance.isOut,
      'isRetiredNotOut': instance.isRetiredNotOut,
      'dismissalText': instance.dismissalText,
    };

_BowlerCard _$BowlerCardFromJson(Map<String, dynamic> json) => _BowlerCard(
  playerId: json['playerId'] as String,
  balls: (json['balls'] as num?)?.toInt() ?? 0,
  runsConceded: (json['runsConceded'] as num?)?.toInt() ?? 0,
  wickets: (json['wickets'] as num?)?.toInt() ?? 0,
  maidens: (json['maidens'] as num?)?.toInt() ?? 0,
  wides: (json['wides'] as num?)?.toInt() ?? 0,
  noBalls: (json['noBalls'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$BowlerCardToJson(_BowlerCard instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'balls': instance.balls,
      'runsConceded': instance.runsConceded,
      'wickets': instance.wickets,
      'maidens': instance.maidens,
      'wides': instance.wides,
      'noBalls': instance.noBalls,
    };
