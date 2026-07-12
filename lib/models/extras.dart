import 'package:freezed_annotation/freezed_annotation.dart';

part 'extras.freezed.dart';
part 'extras.g.dart';

/// Extras accumulated in an innings.
@freezed
abstract class Extras with _$Extras {
  const Extras._();

  const factory Extras({
    @Default(0) int wides,
    @Default(0) int noBalls,
    @Default(0) int byes,
    @Default(0) int legByes,
    @Default(0) int penalties,
  }) = _Extras;

  factory Extras.fromJson(Map<String, dynamic> json) => _$ExtrasFromJson(json);

  /// Total extra runs contributed to the team score.
  int get total => wides + noBalls + byes + legByes + penalties;
}
