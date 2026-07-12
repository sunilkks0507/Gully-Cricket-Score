import 'package:cricket_scoring/models/enums.dart';
import 'package:cricket_scoring/models/match_presets.dart';
import 'package:cricket_scoring/models/match_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Box Cricket preset (CricScore)', () {
    test('has the box-cricket rule shape', () {
      const r = MatchPresets.boxCricket;
      expect(r.presetId, 'box_cricket');
      expect(r.lbwEnabled, isFalse, reason: 'box cricket has no LBW');
      expect(r.wideReBowled, isTrue, reason: 'wides are re-bowled (not legal)');
      expect(r.noBallReBowled, isTrue);
      expect(r.oversPerInnings, greaterThan(0));
      expect(r.playersPerSide, greaterThan(1));
      expect(r.maxOversPerBowler, greaterThan(0));
    });

    test('lookup by id and enum resolve to the same rules', () {
      expect(MatchPresets.byId('box_cricket'), MatchPresets.boxCricket);
      expect(MatchPresets.of(MatchPreset.boxCricket), MatchPresets.boxCricket);
      expect(MatchPresets.byId('does_not_exist'), isNull);
    });

    test('every shipped preset round-trips through JSON', () {
      for (final preset in MatchPresets.all) {
        final restored = MatchRules.fromJson(preset.toJson());
        expect(restored, preset, reason: 'preset ${preset.presetId}');
      }
    });
  });

  group('MatchRules derived values', () {
    test('ballsPerInnings = overs * 6', () {
      const r = MatchRules(oversPerInnings: 5);
      expect(r.ballsPerInnings, 30);
    });

    test('maxWickets is players-1 normally, players with last-man-stands', () {
      expect(const MatchRules(playersPerSide: 6).maxWickets, 5);
      expect(
        const MatchRules(playersPerSide: 6, lastManStands: true).maxWickets,
        6,
      );
    });
  });

  group('JSON is additive (forward-compatible)', () {
    test('absent fields fall back to defaults', () {
      // Simulate an old row that predates several rule flags.
      final json = {
        'presetId': 'box_cricket',
        'label': 'Box Cricket',
        'oversPerInnings': 8,
        'playersPerSide': 7,
      };
      final r = MatchRules.fromJson(json);
      expect(r.oversPerInnings, 8);
      expect(r.playersPerSide, 7);
      // Defaults for everything not present:
      expect(r.maxOversPerBowler, 4);
      expect(r.freeHitAfterNoBall, isTrue);
      expect(r.superOver, SuperOverRule.none);
      expect(r.sixAndOut, isFalse);
    });

    test('unknown extra keys are ignored, not fatal', () {
      final json = MatchPresets.boxCricket.toJson()..['someFutureFlag'] = true;
      expect(() => MatchRules.fromJson(json), returnsNormally);
    });
  });
}
