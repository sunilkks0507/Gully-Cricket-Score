// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
GameEvent _$GameEventFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'matchCreated':
          return MatchCreatedEvent.fromJson(
            json
          );
                case 'inningsStarted':
          return InningsStartedEvent.fromJson(
            json
          );
                case 'ball':
          return BallDelivery.fromJson(
            json
          );
                case 'penalty':
          return PenaltyEvent.fromJson(
            json
          );
                case 'batterReplaced':
          return BatterReplacedEvent.fromJson(
            json
          );
                case 'swapStrike':
          return SwapStrikeEvent.fromJson(
            json
          );
                case 'bowlerChanged':
          return BowlerChangedEvent.fromJson(
            json
          );
                case 'rulesChanged':
          return RulesChangedEvent.fromJson(
            json
          );
                case 'endInnings':
          return EndInningsEvent.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'GameEvent',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$GameEvent {



  /// Serializes this GameEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameEvent);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameEvent()';
}


}

/// @nodoc
class $GameEventCopyWith<$Res>  {
$GameEventCopyWith(GameEvent _, $Res Function(GameEvent) __);
}


/// Adds pattern-matching-related methods to [GameEvent].
extension GameEventPatterns on GameEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MatchCreatedEvent value)?  matchCreated,TResult Function( InningsStartedEvent value)?  inningsStarted,TResult Function( BallDelivery value)?  ball,TResult Function( PenaltyEvent value)?  penalty,TResult Function( BatterReplacedEvent value)?  batterReplaced,TResult Function( SwapStrikeEvent value)?  swapStrike,TResult Function( BowlerChangedEvent value)?  bowlerChanged,TResult Function( RulesChangedEvent value)?  rulesChanged,TResult Function( EndInningsEvent value)?  endInnings,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MatchCreatedEvent() when matchCreated != null:
return matchCreated(_that);case InningsStartedEvent() when inningsStarted != null:
return inningsStarted(_that);case BallDelivery() when ball != null:
return ball(_that);case PenaltyEvent() when penalty != null:
return penalty(_that);case BatterReplacedEvent() when batterReplaced != null:
return batterReplaced(_that);case SwapStrikeEvent() when swapStrike != null:
return swapStrike(_that);case BowlerChangedEvent() when bowlerChanged != null:
return bowlerChanged(_that);case RulesChangedEvent() when rulesChanged != null:
return rulesChanged(_that);case EndInningsEvent() when endInnings != null:
return endInnings(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MatchCreatedEvent value)  matchCreated,required TResult Function( InningsStartedEvent value)  inningsStarted,required TResult Function( BallDelivery value)  ball,required TResult Function( PenaltyEvent value)  penalty,required TResult Function( BatterReplacedEvent value)  batterReplaced,required TResult Function( SwapStrikeEvent value)  swapStrike,required TResult Function( BowlerChangedEvent value)  bowlerChanged,required TResult Function( RulesChangedEvent value)  rulesChanged,required TResult Function( EndInningsEvent value)  endInnings,}){
final _that = this;
switch (_that) {
case MatchCreatedEvent():
return matchCreated(_that);case InningsStartedEvent():
return inningsStarted(_that);case BallDelivery():
return ball(_that);case PenaltyEvent():
return penalty(_that);case BatterReplacedEvent():
return batterReplaced(_that);case SwapStrikeEvent():
return swapStrike(_that);case BowlerChangedEvent():
return bowlerChanged(_that);case RulesChangedEvent():
return rulesChanged(_that);case EndInningsEvent():
return endInnings(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MatchCreatedEvent value)?  matchCreated,TResult? Function( InningsStartedEvent value)?  inningsStarted,TResult? Function( BallDelivery value)?  ball,TResult? Function( PenaltyEvent value)?  penalty,TResult? Function( BatterReplacedEvent value)?  batterReplaced,TResult? Function( SwapStrikeEvent value)?  swapStrike,TResult? Function( BowlerChangedEvent value)?  bowlerChanged,TResult? Function( RulesChangedEvent value)?  rulesChanged,TResult? Function( EndInningsEvent value)?  endInnings,}){
final _that = this;
switch (_that) {
case MatchCreatedEvent() when matchCreated != null:
return matchCreated(_that);case InningsStartedEvent() when inningsStarted != null:
return inningsStarted(_that);case BallDelivery() when ball != null:
return ball(_that);case PenaltyEvent() when penalty != null:
return penalty(_that);case BatterReplacedEvent() when batterReplaced != null:
return batterReplaced(_that);case SwapStrikeEvent() when swapStrike != null:
return swapStrike(_that);case BowlerChangedEvent() when bowlerChanged != null:
return bowlerChanged(_that);case RulesChangedEvent() when rulesChanged != null:
return rulesChanged(_that);case EndInningsEvent() when endInnings != null:
return endInnings(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String matchId,  MatchRules rules,  String teamAId,  String teamBId,  String? tossWinnerTeamId,  TossDecision? tossDecision)?  matchCreated,TResult Function( int inningsIndex,  String battingTeamId,  String bowlingTeamId,  String strikerId,  String nonStrikerId,  String bowlerId,  int battingSquadSize)?  inningsStarted,TResult Function( BallEvent ball)?  ball,TResult Function( int inningsIndex,  int runs)?  penalty,TResult Function( int inningsIndex,  String outgoingId,  String incomingId,  bool retiredHurt,  bool incomingOnStrike)?  batterReplaced,TResult Function( int inningsIndex)?  swapStrike,TResult Function( int inningsIndex,  String bowlerId)?  bowlerChanged,TResult Function( MatchRules rules)?  rulesChanged,TResult Function( int inningsIndex)?  endInnings,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MatchCreatedEvent() when matchCreated != null:
return matchCreated(_that.matchId,_that.rules,_that.teamAId,_that.teamBId,_that.tossWinnerTeamId,_that.tossDecision);case InningsStartedEvent() when inningsStarted != null:
return inningsStarted(_that.inningsIndex,_that.battingTeamId,_that.bowlingTeamId,_that.strikerId,_that.nonStrikerId,_that.bowlerId,_that.battingSquadSize);case BallDelivery() when ball != null:
return ball(_that.ball);case PenaltyEvent() when penalty != null:
return penalty(_that.inningsIndex,_that.runs);case BatterReplacedEvent() when batterReplaced != null:
return batterReplaced(_that.inningsIndex,_that.outgoingId,_that.incomingId,_that.retiredHurt,_that.incomingOnStrike);case SwapStrikeEvent() when swapStrike != null:
return swapStrike(_that.inningsIndex);case BowlerChangedEvent() when bowlerChanged != null:
return bowlerChanged(_that.inningsIndex,_that.bowlerId);case RulesChangedEvent() when rulesChanged != null:
return rulesChanged(_that.rules);case EndInningsEvent() when endInnings != null:
return endInnings(_that.inningsIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String matchId,  MatchRules rules,  String teamAId,  String teamBId,  String? tossWinnerTeamId,  TossDecision? tossDecision)  matchCreated,required TResult Function( int inningsIndex,  String battingTeamId,  String bowlingTeamId,  String strikerId,  String nonStrikerId,  String bowlerId,  int battingSquadSize)  inningsStarted,required TResult Function( BallEvent ball)  ball,required TResult Function( int inningsIndex,  int runs)  penalty,required TResult Function( int inningsIndex,  String outgoingId,  String incomingId,  bool retiredHurt,  bool incomingOnStrike)  batterReplaced,required TResult Function( int inningsIndex)  swapStrike,required TResult Function( int inningsIndex,  String bowlerId)  bowlerChanged,required TResult Function( MatchRules rules)  rulesChanged,required TResult Function( int inningsIndex)  endInnings,}) {final _that = this;
switch (_that) {
case MatchCreatedEvent():
return matchCreated(_that.matchId,_that.rules,_that.teamAId,_that.teamBId,_that.tossWinnerTeamId,_that.tossDecision);case InningsStartedEvent():
return inningsStarted(_that.inningsIndex,_that.battingTeamId,_that.bowlingTeamId,_that.strikerId,_that.nonStrikerId,_that.bowlerId,_that.battingSquadSize);case BallDelivery():
return ball(_that.ball);case PenaltyEvent():
return penalty(_that.inningsIndex,_that.runs);case BatterReplacedEvent():
return batterReplaced(_that.inningsIndex,_that.outgoingId,_that.incomingId,_that.retiredHurt,_that.incomingOnStrike);case SwapStrikeEvent():
return swapStrike(_that.inningsIndex);case BowlerChangedEvent():
return bowlerChanged(_that.inningsIndex,_that.bowlerId);case RulesChangedEvent():
return rulesChanged(_that.rules);case EndInningsEvent():
return endInnings(_that.inningsIndex);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String matchId,  MatchRules rules,  String teamAId,  String teamBId,  String? tossWinnerTeamId,  TossDecision? tossDecision)?  matchCreated,TResult? Function( int inningsIndex,  String battingTeamId,  String bowlingTeamId,  String strikerId,  String nonStrikerId,  String bowlerId,  int battingSquadSize)?  inningsStarted,TResult? Function( BallEvent ball)?  ball,TResult? Function( int inningsIndex,  int runs)?  penalty,TResult? Function( int inningsIndex,  String outgoingId,  String incomingId,  bool retiredHurt,  bool incomingOnStrike)?  batterReplaced,TResult? Function( int inningsIndex)?  swapStrike,TResult? Function( int inningsIndex,  String bowlerId)?  bowlerChanged,TResult? Function( MatchRules rules)?  rulesChanged,TResult? Function( int inningsIndex)?  endInnings,}) {final _that = this;
switch (_that) {
case MatchCreatedEvent() when matchCreated != null:
return matchCreated(_that.matchId,_that.rules,_that.teamAId,_that.teamBId,_that.tossWinnerTeamId,_that.tossDecision);case InningsStartedEvent() when inningsStarted != null:
return inningsStarted(_that.inningsIndex,_that.battingTeamId,_that.bowlingTeamId,_that.strikerId,_that.nonStrikerId,_that.bowlerId,_that.battingSquadSize);case BallDelivery() when ball != null:
return ball(_that.ball);case PenaltyEvent() when penalty != null:
return penalty(_that.inningsIndex,_that.runs);case BatterReplacedEvent() when batterReplaced != null:
return batterReplaced(_that.inningsIndex,_that.outgoingId,_that.incomingId,_that.retiredHurt,_that.incomingOnStrike);case SwapStrikeEvent() when swapStrike != null:
return swapStrike(_that.inningsIndex);case BowlerChangedEvent() when bowlerChanged != null:
return bowlerChanged(_that.inningsIndex,_that.bowlerId);case RulesChangedEvent() when rulesChanged != null:
return rulesChanged(_that.rules);case EndInningsEvent() when endInnings != null:
return endInnings(_that.inningsIndex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class MatchCreatedEvent implements GameEvent {
  const MatchCreatedEvent({required this.matchId, required this.rules, required this.teamAId, required this.teamBId, this.tossWinnerTeamId, this.tossDecision, final  String? $type}): $type = $type ?? 'matchCreated';
  factory MatchCreatedEvent.fromJson(Map<String, dynamic> json) => _$MatchCreatedEventFromJson(json);

 final  String matchId;
 final  MatchRules rules;
 final  String teamAId;
 final  String teamBId;
 final  String? tossWinnerTeamId;
 final  TossDecision? tossDecision;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchCreatedEventCopyWith<MatchCreatedEvent> get copyWith => _$MatchCreatedEventCopyWithImpl<MatchCreatedEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchCreatedEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchCreatedEvent&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.rules, rules) || other.rules == rules)&&(identical(other.teamAId, teamAId) || other.teamAId == teamAId)&&(identical(other.teamBId, teamBId) || other.teamBId == teamBId)&&(identical(other.tossWinnerTeamId, tossWinnerTeamId) || other.tossWinnerTeamId == tossWinnerTeamId)&&(identical(other.tossDecision, tossDecision) || other.tossDecision == tossDecision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchId,rules,teamAId,teamBId,tossWinnerTeamId,tossDecision);

@override
String toString() {
  return 'GameEvent.matchCreated(matchId: $matchId, rules: $rules, teamAId: $teamAId, teamBId: $teamBId, tossWinnerTeamId: $tossWinnerTeamId, tossDecision: $tossDecision)';
}


}

/// @nodoc
abstract mixin class $MatchCreatedEventCopyWith<$Res> implements $GameEventCopyWith<$Res> {
  factory $MatchCreatedEventCopyWith(MatchCreatedEvent value, $Res Function(MatchCreatedEvent) _then) = _$MatchCreatedEventCopyWithImpl;
@useResult
$Res call({
 String matchId, MatchRules rules, String teamAId, String teamBId, String? tossWinnerTeamId, TossDecision? tossDecision
});


$MatchRulesCopyWith<$Res> get rules;

}
/// @nodoc
class _$MatchCreatedEventCopyWithImpl<$Res>
    implements $MatchCreatedEventCopyWith<$Res> {
  _$MatchCreatedEventCopyWithImpl(this._self, this._then);

  final MatchCreatedEvent _self;
  final $Res Function(MatchCreatedEvent) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? matchId = null,Object? rules = null,Object? teamAId = null,Object? teamBId = null,Object? tossWinnerTeamId = freezed,Object? tossDecision = freezed,}) {
  return _then(MatchCreatedEvent(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as MatchRules,teamAId: null == teamAId ? _self.teamAId : teamAId // ignore: cast_nullable_to_non_nullable
as String,teamBId: null == teamBId ? _self.teamBId : teamBId // ignore: cast_nullable_to_non_nullable
as String,tossWinnerTeamId: freezed == tossWinnerTeamId ? _self.tossWinnerTeamId : tossWinnerTeamId // ignore: cast_nullable_to_non_nullable
as String?,tossDecision: freezed == tossDecision ? _self.tossDecision : tossDecision // ignore: cast_nullable_to_non_nullable
as TossDecision?,
  ));
}

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchRulesCopyWith<$Res> get rules {
  
  return $MatchRulesCopyWith<$Res>(_self.rules, (value) {
    return _then(_self.copyWith(rules: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class InningsStartedEvent implements GameEvent {
  const InningsStartedEvent({required this.inningsIndex, required this.battingTeamId, required this.bowlingTeamId, required this.strikerId, required this.nonStrikerId, required this.bowlerId, this.battingSquadSize = 0, final  String? $type}): $type = $type ?? 'inningsStarted';
  factory InningsStartedEvent.fromJson(Map<String, dynamic> json) => _$InningsStartedEventFromJson(json);

 final  int inningsIndex;
 final  String battingTeamId;
 final  String bowlingTeamId;
 final  String strikerId;
 final  String nonStrikerId;
 final  String bowlerId;
/// How many players the batting side actually has available. Drives the
/// all-out check, which must not rely on the configured `playersPerSide`
/// (a side may take the field with fewer). 0 = unknown (older events),
/// in which case the engine falls back to `rules.playersPerSide`.
@JsonKey() final  int battingSquadSize;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InningsStartedEventCopyWith<InningsStartedEvent> get copyWith => _$InningsStartedEventCopyWithImpl<InningsStartedEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InningsStartedEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InningsStartedEvent&&(identical(other.inningsIndex, inningsIndex) || other.inningsIndex == inningsIndex)&&(identical(other.battingTeamId, battingTeamId) || other.battingTeamId == battingTeamId)&&(identical(other.bowlingTeamId, bowlingTeamId) || other.bowlingTeamId == bowlingTeamId)&&(identical(other.strikerId, strikerId) || other.strikerId == strikerId)&&(identical(other.nonStrikerId, nonStrikerId) || other.nonStrikerId == nonStrikerId)&&(identical(other.bowlerId, bowlerId) || other.bowlerId == bowlerId)&&(identical(other.battingSquadSize, battingSquadSize) || other.battingSquadSize == battingSquadSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inningsIndex,battingTeamId,bowlingTeamId,strikerId,nonStrikerId,bowlerId,battingSquadSize);

@override
String toString() {
  return 'GameEvent.inningsStarted(inningsIndex: $inningsIndex, battingTeamId: $battingTeamId, bowlingTeamId: $bowlingTeamId, strikerId: $strikerId, nonStrikerId: $nonStrikerId, bowlerId: $bowlerId, battingSquadSize: $battingSquadSize)';
}


}

/// @nodoc
abstract mixin class $InningsStartedEventCopyWith<$Res> implements $GameEventCopyWith<$Res> {
  factory $InningsStartedEventCopyWith(InningsStartedEvent value, $Res Function(InningsStartedEvent) _then) = _$InningsStartedEventCopyWithImpl;
@useResult
$Res call({
 int inningsIndex, String battingTeamId, String bowlingTeamId, String strikerId, String nonStrikerId, String bowlerId, int battingSquadSize
});




}
/// @nodoc
class _$InningsStartedEventCopyWithImpl<$Res>
    implements $InningsStartedEventCopyWith<$Res> {
  _$InningsStartedEventCopyWithImpl(this._self, this._then);

  final InningsStartedEvent _self;
  final $Res Function(InningsStartedEvent) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? inningsIndex = null,Object? battingTeamId = null,Object? bowlingTeamId = null,Object? strikerId = null,Object? nonStrikerId = null,Object? bowlerId = null,Object? battingSquadSize = null,}) {
  return _then(InningsStartedEvent(
inningsIndex: null == inningsIndex ? _self.inningsIndex : inningsIndex // ignore: cast_nullable_to_non_nullable
as int,battingTeamId: null == battingTeamId ? _self.battingTeamId : battingTeamId // ignore: cast_nullable_to_non_nullable
as String,bowlingTeamId: null == bowlingTeamId ? _self.bowlingTeamId : bowlingTeamId // ignore: cast_nullable_to_non_nullable
as String,strikerId: null == strikerId ? _self.strikerId : strikerId // ignore: cast_nullable_to_non_nullable
as String,nonStrikerId: null == nonStrikerId ? _self.nonStrikerId : nonStrikerId // ignore: cast_nullable_to_non_nullable
as String,bowlerId: null == bowlerId ? _self.bowlerId : bowlerId // ignore: cast_nullable_to_non_nullable
as String,battingSquadSize: null == battingSquadSize ? _self.battingSquadSize : battingSquadSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class BallDelivery implements GameEvent {
  const BallDelivery(this.ball, {final  String? $type}): $type = $type ?? 'ball';
  factory BallDelivery.fromJson(Map<String, dynamic> json) => _$BallDeliveryFromJson(json);

 final  BallEvent ball;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BallDeliveryCopyWith<BallDelivery> get copyWith => _$BallDeliveryCopyWithImpl<BallDelivery>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BallDeliveryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BallDelivery&&(identical(other.ball, ball) || other.ball == ball));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ball);

@override
String toString() {
  return 'GameEvent.ball(ball: $ball)';
}


}

/// @nodoc
abstract mixin class $BallDeliveryCopyWith<$Res> implements $GameEventCopyWith<$Res> {
  factory $BallDeliveryCopyWith(BallDelivery value, $Res Function(BallDelivery) _then) = _$BallDeliveryCopyWithImpl;
@useResult
$Res call({
 BallEvent ball
});


$BallEventCopyWith<$Res> get ball;

}
/// @nodoc
class _$BallDeliveryCopyWithImpl<$Res>
    implements $BallDeliveryCopyWith<$Res> {
  _$BallDeliveryCopyWithImpl(this._self, this._then);

  final BallDelivery _self;
  final $Res Function(BallDelivery) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ball = null,}) {
  return _then(BallDelivery(
null == ball ? _self.ball : ball // ignore: cast_nullable_to_non_nullable
as BallEvent,
  ));
}

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BallEventCopyWith<$Res> get ball {
  
  return $BallEventCopyWith<$Res>(_self.ball, (value) {
    return _then(_self.copyWith(ball: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class PenaltyEvent implements GameEvent {
  const PenaltyEvent({required this.inningsIndex, required this.runs, final  String? $type}): $type = $type ?? 'penalty';
  factory PenaltyEvent.fromJson(Map<String, dynamic> json) => _$PenaltyEventFromJson(json);

 final  int inningsIndex;
 final  int runs;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PenaltyEventCopyWith<PenaltyEvent> get copyWith => _$PenaltyEventCopyWithImpl<PenaltyEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PenaltyEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PenaltyEvent&&(identical(other.inningsIndex, inningsIndex) || other.inningsIndex == inningsIndex)&&(identical(other.runs, runs) || other.runs == runs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inningsIndex,runs);

@override
String toString() {
  return 'GameEvent.penalty(inningsIndex: $inningsIndex, runs: $runs)';
}


}

/// @nodoc
abstract mixin class $PenaltyEventCopyWith<$Res> implements $GameEventCopyWith<$Res> {
  factory $PenaltyEventCopyWith(PenaltyEvent value, $Res Function(PenaltyEvent) _then) = _$PenaltyEventCopyWithImpl;
@useResult
$Res call({
 int inningsIndex, int runs
});




}
/// @nodoc
class _$PenaltyEventCopyWithImpl<$Res>
    implements $PenaltyEventCopyWith<$Res> {
  _$PenaltyEventCopyWithImpl(this._self, this._then);

  final PenaltyEvent _self;
  final $Res Function(PenaltyEvent) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? inningsIndex = null,Object? runs = null,}) {
  return _then(PenaltyEvent(
inningsIndex: null == inningsIndex ? _self.inningsIndex : inningsIndex // ignore: cast_nullable_to_non_nullable
as int,runs: null == runs ? _self.runs : runs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class BatterReplacedEvent implements GameEvent {
  const BatterReplacedEvent({required this.inningsIndex, required this.outgoingId, required this.incomingId, this.retiredHurt = false, this.incomingOnStrike = true, final  String? $type}): $type = $type ?? 'batterReplaced';
  factory BatterReplacedEvent.fromJson(Map<String, dynamic> json) => _$BatterReplacedEventFromJson(json);

 final  int inningsIndex;
 final  String outgoingId;
 final  String incomingId;
@JsonKey() final  bool retiredHurt;
@JsonKey() final  bool incomingOnStrike;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BatterReplacedEventCopyWith<BatterReplacedEvent> get copyWith => _$BatterReplacedEventCopyWithImpl<BatterReplacedEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BatterReplacedEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BatterReplacedEvent&&(identical(other.inningsIndex, inningsIndex) || other.inningsIndex == inningsIndex)&&(identical(other.outgoingId, outgoingId) || other.outgoingId == outgoingId)&&(identical(other.incomingId, incomingId) || other.incomingId == incomingId)&&(identical(other.retiredHurt, retiredHurt) || other.retiredHurt == retiredHurt)&&(identical(other.incomingOnStrike, incomingOnStrike) || other.incomingOnStrike == incomingOnStrike));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inningsIndex,outgoingId,incomingId,retiredHurt,incomingOnStrike);

@override
String toString() {
  return 'GameEvent.batterReplaced(inningsIndex: $inningsIndex, outgoingId: $outgoingId, incomingId: $incomingId, retiredHurt: $retiredHurt, incomingOnStrike: $incomingOnStrike)';
}


}

/// @nodoc
abstract mixin class $BatterReplacedEventCopyWith<$Res> implements $GameEventCopyWith<$Res> {
  factory $BatterReplacedEventCopyWith(BatterReplacedEvent value, $Res Function(BatterReplacedEvent) _then) = _$BatterReplacedEventCopyWithImpl;
@useResult
$Res call({
 int inningsIndex, String outgoingId, String incomingId, bool retiredHurt, bool incomingOnStrike
});




}
/// @nodoc
class _$BatterReplacedEventCopyWithImpl<$Res>
    implements $BatterReplacedEventCopyWith<$Res> {
  _$BatterReplacedEventCopyWithImpl(this._self, this._then);

  final BatterReplacedEvent _self;
  final $Res Function(BatterReplacedEvent) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? inningsIndex = null,Object? outgoingId = null,Object? incomingId = null,Object? retiredHurt = null,Object? incomingOnStrike = null,}) {
  return _then(BatterReplacedEvent(
inningsIndex: null == inningsIndex ? _self.inningsIndex : inningsIndex // ignore: cast_nullable_to_non_nullable
as int,outgoingId: null == outgoingId ? _self.outgoingId : outgoingId // ignore: cast_nullable_to_non_nullable
as String,incomingId: null == incomingId ? _self.incomingId : incomingId // ignore: cast_nullable_to_non_nullable
as String,retiredHurt: null == retiredHurt ? _self.retiredHurt : retiredHurt // ignore: cast_nullable_to_non_nullable
as bool,incomingOnStrike: null == incomingOnStrike ? _self.incomingOnStrike : incomingOnStrike // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SwapStrikeEvent implements GameEvent {
  const SwapStrikeEvent({required this.inningsIndex, final  String? $type}): $type = $type ?? 'swapStrike';
  factory SwapStrikeEvent.fromJson(Map<String, dynamic> json) => _$SwapStrikeEventFromJson(json);

 final  int inningsIndex;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwapStrikeEventCopyWith<SwapStrikeEvent> get copyWith => _$SwapStrikeEventCopyWithImpl<SwapStrikeEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SwapStrikeEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwapStrikeEvent&&(identical(other.inningsIndex, inningsIndex) || other.inningsIndex == inningsIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inningsIndex);

@override
String toString() {
  return 'GameEvent.swapStrike(inningsIndex: $inningsIndex)';
}


}

/// @nodoc
abstract mixin class $SwapStrikeEventCopyWith<$Res> implements $GameEventCopyWith<$Res> {
  factory $SwapStrikeEventCopyWith(SwapStrikeEvent value, $Res Function(SwapStrikeEvent) _then) = _$SwapStrikeEventCopyWithImpl;
@useResult
$Res call({
 int inningsIndex
});




}
/// @nodoc
class _$SwapStrikeEventCopyWithImpl<$Res>
    implements $SwapStrikeEventCopyWith<$Res> {
  _$SwapStrikeEventCopyWithImpl(this._self, this._then);

  final SwapStrikeEvent _self;
  final $Res Function(SwapStrikeEvent) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? inningsIndex = null,}) {
  return _then(SwapStrikeEvent(
inningsIndex: null == inningsIndex ? _self.inningsIndex : inningsIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class BowlerChangedEvent implements GameEvent {
  const BowlerChangedEvent({required this.inningsIndex, required this.bowlerId, final  String? $type}): $type = $type ?? 'bowlerChanged';
  factory BowlerChangedEvent.fromJson(Map<String, dynamic> json) => _$BowlerChangedEventFromJson(json);

 final  int inningsIndex;
 final  String bowlerId;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BowlerChangedEventCopyWith<BowlerChangedEvent> get copyWith => _$BowlerChangedEventCopyWithImpl<BowlerChangedEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BowlerChangedEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BowlerChangedEvent&&(identical(other.inningsIndex, inningsIndex) || other.inningsIndex == inningsIndex)&&(identical(other.bowlerId, bowlerId) || other.bowlerId == bowlerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inningsIndex,bowlerId);

@override
String toString() {
  return 'GameEvent.bowlerChanged(inningsIndex: $inningsIndex, bowlerId: $bowlerId)';
}


}

/// @nodoc
abstract mixin class $BowlerChangedEventCopyWith<$Res> implements $GameEventCopyWith<$Res> {
  factory $BowlerChangedEventCopyWith(BowlerChangedEvent value, $Res Function(BowlerChangedEvent) _then) = _$BowlerChangedEventCopyWithImpl;
@useResult
$Res call({
 int inningsIndex, String bowlerId
});




}
/// @nodoc
class _$BowlerChangedEventCopyWithImpl<$Res>
    implements $BowlerChangedEventCopyWith<$Res> {
  _$BowlerChangedEventCopyWithImpl(this._self, this._then);

  final BowlerChangedEvent _self;
  final $Res Function(BowlerChangedEvent) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? inningsIndex = null,Object? bowlerId = null,}) {
  return _then(BowlerChangedEvent(
inningsIndex: null == inningsIndex ? _self.inningsIndex : inningsIndex // ignore: cast_nullable_to_non_nullable
as int,bowlerId: null == bowlerId ? _self.bowlerId : bowlerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RulesChangedEvent implements GameEvent {
  const RulesChangedEvent({required this.rules, final  String? $type}): $type = $type ?? 'rulesChanged';
  factory RulesChangedEvent.fromJson(Map<String, dynamic> json) => _$RulesChangedEventFromJson(json);

 final  MatchRules rules;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesChangedEventCopyWith<RulesChangedEvent> get copyWith => _$RulesChangedEventCopyWithImpl<RulesChangedEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RulesChangedEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesChangedEvent&&(identical(other.rules, rules) || other.rules == rules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rules);

@override
String toString() {
  return 'GameEvent.rulesChanged(rules: $rules)';
}


}

/// @nodoc
abstract mixin class $RulesChangedEventCopyWith<$Res> implements $GameEventCopyWith<$Res> {
  factory $RulesChangedEventCopyWith(RulesChangedEvent value, $Res Function(RulesChangedEvent) _then) = _$RulesChangedEventCopyWithImpl;
@useResult
$Res call({
 MatchRules rules
});


$MatchRulesCopyWith<$Res> get rules;

}
/// @nodoc
class _$RulesChangedEventCopyWithImpl<$Res>
    implements $RulesChangedEventCopyWith<$Res> {
  _$RulesChangedEventCopyWithImpl(this._self, this._then);

  final RulesChangedEvent _self;
  final $Res Function(RulesChangedEvent) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rules = null,}) {
  return _then(RulesChangedEvent(
rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as MatchRules,
  ));
}

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchRulesCopyWith<$Res> get rules {
  
  return $MatchRulesCopyWith<$Res>(_self.rules, (value) {
    return _then(_self.copyWith(rules: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class EndInningsEvent implements GameEvent {
  const EndInningsEvent({required this.inningsIndex, final  String? $type}): $type = $type ?? 'endInnings';
  factory EndInningsEvent.fromJson(Map<String, dynamic> json) => _$EndInningsEventFromJson(json);

 final  int inningsIndex;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EndInningsEventCopyWith<EndInningsEvent> get copyWith => _$EndInningsEventCopyWithImpl<EndInningsEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EndInningsEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EndInningsEvent&&(identical(other.inningsIndex, inningsIndex) || other.inningsIndex == inningsIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inningsIndex);

@override
String toString() {
  return 'GameEvent.endInnings(inningsIndex: $inningsIndex)';
}


}

/// @nodoc
abstract mixin class $EndInningsEventCopyWith<$Res> implements $GameEventCopyWith<$Res> {
  factory $EndInningsEventCopyWith(EndInningsEvent value, $Res Function(EndInningsEvent) _then) = _$EndInningsEventCopyWithImpl;
@useResult
$Res call({
 int inningsIndex
});




}
/// @nodoc
class _$EndInningsEventCopyWithImpl<$Res>
    implements $EndInningsEventCopyWith<$Res> {
  _$EndInningsEventCopyWithImpl(this._self, this._then);

  final EndInningsEvent _self;
  final $Res Function(EndInningsEvent) _then;

/// Create a copy of GameEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? inningsIndex = null,}) {
  return _then(EndInningsEvent(
inningsIndex: null == inningsIndex ? _self.inningsIndex : inningsIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
