// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scorecard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BatterLine {

 String get playerId; String get name; int get runs; int get balls; int get fours; int get sixes; double get strikeRate;/// e.g. "c Sharma b Khan", "not out", "run out (Patel)".
 String get dismissalText; bool get notOut;
/// Create a copy of BatterLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BatterLineCopyWith<BatterLine> get copyWith => _$BatterLineCopyWithImpl<BatterLine>(this as BatterLine, _$identity);

  /// Serializes this BatterLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BatterLine&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.runs, runs) || other.runs == runs)&&(identical(other.balls, balls) || other.balls == balls)&&(identical(other.fours, fours) || other.fours == fours)&&(identical(other.sixes, sixes) || other.sixes == sixes)&&(identical(other.strikeRate, strikeRate) || other.strikeRate == strikeRate)&&(identical(other.dismissalText, dismissalText) || other.dismissalText == dismissalText)&&(identical(other.notOut, notOut) || other.notOut == notOut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,runs,balls,fours,sixes,strikeRate,dismissalText,notOut);

@override
String toString() {
  return 'BatterLine(playerId: $playerId, name: $name, runs: $runs, balls: $balls, fours: $fours, sixes: $sixes, strikeRate: $strikeRate, dismissalText: $dismissalText, notOut: $notOut)';
}


}

/// @nodoc
abstract mixin class $BatterLineCopyWith<$Res>  {
  factory $BatterLineCopyWith(BatterLine value, $Res Function(BatterLine) _then) = _$BatterLineCopyWithImpl;
@useResult
$Res call({
 String playerId, String name, int runs, int balls, int fours, int sixes, double strikeRate, String dismissalText, bool notOut
});




}
/// @nodoc
class _$BatterLineCopyWithImpl<$Res>
    implements $BatterLineCopyWith<$Res> {
  _$BatterLineCopyWithImpl(this._self, this._then);

  final BatterLine _self;
  final $Res Function(BatterLine) _then;

/// Create a copy of BatterLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? name = null,Object? runs = null,Object? balls = null,Object? fours = null,Object? sixes = null,Object? strikeRate = null,Object? dismissalText = null,Object? notOut = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,runs: null == runs ? _self.runs : runs // ignore: cast_nullable_to_non_nullable
as int,balls: null == balls ? _self.balls : balls // ignore: cast_nullable_to_non_nullable
as int,fours: null == fours ? _self.fours : fours // ignore: cast_nullable_to_non_nullable
as int,sixes: null == sixes ? _self.sixes : sixes // ignore: cast_nullable_to_non_nullable
as int,strikeRate: null == strikeRate ? _self.strikeRate : strikeRate // ignore: cast_nullable_to_non_nullable
as double,dismissalText: null == dismissalText ? _self.dismissalText : dismissalText // ignore: cast_nullable_to_non_nullable
as String,notOut: null == notOut ? _self.notOut : notOut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BatterLine].
extension BatterLinePatterns on BatterLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BatterLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BatterLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BatterLine value)  $default,){
final _that = this;
switch (_that) {
case _BatterLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BatterLine value)?  $default,){
final _that = this;
switch (_that) {
case _BatterLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  String name,  int runs,  int balls,  int fours,  int sixes,  double strikeRate,  String dismissalText,  bool notOut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BatterLine() when $default != null:
return $default(_that.playerId,_that.name,_that.runs,_that.balls,_that.fours,_that.sixes,_that.strikeRate,_that.dismissalText,_that.notOut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  String name,  int runs,  int balls,  int fours,  int sixes,  double strikeRate,  String dismissalText,  bool notOut)  $default,) {final _that = this;
switch (_that) {
case _BatterLine():
return $default(_that.playerId,_that.name,_that.runs,_that.balls,_that.fours,_that.sixes,_that.strikeRate,_that.dismissalText,_that.notOut);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  String name,  int runs,  int balls,  int fours,  int sixes,  double strikeRate,  String dismissalText,  bool notOut)?  $default,) {final _that = this;
switch (_that) {
case _BatterLine() when $default != null:
return $default(_that.playerId,_that.name,_that.runs,_that.balls,_that.fours,_that.sixes,_that.strikeRate,_that.dismissalText,_that.notOut);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BatterLine implements BatterLine {
  const _BatterLine({required this.playerId, required this.name, required this.runs, required this.balls, required this.fours, required this.sixes, required this.strikeRate, required this.dismissalText, required this.notOut});
  factory _BatterLine.fromJson(Map<String, dynamic> json) => _$BatterLineFromJson(json);

@override final  String playerId;
@override final  String name;
@override final  int runs;
@override final  int balls;
@override final  int fours;
@override final  int sixes;
@override final  double strikeRate;
/// e.g. "c Sharma b Khan", "not out", "run out (Patel)".
@override final  String dismissalText;
@override final  bool notOut;

/// Create a copy of BatterLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BatterLineCopyWith<_BatterLine> get copyWith => __$BatterLineCopyWithImpl<_BatterLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BatterLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BatterLine&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.runs, runs) || other.runs == runs)&&(identical(other.balls, balls) || other.balls == balls)&&(identical(other.fours, fours) || other.fours == fours)&&(identical(other.sixes, sixes) || other.sixes == sixes)&&(identical(other.strikeRate, strikeRate) || other.strikeRate == strikeRate)&&(identical(other.dismissalText, dismissalText) || other.dismissalText == dismissalText)&&(identical(other.notOut, notOut) || other.notOut == notOut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,runs,balls,fours,sixes,strikeRate,dismissalText,notOut);

@override
String toString() {
  return 'BatterLine(playerId: $playerId, name: $name, runs: $runs, balls: $balls, fours: $fours, sixes: $sixes, strikeRate: $strikeRate, dismissalText: $dismissalText, notOut: $notOut)';
}


}

/// @nodoc
abstract mixin class _$BatterLineCopyWith<$Res> implements $BatterLineCopyWith<$Res> {
  factory _$BatterLineCopyWith(_BatterLine value, $Res Function(_BatterLine) _then) = __$BatterLineCopyWithImpl;
@override @useResult
$Res call({
 String playerId, String name, int runs, int balls, int fours, int sixes, double strikeRate, String dismissalText, bool notOut
});




}
/// @nodoc
class __$BatterLineCopyWithImpl<$Res>
    implements _$BatterLineCopyWith<$Res> {
  __$BatterLineCopyWithImpl(this._self, this._then);

  final _BatterLine _self;
  final $Res Function(_BatterLine) _then;

/// Create a copy of BatterLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? name = null,Object? runs = null,Object? balls = null,Object? fours = null,Object? sixes = null,Object? strikeRate = null,Object? dismissalText = null,Object? notOut = null,}) {
  return _then(_BatterLine(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,runs: null == runs ? _self.runs : runs // ignore: cast_nullable_to_non_nullable
as int,balls: null == balls ? _self.balls : balls // ignore: cast_nullable_to_non_nullable
as int,fours: null == fours ? _self.fours : fours // ignore: cast_nullable_to_non_nullable
as int,sixes: null == sixes ? _self.sixes : sixes // ignore: cast_nullable_to_non_nullable
as int,strikeRate: null == strikeRate ? _self.strikeRate : strikeRate // ignore: cast_nullable_to_non_nullable
as double,dismissalText: null == dismissalText ? _self.dismissalText : dismissalText // ignore: cast_nullable_to_non_nullable
as String,notOut: null == notOut ? _self.notOut : notOut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$BowlerLine {

 String get playerId; String get name; String get oversText; int get maidens; int get runs; int get wickets; double get economy; int get wides; int get noBalls;
/// Create a copy of BowlerLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BowlerLineCopyWith<BowlerLine> get copyWith => _$BowlerLineCopyWithImpl<BowlerLine>(this as BowlerLine, _$identity);

  /// Serializes this BowlerLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BowlerLine&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.oversText, oversText) || other.oversText == oversText)&&(identical(other.maidens, maidens) || other.maidens == maidens)&&(identical(other.runs, runs) || other.runs == runs)&&(identical(other.wickets, wickets) || other.wickets == wickets)&&(identical(other.economy, economy) || other.economy == economy)&&(identical(other.wides, wides) || other.wides == wides)&&(identical(other.noBalls, noBalls) || other.noBalls == noBalls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,oversText,maidens,runs,wickets,economy,wides,noBalls);

@override
String toString() {
  return 'BowlerLine(playerId: $playerId, name: $name, oversText: $oversText, maidens: $maidens, runs: $runs, wickets: $wickets, economy: $economy, wides: $wides, noBalls: $noBalls)';
}


}

/// @nodoc
abstract mixin class $BowlerLineCopyWith<$Res>  {
  factory $BowlerLineCopyWith(BowlerLine value, $Res Function(BowlerLine) _then) = _$BowlerLineCopyWithImpl;
@useResult
$Res call({
 String playerId, String name, String oversText, int maidens, int runs, int wickets, double economy, int wides, int noBalls
});




}
/// @nodoc
class _$BowlerLineCopyWithImpl<$Res>
    implements $BowlerLineCopyWith<$Res> {
  _$BowlerLineCopyWithImpl(this._self, this._then);

  final BowlerLine _self;
  final $Res Function(BowlerLine) _then;

/// Create a copy of BowlerLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? name = null,Object? oversText = null,Object? maidens = null,Object? runs = null,Object? wickets = null,Object? economy = null,Object? wides = null,Object? noBalls = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,oversText: null == oversText ? _self.oversText : oversText // ignore: cast_nullable_to_non_nullable
as String,maidens: null == maidens ? _self.maidens : maidens // ignore: cast_nullable_to_non_nullable
as int,runs: null == runs ? _self.runs : runs // ignore: cast_nullable_to_non_nullable
as int,wickets: null == wickets ? _self.wickets : wickets // ignore: cast_nullable_to_non_nullable
as int,economy: null == economy ? _self.economy : economy // ignore: cast_nullable_to_non_nullable
as double,wides: null == wides ? _self.wides : wides // ignore: cast_nullable_to_non_nullable
as int,noBalls: null == noBalls ? _self.noBalls : noBalls // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BowlerLine].
extension BowlerLinePatterns on BowlerLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BowlerLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BowlerLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BowlerLine value)  $default,){
final _that = this;
switch (_that) {
case _BowlerLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BowlerLine value)?  $default,){
final _that = this;
switch (_that) {
case _BowlerLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  String name,  String oversText,  int maidens,  int runs,  int wickets,  double economy,  int wides,  int noBalls)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BowlerLine() when $default != null:
return $default(_that.playerId,_that.name,_that.oversText,_that.maidens,_that.runs,_that.wickets,_that.economy,_that.wides,_that.noBalls);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  String name,  String oversText,  int maidens,  int runs,  int wickets,  double economy,  int wides,  int noBalls)  $default,) {final _that = this;
switch (_that) {
case _BowlerLine():
return $default(_that.playerId,_that.name,_that.oversText,_that.maidens,_that.runs,_that.wickets,_that.economy,_that.wides,_that.noBalls);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  String name,  String oversText,  int maidens,  int runs,  int wickets,  double economy,  int wides,  int noBalls)?  $default,) {final _that = this;
switch (_that) {
case _BowlerLine() when $default != null:
return $default(_that.playerId,_that.name,_that.oversText,_that.maidens,_that.runs,_that.wickets,_that.economy,_that.wides,_that.noBalls);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BowlerLine implements BowlerLine {
  const _BowlerLine({required this.playerId, required this.name, required this.oversText, required this.maidens, required this.runs, required this.wickets, required this.economy, required this.wides, required this.noBalls});
  factory _BowlerLine.fromJson(Map<String, dynamic> json) => _$BowlerLineFromJson(json);

@override final  String playerId;
@override final  String name;
@override final  String oversText;
@override final  int maidens;
@override final  int runs;
@override final  int wickets;
@override final  double economy;
@override final  int wides;
@override final  int noBalls;

/// Create a copy of BowlerLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BowlerLineCopyWith<_BowlerLine> get copyWith => __$BowlerLineCopyWithImpl<_BowlerLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BowlerLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BowlerLine&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.oversText, oversText) || other.oversText == oversText)&&(identical(other.maidens, maidens) || other.maidens == maidens)&&(identical(other.runs, runs) || other.runs == runs)&&(identical(other.wickets, wickets) || other.wickets == wickets)&&(identical(other.economy, economy) || other.economy == economy)&&(identical(other.wides, wides) || other.wides == wides)&&(identical(other.noBalls, noBalls) || other.noBalls == noBalls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,oversText,maidens,runs,wickets,economy,wides,noBalls);

@override
String toString() {
  return 'BowlerLine(playerId: $playerId, name: $name, oversText: $oversText, maidens: $maidens, runs: $runs, wickets: $wickets, economy: $economy, wides: $wides, noBalls: $noBalls)';
}


}

/// @nodoc
abstract mixin class _$BowlerLineCopyWith<$Res> implements $BowlerLineCopyWith<$Res> {
  factory _$BowlerLineCopyWith(_BowlerLine value, $Res Function(_BowlerLine) _then) = __$BowlerLineCopyWithImpl;
@override @useResult
$Res call({
 String playerId, String name, String oversText, int maidens, int runs, int wickets, double economy, int wides, int noBalls
});




}
/// @nodoc
class __$BowlerLineCopyWithImpl<$Res>
    implements _$BowlerLineCopyWith<$Res> {
  __$BowlerLineCopyWithImpl(this._self, this._then);

  final _BowlerLine _self;
  final $Res Function(_BowlerLine) _then;

/// Create a copy of BowlerLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? name = null,Object? oversText = null,Object? maidens = null,Object? runs = null,Object? wickets = null,Object? economy = null,Object? wides = null,Object? noBalls = null,}) {
  return _then(_BowlerLine(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,oversText: null == oversText ? _self.oversText : oversText // ignore: cast_nullable_to_non_nullable
as String,maidens: null == maidens ? _self.maidens : maidens // ignore: cast_nullable_to_non_nullable
as int,runs: null == runs ? _self.runs : runs // ignore: cast_nullable_to_non_nullable
as int,wickets: null == wickets ? _self.wickets : wickets // ignore: cast_nullable_to_non_nullable
as int,economy: null == economy ? _self.economy : economy // ignore: cast_nullable_to_non_nullable
as double,wides: null == wides ? _self.wides : wides // ignore: cast_nullable_to_non_nullable
as int,noBalls: null == noBalls ? _self.noBalls : noBalls // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$InningsScorecard {

 String get battingTeamId; String get bowlingTeamId; int get total; int get wickets; String get oversText; double get runRate; List<BatterLine> get batters; List<BowlerLine> get bowlers; Extras get extras; List<FallOfWicket> get fallOfWickets; List<Partnership> get partnerships; int? get target; List<int> get powerplayOvers;
/// Create a copy of InningsScorecard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InningsScorecardCopyWith<InningsScorecard> get copyWith => _$InningsScorecardCopyWithImpl<InningsScorecard>(this as InningsScorecard, _$identity);

  /// Serializes this InningsScorecard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InningsScorecard&&(identical(other.battingTeamId, battingTeamId) || other.battingTeamId == battingTeamId)&&(identical(other.bowlingTeamId, bowlingTeamId) || other.bowlingTeamId == bowlingTeamId)&&(identical(other.total, total) || other.total == total)&&(identical(other.wickets, wickets) || other.wickets == wickets)&&(identical(other.oversText, oversText) || other.oversText == oversText)&&(identical(other.runRate, runRate) || other.runRate == runRate)&&const DeepCollectionEquality().equals(other.batters, batters)&&const DeepCollectionEquality().equals(other.bowlers, bowlers)&&(identical(other.extras, extras) || other.extras == extras)&&const DeepCollectionEquality().equals(other.fallOfWickets, fallOfWickets)&&const DeepCollectionEquality().equals(other.partnerships, partnerships)&&(identical(other.target, target) || other.target == target)&&const DeepCollectionEquality().equals(other.powerplayOvers, powerplayOvers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,battingTeamId,bowlingTeamId,total,wickets,oversText,runRate,const DeepCollectionEquality().hash(batters),const DeepCollectionEquality().hash(bowlers),extras,const DeepCollectionEquality().hash(fallOfWickets),const DeepCollectionEquality().hash(partnerships),target,const DeepCollectionEquality().hash(powerplayOvers));

@override
String toString() {
  return 'InningsScorecard(battingTeamId: $battingTeamId, bowlingTeamId: $bowlingTeamId, total: $total, wickets: $wickets, oversText: $oversText, runRate: $runRate, batters: $batters, bowlers: $bowlers, extras: $extras, fallOfWickets: $fallOfWickets, partnerships: $partnerships, target: $target, powerplayOvers: $powerplayOvers)';
}


}

/// @nodoc
abstract mixin class $InningsScorecardCopyWith<$Res>  {
  factory $InningsScorecardCopyWith(InningsScorecard value, $Res Function(InningsScorecard) _then) = _$InningsScorecardCopyWithImpl;
@useResult
$Res call({
 String battingTeamId, String bowlingTeamId, int total, int wickets, String oversText, double runRate, List<BatterLine> batters, List<BowlerLine> bowlers, Extras extras, List<FallOfWicket> fallOfWickets, List<Partnership> partnerships, int? target, List<int> powerplayOvers
});


$ExtrasCopyWith<$Res> get extras;

}
/// @nodoc
class _$InningsScorecardCopyWithImpl<$Res>
    implements $InningsScorecardCopyWith<$Res> {
  _$InningsScorecardCopyWithImpl(this._self, this._then);

  final InningsScorecard _self;
  final $Res Function(InningsScorecard) _then;

/// Create a copy of InningsScorecard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? battingTeamId = null,Object? bowlingTeamId = null,Object? total = null,Object? wickets = null,Object? oversText = null,Object? runRate = null,Object? batters = null,Object? bowlers = null,Object? extras = null,Object? fallOfWickets = null,Object? partnerships = null,Object? target = freezed,Object? powerplayOvers = null,}) {
  return _then(_self.copyWith(
battingTeamId: null == battingTeamId ? _self.battingTeamId : battingTeamId // ignore: cast_nullable_to_non_nullable
as String,bowlingTeamId: null == bowlingTeamId ? _self.bowlingTeamId : bowlingTeamId // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,wickets: null == wickets ? _self.wickets : wickets // ignore: cast_nullable_to_non_nullable
as int,oversText: null == oversText ? _self.oversText : oversText // ignore: cast_nullable_to_non_nullable
as String,runRate: null == runRate ? _self.runRate : runRate // ignore: cast_nullable_to_non_nullable
as double,batters: null == batters ? _self.batters : batters // ignore: cast_nullable_to_non_nullable
as List<BatterLine>,bowlers: null == bowlers ? _self.bowlers : bowlers // ignore: cast_nullable_to_non_nullable
as List<BowlerLine>,extras: null == extras ? _self.extras : extras // ignore: cast_nullable_to_non_nullable
as Extras,fallOfWickets: null == fallOfWickets ? _self.fallOfWickets : fallOfWickets // ignore: cast_nullable_to_non_nullable
as List<FallOfWicket>,partnerships: null == partnerships ? _self.partnerships : partnerships // ignore: cast_nullable_to_non_nullable
as List<Partnership>,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int?,powerplayOvers: null == powerplayOvers ? _self.powerplayOvers : powerplayOvers // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}
/// Create a copy of InningsScorecard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtrasCopyWith<$Res> get extras {
  
  return $ExtrasCopyWith<$Res>(_self.extras, (value) {
    return _then(_self.copyWith(extras: value));
  });
}
}


/// Adds pattern-matching-related methods to [InningsScorecard].
extension InningsScorecardPatterns on InningsScorecard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InningsScorecard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InningsScorecard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InningsScorecard value)  $default,){
final _that = this;
switch (_that) {
case _InningsScorecard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InningsScorecard value)?  $default,){
final _that = this;
switch (_that) {
case _InningsScorecard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String battingTeamId,  String bowlingTeamId,  int total,  int wickets,  String oversText,  double runRate,  List<BatterLine> batters,  List<BowlerLine> bowlers,  Extras extras,  List<FallOfWicket> fallOfWickets,  List<Partnership> partnerships,  int? target,  List<int> powerplayOvers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InningsScorecard() when $default != null:
return $default(_that.battingTeamId,_that.bowlingTeamId,_that.total,_that.wickets,_that.oversText,_that.runRate,_that.batters,_that.bowlers,_that.extras,_that.fallOfWickets,_that.partnerships,_that.target,_that.powerplayOvers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String battingTeamId,  String bowlingTeamId,  int total,  int wickets,  String oversText,  double runRate,  List<BatterLine> batters,  List<BowlerLine> bowlers,  Extras extras,  List<FallOfWicket> fallOfWickets,  List<Partnership> partnerships,  int? target,  List<int> powerplayOvers)  $default,) {final _that = this;
switch (_that) {
case _InningsScorecard():
return $default(_that.battingTeamId,_that.bowlingTeamId,_that.total,_that.wickets,_that.oversText,_that.runRate,_that.batters,_that.bowlers,_that.extras,_that.fallOfWickets,_that.partnerships,_that.target,_that.powerplayOvers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String battingTeamId,  String bowlingTeamId,  int total,  int wickets,  String oversText,  double runRate,  List<BatterLine> batters,  List<BowlerLine> bowlers,  Extras extras,  List<FallOfWicket> fallOfWickets,  List<Partnership> partnerships,  int? target,  List<int> powerplayOvers)?  $default,) {final _that = this;
switch (_that) {
case _InningsScorecard() when $default != null:
return $default(_that.battingTeamId,_that.bowlingTeamId,_that.total,_that.wickets,_that.oversText,_that.runRate,_that.batters,_that.bowlers,_that.extras,_that.fallOfWickets,_that.partnerships,_that.target,_that.powerplayOvers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InningsScorecard implements InningsScorecard {
  const _InningsScorecard({required this.battingTeamId, required this.bowlingTeamId, required this.total, required this.wickets, required this.oversText, required this.runRate, required final  List<BatterLine> batters, required final  List<BowlerLine> bowlers, required this.extras, required final  List<FallOfWicket> fallOfWickets, required final  List<Partnership> partnerships, this.target, final  List<int> powerplayOvers = const <int>[]}): _batters = batters,_bowlers = bowlers,_fallOfWickets = fallOfWickets,_partnerships = partnerships,_powerplayOvers = powerplayOvers;
  factory _InningsScorecard.fromJson(Map<String, dynamic> json) => _$InningsScorecardFromJson(json);

@override final  String battingTeamId;
@override final  String bowlingTeamId;
@override final  int total;
@override final  int wickets;
@override final  String oversText;
@override final  double runRate;
 final  List<BatterLine> _batters;
@override List<BatterLine> get batters {
  if (_batters is EqualUnmodifiableListView) return _batters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_batters);
}

 final  List<BowlerLine> _bowlers;
@override List<BowlerLine> get bowlers {
  if (_bowlers is EqualUnmodifiableListView) return _bowlers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bowlers);
}

@override final  Extras extras;
 final  List<FallOfWicket> _fallOfWickets;
@override List<FallOfWicket> get fallOfWickets {
  if (_fallOfWickets is EqualUnmodifiableListView) return _fallOfWickets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fallOfWickets);
}

 final  List<Partnership> _partnerships;
@override List<Partnership> get partnerships {
  if (_partnerships is EqualUnmodifiableListView) return _partnerships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_partnerships);
}

@override final  int? target;
 final  List<int> _powerplayOvers;
@override@JsonKey() List<int> get powerplayOvers {
  if (_powerplayOvers is EqualUnmodifiableListView) return _powerplayOvers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_powerplayOvers);
}


/// Create a copy of InningsScorecard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InningsScorecardCopyWith<_InningsScorecard> get copyWith => __$InningsScorecardCopyWithImpl<_InningsScorecard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InningsScorecardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InningsScorecard&&(identical(other.battingTeamId, battingTeamId) || other.battingTeamId == battingTeamId)&&(identical(other.bowlingTeamId, bowlingTeamId) || other.bowlingTeamId == bowlingTeamId)&&(identical(other.total, total) || other.total == total)&&(identical(other.wickets, wickets) || other.wickets == wickets)&&(identical(other.oversText, oversText) || other.oversText == oversText)&&(identical(other.runRate, runRate) || other.runRate == runRate)&&const DeepCollectionEquality().equals(other._batters, _batters)&&const DeepCollectionEquality().equals(other._bowlers, _bowlers)&&(identical(other.extras, extras) || other.extras == extras)&&const DeepCollectionEquality().equals(other._fallOfWickets, _fallOfWickets)&&const DeepCollectionEquality().equals(other._partnerships, _partnerships)&&(identical(other.target, target) || other.target == target)&&const DeepCollectionEquality().equals(other._powerplayOvers, _powerplayOvers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,battingTeamId,bowlingTeamId,total,wickets,oversText,runRate,const DeepCollectionEquality().hash(_batters),const DeepCollectionEquality().hash(_bowlers),extras,const DeepCollectionEquality().hash(_fallOfWickets),const DeepCollectionEquality().hash(_partnerships),target,const DeepCollectionEquality().hash(_powerplayOvers));

@override
String toString() {
  return 'InningsScorecard(battingTeamId: $battingTeamId, bowlingTeamId: $bowlingTeamId, total: $total, wickets: $wickets, oversText: $oversText, runRate: $runRate, batters: $batters, bowlers: $bowlers, extras: $extras, fallOfWickets: $fallOfWickets, partnerships: $partnerships, target: $target, powerplayOvers: $powerplayOvers)';
}


}

/// @nodoc
abstract mixin class _$InningsScorecardCopyWith<$Res> implements $InningsScorecardCopyWith<$Res> {
  factory _$InningsScorecardCopyWith(_InningsScorecard value, $Res Function(_InningsScorecard) _then) = __$InningsScorecardCopyWithImpl;
@override @useResult
$Res call({
 String battingTeamId, String bowlingTeamId, int total, int wickets, String oversText, double runRate, List<BatterLine> batters, List<BowlerLine> bowlers, Extras extras, List<FallOfWicket> fallOfWickets, List<Partnership> partnerships, int? target, List<int> powerplayOvers
});


@override $ExtrasCopyWith<$Res> get extras;

}
/// @nodoc
class __$InningsScorecardCopyWithImpl<$Res>
    implements _$InningsScorecardCopyWith<$Res> {
  __$InningsScorecardCopyWithImpl(this._self, this._then);

  final _InningsScorecard _self;
  final $Res Function(_InningsScorecard) _then;

/// Create a copy of InningsScorecard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? battingTeamId = null,Object? bowlingTeamId = null,Object? total = null,Object? wickets = null,Object? oversText = null,Object? runRate = null,Object? batters = null,Object? bowlers = null,Object? extras = null,Object? fallOfWickets = null,Object? partnerships = null,Object? target = freezed,Object? powerplayOvers = null,}) {
  return _then(_InningsScorecard(
battingTeamId: null == battingTeamId ? _self.battingTeamId : battingTeamId // ignore: cast_nullable_to_non_nullable
as String,bowlingTeamId: null == bowlingTeamId ? _self.bowlingTeamId : bowlingTeamId // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,wickets: null == wickets ? _self.wickets : wickets // ignore: cast_nullable_to_non_nullable
as int,oversText: null == oversText ? _self.oversText : oversText // ignore: cast_nullable_to_non_nullable
as String,runRate: null == runRate ? _self.runRate : runRate // ignore: cast_nullable_to_non_nullable
as double,batters: null == batters ? _self._batters : batters // ignore: cast_nullable_to_non_nullable
as List<BatterLine>,bowlers: null == bowlers ? _self._bowlers : bowlers // ignore: cast_nullable_to_non_nullable
as List<BowlerLine>,extras: null == extras ? _self.extras : extras // ignore: cast_nullable_to_non_nullable
as Extras,fallOfWickets: null == fallOfWickets ? _self._fallOfWickets : fallOfWickets // ignore: cast_nullable_to_non_nullable
as List<FallOfWicket>,partnerships: null == partnerships ? _self._partnerships : partnerships // ignore: cast_nullable_to_non_nullable
as List<Partnership>,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int?,powerplayOvers: null == powerplayOvers ? _self._powerplayOvers : powerplayOvers // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

/// Create a copy of InningsScorecard
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
