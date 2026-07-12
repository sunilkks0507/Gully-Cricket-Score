import 'match_rules.dart';

/// CricScore ships **box cricket only** (limited overs, no LBW). The organiser
/// picks overs / players / joker at setup; the ruleset itself is box cricket.
/// See Design/Instructions.docx and docs/05-gully-cricket-rules.md.
enum MatchPreset { boxCricket, custom }

/// Shipped [MatchRules] presets and lookup helpers.
abstract final class MatchPresets {
  /// Box Cricket (default): limited overs, no LBW, wides/no-balls are extras but
  /// not legal deliveries (re-bowled). Overs/players/joker are set at setup.
  static const MatchRules boxCricket = MatchRules(
    presetId: 'box_cricket',
    label: 'Box Cricket',
    oversPerInnings: 5,
    playersPerSide: 6,
    maxOversPerBowler: 2,
    lbwEnabled: false,
    // Box cricket is typically no-free-hit; the organiser can turn it on.
    freeHitAfterNoBall: false,
    keeperPresent: false,
    wideReBowled: true,
    noBallReBowled: true,
  );

  /// Custom base — starts from box-cricket defaults, ready to be edited.
  static const MatchRules custom = MatchRules(
    presetId: 'custom',
    label: 'Custom',
    oversPerInnings: 5,
    playersPerSide: 6,
    maxOversPerBowler: 2,
    lbwEnabled: false,
    freeHitAfterNoBall: false,
    keeperPresent: false,
  );

  /// All presets in display order.
  static const List<MatchRules> all = [boxCricket, custom];

  static const Map<MatchPreset, MatchRules> _byEnum = {
    MatchPreset.boxCricket: boxCricket,
    MatchPreset.custom: custom,
  };

  /// The [MatchRules] for a [MatchPreset].
  static MatchRules of(MatchPreset preset) => _byEnum[preset]!;

  /// Look up a preset by its `presetId`; returns null if unknown.
  static MatchRules? byId(String presetId) {
    for (final rules in all) {
      if (rules.presetId == presetId) return rules;
    }
    return null;
  }
}
