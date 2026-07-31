// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ball_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BallEvent {

/// 0 = first innings, 1 = second, higher for super overs.
 int get inningsIndex; String get strikerId;/// The batter at the other end. Null only when a lone batter is carrying on
/// under the last-man-stands rule.
 String? get nonStrikerId; String get bowlerId;/// Runs scored off the bat (credited to the striker). 0..6.
 int get runsOffBat;/// The extra on this delivery, if any.
 ExtraType get extraType;/// Additional runs from the extra (e.g. wide + 4 byes → extraRuns = 4;
/// byes/leg-byes run → extraRuns; penalty runs → extraRuns).
 int get extraRuns;/// True if this delivery is a free hit.
 bool get isFreeHit;/// The dismissal on this delivery, if any.
 Wicket? get wicket;/// The batter coming in after a dismissal on this ball (placed at the out
/// batter's end). Null when no wicket, or when the innings ends (all out /
/// last-man). The engine requires the vacated end filled before the next ball.
 String? get newBatterId;/// Local timestamp — metadata only, never used by engine logic.
 DateTime? get tsLocal;
/// Create a copy of BallEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BallEventCopyWith<BallEvent> get copyWith => _$BallEventCopyWithImpl<BallEvent>(this as BallEvent, _$identity);

  /// Serializes this BallEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BallEvent&&(identical(other.inningsIndex, inningsIndex) || other.inningsIndex == inningsIndex)&&(identical(other.strikerId, strikerId) || other.strikerId == strikerId)&&(identical(other.nonStrikerId, nonStrikerId) || other.nonStrikerId == nonStrikerId)&&(identical(other.bowlerId, bowlerId) || other.bowlerId == bowlerId)&&(identical(other.runsOffBat, runsOffBat) || other.runsOffBat == runsOffBat)&&(identical(other.extraType, extraType) || other.extraType == extraType)&&(identical(other.extraRuns, extraRuns) || other.extraRuns == extraRuns)&&(identical(other.isFreeHit, isFreeHit) || other.isFreeHit == isFreeHit)&&(identical(other.wicket, wicket) || other.wicket == wicket)&&(identical(other.newBatterId, newBatterId) || other.newBatterId == newBatterId)&&(identical(other.tsLocal, tsLocal) || other.tsLocal == tsLocal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inningsIndex,strikerId,nonStrikerId,bowlerId,runsOffBat,extraType,extraRuns,isFreeHit,wicket,newBatterId,tsLocal);

@override
String toString() {
  return 'BallEvent(inningsIndex: $inningsIndex, strikerId: $strikerId, nonStrikerId: $nonStrikerId, bowlerId: $bowlerId, runsOffBat: $runsOffBat, extraType: $extraType, extraRuns: $extraRuns, isFreeHit: $isFreeHit, wicket: $wicket, newBatterId: $newBatterId, tsLocal: $tsLocal)';
}


}

/// @nodoc
abstract mixin class $BallEventCopyWith<$Res>  {
  factory $BallEventCopyWith(BallEvent value, $Res Function(BallEvent) _then) = _$BallEventCopyWithImpl;
@useResult
$Res call({
 int inningsIndex, String strikerId, String? nonStrikerId, String bowlerId, int runsOffBat, ExtraType extraType, int extraRuns, bool isFreeHit, Wicket? wicket, String? newBatterId, DateTime? tsLocal
});


$WicketCopyWith<$Res>? get wicket;

}
/// @nodoc
class _$BallEventCopyWithImpl<$Res>
    implements $BallEventCopyWith<$Res> {
  _$BallEventCopyWithImpl(this._self, this._then);

  final BallEvent _self;
  final $Res Function(BallEvent) _then;

/// Create a copy of BallEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inningsIndex = null,Object? strikerId = null,Object? nonStrikerId = freezed,Object? bowlerId = null,Object? runsOffBat = null,Object? extraType = null,Object? extraRuns = null,Object? isFreeHit = null,Object? wicket = freezed,Object? newBatterId = freezed,Object? tsLocal = freezed,}) {
  return _then(_self.copyWith(
inningsIndex: null == inningsIndex ? _self.inningsIndex : inningsIndex // ignore: cast_nullable_to_non_nullable
as int,strikerId: null == strikerId ? _self.strikerId : strikerId // ignore: cast_nullable_to_non_nullable
as String,nonStrikerId: freezed == nonStrikerId ? _self.nonStrikerId : nonStrikerId // ignore: cast_nullable_to_non_nullable
as String?,bowlerId: null == bowlerId ? _self.bowlerId : bowlerId // ignore: cast_nullable_to_non_nullable
as String,runsOffBat: null == runsOffBat ? _self.runsOffBat : runsOffBat // ignore: cast_nullable_to_non_nullable
as int,extraType: null == extraType ? _self.extraType : extraType // ignore: cast_nullable_to_non_nullable
as ExtraType,extraRuns: null == extraRuns ? _self.extraRuns : extraRuns // ignore: cast_nullable_to_non_nullable
as int,isFreeHit: null == isFreeHit ? _self.isFreeHit : isFreeHit // ignore: cast_nullable_to_non_nullable
as bool,wicket: freezed == wicket ? _self.wicket : wicket // ignore: cast_nullable_to_non_nullable
as Wicket?,newBatterId: freezed == newBatterId ? _self.newBatterId : newBatterId // ignore: cast_nullable_to_non_nullable
as String?,tsLocal: freezed == tsLocal ? _self.tsLocal : tsLocal // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of BallEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WicketCopyWith<$Res>? get wicket {
    if (_self.wicket == null) {
    return null;
  }

  return $WicketCopyWith<$Res>(_self.wicket!, (value) {
    return _then(_self.copyWith(wicket: value));
  });
}
}


/// Adds pattern-matching-related methods to [BallEvent].
extension BallEventPatterns on BallEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BallEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BallEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BallEvent value)  $default,){
final _that = this;
switch (_that) {
case _BallEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BallEvent value)?  $default,){
final _that = this;
switch (_that) {
case _BallEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int inningsIndex,  String strikerId,  String? nonStrikerId,  String bowlerId,  int runsOffBat,  ExtraType extraType,  int extraRuns,  bool isFreeHit,  Wicket? wicket,  String? newBatterId,  DateTime? tsLocal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BallEvent() when $default != null:
return $default(_that.inningsIndex,_that.strikerId,_that.nonStrikerId,_that.bowlerId,_that.runsOffBat,_that.extraType,_that.extraRuns,_that.isFreeHit,_that.wicket,_that.newBatterId,_that.tsLocal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int inningsIndex,  String strikerId,  String? nonStrikerId,  String bowlerId,  int runsOffBat,  ExtraType extraType,  int extraRuns,  bool isFreeHit,  Wicket? wicket,  String? newBatterId,  DateTime? tsLocal)  $default,) {final _that = this;
switch (_that) {
case _BallEvent():
return $default(_that.inningsIndex,_that.strikerId,_that.nonStrikerId,_that.bowlerId,_that.runsOffBat,_that.extraType,_that.extraRuns,_that.isFreeHit,_that.wicket,_that.newBatterId,_that.tsLocal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int inningsIndex,  String strikerId,  String? nonStrikerId,  String bowlerId,  int runsOffBat,  ExtraType extraType,  int extraRuns,  bool isFreeHit,  Wicket? wicket,  String? newBatterId,  DateTime? tsLocal)?  $default,) {final _that = this;
switch (_that) {
case _BallEvent() when $default != null:
return $default(_that.inningsIndex,_that.strikerId,_that.nonStrikerId,_that.bowlerId,_that.runsOffBat,_that.extraType,_that.extraRuns,_that.isFreeHit,_that.wicket,_that.newBatterId,_that.tsLocal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BallEvent implements BallEvent {
  const _BallEvent({required this.inningsIndex, required this.strikerId, required this.nonStrikerId, required this.bowlerId, this.runsOffBat = 0, this.extraType = ExtraType.none, this.extraRuns = 0, this.isFreeHit = false, this.wicket, this.newBatterId, this.tsLocal});
  factory _BallEvent.fromJson(Map<String, dynamic> json) => _$BallEventFromJson(json);

/// 0 = first innings, 1 = second, higher for super overs.
@override final  int inningsIndex;
@override final  String strikerId;
/// The batter at the other end. Null only when a lone batter is carrying on
/// under the last-man-stands rule.
@override final  String? nonStrikerId;
@override final  String bowlerId;
/// Runs scored off the bat (credited to the striker). 0..6.
@override@JsonKey() final  int runsOffBat;
/// The extra on this delivery, if any.
@override@JsonKey() final  ExtraType extraType;
/// Additional runs from the extra (e.g. wide + 4 byes → extraRuns = 4;
/// byes/leg-byes run → extraRuns; penalty runs → extraRuns).
@override@JsonKey() final  int extraRuns;
/// True if this delivery is a free hit.
@override@JsonKey() final  bool isFreeHit;
/// The dismissal on this delivery, if any.
@override final  Wicket? wicket;
/// The batter coming in after a dismissal on this ball (placed at the out
/// batter's end). Null when no wicket, or when the innings ends (all out /
/// last-man). The engine requires the vacated end filled before the next ball.
@override final  String? newBatterId;
/// Local timestamp — metadata only, never used by engine logic.
@override final  DateTime? tsLocal;

/// Create a copy of BallEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BallEventCopyWith<_BallEvent> get copyWith => __$BallEventCopyWithImpl<_BallEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BallEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BallEvent&&(identical(other.inningsIndex, inningsIndex) || other.inningsIndex == inningsIndex)&&(identical(other.strikerId, strikerId) || other.strikerId == strikerId)&&(identical(other.nonStrikerId, nonStrikerId) || other.nonStrikerId == nonStrikerId)&&(identical(other.bowlerId, bowlerId) || other.bowlerId == bowlerId)&&(identical(other.runsOffBat, runsOffBat) || other.runsOffBat == runsOffBat)&&(identical(other.extraType, extraType) || other.extraType == extraType)&&(identical(other.extraRuns, extraRuns) || other.extraRuns == extraRuns)&&(identical(other.isFreeHit, isFreeHit) || other.isFreeHit == isFreeHit)&&(identical(other.wicket, wicket) || other.wicket == wicket)&&(identical(other.newBatterId, newBatterId) || other.newBatterId == newBatterId)&&(identical(other.tsLocal, tsLocal) || other.tsLocal == tsLocal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inningsIndex,strikerId,nonStrikerId,bowlerId,runsOffBat,extraType,extraRuns,isFreeHit,wicket,newBatterId,tsLocal);

@override
String toString() {
  return 'BallEvent(inningsIndex: $inningsIndex, strikerId: $strikerId, nonStrikerId: $nonStrikerId, bowlerId: $bowlerId, runsOffBat: $runsOffBat, extraType: $extraType, extraRuns: $extraRuns, isFreeHit: $isFreeHit, wicket: $wicket, newBatterId: $newBatterId, tsLocal: $tsLocal)';
}


}

/// @nodoc
abstract mixin class _$BallEventCopyWith<$Res> implements $BallEventCopyWith<$Res> {
  factory _$BallEventCopyWith(_BallEvent value, $Res Function(_BallEvent) _then) = __$BallEventCopyWithImpl;
@override @useResult
$Res call({
 int inningsIndex, String strikerId, String? nonStrikerId, String bowlerId, int runsOffBat, ExtraType extraType, int extraRuns, bool isFreeHit, Wicket? wicket, String? newBatterId, DateTime? tsLocal
});


@override $WicketCopyWith<$Res>? get wicket;

}
/// @nodoc
class __$BallEventCopyWithImpl<$Res>
    implements _$BallEventCopyWith<$Res> {
  __$BallEventCopyWithImpl(this._self, this._then);

  final _BallEvent _self;
  final $Res Function(_BallEvent) _then;

/// Create a copy of BallEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inningsIndex = null,Object? strikerId = null,Object? nonStrikerId = freezed,Object? bowlerId = null,Object? runsOffBat = null,Object? extraType = null,Object? extraRuns = null,Object? isFreeHit = null,Object? wicket = freezed,Object? newBatterId = freezed,Object? tsLocal = freezed,}) {
  return _then(_BallEvent(
inningsIndex: null == inningsIndex ? _self.inningsIndex : inningsIndex // ignore: cast_nullable_to_non_nullable
as int,strikerId: null == strikerId ? _self.strikerId : strikerId // ignore: cast_nullable_to_non_nullable
as String,nonStrikerId: freezed == nonStrikerId ? _self.nonStrikerId : nonStrikerId // ignore: cast_nullable_to_non_nullable
as String?,bowlerId: null == bowlerId ? _self.bowlerId : bowlerId // ignore: cast_nullable_to_non_nullable
as String,runsOffBat: null == runsOffBat ? _self.runsOffBat : runsOffBat // ignore: cast_nullable_to_non_nullable
as int,extraType: null == extraType ? _self.extraType : extraType // ignore: cast_nullable_to_non_nullable
as ExtraType,extraRuns: null == extraRuns ? _self.extraRuns : extraRuns // ignore: cast_nullable_to_non_nullable
as int,isFreeHit: null == isFreeHit ? _self.isFreeHit : isFreeHit // ignore: cast_nullable_to_non_nullable
as bool,wicket: freezed == wicket ? _self.wicket : wicket // ignore: cast_nullable_to_non_nullable
as Wicket?,newBatterId: freezed == newBatterId ? _self.newBatterId : newBatterId // ignore: cast_nullable_to_non_nullable
as String?,tsLocal: freezed == tsLocal ? _self.tsLocal : tsLocal // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of BallEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WicketCopyWith<$Res>? get wicket {
    if (_self.wicket == null) {
    return null;
  }

  return $WicketCopyWith<$Res>(_self.wicket!, (value) {
    return _then(_self.copyWith(wicket: value));
  });
}
}

// dart format on
