// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'innings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InningsState _$InningsStateFromJson(Map<String, dynamic> json) =>
    _InningsState(
      battingTeamId: json['battingTeamId'] as String,
      bowlingTeamId: json['bowlingTeamId'] as String,
      totalRuns: (json['totalRuns'] as num?)?.toInt() ?? 0,
      wickets: (json['wickets'] as num?)?.toInt() ?? 0,
      legalBalls: (json['legalBalls'] as num?)?.toInt() ?? 0,
      strikerId: json['strikerId'] as String?,
      nonStrikerId: json['nonStrikerId'] as String?,
      bowlerId: json['bowlerId'] as String?,
      previousBowlerId: json['previousBowlerId'] as String?,
      extras: json['extras'] == null
          ? const Extras()
          : Extras.fromJson(json['extras'] as Map<String, dynamic>),
      batters:
          (json['batters'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, BatterCard.fromJson(e as Map<String, dynamic>)),
          ) ??
          const <String, BatterCard>{},
      bowlers:
          (json['bowlers'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, BowlerCard.fromJson(e as Map<String, dynamic>)),
          ) ??
          const <String, BowlerCard>{},
      fow:
          (json['fow'] as List<dynamic>?)
              ?.map((e) => FallOfWicket.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FallOfWicket>[],
      partnerships:
          (json['partnerships'] as List<dynamic>?)
              ?.map((e) => Partnership.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Partnership>[],
      dismissals:
          (json['dismissals'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Wicket.fromJson(e as Map<String, dynamic>)),
          ) ??
          const <String, Wicket>{},
      target: (json['target'] as num?)?.toInt(),
      freeHitPending: json['freeHitPending'] as bool? ?? false,
      ballsThisOver: (json['ballsThisOver'] as num?)?.toInt() ?? 0,
      runsConcededThisOver:
          (json['runsConcededThisOver'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$InningsStateToJson(_InningsState instance) =>
    <String, dynamic>{
      'battingTeamId': instance.battingTeamId,
      'bowlingTeamId': instance.bowlingTeamId,
      'totalRuns': instance.totalRuns,
      'wickets': instance.wickets,
      'legalBalls': instance.legalBalls,
      'strikerId': instance.strikerId,
      'nonStrikerId': instance.nonStrikerId,
      'bowlerId': instance.bowlerId,
      'previousBowlerId': instance.previousBowlerId,
      'extras': instance.extras.toJson(),
      'batters': instance.batters.map((k, e) => MapEntry(k, e.toJson())),
      'bowlers': instance.bowlers.map((k, e) => MapEntry(k, e.toJson())),
      'fow': instance.fow.map((e) => e.toJson()).toList(),
      'partnerships': instance.partnerships.map((e) => e.toJson()).toList(),
      'dismissals': instance.dismissals.map((k, e) => MapEntry(k, e.toJson())),
      'target': instance.target,
      'freeHitPending': instance.freeHitPending,
      'ballsThisOver': instance.ballsThisOver,
      'runsConcededThisOver': instance.runsConcededThisOver,
    };
