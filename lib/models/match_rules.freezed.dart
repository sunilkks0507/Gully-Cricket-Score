// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_rules.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchRules {

/// Which preset this config was derived from ('t20', 'gully_classic',
/// 'custom', ...). Metadata for display; the engine reads the fields below.
 String get presetId;/// Human-readable name, e.g. "T20 (standard)".
 String get label;/// Overs per innings. 0 = unlimited (not used in v1).
 int get oversPerInnings; int get playersPerSide; int get maxOversPerBowler; bool get freeHitAfterNoBall; int get noBallPenalty; int get wideRun;/// A wide is re-bowled (does not count as a legal ball). Some gully games
/// set this false (a wide is just a run and the ball counts).
 bool get wideReBowled; bool get noBallReBowled; bool get lbwEnabled;/// Strict laws: leg-byes only count if the batter offered a shot / evaded.
 bool get legByeRequiresShot;/// A wicketkeeper is present (enables stumped).
 bool get keeperPresent; List<int> get powerplayOvers;/// Last batter bats alone after the 2nd-last wicket instead of ending.
 bool get lastManStands;/// With last-man-stands, a single run is void (batters must run in pairs).
 bool get lastManMustRunTwo;/// A "six" also dismisses the striker (box cricket — ball leaves the box).
 bool get sixAndOut;/// One player bats for both sides (uneven numbers). Mostly a roster concern.
 bool get jokerBatsBothSides;/// One-tip-one-hand catches are legal dismissals (enables the picker option).
 bool get oneTipOneHand;/// One-hand-one-bounce off a wall counts (box cricket) — metadata for v1.
 bool get oneHandOneBounceWall; SuperOverRule get superOver;
/// Create a copy of MatchRules
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchRulesCopyWith<MatchRules> get copyWith => _$MatchRulesCopyWithImpl<MatchRules>(this as MatchRules, _$identity);

  /// Serializes this MatchRules to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchRules&&(identical(other.presetId, presetId) || other.presetId == presetId)&&(identical(other.label, label) || other.label == label)&&(identical(other.oversPerInnings, oversPerInnings) || other.oversPerInnings == oversPerInnings)&&(identical(other.playersPerSide, playersPerSide) || other.playersPerSide == playersPerSide)&&(identical(other.maxOversPerBowler, maxOversPerBowler) || other.maxOversPerBowler == maxOversPerBowler)&&(identical(other.freeHitAfterNoBall, freeHitAfterNoBall) || other.freeHitAfterNoBall == freeHitAfterNoBall)&&(identical(other.noBallPenalty, noBallPenalty) || other.noBallPenalty == noBallPenalty)&&(identical(other.wideRun, wideRun) || other.wideRun == wideRun)&&(identical(other.wideReBowled, wideReBowled) || other.wideReBowled == wideReBowled)&&(identical(other.noBallReBowled, noBallReBowled) || other.noBallReBowled == noBallReBowled)&&(identical(other.lbwEnabled, lbwEnabled) || other.lbwEnabled == lbwEnabled)&&(identical(other.legByeRequiresShot, legByeRequiresShot) || other.legByeRequiresShot == legByeRequiresShot)&&(identical(other.keeperPresent, keeperPresent) || other.keeperPresent == keeperPresent)&&const DeepCollectionEquality().equals(other.powerplayOvers, powerplayOvers)&&(identical(other.lastManStands, lastManStands) || other.lastManStands == lastManStands)&&(identical(other.lastManMustRunTwo, lastManMustRunTwo) || other.lastManMustRunTwo == lastManMustRunTwo)&&(identical(other.sixAndOut, sixAndOut) || other.sixAndOut == sixAndOut)&&(identical(other.jokerBatsBothSides, jokerBatsBothSides) || other.jokerBatsBothSides == jokerBatsBothSides)&&(identical(other.oneTipOneHand, oneTipOneHand) || other.oneTipOneHand == oneTipOneHand)&&(identical(other.oneHandOneBounceWall, oneHandOneBounceWall) || other.oneHandOneBounceWall == oneHandOneBounceWall)&&(identical(other.superOver, superOver) || other.superOver == superOver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,presetId,label,oversPerInnings,playersPerSide,maxOversPerBowler,freeHitAfterNoBall,noBallPenalty,wideRun,wideReBowled,noBallReBowled,lbwEnabled,legByeRequiresShot,keeperPresent,const DeepCollectionEquality().hash(powerplayOvers),lastManStands,lastManMustRunTwo,sixAndOut,jokerBatsBothSides,oneTipOneHand,oneHandOneBounceWall,superOver]);

@override
String toString() {
  return 'MatchRules(presetId: $presetId, label: $label, oversPerInnings: $oversPerInnings, playersPerSide: $playersPerSide, maxOversPerBowler: $maxOversPerBowler, freeHitAfterNoBall: $freeHitAfterNoBall, noBallPenalty: $noBallPenalty, wideRun: $wideRun, wideReBowled: $wideReBowled, noBallReBowled: $noBallReBowled, lbwEnabled: $lbwEnabled, legByeRequiresShot: $legByeRequiresShot, keeperPresent: $keeperPresent, powerplayOvers: $powerplayOvers, lastManStands: $lastManStands, lastManMustRunTwo: $lastManMustRunTwo, sixAndOut: $sixAndOut, jokerBatsBothSides: $jokerBatsBothSides, oneTipOneHand: $oneTipOneHand, oneHandOneBounceWall: $oneHandOneBounceWall, superOver: $superOver)';
}


}

/// @nodoc
abstract mixin class $MatchRulesCopyWith<$Res>  {
  factory $MatchRulesCopyWith(MatchRules value, $Res Function(MatchRules) _then) = _$MatchRulesCopyWithImpl;
@useResult
$Res call({
 String presetId, String label, int oversPerInnings, int playersPerSide, int maxOversPerBowler, bool freeHitAfterNoBall, int noBallPenalty, int wideRun, bool wideReBowled, bool noBallReBowled, bool lbwEnabled, bool legByeRequiresShot, bool keeperPresent, List<int> powerplayOvers, bool lastManStands, bool lastManMustRunTwo, bool sixAndOut, bool jokerBatsBothSides, bool oneTipOneHand, bool oneHandOneBounceWall, SuperOverRule superOver
});




}
/// @nodoc
class _$MatchRulesCopyWithImpl<$Res>
    implements $MatchRulesCopyWith<$Res> {
  _$MatchRulesCopyWithImpl(this._self, this._then);

  final MatchRules _self;
  final $Res Function(MatchRules) _then;

/// Create a copy of MatchRules
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? presetId = null,Object? label = null,Object? oversPerInnings = null,Object? playersPerSide = null,Object? maxOversPerBowler = null,Object? freeHitAfterNoBall = null,Object? noBallPenalty = null,Object? wideRun = null,Object? wideReBowled = null,Object? noBallReBowled = null,Object? lbwEnabled = null,Object? legByeRequiresShot = null,Object? keeperPresent = null,Object? powerplayOvers = null,Object? lastManStands = null,Object? lastManMustRunTwo = null,Object? sixAndOut = null,Object? jokerBatsBothSides = null,Object? oneTipOneHand = null,Object? oneHandOneBounceWall = null,Object? superOver = null,}) {
  return _then(_self.copyWith(
presetId: null == presetId ? _self.presetId : presetId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,oversPerInnings: null == oversPerInnings ? _self.oversPerInnings : oversPerInnings // ignore: cast_nullable_to_non_nullable
as int,playersPerSide: null == playersPerSide ? _self.playersPerSide : playersPerSide // ignore: cast_nullable_to_non_nullable
as int,maxOversPerBowler: null == maxOversPerBowler ? _self.maxOversPerBowler : maxOversPerBowler // ignore: cast_nullable_to_non_nullable
as int,freeHitAfterNoBall: null == freeHitAfterNoBall ? _self.freeHitAfterNoBall : freeHitAfterNoBall // ignore: cast_nullable_to_non_nullable
as bool,noBallPenalty: null == noBallPenalty ? _self.noBallPenalty : noBallPenalty // ignore: cast_nullable_to_non_nullable
as int,wideRun: null == wideRun ? _self.wideRun : wideRun // ignore: cast_nullable_to_non_nullable
as int,wideReBowled: null == wideReBowled ? _self.wideReBowled : wideReBowled // ignore: cast_nullable_to_non_nullable
as bool,noBallReBowled: null == noBallReBowled ? _self.noBallReBowled : noBallReBowled // ignore: cast_nullable_to_non_nullable
as bool,lbwEnabled: null == lbwEnabled ? _self.lbwEnabled : lbwEnabled // ignore: cast_nullable_to_non_nullable
as bool,legByeRequiresShot: null == legByeRequiresShot ? _self.legByeRequiresShot : legByeRequiresShot // ignore: cast_nullable_to_non_nullable
as bool,keeperPresent: null == keeperPresent ? _self.keeperPresent : keeperPresent // ignore: cast_nullable_to_non_nullable
as bool,powerplayOvers: null == powerplayOvers ? _self.powerplayOvers : powerplayOvers // ignore: cast_nullable_to_non_nullable
as List<int>,lastManStands: null == lastManStands ? _self.lastManStands : lastManStands // ignore: cast_nullable_to_non_nullable
as bool,lastManMustRunTwo: null == lastManMustRunTwo ? _self.lastManMustRunTwo : lastManMustRunTwo // ignore: cast_nullable_to_non_nullable
as bool,sixAndOut: null == sixAndOut ? _self.sixAndOut : sixAndOut // ignore: cast_nullable_to_non_nullable
as bool,jokerBatsBothSides: null == jokerBatsBothSides ? _self.jokerBatsBothSides : jokerBatsBothSides // ignore: cast_nullable_to_non_nullable
as bool,oneTipOneHand: null == oneTipOneHand ? _self.oneTipOneHand : oneTipOneHand // ignore: cast_nullable_to_non_nullable
as bool,oneHandOneBounceWall: null == oneHandOneBounceWall ? _self.oneHandOneBounceWall : oneHandOneBounceWall // ignore: cast_nullable_to_non_nullable
as bool,superOver: null == superOver ? _self.superOver : superOver // ignore: cast_nullable_to_non_nullable
as SuperOverRule,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchRules].
extension MatchRulesPatterns on MatchRules {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchRules value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchRules() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchRules value)  $default,){
final _that = this;
switch (_that) {
case _MatchRules():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchRules value)?  $default,){
final _that = this;
switch (_that) {
case _MatchRules() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String presetId,  String label,  int oversPerInnings,  int playersPerSide,  int maxOversPerBowler,  bool freeHitAfterNoBall,  int noBallPenalty,  int wideRun,  bool wideReBowled,  bool noBallReBowled,  bool lbwEnabled,  bool legByeRequiresShot,  bool keeperPresent,  List<int> powerplayOvers,  bool lastManStands,  bool lastManMustRunTwo,  bool sixAndOut,  bool jokerBatsBothSides,  bool oneTipOneHand,  bool oneHandOneBounceWall,  SuperOverRule superOver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchRules() when $default != null:
return $default(_that.presetId,_that.label,_that.oversPerInnings,_that.playersPerSide,_that.maxOversPerBowler,_that.freeHitAfterNoBall,_that.noBallPenalty,_that.wideRun,_that.wideReBowled,_that.noBallReBowled,_that.lbwEnabled,_that.legByeRequiresShot,_that.keeperPresent,_that.powerplayOvers,_that.lastManStands,_that.lastManMustRunTwo,_that.sixAndOut,_that.jokerBatsBothSides,_that.oneTipOneHand,_that.oneHandOneBounceWall,_that.superOver);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String presetId,  String label,  int oversPerInnings,  int playersPerSide,  int maxOversPerBowler,  bool freeHitAfterNoBall,  int noBallPenalty,  int wideRun,  bool wideReBowled,  bool noBallReBowled,  bool lbwEnabled,  bool legByeRequiresShot,  bool keeperPresent,  List<int> powerplayOvers,  bool lastManStands,  bool lastManMustRunTwo,  bool sixAndOut,  bool jokerBatsBothSides,  bool oneTipOneHand,  bool oneHandOneBounceWall,  SuperOverRule superOver)  $default,) {final _that = this;
switch (_that) {
case _MatchRules():
return $default(_that.presetId,_that.label,_that.oversPerInnings,_that.playersPerSide,_that.maxOversPerBowler,_that.freeHitAfterNoBall,_that.noBallPenalty,_that.wideRun,_that.wideReBowled,_that.noBallReBowled,_that.lbwEnabled,_that.legByeRequiresShot,_that.keeperPresent,_that.powerplayOvers,_that.lastManStands,_that.lastManMustRunTwo,_that.sixAndOut,_that.jokerBatsBothSides,_that.oneTipOneHand,_that.oneHandOneBounceWall,_that.superOver);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String presetId,  String label,  int oversPerInnings,  int playersPerSide,  int maxOversPerBowler,  bool freeHitAfterNoBall,  int noBallPenalty,  int wideRun,  bool wideReBowled,  bool noBallReBowled,  bool lbwEnabled,  bool legByeRequiresShot,  bool keeperPresent,  List<int> powerplayOvers,  bool lastManStands,  bool lastManMustRunTwo,  bool sixAndOut,  bool jokerBatsBothSides,  bool oneTipOneHand,  bool oneHandOneBounceWall,  SuperOverRule superOver)?  $default,) {final _that = this;
switch (_that) {
case _MatchRules() when $default != null:
return $default(_that.presetId,_that.label,_that.oversPerInnings,_that.playersPerSide,_that.maxOversPerBowler,_that.freeHitAfterNoBall,_that.noBallPenalty,_that.wideRun,_that.wideReBowled,_that.noBallReBowled,_that.lbwEnabled,_that.legByeRequiresShot,_that.keeperPresent,_that.powerplayOvers,_that.lastManStands,_that.lastManMustRunTwo,_that.sixAndOut,_that.jokerBatsBothSides,_that.oneTipOneHand,_that.oneHandOneBounceWall,_that.superOver);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchRules extends MatchRules {
  const _MatchRules({this.presetId = 'custom', this.label = 'Custom', this.oversPerInnings = 20, this.playersPerSide = 11, this.maxOversPerBowler = 4, this.freeHitAfterNoBall = true, this.noBallPenalty = 1, this.wideRun = 1, this.wideReBowled = true, this.noBallReBowled = true, this.lbwEnabled = true, this.legByeRequiresShot = true, this.keeperPresent = true, final  List<int> powerplayOvers = const <int>[], this.lastManStands = false, this.lastManMustRunTwo = false, this.sixAndOut = false, this.jokerBatsBothSides = false, this.oneTipOneHand = false, this.oneHandOneBounceWall = false, this.superOver = SuperOverRule.none}): _powerplayOvers = powerplayOvers,super._();
  factory _MatchRules.fromJson(Map<String, dynamic> json) => _$MatchRulesFromJson(json);

/// Which preset this config was derived from ('t20', 'gully_classic',
/// 'custom', ...). Metadata for display; the engine reads the fields below.
@override@JsonKey() final  String presetId;
/// Human-readable name, e.g. "T20 (standard)".
@override@JsonKey() final  String label;
/// Overs per innings. 0 = unlimited (not used in v1).
@override@JsonKey() final  int oversPerInnings;
@override@JsonKey() final  int playersPerSide;
@override@JsonKey() final  int maxOversPerBowler;
@override@JsonKey() final  bool freeHitAfterNoBall;
@override@JsonKey() final  int noBallPenalty;
@override@JsonKey() final  int wideRun;
/// A wide is re-bowled (does not count as a legal ball). Some gully games
/// set this false (a wide is just a run and the ball counts).
@override@JsonKey() final  bool wideReBowled;
@override@JsonKey() final  bool noBallReBowled;
@override@JsonKey() final  bool lbwEnabled;
/// Strict laws: leg-byes only count if the batter offered a shot / evaded.
@override@JsonKey() final  bool legByeRequiresShot;
/// A wicketkeeper is present (enables stumped).
@override@JsonKey() final  bool keeperPresent;
 final  List<int> _powerplayOvers;
@override@JsonKey() List<int> get powerplayOvers {
  if (_powerplayOvers is EqualUnmodifiableListView) return _powerplayOvers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_powerplayOvers);
}

/// Last batter bats alone after the 2nd-last wicket instead of ending.
@override@JsonKey() final  bool lastManStands;
/// With last-man-stands, a single run is void (batters must run in pairs).
@override@JsonKey() final  bool lastManMustRunTwo;
/// A "six" also dismisses the striker (box cricket — ball leaves the box).
@override@JsonKey() final  bool sixAndOut;
/// One player bats for both sides (uneven numbers). Mostly a roster concern.
@override@JsonKey() final  bool jokerBatsBothSides;
/// One-tip-one-hand catches are legal dismissals (enables the picker option).
@override@JsonKey() final  bool oneTipOneHand;
/// One-hand-one-bounce off a wall counts (box cricket) — metadata for v1.
@override@JsonKey() final  bool oneHandOneBounceWall;
@override@JsonKey() final  SuperOverRule superOver;

/// Create a copy of MatchRules
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchRulesCopyWith<_MatchRules> get copyWith => __$MatchRulesCopyWithImpl<_MatchRules>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchRulesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchRules&&(identical(other.presetId, presetId) || other.presetId == presetId)&&(identical(other.label, label) || other.label == label)&&(identical(other.oversPerInnings, oversPerInnings) || other.oversPerInnings == oversPerInnings)&&(identical(other.playersPerSide, playersPerSide) || other.playersPerSide == playersPerSide)&&(identical(other.maxOversPerBowler, maxOversPerBowler) || other.maxOversPerBowler == maxOversPerBowler)&&(identical(other.freeHitAfterNoBall, freeHitAfterNoBall) || other.freeHitAfterNoBall == freeHitAfterNoBall)&&(identical(other.noBallPenalty, noBallPenalty) || other.noBallPenalty == noBallPenalty)&&(identical(other.wideRun, wideRun) || other.wideRun == wideRun)&&(identical(other.wideReBowled, wideReBowled) || other.wideReBowled == wideReBowled)&&(identical(other.noBallReBowled, noBallReBowled) || other.noBallReBowled == noBallReBowled)&&(identical(other.lbwEnabled, lbwEnabled) || other.lbwEnabled == lbwEnabled)&&(identical(other.legByeRequiresShot, legByeRequiresShot) || other.legByeRequiresShot == legByeRequiresShot)&&(identical(other.keeperPresent, keeperPresent) || other.keeperPresent == keeperPresent)&&const DeepCollectionEquality().equals(other._powerplayOvers, _powerplayOvers)&&(identical(other.lastManStands, lastManStands) || other.lastManStands == lastManStands)&&(identical(other.lastManMustRunTwo, lastManMustRunTwo) || other.lastManMustRunTwo == lastManMustRunTwo)&&(identical(other.sixAndOut, sixAndOut) || other.sixAndOut == sixAndOut)&&(identical(other.jokerBatsBothSides, jokerBatsBothSides) || other.jokerBatsBothSides == jokerBatsBothSides)&&(identical(other.oneTipOneHand, oneTipOneHand) || other.oneTipOneHand == oneTipOneHand)&&(identical(other.oneHandOneBounceWall, oneHandOneBounceWall) || other.oneHandOneBounceWall == oneHandOneBounceWall)&&(identical(other.superOver, superOver) || other.superOver == superOver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,presetId,label,oversPerInnings,playersPerSide,maxOversPerBowler,freeHitAfterNoBall,noBallPenalty,wideRun,wideReBowled,noBallReBowled,lbwEnabled,legByeRequiresShot,keeperPresent,const DeepCollectionEquality().hash(_powerplayOvers),lastManStands,lastManMustRunTwo,sixAndOut,jokerBatsBothSides,oneTipOneHand,oneHandOneBounceWall,superOver]);

@override
String toString() {
  return 'MatchRules(presetId: $presetId, label: $label, oversPerInnings: $oversPerInnings, playersPerSide: $playersPerSide, maxOversPerBowler: $maxOversPerBowler, freeHitAfterNoBall: $freeHitAfterNoBall, noBallPenalty: $noBallPenalty, wideRun: $wideRun, wideReBowled: $wideReBowled, noBallReBowled: $noBallReBowled, lbwEnabled: $lbwEnabled, legByeRequiresShot: $legByeRequiresShot, keeperPresent: $keeperPresent, powerplayOvers: $powerplayOvers, lastManStands: $lastManStands, lastManMustRunTwo: $lastManMustRunTwo, sixAndOut: $sixAndOut, jokerBatsBothSides: $jokerBatsBothSides, oneTipOneHand: $oneTipOneHand, oneHandOneBounceWall: $oneHandOneBounceWall, superOver: $superOver)';
}


}

/// @nodoc
abstract mixin class _$MatchRulesCopyWith<$Res> implements $MatchRulesCopyWith<$Res> {
  factory _$MatchRulesCopyWith(_MatchRules value, $Res Function(_MatchRules) _then) = __$MatchRulesCopyWithImpl;
@override @useResult
$Res call({
 String presetId, String label, int oversPerInnings, int playersPerSide, int maxOversPerBowler, bool freeHitAfterNoBall, int noBallPenalty, int wideRun, bool wideReBowled, bool noBallReBowled, bool lbwEnabled, bool legByeRequiresShot, bool keeperPresent, List<int> powerplayOvers, bool lastManStands, bool lastManMustRunTwo, bool sixAndOut, bool jokerBatsBothSides, bool oneTipOneHand, bool oneHandOneBounceWall, SuperOverRule superOver
});




}
/// @nodoc
class __$MatchRulesCopyWithImpl<$Res>
    implements _$MatchRulesCopyWith<$Res> {
  __$MatchRulesCopyWithImpl(this._self, this._then);

  final _MatchRules _self;
  final $Res Function(_MatchRules) _then;

/// Create a copy of MatchRules
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? presetId = null,Object? label = null,Object? oversPerInnings = null,Object? playersPerSide = null,Object? maxOversPerBowler = null,Object? freeHitAfterNoBall = null,Object? noBallPenalty = null,Object? wideRun = null,Object? wideReBowled = null,Object? noBallReBowled = null,Object? lbwEnabled = null,Object? legByeRequiresShot = null,Object? keeperPresent = null,Object? powerplayOvers = null,Object? lastManStands = null,Object? lastManMustRunTwo = null,Object? sixAndOut = null,Object? jokerBatsBothSides = null,Object? oneTipOneHand = null,Object? oneHandOneBounceWall = null,Object? superOver = null,}) {
  return _then(_MatchRules(
presetId: null == presetId ? _self.presetId : presetId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,oversPerInnings: null == oversPerInnings ? _self.oversPerInnings : oversPerInnings // ignore: cast_nullable_to_non_nullable
as int,playersPerSide: null == playersPerSide ? _self.playersPerSide : playersPerSide // ignore: cast_nullable_to_non_nullable
as int,maxOversPerBowler: null == maxOversPerBowler ? _self.maxOversPerBowler : maxOversPerBowler // ignore: cast_nullable_to_non_nullable
as int,freeHitAfterNoBall: null == freeHitAfterNoBall ? _self.freeHitAfterNoBall : freeHitAfterNoBall // ignore: cast_nullable_to_non_nullable
as bool,noBallPenalty: null == noBallPenalty ? _self.noBallPenalty : noBallPenalty // ignore: cast_nullable_to_non_nullable
as int,wideRun: null == wideRun ? _self.wideRun : wideRun // ignore: cast_nullable_to_non_nullable
as int,wideReBowled: null == wideReBowled ? _self.wideReBowled : wideReBowled // ignore: cast_nullable_to_non_nullable
as bool,noBallReBowled: null == noBallReBowled ? _self.noBallReBowled : noBallReBowled // ignore: cast_nullable_to_non_nullable
as bool,lbwEnabled: null == lbwEnabled ? _self.lbwEnabled : lbwEnabled // ignore: cast_nullable_to_non_nullable
as bool,legByeRequiresShot: null == legByeRequiresShot ? _self.legByeRequiresShot : legByeRequiresShot // ignore: cast_nullable_to_non_nullable
as bool,keeperPresent: null == keeperPresent ? _self.keeperPresent : keeperPresent // ignore: cast_nullable_to_non_nullable
as bool,powerplayOvers: null == powerplayOvers ? _self._powerplayOvers : powerplayOvers // ignore: cast_nullable_to_non_nullable
as List<int>,lastManStands: null == lastManStands ? _self.lastManStands : lastManStands // ignore: cast_nullable_to_non_nullable
as bool,lastManMustRunTwo: null == lastManMustRunTwo ? _self.lastManMustRunTwo : lastManMustRunTwo // ignore: cast_nullable_to_non_nullable
as bool,sixAndOut: null == sixAndOut ? _self.sixAndOut : sixAndOut // ignore: cast_nullable_to_non_nullable
as bool,jokerBatsBothSides: null == jokerBatsBothSides ? _self.jokerBatsBothSides : jokerBatsBothSides // ignore: cast_nullable_to_non_nullable
as bool,oneTipOneHand: null == oneTipOneHand ? _self.oneTipOneHand : oneTipOneHand // ignore: cast_nullable_to_non_nullable
as bool,oneHandOneBounceWall: null == oneHandOneBounceWall ? _self.oneHandOneBounceWall : oneHandOneBounceWall // ignore: cast_nullable_to_non_nullable
as bool,superOver: null == superOver ? _self.superOver : superOver // ignore: cast_nullable_to_non_nullable
as SuperOverRule,
  ));
}


}

// dart format on
