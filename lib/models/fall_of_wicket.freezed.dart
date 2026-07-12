// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fall_of_wicket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FallOfWicket {

/// 1-based wicket number (1 = first wicket to fall).
 int get wicketNo; String get batterId;/// Team total at the moment of the fall.
 int get scoreAtFall;/// Legal balls bowled at the fall (overs = legalBalls ~/ 6 . % 6).
 int get legalBallsAtFall;
/// Create a copy of FallOfWicket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FallOfWicketCopyWith<FallOfWicket> get copyWith => _$FallOfWicketCopyWithImpl<FallOfWicket>(this as FallOfWicket, _$identity);

  /// Serializes this FallOfWicket to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FallOfWicket&&(identical(other.wicketNo, wicketNo) || other.wicketNo == wicketNo)&&(identical(other.batterId, batterId) || other.batterId == batterId)&&(identical(other.scoreAtFall, scoreAtFall) || other.scoreAtFall == scoreAtFall)&&(identical(other.legalBallsAtFall, legalBallsAtFall) || other.legalBallsAtFall == legalBallsAtFall));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wicketNo,batterId,scoreAtFall,legalBallsAtFall);

@override
String toString() {
  return 'FallOfWicket(wicketNo: $wicketNo, batterId: $batterId, scoreAtFall: $scoreAtFall, legalBallsAtFall: $legalBallsAtFall)';
}


}

/// @nodoc
abstract mixin class $FallOfWicketCopyWith<$Res>  {
  factory $FallOfWicketCopyWith(FallOfWicket value, $Res Function(FallOfWicket) _then) = _$FallOfWicketCopyWithImpl;
@useResult
$Res call({
 int wicketNo, String batterId, int scoreAtFall, int legalBallsAtFall
});




}
/// @nodoc
class _$FallOfWicketCopyWithImpl<$Res>
    implements $FallOfWicketCopyWith<$Res> {
  _$FallOfWicketCopyWithImpl(this._self, this._then);

  final FallOfWicket _self;
  final $Res Function(FallOfWicket) _then;

/// Create a copy of FallOfWicket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wicketNo = null,Object? batterId = null,Object? scoreAtFall = null,Object? legalBallsAtFall = null,}) {
  return _then(_self.copyWith(
wicketNo: null == wicketNo ? _self.wicketNo : wicketNo // ignore: cast_nullable_to_non_nullable
as int,batterId: null == batterId ? _self.batterId : batterId // ignore: cast_nullable_to_non_nullable
as String,scoreAtFall: null == scoreAtFall ? _self.scoreAtFall : scoreAtFall // ignore: cast_nullable_to_non_nullable
as int,legalBallsAtFall: null == legalBallsAtFall ? _self.legalBallsAtFall : legalBallsAtFall // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FallOfWicket].
extension FallOfWicketPatterns on FallOfWicket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FallOfWicket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FallOfWicket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FallOfWicket value)  $default,){
final _that = this;
switch (_that) {
case _FallOfWicket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FallOfWicket value)?  $default,){
final _that = this;
switch (_that) {
case _FallOfWicket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int wicketNo,  String batterId,  int scoreAtFall,  int legalBallsAtFall)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FallOfWicket() when $default != null:
return $default(_that.wicketNo,_that.batterId,_that.scoreAtFall,_that.legalBallsAtFall);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int wicketNo,  String batterId,  int scoreAtFall,  int legalBallsAtFall)  $default,) {final _that = this;
switch (_that) {
case _FallOfWicket():
return $default(_that.wicketNo,_that.batterId,_that.scoreAtFall,_that.legalBallsAtFall);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int wicketNo,  String batterId,  int scoreAtFall,  int legalBallsAtFall)?  $default,) {final _that = this;
switch (_that) {
case _FallOfWicket() when $default != null:
return $default(_that.wicketNo,_that.batterId,_that.scoreAtFall,_that.legalBallsAtFall);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FallOfWicket extends FallOfWicket {
  const _FallOfWicket({required this.wicketNo, required this.batterId, required this.scoreAtFall, required this.legalBallsAtFall}): super._();
  factory _FallOfWicket.fromJson(Map<String, dynamic> json) => _$FallOfWicketFromJson(json);

/// 1-based wicket number (1 = first wicket to fall).
@override final  int wicketNo;
@override final  String batterId;
/// Team total at the moment of the fall.
@override final  int scoreAtFall;
/// Legal balls bowled at the fall (overs = legalBalls ~/ 6 . % 6).
@override final  int legalBallsAtFall;

/// Create a copy of FallOfWicket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FallOfWicketCopyWith<_FallOfWicket> get copyWith => __$FallOfWicketCopyWithImpl<_FallOfWicket>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FallOfWicketToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FallOfWicket&&(identical(other.wicketNo, wicketNo) || other.wicketNo == wicketNo)&&(identical(other.batterId, batterId) || other.batterId == batterId)&&(identical(other.scoreAtFall, scoreAtFall) || other.scoreAtFall == scoreAtFall)&&(identical(other.legalBallsAtFall, legalBallsAtFall) || other.legalBallsAtFall == legalBallsAtFall));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wicketNo,batterId,scoreAtFall,legalBallsAtFall);

@override
String toString() {
  return 'FallOfWicket(wicketNo: $wicketNo, batterId: $batterId, scoreAtFall: $scoreAtFall, legalBallsAtFall: $legalBallsAtFall)';
}


}

/// @nodoc
abstract mixin class _$FallOfWicketCopyWith<$Res> implements $FallOfWicketCopyWith<$Res> {
  factory _$FallOfWicketCopyWith(_FallOfWicket value, $Res Function(_FallOfWicket) _then) = __$FallOfWicketCopyWithImpl;
@override @useResult
$Res call({
 int wicketNo, String batterId, int scoreAtFall, int legalBallsAtFall
});




}
/// @nodoc
class __$FallOfWicketCopyWithImpl<$Res>
    implements _$FallOfWicketCopyWith<$Res> {
  __$FallOfWicketCopyWithImpl(this._self, this._then);

  final _FallOfWicket _self;
  final $Res Function(_FallOfWicket) _then;

/// Create a copy of FallOfWicket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wicketNo = null,Object? batterId = null,Object? scoreAtFall = null,Object? legalBallsAtFall = null,}) {
  return _then(_FallOfWicket(
wicketNo: null == wicketNo ? _self.wicketNo : wicketNo // ignore: cast_nullable_to_non_nullable
as int,batterId: null == batterId ? _self.batterId : batterId // ignore: cast_nullable_to_non_nullable
as String,scoreAtFall: null == scoreAtFall ? _self.scoreAtFall : scoreAtFall // ignore: cast_nullable_to_non_nullable
as int,legalBallsAtFall: null == legalBallsAtFall ? _self.legalBallsAtFall : legalBallsAtFall // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Partnership {

/// The wicket this partnership is for (1 = opening partnership).
 int get forWicket; String get batterAId; String get batterBId; int get runs; int get balls;/// True while this partnership is still in progress.
 bool get unbroken;
/// Create a copy of Partnership
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartnershipCopyWith<Partnership> get copyWith => _$PartnershipCopyWithImpl<Partnership>(this as Partnership, _$identity);

  /// Serializes this Partnership to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Partnership&&(identical(other.forWicket, forWicket) || other.forWicket == forWicket)&&(identical(other.batterAId, batterAId) || other.batterAId == batterAId)&&(identical(other.batterBId, batterBId) || other.batterBId == batterBId)&&(identical(other.runs, runs) || other.runs == runs)&&(identical(other.balls, balls) || other.balls == balls)&&(identical(other.unbroken, unbroken) || other.unbroken == unbroken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forWicket,batterAId,batterBId,runs,balls,unbroken);

@override
String toString() {
  return 'Partnership(forWicket: $forWicket, batterAId: $batterAId, batterBId: $batterBId, runs: $runs, balls: $balls, unbroken: $unbroken)';
}


}

/// @nodoc
abstract mixin class $PartnershipCopyWith<$Res>  {
  factory $PartnershipCopyWith(Partnership value, $Res Function(Partnership) _then) = _$PartnershipCopyWithImpl;
@useResult
$Res call({
 int forWicket, String batterAId, String batterBId, int runs, int balls, bool unbroken
});




}
/// @nodoc
class _$PartnershipCopyWithImpl<$Res>
    implements $PartnershipCopyWith<$Res> {
  _$PartnershipCopyWithImpl(this._self, this._then);

  final Partnership _self;
  final $Res Function(Partnership) _then;

/// Create a copy of Partnership
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? forWicket = null,Object? batterAId = null,Object? batterBId = null,Object? runs = null,Object? balls = null,Object? unbroken = null,}) {
  return _then(_self.copyWith(
forWicket: null == forWicket ? _self.forWicket : forWicket // ignore: cast_nullable_to_non_nullable
as int,batterAId: null == batterAId ? _self.batterAId : batterAId // ignore: cast_nullable_to_non_nullable
as String,batterBId: null == batterBId ? _self.batterBId : batterBId // ignore: cast_nullable_to_non_nullable
as String,runs: null == runs ? _self.runs : runs // ignore: cast_nullable_to_non_nullable
as int,balls: null == balls ? _self.balls : balls // ignore: cast_nullable_to_non_nullable
as int,unbroken: null == unbroken ? _self.unbroken : unbroken // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Partnership].
extension PartnershipPatterns on Partnership {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Partnership value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Partnership() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Partnership value)  $default,){
final _that = this;
switch (_that) {
case _Partnership():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Partnership value)?  $default,){
final _that = this;
switch (_that) {
case _Partnership() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int forWicket,  String batterAId,  String batterBId,  int runs,  int balls,  bool unbroken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Partnership() when $default != null:
return $default(_that.forWicket,_that.batterAId,_that.batterBId,_that.runs,_that.balls,_that.unbroken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int forWicket,  String batterAId,  String batterBId,  int runs,  int balls,  bool unbroken)  $default,) {final _that = this;
switch (_that) {
case _Partnership():
return $default(_that.forWicket,_that.batterAId,_that.batterBId,_that.runs,_that.balls,_that.unbroken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int forWicket,  String batterAId,  String batterBId,  int runs,  int balls,  bool unbroken)?  $default,) {final _that = this;
switch (_that) {
case _Partnership() when $default != null:
return $default(_that.forWicket,_that.batterAId,_that.batterBId,_that.runs,_that.balls,_that.unbroken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Partnership implements Partnership {
  const _Partnership({required this.forWicket, required this.batterAId, required this.batterBId, this.runs = 0, this.balls = 0, this.unbroken = true});
  factory _Partnership.fromJson(Map<String, dynamic> json) => _$PartnershipFromJson(json);

/// The wicket this partnership is for (1 = opening partnership).
@override final  int forWicket;
@override final  String batterAId;
@override final  String batterBId;
@override@JsonKey() final  int runs;
@override@JsonKey() final  int balls;
/// True while this partnership is still in progress.
@override@JsonKey() final  bool unbroken;

/// Create a copy of Partnership
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartnershipCopyWith<_Partnership> get copyWith => __$PartnershipCopyWithImpl<_Partnership>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartnershipToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Partnership&&(identical(other.forWicket, forWicket) || other.forWicket == forWicket)&&(identical(other.batterAId, batterAId) || other.batterAId == batterAId)&&(identical(other.batterBId, batterBId) || other.batterBId == batterBId)&&(identical(other.runs, runs) || other.runs == runs)&&(identical(other.balls, balls) || other.balls == balls)&&(identical(other.unbroken, unbroken) || other.unbroken == unbroken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forWicket,batterAId,batterBId,runs,balls,unbroken);

@override
String toString() {
  return 'Partnership(forWicket: $forWicket, batterAId: $batterAId, batterBId: $batterBId, runs: $runs, balls: $balls, unbroken: $unbroken)';
}


}

/// @nodoc
abstract mixin class _$PartnershipCopyWith<$Res> implements $PartnershipCopyWith<$Res> {
  factory _$PartnershipCopyWith(_Partnership value, $Res Function(_Partnership) _then) = __$PartnershipCopyWithImpl;
@override @useResult
$Res call({
 int forWicket, String batterAId, String batterBId, int runs, int balls, bool unbroken
});




}
/// @nodoc
class __$PartnershipCopyWithImpl<$Res>
    implements _$PartnershipCopyWith<$Res> {
  __$PartnershipCopyWithImpl(this._self, this._then);

  final _Partnership _self;
  final $Res Function(_Partnership) _then;

/// Create a copy of Partnership
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? forWicket = null,Object? batterAId = null,Object? batterBId = null,Object? runs = null,Object? balls = null,Object? unbroken = null,}) {
  return _then(_Partnership(
forWicket: null == forWicket ? _self.forWicket : forWicket // ignore: cast_nullable_to_non_nullable
as int,batterAId: null == batterAId ? _self.batterAId : batterAId // ignore: cast_nullable_to_non_nullable
as String,batterBId: null == batterBId ? _self.batterBId : batterBId // ignore: cast_nullable_to_non_nullable
as String,runs: null == runs ? _self.runs : runs // ignore: cast_nullable_to_non_nullable
as int,balls: null == balls ? _self.balls : balls // ignore: cast_nullable_to_non_nullable
as int,unbroken: null == unbroken ? _self.unbroken : unbroken // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
