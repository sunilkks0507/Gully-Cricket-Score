// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extras.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Extras {

 int get wides; int get noBalls; int get byes; int get legByes; int get penalties;
/// Create a copy of Extras
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtrasCopyWith<Extras> get copyWith => _$ExtrasCopyWithImpl<Extras>(this as Extras, _$identity);

  /// Serializes this Extras to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Extras&&(identical(other.wides, wides) || other.wides == wides)&&(identical(other.noBalls, noBalls) || other.noBalls == noBalls)&&(identical(other.byes, byes) || other.byes == byes)&&(identical(other.legByes, legByes) || other.legByes == legByes)&&(identical(other.penalties, penalties) || other.penalties == penalties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wides,noBalls,byes,legByes,penalties);

@override
String toString() {
  return 'Extras(wides: $wides, noBalls: $noBalls, byes: $byes, legByes: $legByes, penalties: $penalties)';
}


}

/// @nodoc
abstract mixin class $ExtrasCopyWith<$Res>  {
  factory $ExtrasCopyWith(Extras value, $Res Function(Extras) _then) = _$ExtrasCopyWithImpl;
@useResult
$Res call({
 int wides, int noBalls, int byes, int legByes, int penalties
});




}
/// @nodoc
class _$ExtrasCopyWithImpl<$Res>
    implements $ExtrasCopyWith<$Res> {
  _$ExtrasCopyWithImpl(this._self, this._then);

  final Extras _self;
  final $Res Function(Extras) _then;

/// Create a copy of Extras
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wides = null,Object? noBalls = null,Object? byes = null,Object? legByes = null,Object? penalties = null,}) {
  return _then(_self.copyWith(
wides: null == wides ? _self.wides : wides // ignore: cast_nullable_to_non_nullable
as int,noBalls: null == noBalls ? _self.noBalls : noBalls // ignore: cast_nullable_to_non_nullable
as int,byes: null == byes ? _self.byes : byes // ignore: cast_nullable_to_non_nullable
as int,legByes: null == legByes ? _self.legByes : legByes // ignore: cast_nullable_to_non_nullable
as int,penalties: null == penalties ? _self.penalties : penalties // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Extras].
extension ExtrasPatterns on Extras {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Extras value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Extras() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Extras value)  $default,){
final _that = this;
switch (_that) {
case _Extras():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Extras value)?  $default,){
final _that = this;
switch (_that) {
case _Extras() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int wides,  int noBalls,  int byes,  int legByes,  int penalties)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Extras() when $default != null:
return $default(_that.wides,_that.noBalls,_that.byes,_that.legByes,_that.penalties);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int wides,  int noBalls,  int byes,  int legByes,  int penalties)  $default,) {final _that = this;
switch (_that) {
case _Extras():
return $default(_that.wides,_that.noBalls,_that.byes,_that.legByes,_that.penalties);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int wides,  int noBalls,  int byes,  int legByes,  int penalties)?  $default,) {final _that = this;
switch (_that) {
case _Extras() when $default != null:
return $default(_that.wides,_that.noBalls,_that.byes,_that.legByes,_that.penalties);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Extras extends Extras {
  const _Extras({this.wides = 0, this.noBalls = 0, this.byes = 0, this.legByes = 0, this.penalties = 0}): super._();
  factory _Extras.fromJson(Map<String, dynamic> json) => _$ExtrasFromJson(json);

@override@JsonKey() final  int wides;
@override@JsonKey() final  int noBalls;
@override@JsonKey() final  int byes;
@override@JsonKey() final  int legByes;
@override@JsonKey() final  int penalties;

/// Create a copy of Extras
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtrasCopyWith<_Extras> get copyWith => __$ExtrasCopyWithImpl<_Extras>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExtrasToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Extras&&(identical(other.wides, wides) || other.wides == wides)&&(identical(other.noBalls, noBalls) || other.noBalls == noBalls)&&(identical(other.byes, byes) || other.byes == byes)&&(identical(other.legByes, legByes) || other.legByes == legByes)&&(identical(other.penalties, penalties) || other.penalties == penalties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wides,noBalls,byes,legByes,penalties);

@override
String toString() {
  return 'Extras(wides: $wides, noBalls: $noBalls, byes: $byes, legByes: $legByes, penalties: $penalties)';
}


}

/// @nodoc
abstract mixin class _$ExtrasCopyWith<$Res> implements $ExtrasCopyWith<$Res> {
  factory _$ExtrasCopyWith(_Extras value, $Res Function(_Extras) _then) = __$ExtrasCopyWithImpl;
@override @useResult
$Res call({
 int wides, int noBalls, int byes, int legByes, int penalties
});




}
/// @nodoc
class __$ExtrasCopyWithImpl<$Res>
    implements _$ExtrasCopyWith<$Res> {
  __$ExtrasCopyWithImpl(this._self, this._then);

  final _Extras _self;
  final $Res Function(_Extras) _then;

/// Create a copy of Extras
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wides = null,Object? noBalls = null,Object? byes = null,Object? legByes = null,Object? penalties = null,}) {
  return _then(_Extras(
wides: null == wides ? _self.wides : wides // ignore: cast_nullable_to_non_nullable
as int,noBalls: null == noBalls ? _self.noBalls : noBalls // ignore: cast_nullable_to_non_nullable
as int,byes: null == byes ? _self.byes : byes // ignore: cast_nullable_to_non_nullable
as int,legByes: null == legByes ? _self.legByes : legByes // ignore: cast_nullable_to_non_nullable
as int,penalties: null == penalties ? _self.penalties : penalties // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
