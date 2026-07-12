// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scorecard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BatterLine _$BatterLineFromJson(Map<String, dynamic> json) => _BatterLine(
  playerId: json['playerId'] as String,
  name: json['name'] as String,
  runs: (json['runs'] as num).toInt(),
  balls: (json['balls'] as num).toInt(),
  fours: (json['fours'] as num).toInt(),
  sixes: (json['sixes'] as num).toInt(),
  strikeRate: (json['strikeRate'] as num).toDouble(),
  dismissalText: json['dismissalText'] as String,
  notOut: json['notOut'] as bool,
);

Map<String, dynamic> _$BatterLineToJson(_BatterLine instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'name': instance.name,
      'runs': instance.runs,
      'balls': instance.balls,
      'fours': instance.fours,
      'sixes': instance.sixes,
      'strikeRate': instance.strikeRate,
      'dismissalText': instance.dismissalText,
      'notOut': instance.notOut,
    };

_BowlerLine _$BowlerLineFromJson(Map<String, dynamic> json) => _BowlerLine(
  playerId: json['playerId'] as String,
  name: json['name'] as String,
  oversText: json['oversText'] as String,
  maidens: (json['maidens'] as num).toInt(),
  runs: (json['runs'] as num).toInt(),
  wickets: (json['wickets'] as num).toInt(),
  economy: (json['economy'] as num).toDouble(),
  wides: (json['wides'] as num).toInt(),
  noBalls: (json['noBalls'] as num).toInt(),
);

Map<String, dynamic> _$BowlerLineToJson(_BowlerLine instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'name': instance.name,
      'oversText': instance.oversText,
      'maidens': instance.maidens,
      'runs': instance.runs,
      'wickets': instance.wickets,
      'economy': instance.economy,
      'wides': instance.wides,
      'noBalls': instance.noBalls,
    };

_InningsScorecard _$InningsScorecardFromJson(Map<String, dynamic> json) =>
    _InningsScorecard(
      battingTeamId: json['battingTeamId'] as String,
      bowlingTeamId: json['bowlingTeamId'] as String,
      total: (json['total'] as num).toInt(),
      wickets: (json['wickets'] as num).toInt(),
      oversText: json['oversText'] as String,
      runRate: (json['runRate'] as num).toDouble(),
      batters: (json['batters'] as List<dynamic>)
          .map((e) => BatterLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      bowlers: (json['bowlers'] as List<dynamic>)
          .map((e) => BowlerLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      extras: Extras.fromJson(json['extras'] as Map<String, dynamic>),
      fallOfWickets: (json['fallOfWickets'] as List<dynamic>)
          .map((e) => FallOfWicket.fromJson(e as Map<String, dynamic>))
          .toList(),
      partnerships: (json['partnerships'] as List<dynamic>)
          .map((e) => Partnership.fromJson(e as Map<String, dynamic>))
          .toList(),
      target: (json['target'] as num?)?.toInt(),
      powerplayOvers:
          (json['powerplayOvers'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
    );

Map<String, dynamic> _$InningsScorecardToJson(_InningsScorecard instance) =>
    <String, dynamic>{
      'battingTeamId': instance.battingTeamId,
      'bowlingTeamId': instance.bowlingTeamId,
      'total': instance.total,
      'wickets': instance.wickets,
      'oversText': instance.oversText,
      'runRate': instance.runRate,
      'batters': instance.batters.map((e) => e.toJson()).toList(),
      'bowlers': instance.bowlers.map((e) => e.toJson()).toList(),
      'extras': instance.extras.toJson(),
      'fallOfWickets': instance.fallOfWickets.map((e) => e.toJson()).toList(),
      'partnerships': instance.partnerships.map((e) => e.toJson()).toList(),
      'target': instance.target,
      'powerplayOvers': instance.powerplayOvers,
    };
