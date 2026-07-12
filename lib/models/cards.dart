import 'package:freezed_annotation/freezed_annotation.dart';

part 'cards.freezed.dart';
part 'cards.g.dart';

/// A batter's running figures within an innings.
@freezed
abstract class BatterCard with _$BatterCard {
  const BatterCard._();

  const factory BatterCard({
    required String playerId,
    @Default(0) int runs,
    @Default(0) int balls,
    @Default(0) int fours,
    @Default(0) int sixes,

    /// True once dismissed (a wicket). Retired-hurt/absent are tracked via
    /// [isRetiredNotOut], not this flag.
    @Default(false) bool isOut,

    /// Left the crease not out (retired hurt / absent) — can return.
    @Default(false) bool isRetiredNotOut,

    /// Human-readable dismissal, e.g. "c Sharma b Khan" (set on dismissal).
    String? dismissalText,
  }) = _BatterCard;

  factory BatterCard.fromJson(Map<String, dynamic> json) =>
      _$BatterCardFromJson(json);

  /// Strike rate (runs per 100 balls). 0 when no balls faced.
  double get strikeRate => balls == 0 ? 0 : (runs * 100) / balls;

  /// Whether this batter has faced a ball or is otherwise part of the innings.
  bool get hasBatted => balls > 0 || runs > 0 || isOut || isRetiredNotOut;
}

/// A bowler's running figures within an innings.
@freezed
abstract class BowlerCard with _$BowlerCard {
  const BowlerCard._();

  const factory BowlerCard({
    required String playerId,

    /// Legal balls bowled (wides/no-balls excluded).
    @Default(0) int balls,

    /// Runs conceded (off bat + wides + no-ball penalty; NOT byes/leg-byes).
    @Default(0) int runsConceded,
    @Default(0) int wickets,
    @Default(0) int maidens,
    @Default(0) int wides,
    @Default(0) int noBalls,
  }) = _BowlerCard;

  factory BowlerCard.fromJson(Map<String, dynamic> json) =>
      _$BowlerCardFromJson(json);

  /// Completed overs bowled.
  int get completedOvers => balls ~/ 6;

  /// Balls into the current (incomplete) over, 0..5.
  int get ballsThisOver => balls % 6;

  /// Overs string, e.g. "3.4".
  String get oversText => '$completedOvers.$ballsThisOver';

  /// Economy rate (runs per over). 0 when no balls bowled.
  double get economy => balls == 0 ? 0 : (runsConceded * 6) / balls;
}
