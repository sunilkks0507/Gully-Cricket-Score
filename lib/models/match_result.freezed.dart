// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchResult {

 MatchResultType get type;/// Winning team, when there is one (null for tie / no result).
 String? get winnerTeamId;/// Margin magnitude (runs or wickets, per [marginUnit]).
 int get margin;/// "runs" or "wickets" (empty for tie / no result).
 String get marginUnit;/// Human-readable summary, e.g. "Team A won by 23 runs".
 String get summary;
/// Create a copy of MatchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchResultCopyWith<MatchResult> get copyWith => _$MatchResultCopyWithImpl<MatchResult>(this as MatchResult, _$identity);

  /// Serializes this MatchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchResult&&(identical(other.type, type) || other.type == type)&&(identical(other.winnerTeamId, winnerTeamId) || other.winnerTeamId == winnerTeamId)&&(identical(other.margin, margin) || other.margin == margin)&&(identical(other.marginUnit, marginUnit) || other.marginUnit == marginUnit)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,winnerTeamId,margin,marginUnit,summary);

@override
String toString() {
  return 'MatchResult(type: $type, winnerTeamId: $winnerTeamId, margin: $margin, marginUnit: $marginUnit, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $MatchResultCopyWith<$Res>  {
  factory $MatchResultCopyWith(MatchResult value, $Res Function(MatchResult) _then) = _$MatchResultCopyWithImpl;
@useResult
$Res call({
 MatchResultType type, String? winnerTeamId, int margin, String marginUnit, String summary
});




}
/// @nodoc
class _$MatchResultCopyWithImpl<$Res>
    implements $MatchResultCopyWith<$Res> {
  _$MatchResultCopyWithImpl(this._self, this._then);

  final MatchResult _self;
  final $Res Function(MatchResult) _then;

/// Create a copy of MatchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? winnerTeamId = freezed,Object? margin = null,Object? marginUnit = null,Object? summary = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MatchResultType,winnerTeamId: freezed == winnerTeamId ? _self.winnerTeamId : winnerTeamId // ignore: cast_nullable_to_non_nullable
as String?,margin: null == margin ? _self.margin : margin // ignore: cast_nullable_to_non_nullable
as int,marginUnit: null == marginUnit ? _self.marginUnit : marginUnit // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchResult].
extension MatchResultPatterns on MatchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchResult value)  $default,){
final _that = this;
switch (_that) {
case _MatchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchResult value)?  $default,){
final _that = this;
switch (_that) {
case _MatchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MatchResultType type,  String? winnerTeamId,  int margin,  String marginUnit,  String summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchResult() when $default != null:
return $default(_that.type,_that.winnerTeamId,_that.margin,_that.marginUnit,_that.summary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MatchResultType type,  String? winnerTeamId,  int margin,  String marginUnit,  String summary)  $default,) {final _that = this;
switch (_that) {
case _MatchResult():
return $default(_that.type,_that.winnerTeamId,_that.margin,_that.marginUnit,_that.summary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MatchResultType type,  String? winnerTeamId,  int margin,  String marginUnit,  String summary)?  $default,) {final _that = this;
switch (_that) {
case _MatchResult() when $default != null:
return $default(_that.type,_that.winnerTeamId,_that.margin,_that.marginUnit,_that.summary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchResult implements MatchResult {
  const _MatchResult({required this.type, this.winnerTeamId, this.margin = 0, this.marginUnit = '', required this.summary});
  factory _MatchResult.fromJson(Map<String, dynamic> json) => _$MatchResultFromJson(json);

@override final  MatchResultType type;
/// Winning team, when there is one (null for tie / no result).
@override final  String? winnerTeamId;
/// Margin magnitude (runs or wickets, per [marginUnit]).
@override@JsonKey() final  int margin;
/// "runs" or "wickets" (empty for tie / no result).
@override@JsonKey() final  String marginUnit;
/// Human-readable summary, e.g. "Team A won by 23 runs".
@override final  String summary;

/// Create a copy of MatchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchResultCopyWith<_MatchResult> get copyWith => __$MatchResultCopyWithImpl<_MatchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchResult&&(identical(other.type, type) || other.type == type)&&(identical(other.winnerTeamId, winnerTeamId) || other.winnerTeamId == winnerTeamId)&&(identical(other.margin, margin) || other.margin == margin)&&(identical(other.marginUnit, marginUnit) || other.marginUnit == marginUnit)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,winnerTeamId,margin,marginUnit,summary);

@override
String toString() {
  return 'MatchResult(type: $type, winnerTeamId: $winnerTeamId, margin: $margin, marginUnit: $marginUnit, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$MatchResultCopyWith<$Res> implements $MatchResultCopyWith<$Res> {
  factory _$MatchResultCopyWith(_MatchResult value, $Res Function(_MatchResult) _then) = __$MatchResultCopyWithImpl;
@override @useResult
$Res call({
 MatchResultType type, String? winnerTeamId, int margin, String marginUnit, String summary
});




}
/// @nodoc
class __$MatchResultCopyWithImpl<$Res>
    implements _$MatchResultCopyWith<$Res> {
  __$MatchResultCopyWithImpl(this._self, this._then);

  final _MatchResult _self;
  final $Res Function(_MatchResult) _then;

/// Create a copy of MatchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? winnerTeamId = freezed,Object? margin = null,Object? marginUnit = null,Object? summary = null,}) {
  return _then(_MatchResult(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MatchResultType,winnerTeamId: freezed == winnerTeamId ? _self.winnerTeamId : winnerTeamId // ignore: cast_nullable_to_non_nullable
as String?,margin: null == margin ? _self.margin : margin // ignore: cast_nullable_to_non_nullable
as int,marginUnit: null == marginUnit ? _self.marginUnit : marginUnit // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
