// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extras.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Extras _$ExtrasFromJson(Map<String, dynamic> json) => _Extras(
  wides: (json['wides'] as num?)?.toInt() ?? 0,
  noBalls: (json['noBalls'] as num?)?.toInt() ?? 0,
  byes: (json['byes'] as num?)?.toInt() ?? 0,
  legByes: (json['legByes'] as num?)?.toInt() ?? 0,
  penalties: (json['penalties'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ExtrasToJson(_Extras instance) => <String, dynamic>{
  'wides': instance.wides,
  'noBalls': instance.noBalls,
  'byes': instance.byes,
  'legByes': instance.legByes,
  'penalties': instance.penalties,
};
