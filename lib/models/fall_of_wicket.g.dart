// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fall_of_wicket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FallOfWicket _$FallOfWicketFromJson(Map<String, dynamic> json) =>
    _FallOfWicket(
      wicketNo: (json['wicketNo'] as num).toInt(),
      batterId: json['batterId'] as String,
      scoreAtFall: (json['scoreAtFall'] as num).toInt(),
      legalBallsAtFall: (json['legalBallsAtFall'] as num).toInt(),
    );

Map<String, dynamic> _$FallOfWicketToJson(_FallOfWicket instance) =>
    <String, dynamic>{
      'wicketNo': instance.wicketNo,
      'batterId': instance.batterId,
      'scoreAtFall': instance.scoreAtFall,
      'legalBallsAtFall': instance.legalBallsAtFall,
    };

_Partnership _$PartnershipFromJson(Map<String, dynamic> json) => _Partnership(
  forWicket: (json['forWicket'] as num).toInt(),
  batterAId: json['batterAId'] as String,
  batterBId: json['batterBId'] as String,
  runs: (json['runs'] as num?)?.toInt() ?? 0,
  balls: (json['balls'] as num?)?.toInt() ?? 0,
  unbroken: json['unbroken'] as bool? ?? true,
);

Map<String, dynamic> _$PartnershipToJson(_Partnership instance) =>
    <String, dynamic>{
      'forWicket': instance.forWicket,
      'batterAId': instance.batterAId,
      'batterBId': instance.batterBId,
      'runs': instance.runs,
      'balls': instance.balls,
      'unbroken': instance.unbroken,
    };
