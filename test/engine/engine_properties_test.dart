import 'package:cricket_scoring/engine/scoring_engine.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

/// Property tests: invariants that must hold for ANY event sequence, plus the
/// undo/redo law (folding is consistent with single-step apply).
void main() {
  /// Play a scripted, varied but valid innings and return the event log.
  List<GameEvent> scriptedInnings() {
    final events = <GameEvent>[
      const GameEvent.matchCreated(
        matchId: 'm1',
        rules: MatchRules(
          presetId: 'test',
          oversPerInnings: 5,
          playersPerSide: 6,
          lbwEnabled: false,
        ),
        teamAId: 'A',
        teamBId: 'B',
      ),
      const GameEvent.inningsStarted(
        inningsIndex: 0,
        battingTeamId: 'A',
        bowlingTeamId: 'B',
        strikerId: 'a1',
        nonStrikerId: 'a2',
        bowlerId: 'b1',
      ),
    ];
    var state = ScoringEngine.rebuild(events);

    void bowl({
      int runs = 0,
      ExtraType extra = ExtraType.none,
      int extraRuns = 0,
      Wicket? wicket,
      String? newBatter,
      String? bowler,
    }) {
      final inn = state.activeInnings!;
      final ev = GameEvent.ball(
        BallEvent(
          inningsIndex: state.currentInnings,
          strikerId: inn.strikerId!,
          nonStrikerId: inn.nonStrikerId!,
          bowlerId: bowler ?? inn.bowlerId!,
          runsOffBat: runs,
          extraType: extra,
          extraRuns: extraRuns,
          wicket: wicket,
          newBatterId: newBatter,
        ),
      );
      events.add(ev);
      state = ScoringEngine.apply(state, ev);
    }

    // Over 1 (b1): mix of runs, a wide, a bye.
    bowl(runs: 1);
    bowl(extra: ExtraType.wide);
    bowl(runs: 4);
    bowl(extra: ExtraType.bye, extraRuns: 1);
    bowl();
    bowl(runs: 2);
    bowl(runs: 1); // 6th legal ball → over ends, strike/bowler rotate
    // Over 2 (b2): a wicket, a no-ball, more runs.
    bowl(
      bowler: 'b2',
      wicket: const Wicket(type: DismissalType.bowled, outBatterId: 'a1'),
      newBatter: 'a3',
    );
    bowl(extra: ExtraType.noBall, runs: 1);
    bowl(runs: 3);
    bowl(extra: ExtraType.legBye, extraRuns: 2);
    bowl();

    return events;
  }

  void checkInvariants(InningsState inn) {
    final batterRuns = inn.batters.values.fold<int>(
      0,
      (sum, b) => sum + b.runs,
    );
    expect(
      inn.totalRuns,
      batterRuns + inn.extras.total,
      reason: 'team total == batter runs + extras',
    );

    final bowlerBalls = inn.bowlers.values.fold<int>(
      0,
      (sum, b) => sum + b.balls,
    );
    expect(
      inn.legalBalls,
      bowlerBalls,
      reason: 'legal balls == sum of bowler balls',
    );

    final bowlerWickets = inn.bowlers.values.fold<int>(
      0,
      (sum, b) => sum + b.wickets,
    );
    expect(
      bowlerWickets,
      lessThanOrEqualTo(inn.wickets),
      reason: 'bowler-credited wickets never exceed total wickets',
    );

    expect(
      inn.wickets,
      inn.fow.length,
      reason: 'one fall-of-wicket entry per wicket',
    );
  }

  test('conservation invariants hold after a full innings', () {
    final state = ScoringEngine.rebuild(scriptedInnings());
    checkInvariants(state.activeInnings!);
  });

  test('invariants hold at every prefix of the event log', () {
    final events = scriptedInnings();
    for (var k = 2; k <= events.length; k++) {
      final state = ScoringEngine.rebuild(events.sublist(0, k));
      final inn = state.activeInnings;
      if (inn != null) checkInvariants(inn);
    }
  });

  test(
    'undo/redo law: apply(rebuild(prefix), next) == rebuild(prefix+next)',
    () {
      final events = scriptedInnings();
      for (var k = 1; k < events.length; k++) {
        final before = ScoringEngine.rebuild(events.sublist(0, k));
        final stepwise = ScoringEngine.apply(before, events[k]);
        final rebuilt = ScoringEngine.rebuild(events.sublist(0, k + 1));
        expect(stepwise, rebuilt, reason: 'mismatch applying event #$k');
      }
    },
  );

  test('rebuild is deterministic (same log → identical state)', () {
    final events = scriptedInnings();
    expect(ScoringEngine.rebuild(events), ScoringEngine.rebuild(events));
  });
}
