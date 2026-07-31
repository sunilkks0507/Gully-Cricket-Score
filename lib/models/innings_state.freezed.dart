// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'innings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InningsState {

 String get battingTeamId; String get bowlingTeamId; int get totalRuns; int get wickets;/// Legal balls bowled so far. overs = legalBalls ~/ 6 . legalBalls % 6.
 int get legalBalls; String? get strikerId; String? get nonStrikerId; String? get bowlerId;/// Bowler of the previous over (may not bowl two in a row).
 String? get previousBowlerId; Extras get extras;/// Batter figures keyed by playerId.
 Map<String, BatterCard> get batters;/// Bowler figures keyed by playerId.
 Map<String, BowlerCard> get bowlers; List<FallOfWicket> get fow; List<Partnership> get partnerships;/// The dismissal for each out batter, keyed by playerId (for scorecard text).
 Map<String, Wicket> get dismissals;/// Second-innings target (innings1.totalRuns + 1); null in the first innings.
 int? get target;/// The next legal delivery is a free hit.
 bool get freeHitPending;/// Legal balls bowled in the current over (0..5); resets each over.
 int get ballsThisOver;/// Runs charged to the current bowler in the current over (for maiden
/// detection); resets each over.
 int get runsConcededThisOver;/// Players actually available to bat for this side. 0 = unknown, in which
/// case the all-out check falls back to `rules.playersPerSide`.
 int get battingSquadSize;
/// Create a copy of InningsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InningsStateCopyWith<InningsState> get copyWith => _$InningsStateCopyWithImpl<InningsState>(this as InningsState, _$identity);

  /// Serializes this InningsState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InningsState&&(identical(other.battingTeamId, battingTeamId) || other.battingTeamId == battingTeamId)&&(identical(other.bowlingTeamId, bowlingTeamId) || other.bowlingTeamId == bowlingTeamId)&&(identical(other.totalRuns, totalRuns) || other.totalRuns == totalRuns)&&(identical(other.wickets, wickets) || other.wickets == wickets)&&(identical(other.legalBalls, legalBalls) || other.legalBalls == legalBalls)&&(identical(other.strikerId, strikerId) || other.strikerId == strikerId)&&(identical(other.nonStrikerId, nonStrikerId) || other.nonStrikerId == nonStrikerId)&&(identical(other.bowlerId, bowlerId) || other.bowlerId == bowlerId)&&(identical(other.previousBowlerId, previousBowlerId) || other.previousBowlerId == previousBowlerId)&&(identical(other.extras, extras) || other.extras == extras)&&const DeepCollectionEquality().equals(other.batters, batters)&&const DeepCollectionEquality().equals(other.bowlers, bowlers)&&const DeepCollectionEquality().equals(other.fow, fow)&&const DeepCollectionEquality().equals(other.partnerships, partnerships)&&const DeepCollectionEquality().equals(other.dismissals, dismissals)&&(identical(other.target, target) || other.target == target)&&(identical(other.freeHitPending, freeHitPending) || other.freeHitPending == freeHitPending)&&(identical(other.ballsThisOver, ballsThisOver) || other.ballsThisOver == ballsThisOver)&&(identical(other.runsConcededThisOver, runsConcededThisOver) || other.runsConcededThisOver == runsConcededThisOver)&&(identical(other.battingSquadSize, battingSquadSize) || other.battingSquadSize == battingSquadSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,battingTeamId,bowlingTeamId,totalRuns,wickets,legalBalls,strikerId,nonStrikerId,bowlerId,previousBowlerId,extras,const DeepCollectionEquality().hash(batters),const DeepCollectionEquality().hash(bowlers),const DeepCollectionEquality().hash(fow),const DeepCollectionEquality().hash(partnerships),const DeepCollectionEquality().hash(dismissals),target,freeHitPending,ballsThisOver,runsConcededThisOver,battingSquadSize]);

@override
String toString() {
  return 'InningsState(battingTeamId: $battingTeamId, bowlingTeamId: $bowlingTeamId, totalRuns: $totalRuns, wickets: $wickets, legalBalls: $legalBalls, strikerId: $strikerId, nonStrikerId: $nonStrikerId, bowlerId: $bowlerId, previousBowlerId: $previousBowlerId, extras: $extras, batters: $batters, bowlers: $bowlers, fow: $fow, partnerships: $partnerships, dismissals: $dismissals, target: $target, freeHitPending: $freeHitPending, ballsThisOver: $ballsThisOver, runsConcededThisOver: $runsConcededThisOver, battingSquadSize: $battingSquadSize)';
}


}

/// @nodoc
abstract mixin class $InningsStateCopyWith<$Res>  {
  factory $InningsStateCopyWith(InningsState value, $Res Function(InningsState) _then) = _$InningsStateCopyWithImpl;
@useResult
$Res call({
 String battingTeamId, String bowlingTeamId, int totalRuns, int wickets, int legalBalls, String? strikerId, String? nonStrikerId, String? bowlerId, String? previousBowlerId, Extras extras, Map<String, BatterCard> batters, Map<String, BowlerCard> bowlers, List<FallOfWicket> fow, List<Partnership> partnerships, Map<String, Wicket> dismissals, int? target, bool freeHitPending, int ballsThisOver, int runsConcededThisOver, int battingSquadSize
});


$ExtrasCopyWith<$Res> get extras;

}
/// @nodoc
class _$InningsStateCopyWithImpl<$Res>
    implements $InningsStateCopyWith<$Res> {
  _$InningsStateCopyWithImpl(this._self, this._then);

  final InningsState _self;
  final $Res Function(InningsState) _then;

/// Create a copy of InningsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? battingTeamId = null,Object? bowlingTeamId = null,Object? totalRuns = null,Object? wickets = null,Object? legalBalls = null,Object? strikerId = freezed,Object? nonStrikerId = freezed,Object? bowlerId = freezed,Object? previousBowlerId = freezed,Object? extras = null,Object? batters = null,Object? bowlers = null,Object? fow = null,Object? partnerships = null,Object? dismissals = null,Object? target = freezed,Object? freeHitPending = null,Object? ballsThisOver = null,Object? runsConcededThisOver = null,Object? battingSquadSize = null,}) {
  return _then(_self.copyWith(
battingTeamId: null == battingTeamId ? _self.battingTeamId : battingTeamId // ignore: cast_nullable_to_non_nullable
as String,bowlingTeamId: null == bowlingTeamId ? _self.bowlingTeamId : bowlingTeamId // ignore: cast_nullable_to_non_nullable
as String,totalRuns: null == totalRuns ? _self.totalRuns : totalRuns // ignore: cast_nullable_to_non_nullable
as int,wickets: null == wickets ? _self.wickets : wickets // ignore: cast_nullable_to_non_nullable
as int,legalBalls: null == legalBalls ? _self.legalBalls : legalBalls // ignore: cast_nullable_to_non_nullable
as int,strikerId: freezed == strikerId ? _self.strikerId : strikerId // ignore: cast_nullable_to_non_nullable
as String?,nonStrikerId: freezed == nonStrikerId ? _self.nonStrikerId : nonStrikerId // ignore: cast_nullable_to_non_nullable
as String?,bowlerId: freezed == bowlerId ? _self.bowlerId : bowlerId // ignore: cast_nullable_to_non_nullable
as String?,previousBowlerId: freezed == previousBowlerId ? _self.previousBowlerId : previousBowlerId // ignore: cast_nullable_to_non_nullable
as String?,extras: null == extras ? _self.extras : extras // ignore: cast_nullable_to_non_nullable
as Extras,batters: null == batters ? _self.batters : batters // ignore: cast_nullable_to_non_nullable
as Map<String, BatterCard>,bowlers: null == bowlers ? _self.bowlers : bowlers // ignore: cast_nullable_to_non_nullable
as Map<String, BowlerCard>,fow: null == fow ? _self.fow : fow // ignore: cast_nullable_to_non_nullable
as List<FallOfWicket>,partnerships: null == partnerships ? _self.partnerships : partnerships // ignore: cast_nullable_to_non_nullable
as List<Partnership>,dismissals: null == dismissals ? _self.dismissals : dismissals // ignore: cast_nullable_to_non_nullable
as Map<String, Wicket>,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int?,freeHitPending: null == freeHitPending ? _self.freeHitPending : freeHitPending // ignore: cast_nullable_to_non_nullable
as bool,ballsThisOver: null == ballsThisOver ? _self.ballsThisOver : ballsThisOver // ignore: cast_nullable_to_non_nullable
as int,runsConcededThisOver: null == runsConcededThisOver ? _self.runsConcededThisOver : runsConcededThisOver // ignore: cast_nullable_to_non_nullable
as int,battingSquadSize: null == battingSquadSize ? _self.battingSquadSize : battingSquadSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of InningsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtrasCopyWith<$Res> get extras {
  
  return $ExtrasCopyWith<$Res>(_self.extras, (value) {
    return _then(_self.copyWith(extras: value));
  });
}
}


/// Adds pattern-matching-related methods to [InningsState].
extension InningsStatePatterns on InningsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InningsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InningsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InningsState value)  $default,){
final _that = this;
switch (_that) {
case _InningsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InningsState value)?  $default,){
final _that = this;
switch (_that) {
case _InningsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String battingTeamId,  String bowlingTeamId,  int totalRuns,  int wickets,  int legalBalls,  String? strikerId,  String? nonStrikerId,  String? bowlerId,  String? previousBowlerId,  Extras extras,  Map<String, BatterCard> batters,  Map<String, BowlerCard> bowlers,  List<FallOfWicket> fow,  List<Partnership> partnerships,  Map<String, Wicket> dismissals,  int? target,  bool freeHitPending,  int ballsThisOver,  int runsConcededThisOver,  int battingSquadSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InningsState() when $default != null:
return $default(_that.battingTeamId,_that.bowlingTeamId,_that.totalRuns,_that.wickets,_that.legalBalls,_that.strikerId,_that.nonStrikerId,_that.bowlerId,_that.previousBowlerId,_that.extras,_that.batters,_that.bowlers,_that.fow,_that.partnerships,_that.dismissals,_that.target,_that.freeHitPending,_that.ballsThisOver,_that.runsConcededThisOver,_that.battingSquadSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String battingTeamId,  String bowlingTeamId,  int totalRuns,  int wickets,  int legalBalls,  String? strikerId,  String? nonStrikerId,  String? bowlerId,  String? previousBowlerId,  Extras extras,  Map<String, BatterCard> batters,  Map<String, BowlerCard> bowlers,  List<FallOfWicket> fow,  List<Partnership> partnerships,  Map<String, Wicket> dismissals,  int? target,  bool freeHitPending,  int ballsThisOver,  int runsConcededThisOver,  int battingSquadSize)  $default,) {final _that = this;
switch (_that) {
case _InningsState():
return $default(_that.battingTeamId,_that.bowlingTeamId,_that.totalRuns,_that.wickets,_that.legalBalls,_that.strikerId,_that.nonStrikerId,_that.bowlerId,_that.previousBowlerId,_that.extras,_that.batters,_that.bowlers,_that.fow,_that.partnerships,_that.dismissals,_that.target,_that.freeHitPending,_that.ballsThisOver,_that.runsConcededThisOver,_that.battingSquadSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String battingTeamId,  String bowlingTeamId,  int totalRuns,  int wickets,  int legalBalls,  String? strikerId,  String? nonStrikerId,  String? bowlerId,  String? previousBowlerId,  Extras extras,  Map<String, BatterCard> batters,  Map<String, BowlerCard> bowlers,  List<FallOfWicket> fow,  List<Partnership> partnerships,  Map<String, Wicket> dismissals,  int? target,  bool freeHitPending,  int ballsThisOver,  int runsConcededThisOver,  int battingSquadSize)?  $default,) {final _that = this;
switch (_that) {
case _InningsState() when $default != null:
return $default(_that.battingTeamId,_that.bowlingTeamId,_that.totalRuns,_that.wickets,_that.legalBalls,_that.strikerId,_that.nonStrikerId,_that.bowlerId,_that.previousBowlerId,_that.extras,_that.batters,_that.bowlers,_that.fow,_that.partnerships,_that.dismissals,_that.target,_that.freeHitPending,_that.ballsThisOver,_that.runsConcededThisOver,_that.battingSquadSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InningsState extends InningsState {
  const _InningsState({required this.battingTeamId, required this.bowlingTeamId, this.totalRuns = 0, this.wickets = 0, this.legalBalls = 0, this.strikerId, this.nonStrikerId, this.bowlerId, this.previousBowlerId, this.extras = const Extras(), final  Map<String, BatterCard> batters = const <String, BatterCard>{}, final  Map<String, BowlerCard> bowlers = const <String, BowlerCard>{}, final  List<FallOfWicket> fow = const <FallOfWicket>[], final  List<Partnership> partnerships = const <Partnership>[], final  Map<String, Wicket> dismissals = const <String, Wicket>{}, this.target, this.freeHitPending = false, this.ballsThisOver = 0, this.runsConcededThisOver = 0, this.battingSquadSize = 0}): _batters = batters,_bowlers = bowlers,_fow = fow,_partnerships = partnerships,_dismissals = dismissals,super._();
  factory _InningsState.fromJson(Map<String, dynamic> json) => _$InningsStateFromJson(json);

@override final  String battingTeamId;
@override final  String bowlingTeamId;
@override@JsonKey() final  int totalRuns;
@override@JsonKey() final  int wickets;
/// Legal balls bowled so far. overs = legalBalls ~/ 6 . legalBalls % 6.
@override@JsonKey() final  int legalBalls;
@override final  String? strikerId;
@override final  String? nonStrikerId;
@override final  String? bowlerId;
/// Bowler of the previous over (may not bowl two in a row).
@override final  String? previousBowlerId;
@override@JsonKey() final  Extras extras;
/// Batter figures keyed by playerId.
 final  Map<String, BatterCard> _batters;
/// Batter figures keyed by playerId.
@override@JsonKey() Map<String, BatterCard> get batters {
  if (_batters is EqualUnmodifiableMapView) return _batters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_batters);
}

/// Bowler figures keyed by playerId.
 final  Map<String, BowlerCard> _bowlers;
/// Bowler figures keyed by playerId.
@override@JsonKey() Map<String, BowlerCard> get bowlers {
  if (_bowlers is EqualUnmodifiableMapView) return _bowlers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_bowlers);
}

 final  List<FallOfWicket> _fow;
@override@JsonKey() List<FallOfWicket> get fow {
  if (_fow is EqualUnmodifiableListView) return _fow;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fow);
}

 final  List<Partnership> _partnerships;
@override@JsonKey() List<Partnership> get partnerships {
  if (_partnerships is EqualUnmodifiableListView) return _partnerships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_partnerships);
}

/// The dismissal for each out batter, keyed by playerId (for scorecard text).
 final  Map<String, Wicket> _dismissals;
/// The dismissal for each out batter, keyed by playerId (for scorecard text).
@override@JsonKey() Map<String, Wicket> get dismissals {
  if (_dismissals is EqualUnmodifiableMapView) return _dismissals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_dismissals);
}

/// Second-innings target (innings1.totalRuns + 1); null in the first innings.
@override final  int? target;
/// The next legal delivery is a free hit.
@override@JsonKey() final  bool freeHitPending;
/// Legal balls bowled in the current over (0..5); resets each over.
@override@JsonKey() final  int ballsThisOver;
/// Runs charged to the current bowler in the current over (for maiden
/// detection); resets each over.
@override@JsonKey() final  int runsConcededThisOver;
/// Players actually available to bat for this side. 0 = unknown, in which
/// case the all-out check falls back to `rules.playersPerSide`.
@override@JsonKey() final  int battingSquadSize;

/// Create a copy of InningsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InningsStateCopyWith<_InningsState> get copyWith => __$InningsStateCopyWithImpl<_InningsState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InningsStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InningsState&&(identical(other.battingTeamId, battingTeamId) || other.battingTeamId == battingTeamId)&&(identical(other.bowlingTeamId, bowlingTeamId) || other.bowlingTeamId == bowlingTeamId)&&(identical(other.totalRuns, totalRuns) || other.totalRuns == totalRuns)&&(identical(other.wickets, wickets) || other.wickets == wickets)&&(identical(other.legalBalls, legalBalls) || other.legalBalls == legalBalls)&&(identical(other.strikerId, strikerId) || other.strikerId == strikerId)&&(identical(other.nonStrikerId, nonStrikerId) || other.nonStrikerId == nonStrikerId)&&(identical(other.bowlerId, bowlerId) || other.bowlerId == bowlerId)&&(identical(other.previousBowlerId, previousBowlerId) || other.previousBowlerId == previousBowlerId)&&(identical(other.extras, extras) || other.extras == extras)&&const DeepCollectionEquality().equals(other._batters, _batters)&&const DeepCollectionEquality().equals(other._bowlers, _bowlers)&&const DeepCollectionEquality().equals(other._fow, _fow)&&const DeepCollectionEquality().equals(other._partnerships, _partnerships)&&const DeepCollectionEquality().equals(other._dismissals, _dismissals)&&(identical(other.target, target) || other.target == target)&&(identical(other.freeHitPending, freeHitPending) || other.freeHitPending == freeHitPending)&&(identical(other.ballsThisOver, ballsThisOver) || other.ballsThisOver == ballsThisOver)&&(identical(other.runsConcededThisOver, runsConcededThisOver) || other.runsConcededThisOver == runsConcededThisOver)&&(identical(other.battingSquadSize, battingSquadSize) || other.battingSquadSize == battingSquadSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,battingTeamId,bowlingTeamId,totalRuns,wickets,legalBalls,strikerId,nonStrikerId,bowlerId,previousBowlerId,extras,const DeepCollectionEquality().hash(_batters),const DeepCollectionEquality().hash(_bowlers),const DeepCollectionEquality().hash(_fow),const DeepCollectionEquality().hash(_partnerships),const DeepCollectionEquality().hash(_dismissals),target,freeHitPending,ballsThisOver,runsConcededThisOver,battingSquadSize]);

@override
String toString() {
  return 'InningsState(battingTeamId: $battingTeamId, bowlingTeamId: $bowlingTeamId, totalRuns: $totalRuns, wickets: $wickets, legalBalls: $legalBalls, strikerId: $strikerId, nonStrikerId: $nonStrikerId, bowlerId: $bowlerId, previousBowlerId: $previousBowlerId, extras: $extras, batters: $batters, bowlers: $bowlers, fow: $fow, partnerships: $partnerships, dismissals: $dismissals, target: $target, freeHitPending: $freeHitPending, ballsThisOver: $ballsThisOver, runsConcededThisOver: $runsConcededThisOver, battingSquadSize: $battingSquadSize)';
}


}

/// @nodoc
abstract mixin class _$InningsStateCopyWith<$Res> implements $InningsStateCopyWith<$Res> {
  factory _$InningsStateCopyWith(_InningsState value, $Res Function(_InningsState) _then) = __$InningsStateCopyWithImpl;
@override @useResult
$Res call({
 String battingTeamId, String bowlingTeamId, int totalRuns, int wickets, int legalBalls, String? strikerId, String? nonStrikerId, String? bowlerId, String? previousBowlerId, Extras extras, Map<String, BatterCard> batters, Map<String, BowlerCard> bowlers, List<FallOfWicket> fow, List<Partnership> partnerships, Map<String, Wicket> dismissals, int? target, bool freeHitPending, int ballsThisOver, int runsConcededThisOver, int battingSquadSize
});


@override $ExtrasCopyWith<$Res> get extras;

}
/// @nodoc
class __$InningsStateCopyWithImpl<$Res>
    implements _$InningsStateCopyWith<$Res> {
  __$InningsStateCopyWithImpl(this._self, this._then);

  final _InningsState _self;
  final $Res Function(_InningsState) _then;

/// Create a copy of InningsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? battingTeamId = null,Object? bowlingTeamId = null,Object? totalRuns = null,Object? wickets = null,Object? legalBalls = null,Object? strikerId = freezed,Object? nonStrikerId = freezed,Object? bowlerId = freezed,Object? previousBowlerId = freezed,Object? extras = null,Object? batters = null,Object? bowlers = null,Object? fow = null,Object? partnerships = null,Object? dismissals = null,Object? target = freezed,Object? freeHitPending = null,Object? ballsThisOver = null,Object? runsConcededThisOver = null,Object? battingSquadSize = null,}) {
  return _then(_InningsState(
battingTeamId: null == battingTeamId ? _self.battingTeamId : battingTeamId // ignore: cast_nullable_to_non_nullable
as String,bowlingTeamId: null == bowlingTeamId ? _self.bowlingTeamId : bowlingTeamId // ignore: cast_nullable_to_non_nullable
as String,totalRuns: null == totalRuns ? _self.totalRuns : totalRuns // ignore: cast_nullable_to_non_nullable
as int,wickets: null == wickets ? _self.wickets : wickets // ignore: cast_nullable_to_non_nullable
as int,legalBalls: null == legalBalls ? _self.legalBalls : legalBalls // ignore: cast_nullable_to_non_nullable
as int,strikerId: freezed == strikerId ? _self.strikerId : strikerId // ignore: cast_nullable_to_non_nullable
as String?,nonStrikerId: freezed == nonStrikerId ? _self.nonStrikerId : nonStrikerId // ignore: cast_nullable_to_non_nullable
as String?,bowlerId: freezed == bowlerId ? _self.bowlerId : bowlerId // ignore: cast_nullable_to_non_nullable
as String?,previousBowlerId: freezed == previousBowlerId ? _self.previousBowlerId : previousBowlerId // ignore: cast_nullable_to_non_nullable
as String?,extras: null == extras ? _self.extras : extras // ignore: cast_nullable_to_non_nullable
as Extras,batters: null == batters ? _self._batters : batters // ignore: cast_nullable_to_non_nullable
as Map<String, BatterCard>,bowlers: null == bowlers ? _self._bowlers : bowlers // ignore: cast_nullable_to_non_nullable
as Map<String, BowlerCard>,fow: null == fow ? _self._fow : fow // ignore: cast_nullable_to_non_nullable
as List<FallOfWicket>,partnerships: null == partnerships ? _self._partnerships : partnerships // ignore: cast_nullable_to_non_nullable
as List<Partnership>,dismissals: null == dismissals ? _self._dismissals : dismissals // ignore: cast_nullable_to_non_nullable
as Map<String, Wicket>,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int?,freeHitPending: null == freeHitPending ? _self.freeHitPending : freeHitPending // ignore: cast_nullable_to_non_nullable
as bool,ballsThisOver: null == ballsThisOver ? _self.ballsThisOver : ballsThisOver // ignore: cast_nullable_to_non_nullable
as int,runsConcededThisOver: null == runsConcededThisOver ? _self.runsConcededThisOver : runsConcededThisOver // ignore: cast_nullable_to_non_nullable
as int,battingSquadSize: null == battingSquadSize ? _self.battingSquadSize : battingSquadSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of InningsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtrasCopyWith<$Res> get extras {
  
  return $ExtrasCopyWith<$Res>(_self.extras, (value) {
    return _then(_self.copyWith(extras: value));
  });
}
}

// dart format on
