// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchRules _$MatchRulesFromJson(Map<String, dynamic> json) => _MatchRules(
  presetId: json['presetId'] as String? ?? 'custom',
  label: json['label'] as String? ?? 'Custom',
  oversPerInnings: (json['oversPerInnings'] as num?)?.toInt() ?? 20,
  playersPerSide: (json['playersPerSide'] as num?)?.toInt() ?? 11,
  maxOversPerBowler: (json['maxOversPerBowler'] as num?)?.toInt() ?? 4,
  freeHitAfterNoBall: json['freeHitAfterNoBall'] as bool? ?? true,
  noBallPenalty: (json['noBallPenalty'] as num?)?.toInt() ?? 1,
  wideRun: (json['wideRun'] as num?)?.toInt() ?? 1,
  wideReBowled: json['wideReBowled'] as bool? ?? true,
  noBallReBowled: json['noBallReBowled'] as bool? ?? true,
  lbwEnabled: json['lbwEnabled'] as bool? ?? true,
  legByeRequiresShot: json['legByeRequiresShot'] as bool? ?? true,
  keeperPresent: json['keeperPresent'] as bool? ?? true,
  powerplayOvers:
      (json['powerplayOvers'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  lastManStands: json['lastManStands'] as bool? ?? false,
  lastManMustRunTwo: json['lastManMustRunTwo'] as bool? ?? false,
  sixAndOut: json['sixAndOut'] as bool? ?? false,
  jokerBatsBothSides: json['jokerBatsBothSides'] as bool? ?? false,
  oneTipOneHand: json['oneTipOneHand'] as bool? ?? false,
  oneHandOneBounceWall: json['oneHandOneBounceWall'] as bool? ?? false,
  superOver:
      $enumDecodeNullable(_$SuperOverRuleEnumMap, json['superOver']) ??
      SuperOverRule.none,
);

Map<String, dynamic> _$MatchRulesToJson(_MatchRules instance) =>
    <String, dynamic>{
      'presetId': instance.presetId,
      'label': instance.label,
      'oversPerInnings': instance.oversPerInnings,
      'playersPerSide': instance.playersPerSide,
      'maxOversPerBowler': instance.maxOversPerBowler,
      'freeHitAfterNoBall': instance.freeHitAfterNoBall,
      'noBallPenalty': instance.noBallPenalty,
      'wideRun': instance.wideRun,
      'wideReBowled': instance.wideReBowled,
      'noBallReBowled': instance.noBallReBowled,
      'lbwEnabled': instance.lbwEnabled,
      'legByeRequiresShot': instance.legByeRequiresShot,
      'keeperPresent': instance.keeperPresent,
      'powerplayOvers': instance.powerplayOvers,
      'lastManStands': instance.lastManStands,
      'lastManMustRunTwo': instance.lastManMustRunTwo,
      'sixAndOut': instance.sixAndOut,
      'jokerBatsBothSides': instance.jokerBatsBothSides,
      'oneTipOneHand': instance.oneTipOneHand,
      'oneHandOneBounceWall': instance.oneHandOneBounceWall,
      'superOver': _$SuperOverRuleEnumMap[instance.superOver]!,
    };

const _$SuperOverRuleEnumMap = {
  SuperOverRule.none: 'none',
  SuperOverRule.oneOver: 'oneOver',
  SuperOverRule.boundaryCountback: 'boundaryCountback',
};
