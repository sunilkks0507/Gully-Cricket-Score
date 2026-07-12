import 'package:freezed_annotation/freezed_annotation.dart';

part 'fall_of_wicket.freezed.dart';
part 'fall_of_wicket.g.dart';

/// A fall-of-wicket entry: the score and ball position when a wicket fell.
@freezed
abstract class FallOfWicket with _$FallOfWicket {
  const FallOfWicket._();

  const factory FallOfWicket({
    /// 1-based wicket number (1 = first wicket to fall).
    required int wicketNo,
    required String batterId,

    /// Team total at the moment of the fall.
    required int scoreAtFall,

    /// Legal balls bowled at the fall (overs = legalBalls ~/ 6 . % 6).
    required int legalBallsAtFall,
  }) = _FallOfWicket;

  factory FallOfWicket.fromJson(Map<String, dynamic> json) =>
      _$FallOfWicketFromJson(json);

  /// Overs string at the fall, e.g. "12.3".
  String get oversText => '${legalBallsAtFall ~/ 6}.${legalBallsAtFall % 6}';
}

/// A batting partnership (broken or unbroken).
@freezed
abstract class Partnership with _$Partnership {
  const factory Partnership({
    /// The wicket this partnership is for (1 = opening partnership).
    required int forWicket,
    required String batterAId,
    required String batterBId,
    @Default(0) int runs,
    @Default(0) int balls,

    /// True while this partnership is still in progress.
    @Default(true) bool unbroken,
  }) = _Partnership;

  factory Partnership.fromJson(Map<String, dynamic> json) =>
      _$PartnershipFromJson(json);
}
