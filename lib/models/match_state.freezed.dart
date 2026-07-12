// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchState {

/// Owning match id (uuid). Links the derived state back to its event log.
 String get matchId; MatchRules get rules;/// 0 = first innings in progress/next, 1 = second, higher for super overs.
 int get currentInnings;/// First innings; null until it starts.
 InningsState? get innings1;/// Second innings; null until it starts.
 InningsState? get innings2; MatchStatus get status; MatchResult? get result;
/// Create a copy of MatchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchStateCopyWith<MatchState> get copyWith => _$MatchStateCopyWithImpl<MatchState>(this as MatchState, _$identity);

  /// Serializes this MatchState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchState&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.rules, rules) || other.rules == rules)&&(identical(other.currentInnings, currentInnings) || other.currentInnings == currentInnings)&&(identical(other.innings1, innings1) || other.innings1 == innings1)&&(identical(other.innings2, innings2) || other.innings2 == innings2)&&(identical(other.status, status) || other.status == status)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchId,rules,currentInnings,innings1,innings2,status,result);

@override
String toString() {
  return 'MatchState(matchId: $matchId, rules: $rules, currentInnings: $currentInnings, innings1: $innings1, innings2: $innings2, status: $status, result: $result)';
}


}

/// @nodoc
abstract mixin class $MatchStateCopyWith<$Res>  {
  factory $MatchStateCopyWith(MatchState value, $Res Function(MatchState) _then) = _$MatchStateCopyWithImpl;
@useResult
$Res call({
 String matchId, MatchRules rules, int currentInnings, InningsState? innings1, InningsState? innings2, MatchStatus status, MatchResult? result
});


$MatchRulesCopyWith<$Res> get rules;$InningsStateCopyWith<$Res>? get innings1;$InningsStateCopyWith<$Res>? get innings2;$MatchResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$MatchStateCopyWithImpl<$Res>
    implements $MatchStateCopyWith<$Res> {
  _$MatchStateCopyWithImpl(this._self, this._then);

  final MatchState _self;
  final $Res Function(MatchState) _then;

/// Create a copy of MatchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchId = null,Object? rules = null,Object? currentInnings = null,Object? innings1 = freezed,Object? innings2 = freezed,Object? status = null,Object? result = freezed,}) {
  return _then(_self.copyWith(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as MatchRules,currentInnings: null == currentInnings ? _self.currentInnings : currentInnings // ignore: cast_nullable_to_non_nullable
as int,innings1: freezed == innings1 ? _self.innings1 : innings1 // ignore: cast_nullable_to_non_nullable
as InningsState?,innings2: freezed == innings2 ? _self.innings2 : innings2 // ignore: cast_nullable_to_non_nullable
as InningsState?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MatchStatus,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as MatchResult?,
  ));
}
/// Create a copy of MatchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchRulesCopyWith<$Res> get rules {
  
  return $MatchRulesCopyWith<$Res>(_self.rules, (value) {
    return _then(_self.copyWith(rules: value));
  });
}/// Create a copy of MatchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InningsStateCopyWith<$Res>? get innings1 {
    if (_self.innings1 == null) {
    return null;
  }

  return $InningsStateCopyWith<$Res>(_self.innings1!, (value) {
    return _then(_self.copyWith(innings1: value));
  });
}/// Create a copy of MatchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InningsStateCopyWith<$Res>? get innings2 {
    if (_self.innings2 == null) {
    return null;
  }

  return $InningsStateCopyWith<$Res>(_self.innings2!, (value) {
    return _then(_self.copyWith(innings2: value));
  });
}/// Create a copy of MatchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $MatchResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [MatchState].
extension MatchStatePatterns on MatchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchState value)  $default,){
final _that = this;
switch (_that) {
case _MatchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchState value)?  $default,){
final _that = this;
switch (_that) {
case _MatchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String matchId,  MatchRules rules,  int currentInnings,  InningsState? innings1,  InningsState? innings2,  MatchStatus status,  MatchResult? result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchState() when $default != null:
return $default(_that.matchId,_that.rules,_that.currentInnings,_that.innings1,_that.innings2,_that.status,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String matchId,  MatchRules rules,  int currentInnings,  InningsState? innings1,  InningsState? innings2,  MatchStatus status,  MatchResult? result)  $default,) {final _that = this;
switch (_that) {
case _MatchState():
return $default(_that.matchId,_that.rules,_that.currentInnings,_that.innings1,_that.innings2,_that.status,_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String matchId,  MatchRules rules,  int currentInnings,  InningsState? innings1,  InningsState? innings2,  MatchStatus status,  MatchResult? result)?  $default,) {final _that = this;
switch (_that) {
case _MatchState() when $default != null:
return $default(_that.matchId,_that.rules,_that.currentInnings,_that.innings1,_that.innings2,_that.status,_that.result);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchState extends MatchState {
  const _MatchState({required this.matchId, required this.rules, this.currentInnings = 0, this.innings1, this.innings2, this.status = MatchStatus.notStarted, this.result}): super._();
  factory _MatchState.fromJson(Map<String, dynamic> json) => _$MatchStateFromJson(json);

/// Owning match id (uuid). Links the derived state back to its event log.
@override final  String matchId;
@override final  MatchRules rules;
/// 0 = first innings in progress/next, 1 = second, higher for super overs.
@override@JsonKey() final  int currentInnings;
/// First innings; null until it starts.
@override final  InningsState? innings1;
/// Second innings; null until it starts.
@override final  InningsState? innings2;
@override@JsonKey() final  MatchStatus status;
@override final  MatchResult? result;

/// Create a copy of MatchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchStateCopyWith<_MatchState> get copyWith => __$MatchStateCopyWithImpl<_MatchState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchState&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.rules, rules) || other.rules == rules)&&(identical(other.currentInnings, currentInnings) || other.currentInnings == currentInnings)&&(identical(other.innings1, innings1) || other.innings1 == innings1)&&(identical(other.innings2, innings2) || other.innings2 == innings2)&&(identical(other.status, status) || other.status == status)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchId,rules,currentInnings,innings1,innings2,status,result);

@override
String toString() {
  return 'MatchState(matchId: $matchId, rules: $rules, currentInnings: $currentInnings, innings1: $innings1, innings2: $innings2, status: $status, result: $result)';
}


}

/// @nodoc
abstract mixin class _$MatchStateCopyWith<$Res> implements $MatchStateCopyWith<$Res> {
  factory _$MatchStateCopyWith(_MatchState value, $Res Function(_MatchState) _then) = __$MatchStateCopyWithImpl;
@override @useResult
$Res call({
 String matchId, MatchRules rules, int currentInnings, InningsState? innings1, InningsState? innings2, MatchStatus status, MatchResult? result
});


@override $MatchRulesCopyWith<$Res> get rules;@override $InningsStateCopyWith<$Res>? get innings1;@override $InningsStateCopyWith<$Res>? get innings2;@override $MatchResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$MatchStateCopyWithImpl<$Res>
    implements _$MatchStateCopyWith<$Res> {
  __$MatchStateCopyWithImpl(this._self, this._then);

  final _MatchState _self;
  final $Res Function(_MatchState) _then;

/// Create a copy of MatchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchId = null,Object? rules = null,Object? currentInnings = null,Object? innings1 = freezed,Object? innings2 = freezed,Object? status = null,Object? result = freezed,}) {
  return _then(_MatchState(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as MatchRules,currentInnings: null == currentInnings ? _self.currentInnings : currentInnings // ignore: cast_nullable_to_non_nullable
as int,innings1: freezed == innings1 ? _self.innings1 : innings1 // ignore: cast_nullable_to_non_nullable
as InningsState?,innings2: freezed == innings2 ? _self.innings2 : innings2 // ignore: cast_nullable_to_non_nullable
as InningsState?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MatchStatus,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as MatchResult?,
  ));
}

/// Create a copy of MatchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchRulesCopyWith<$Res> get rules {
  
  return $MatchRulesCopyWith<$Res>(_self.rules, (value) {
    return _then(_self.copyWith(rules: value));
  });
}/// Create a copy of MatchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InningsStateCopyWith<$Res>? get innings1 {
    if (_self.innings1 == null) {
    return null;
  }

  return $InningsStateCopyWith<$Res>(_self.innings1!, (value) {
    return _then(_self.copyWith(innings1: value));
  });
}/// Create a copy of MatchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InningsStateCopyWith<$Res>? get innings2 {
    if (_self.innings2 == null) {
    return null;
  }

  return $InningsStateCopyWith<$Res>(_self.innings2!, (value) {
    return _then(_self.copyWith(innings2: value));
  });
}/// Create a copy of MatchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $MatchResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
