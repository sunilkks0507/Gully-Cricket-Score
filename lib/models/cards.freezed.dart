// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cards.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BatterCard {

 String get playerId; int get runs; int get balls; int get fours; int get sixes;/// True once dismissed (a wicket). Retired-hurt/absent are tracked via
/// [isRetiredNotOut], not this flag.
 bool get isOut;/// Left the crease not out (retired hurt / absent) — can return.
 bool get isRetiredNotOut;/// Human-readable dismissal, e.g. "c Sharma b Khan" (set on dismissal).
 String? get dismissalText;
/// Create a copy of BatterCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BatterCardCopyWith<BatterCard> get copyWith => _$BatterCardCopyWithImpl<BatterCard>(this as BatterCard, _$identity);

  /// Serializes this BatterCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BatterCard&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.runs, runs) || other.runs == runs)&&(identical(other.balls, balls) || other.balls == balls)&&(identical(other.fours, fours) || other.fours == fours)&&(identical(other.sixes, sixes) || other.sixes == sixes)&&(identical(other.isOut, isOut) || other.isOut == isOut)&&(identical(other.isRetiredNotOut, isRetiredNotOut) || other.isRetiredNotOut == isRetiredNotOut)&&(identical(other.dismissalText, dismissalText) || other.dismissalText == dismissalText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,runs,balls,fours,sixes,isOut,isRetiredNotOut,dismissalText);

@override
String toString() {
  return 'BatterCard(playerId: $playerId, runs: $runs, balls: $balls, fours: $fours, sixes: $sixes, isOut: $isOut, isRetiredNotOut: $isRetiredNotOut, dismissalText: $dismissalText)';
}


}

/// @nodoc
abstract mixin class $BatterCardCopyWith<$Res>  {
  factory $BatterCardCopyWith(BatterCard value, $Res Function(BatterCard) _then) = _$BatterCardCopyWithImpl;
@useResult
$Res call({
 String playerId, int runs, int balls, int fours, int sixes, bool isOut, bool isRetiredNotOut, String? dismissalText
});




}
/// @nodoc
class _$BatterCardCopyWithImpl<$Res>
    implements $BatterCardCopyWith<$Res> {
  _$BatterCardCopyWithImpl(this._self, this._then);

  final BatterCard _self;
  final $Res Function(BatterCard) _then;

/// Create a copy of BatterCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? runs = null,Object? balls = null,Object? fours = null,Object? sixes = null,Object? isOut = null,Object? isRetiredNotOut = null,Object? dismissalText = freezed,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,runs: null == runs ? _self.runs : runs // ignore: cast_nullable_to_non_nullable
as int,balls: null == balls ? _self.balls : balls // ignore: cast_nullable_to_non_nullable
as int,fours: null == fours ? _self.fours : fours // ignore: cast_nullable_to_non_nullable
as int,sixes: null == sixes ? _self.sixes : sixes // ignore: cast_nullable_to_non_nullable
as int,isOut: null == isOut ? _self.isOut : isOut // ignore: cast_nullable_to_non_nullable
as bool,isRetiredNotOut: null == isRetiredNotOut ? _self.isRetiredNotOut : isRetiredNotOut // ignore: cast_nullable_to_non_nullable
as bool,dismissalText: freezed == dismissalText ? _self.dismissalText : dismissalText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BatterCard].
extension BatterCardPatterns on BatterCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BatterCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BatterCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BatterCard value)  $default,){
final _that = this;
switch (_that) {
case _BatterCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BatterCard value)?  $default,){
final _that = this;
switch (_that) {
case _BatterCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  int runs,  int balls,  int fours,  int sixes,  bool isOut,  bool isRetiredNotOut,  String? dismissalText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BatterCard() when $default != null:
return $default(_that.playerId,_that.runs,_that.balls,_that.fours,_that.sixes,_that.isOut,_that.isRetiredNotOut,_that.dismissalText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  int runs,  int balls,  int fours,  int sixes,  bool isOut,  bool isRetiredNotOut,  String? dismissalText)  $default,) {final _that = this;
switch (_that) {
case _BatterCard():
return $default(_that.playerId,_that.runs,_that.balls,_that.fours,_that.sixes,_that.isOut,_that.isRetiredNotOut,_that.dismissalText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  int runs,  int balls,  int fours,  int sixes,  bool isOut,  bool isRetiredNotOut,  String? dismissalText)?  $default,) {final _that = this;
switch (_that) {
case _BatterCard() when $default != null:
return $default(_that.playerId,_that.runs,_that.balls,_that.fours,_that.sixes,_that.isOut,_that.isRetiredNotOut,_that.dismissalText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BatterCard extends BatterCard {
  const _BatterCard({required this.playerId, this.runs = 0, this.balls = 0, this.fours = 0, this.sixes = 0, this.isOut = false, this.isRetiredNotOut = false, this.dismissalText}): super._();
  factory _BatterCard.fromJson(Map<String, dynamic> json) => _$BatterCardFromJson(json);

@override final  String playerId;
@override@JsonKey() final  int runs;
@override@JsonKey() final  int balls;
@override@JsonKey() final  int fours;
@override@JsonKey() final  int sixes;
/// True once dismissed (a wicket). Retired-hurt/absent are tracked via
/// [isRetiredNotOut], not this flag.
@override@JsonKey() final  bool isOut;
/// Left the crease not out (retired hurt / absent) — can return.
@override@JsonKey() final  bool isRetiredNotOut;
/// Human-readable dismissal, e.g. "c Sharma b Khan" (set on dismissal).
@override final  String? dismissalText;

/// Create a copy of BatterCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BatterCardCopyWith<_BatterCard> get copyWith => __$BatterCardCopyWithImpl<_BatterCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BatterCardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BatterCard&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.runs, runs) || other.runs == runs)&&(identical(other.balls, balls) || other.balls == balls)&&(identical(other.fours, fours) || other.fours == fours)&&(identical(other.sixes, sixes) || other.sixes == sixes)&&(identical(other.isOut, isOut) || other.isOut == isOut)&&(identical(other.isRetiredNotOut, isRetiredNotOut) || other.isRetiredNotOut == isRetiredNotOut)&&(identical(other.dismissalText, dismissalText) || other.dismissalText == dismissalText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,runs,balls,fours,sixes,isOut,isRetiredNotOut,dismissalText);

@override
String toString() {
  return 'BatterCard(playerId: $playerId, runs: $runs, balls: $balls, fours: $fours, sixes: $sixes, isOut: $isOut, isRetiredNotOut: $isRetiredNotOut, dismissalText: $dismissalText)';
}


}

/// @nodoc
abstract mixin class _$BatterCardCopyWith<$Res> implements $BatterCardCopyWith<$Res> {
  factory _$BatterCardCopyWith(_BatterCard value, $Res Function(_BatterCard) _then) = __$BatterCardCopyWithImpl;
@override @useResult
$Res call({
 String playerId, int runs, int balls, int fours, int sixes, bool isOut, bool isRetiredNotOut, String? dismissalText
});




}
/// @nodoc
class __$BatterCardCopyWithImpl<$Res>
    implements _$BatterCardCopyWith<$Res> {
  __$BatterCardCopyWithImpl(this._self, this._then);

  final _BatterCard _self;
  final $Res Function(_BatterCard) _then;

/// Create a copy of BatterCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? runs = null,Object? balls = null,Object? fours = null,Object? sixes = null,Object? isOut = null,Object? isRetiredNotOut = null,Object? dismissalText = freezed,}) {
  return _then(_BatterCard(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,runs: null == runs ? _self.runs : runs // ignore: cast_nullable_to_non_nullable
as int,balls: null == balls ? _self.balls : balls // ignore: cast_nullable_to_non_nullable
as int,fours: null == fours ? _self.fours : fours // ignore: cast_nullable_to_non_nullable
as int,sixes: null == sixes ? _self.sixes : sixes // ignore: cast_nullable_to_non_nullable
as int,isOut: null == isOut ? _self.isOut : isOut // ignore: cast_nullable_to_non_nullable
as bool,isRetiredNotOut: null == isRetiredNotOut ? _self.isRetiredNotOut : isRetiredNotOut // ignore: cast_nullable_to_non_nullable
as bool,dismissalText: freezed == dismissalText ? _self.dismissalText : dismissalText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BowlerCard {

 String get playerId;/// Legal balls bowled (wides/no-balls excluded).
 int get balls;/// Runs conceded (off bat + wides + no-ball penalty; NOT byes/leg-byes).
 int get runsConceded; int get wickets; int get maidens; int get wides; int get noBalls;
/// Create a copy of BowlerCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BowlerCardCopyWith<BowlerCard> get copyWith => _$BowlerCardCopyWithImpl<BowlerCard>(this as BowlerCard, _$identity);

  /// Serializes this BowlerCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BowlerCard&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.balls, balls) || other.balls == balls)&&(identical(other.runsConceded, runsConceded) || other.runsConceded == runsConceded)&&(identical(other.wickets, wickets) || other.wickets == wickets)&&(identical(other.maidens, maidens) || other.maidens == maidens)&&(identical(other.wides, wides) || other.wides == wides)&&(identical(other.noBalls, noBalls) || other.noBalls == noBalls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,balls,runsConceded,wickets,maidens,wides,noBalls);

@override
String toString() {
  return 'BowlerCard(playerId: $playerId, balls: $balls, runsConceded: $runsConceded, wickets: $wickets, maidens: $maidens, wides: $wides, noBalls: $noBalls)';
}


}

/// @nodoc
abstract mixin class $BowlerCardCopyWith<$Res>  {
  factory $BowlerCardCopyWith(BowlerCard value, $Res Function(BowlerCard) _then) = _$BowlerCardCopyWithImpl;
@useResult
$Res call({
 String playerId, int balls, int runsConceded, int wickets, int maidens, int wides, int noBalls
});




}
/// @nodoc
class _$BowlerCardCopyWithImpl<$Res>
    implements $BowlerCardCopyWith<$Res> {
  _$BowlerCardCopyWithImpl(this._self, this._then);

  final BowlerCard _self;
  final $Res Function(BowlerCard) _then;

/// Create a copy of BowlerCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? balls = null,Object? runsConceded = null,Object? wickets = null,Object? maidens = null,Object? wides = null,Object? noBalls = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,balls: null == balls ? _self.balls : balls // ignore: cast_nullable_to_non_nullable
as int,runsConceded: null == runsConceded ? _self.runsConceded : runsConceded // ignore: cast_nullable_to_non_nullable
as int,wickets: null == wickets ? _self.wickets : wickets // ignore: cast_nullable_to_non_nullable
as int,maidens: null == maidens ? _self.maidens : maidens // ignore: cast_nullable_to_non_nullable
as int,wides: null == wides ? _self.wides : wides // ignore: cast_nullable_to_non_nullable
as int,noBalls: null == noBalls ? _self.noBalls : noBalls // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BowlerCard].
extension BowlerCardPatterns on BowlerCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BowlerCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BowlerCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BowlerCard value)  $default,){
final _that = this;
switch (_that) {
case _BowlerCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BowlerCard value)?  $default,){
final _that = this;
switch (_that) {
case _BowlerCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  int balls,  int runsConceded,  int wickets,  int maidens,  int wides,  int noBalls)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BowlerCard() when $default != null:
return $default(_that.playerId,_that.balls,_that.runsConceded,_that.wickets,_that.maidens,_that.wides,_that.noBalls);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  int balls,  int runsConceded,  int wickets,  int maidens,  int wides,  int noBalls)  $default,) {final _that = this;
switch (_that) {
case _BowlerCard():
return $default(_that.playerId,_that.balls,_that.runsConceded,_that.wickets,_that.maidens,_that.wides,_that.noBalls);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  int balls,  int runsConceded,  int wickets,  int maidens,  int wides,  int noBalls)?  $default,) {final _that = this;
switch (_that) {
case _BowlerCard() when $default != null:
return $default(_that.playerId,_that.balls,_that.runsConceded,_that.wickets,_that.maidens,_that.wides,_that.noBalls);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BowlerCard extends BowlerCard {
  const _BowlerCard({required this.playerId, this.balls = 0, this.runsConceded = 0, this.wickets = 0, this.maidens = 0, this.wides = 0, this.noBalls = 0}): super._();
  factory _BowlerCard.fromJson(Map<String, dynamic> json) => _$BowlerCardFromJson(json);

@override final  String playerId;
/// Legal balls bowled (wides/no-balls excluded).
@override@JsonKey() final  int balls;
/// Runs conceded (off bat + wides + no-ball penalty; NOT byes/leg-byes).
@override@JsonKey() final  int runsConceded;
@override@JsonKey() final  int wickets;
@override@JsonKey() final  int maidens;
@override@JsonKey() final  int wides;
@override@JsonKey() final  int noBalls;

/// Create a copy of BowlerCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BowlerCardCopyWith<_BowlerCard> get copyWith => __$BowlerCardCopyWithImpl<_BowlerCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BowlerCardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BowlerCard&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.balls, balls) || other.balls == balls)&&(identical(other.runsConceded, runsConceded) || other.runsConceded == runsConceded)&&(identical(other.wickets, wickets) || other.wickets == wickets)&&(identical(other.maidens, maidens) || other.maidens == maidens)&&(identical(other.wides, wides) || other.wides == wides)&&(identical(other.noBalls, noBalls) || other.noBalls == noBalls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,balls,runsConceded,wickets,maidens,wides,noBalls);

@override
String toString() {
  return 'BowlerCard(playerId: $playerId, balls: $balls, runsConceded: $runsConceded, wickets: $wickets, maidens: $maidens, wides: $wides, noBalls: $noBalls)';
}


}

/// @nodoc
abstract mixin class _$BowlerCardCopyWith<$Res> implements $BowlerCardCopyWith<$Res> {
  factory _$BowlerCardCopyWith(_BowlerCard value, $Res Function(_BowlerCard) _then) = __$BowlerCardCopyWithImpl;
@override @useResult
$Res call({
 String playerId, int balls, int runsConceded, int wickets, int maidens, int wides, int noBalls
});




}
/// @nodoc
class __$BowlerCardCopyWithImpl<$Res>
    implements _$BowlerCardCopyWith<$Res> {
  __$BowlerCardCopyWithImpl(this._self, this._then);

  final _BowlerCard _self;
  final $Res Function(_BowlerCard) _then;

/// Create a copy of BowlerCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? balls = null,Object? runsConceded = null,Object? wickets = null,Object? maidens = null,Object? wides = null,Object? noBalls = null,}) {
  return _then(_BowlerCard(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,balls: null == balls ? _self.balls : balls // ignore: cast_nullable_to_non_nullable
as int,runsConceded: null == runsConceded ? _self.runsConceded : runsConceded // ignore: cast_nullable_to_non_nullable
as int,wickets: null == wickets ? _self.wickets : wickets // ignore: cast_nullable_to_non_nullable
as int,maidens: null == maidens ? _self.maidens : maidens // ignore: cast_nullable_to_non_nullable
as int,wides: null == wides ? _self.wides : wides // ignore: cast_nullable_to_non_nullable
as int,noBalls: null == noBalls ? _self.noBalls : noBalls // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
