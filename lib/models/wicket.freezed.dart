// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wicket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Wicket {

 DismissalType get type;/// The batter dismissed (striker or non-striker; run outs can be either).
 String get outBatterId;/// Catcher / keeper / thrower, when applicable.
 String? get fielderId;/// Bowler credited with the wicket; null for team dismissals (run out,
/// obstructing, timed out, retired out).
 String? get bowlerId;/// Runs completed by the batters before the dismissal on this ball
/// (relevant for run outs).
 int get runsCompletedBeforeOut;/// Gully "one tip one hand" catch flag (metadata for the scorecard label).
 bool get oneTipOneHand;/// Whether the batters had crossed when the dismissal occurred. Drives which
/// end the surviving batter is at (e.g. a caught dismissal where they crossed
/// in the air). For run outs the crossing is derived from completed runs, but
/// this flag can override it.
 bool get battersCrossed;
/// Create a copy of Wicket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WicketCopyWith<Wicket> get copyWith => _$WicketCopyWithImpl<Wicket>(this as Wicket, _$identity);

  /// Serializes this Wicket to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Wicket&&(identical(other.type, type) || other.type == type)&&(identical(other.outBatterId, outBatterId) || other.outBatterId == outBatterId)&&(identical(other.fielderId, fielderId) || other.fielderId == fielderId)&&(identical(other.bowlerId, bowlerId) || other.bowlerId == bowlerId)&&(identical(other.runsCompletedBeforeOut, runsCompletedBeforeOut) || other.runsCompletedBeforeOut == runsCompletedBeforeOut)&&(identical(other.oneTipOneHand, oneTipOneHand) || other.oneTipOneHand == oneTipOneHand)&&(identical(other.battersCrossed, battersCrossed) || other.battersCrossed == battersCrossed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,outBatterId,fielderId,bowlerId,runsCompletedBeforeOut,oneTipOneHand,battersCrossed);

@override
String toString() {
  return 'Wicket(type: $type, outBatterId: $outBatterId, fielderId: $fielderId, bowlerId: $bowlerId, runsCompletedBeforeOut: $runsCompletedBeforeOut, oneTipOneHand: $oneTipOneHand, battersCrossed: $battersCrossed)';
}


}

/// @nodoc
abstract mixin class $WicketCopyWith<$Res>  {
  factory $WicketCopyWith(Wicket value, $Res Function(Wicket) _then) = _$WicketCopyWithImpl;
@useResult
$Res call({
 DismissalType type, String outBatterId, String? fielderId, String? bowlerId, int runsCompletedBeforeOut, bool oneTipOneHand, bool battersCrossed
});




}
/// @nodoc
class _$WicketCopyWithImpl<$Res>
    implements $WicketCopyWith<$Res> {
  _$WicketCopyWithImpl(this._self, this._then);

  final Wicket _self;
  final $Res Function(Wicket) _then;

/// Create a copy of Wicket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? outBatterId = null,Object? fielderId = freezed,Object? bowlerId = freezed,Object? runsCompletedBeforeOut = null,Object? oneTipOneHand = null,Object? battersCrossed = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DismissalType,outBatterId: null == outBatterId ? _self.outBatterId : outBatterId // ignore: cast_nullable_to_non_nullable
as String,fielderId: freezed == fielderId ? _self.fielderId : fielderId // ignore: cast_nullable_to_non_nullable
as String?,bowlerId: freezed == bowlerId ? _self.bowlerId : bowlerId // ignore: cast_nullable_to_non_nullable
as String?,runsCompletedBeforeOut: null == runsCompletedBeforeOut ? _self.runsCompletedBeforeOut : runsCompletedBeforeOut // ignore: cast_nullable_to_non_nullable
as int,oneTipOneHand: null == oneTipOneHand ? _self.oneTipOneHand : oneTipOneHand // ignore: cast_nullable_to_non_nullable
as bool,battersCrossed: null == battersCrossed ? _self.battersCrossed : battersCrossed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Wicket].
extension WicketPatterns on Wicket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Wicket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Wicket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Wicket value)  $default,){
final _that = this;
switch (_that) {
case _Wicket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Wicket value)?  $default,){
final _that = this;
switch (_that) {
case _Wicket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DismissalType type,  String outBatterId,  String? fielderId,  String? bowlerId,  int runsCompletedBeforeOut,  bool oneTipOneHand,  bool battersCrossed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Wicket() when $default != null:
return $default(_that.type,_that.outBatterId,_that.fielderId,_that.bowlerId,_that.runsCompletedBeforeOut,_that.oneTipOneHand,_that.battersCrossed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DismissalType type,  String outBatterId,  String? fielderId,  String? bowlerId,  int runsCompletedBeforeOut,  bool oneTipOneHand,  bool battersCrossed)  $default,) {final _that = this;
switch (_that) {
case _Wicket():
return $default(_that.type,_that.outBatterId,_that.fielderId,_that.bowlerId,_that.runsCompletedBeforeOut,_that.oneTipOneHand,_that.battersCrossed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DismissalType type,  String outBatterId,  String? fielderId,  String? bowlerId,  int runsCompletedBeforeOut,  bool oneTipOneHand,  bool battersCrossed)?  $default,) {final _that = this;
switch (_that) {
case _Wicket() when $default != null:
return $default(_that.type,_that.outBatterId,_that.fielderId,_that.bowlerId,_that.runsCompletedBeforeOut,_that.oneTipOneHand,_that.battersCrossed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Wicket implements Wicket {
  const _Wicket({required this.type, required this.outBatterId, this.fielderId, this.bowlerId, this.runsCompletedBeforeOut = 0, this.oneTipOneHand = false, this.battersCrossed = false});
  factory _Wicket.fromJson(Map<String, dynamic> json) => _$WicketFromJson(json);

@override final  DismissalType type;
/// The batter dismissed (striker or non-striker; run outs can be either).
@override final  String outBatterId;
/// Catcher / keeper / thrower, when applicable.
@override final  String? fielderId;
/// Bowler credited with the wicket; null for team dismissals (run out,
/// obstructing, timed out, retired out).
@override final  String? bowlerId;
/// Runs completed by the batters before the dismissal on this ball
/// (relevant for run outs).
@override@JsonKey() final  int runsCompletedBeforeOut;
/// Gully "one tip one hand" catch flag (metadata for the scorecard label).
@override@JsonKey() final  bool oneTipOneHand;
/// Whether the batters had crossed when the dismissal occurred. Drives which
/// end the surviving batter is at (e.g. a caught dismissal where they crossed
/// in the air). For run outs the crossing is derived from completed runs, but
/// this flag can override it.
@override@JsonKey() final  bool battersCrossed;

/// Create a copy of Wicket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WicketCopyWith<_Wicket> get copyWith => __$WicketCopyWithImpl<_Wicket>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WicketToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Wicket&&(identical(other.type, type) || other.type == type)&&(identical(other.outBatterId, outBatterId) || other.outBatterId == outBatterId)&&(identical(other.fielderId, fielderId) || other.fielderId == fielderId)&&(identical(other.bowlerId, bowlerId) || other.bowlerId == bowlerId)&&(identical(other.runsCompletedBeforeOut, runsCompletedBeforeOut) || other.runsCompletedBeforeOut == runsCompletedBeforeOut)&&(identical(other.oneTipOneHand, oneTipOneHand) || other.oneTipOneHand == oneTipOneHand)&&(identical(other.battersCrossed, battersCrossed) || other.battersCrossed == battersCrossed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,outBatterId,fielderId,bowlerId,runsCompletedBeforeOut,oneTipOneHand,battersCrossed);

@override
String toString() {
  return 'Wicket(type: $type, outBatterId: $outBatterId, fielderId: $fielderId, bowlerId: $bowlerId, runsCompletedBeforeOut: $runsCompletedBeforeOut, oneTipOneHand: $oneTipOneHand, battersCrossed: $battersCrossed)';
}


}

/// @nodoc
abstract mixin class _$WicketCopyWith<$Res> implements $WicketCopyWith<$Res> {
  factory _$WicketCopyWith(_Wicket value, $Res Function(_Wicket) _then) = __$WicketCopyWithImpl;
@override @useResult
$Res call({
 DismissalType type, String outBatterId, String? fielderId, String? bowlerId, int runsCompletedBeforeOut, bool oneTipOneHand, bool battersCrossed
});




}
/// @nodoc
class __$WicketCopyWithImpl<$Res>
    implements _$WicketCopyWith<$Res> {
  __$WicketCopyWithImpl(this._self, this._then);

  final _Wicket _self;
  final $Res Function(_Wicket) _then;

/// Create a copy of Wicket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? outBatterId = null,Object? fielderId = freezed,Object? bowlerId = freezed,Object? runsCompletedBeforeOut = null,Object? oneTipOneHand = null,Object? battersCrossed = null,}) {
  return _then(_Wicket(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DismissalType,outBatterId: null == outBatterId ? _self.outBatterId : outBatterId // ignore: cast_nullable_to_non_nullable
as String,fielderId: freezed == fielderId ? _self.fielderId : fielderId // ignore: cast_nullable_to_non_nullable
as String?,bowlerId: freezed == bowlerId ? _self.bowlerId : bowlerId // ignore: cast_nullable_to_non_nullable
as String?,runsCompletedBeforeOut: null == runsCompletedBeforeOut ? _self.runsCompletedBeforeOut : runsCompletedBeforeOut // ignore: cast_nullable_to_non_nullable
as int,oneTipOneHand: null == oneTipOneHand ? _self.oneTipOneHand : oneTipOneHand // ignore: cast_nullable_to_non_nullable
as bool,battersCrossed: null == battersCrossed ? _self.battersCrossed : battersCrossed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
