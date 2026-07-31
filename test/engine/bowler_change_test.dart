import 'package:cricket_scoring/engine/engine_exception.dart';
import 'package:cricket_scoring/engine/projections.dart';
import 'package:cricket_scoring/engine/scoring_engine.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import 'engine_harness.dart';

void main() {
  group('bowler changes', () {
    test(
      'over end clears the bowler so the UI can prompt for the next one',
      () {
        var s = startedInnings();
        for (var i = 0; i < 6; i++) {
          s = ball(s);
        }
        expect(inns(s).completedOvers, 1);
        expect(inns(s).bowlerId, isNull, reason: 'prompts for a new bowler');
        expect(inns(s).previousBowlerId, 'b1');
      },
    );

    test('bowlerChanged sets the bowler for the new over', () {
      var s = startedInnings();
      for (var i = 0; i < 6; i++) {
        s = ball(s);
      }
      s = ScoringEngine.apply(
        s,
        const GameEvent.bowlerChanged(inningsIndex: 0, bowlerId: 'b2'),
      );
      expect(inns(s).bowlerId, 'b2');
      // and play continues with that bowler
      s = ball(s, runs: 1);
      expect(inns(s).bowlers['b2']!.balls, 1);
    });

    test('bowlerChanged rejects the same bowler two overs in a row', () {
      var s = startedInnings();
      for (var i = 0; i < 6; i++) {
        s = ball(s);
      }
      expect(
        () => ScoringEngine.apply(
          s,
          const GameEvent.bowlerChanged(inningsIndex: 0, bowlerId: 'b1'),
        ),
        throwsA(isA<EngineException>()),
      );
    });

    test('bowler can be swapped mid-over', () {
      var s = startedInnings();
      s = ball(s); // b1 bowls 1 legal ball
      expect(inns(s).ballsThisOver, 1);

      s = ScoringEngine.apply(
        s,
        const GameEvent.bowlerChanged(inningsIndex: 0, bowlerId: 'b2'),
      );
      expect(inns(s).bowlerId, 'b2', reason: 'mid-over swap allowed');

      // b2 finishes the over; both bowlers keep their own figures.
      s = ball(s, runs: 4);
      expect(inns(s).bowlers['b1']!.balls, 1);
      expect(inns(s).bowlers['b2']!.balls, 1);
      expect(inns(s).bowlers['b2']!.runsConceded, 4);
      expect(inns(s).ballsThisOver, 2);
    });

    test('mid-over swap finishes the SAME over — it does not restart it', () {
      var s = startedInnings();
      // b1 bowls 4 balls of the over.
      for (var i = 0; i < 4; i++) {
        s = ball(s);
      }
      expect(inns(s).ballsThisOver, 4);
      expect(inns(s).legalBalls, 4);

      // Swap to b2 mid-over.
      s = ScoringEngine.apply(
        s,
        const GameEvent.bowlerChanged(inningsIndex: 0, bowlerId: 'b2'),
      );
      expect(inns(s).ballsThisOver, 4, reason: 'over position is preserved');

      // b2 bowls the 5th ball — still the same over, not a new one.
      s = ball(s);
      expect(inns(s).ballsThisOver, 5);
      expect(inns(s).completedOvers, 0, reason: 'over not complete yet');

      // The 6th ball completes the over (6 legal balls in total, not 6 each).
      s = ball(s);
      expect(inns(s).legalBalls, 6);
      expect(inns(s).completedOvers, 1);
      expect(inns(s).ballsThisOver, 0, reason: 'over rolled over');
      expect(inns(s).bowlerId, isNull, reason: 'prompts for the next bowler');

      // Balls are attributed to whoever actually bowled them.
      expect(inns(s).bowlers['b1']!.balls, 4);
      expect(inns(s).bowlers['b2']!.balls, 2);
      // The bowler who finished the over is the one barred from the next one.
      expect(inns(s).previousBowlerId, 'b2');
    });

    test('bowlerChanged respects the per-bowler over cap at over start', () {
      var s = startedInnings(matchRules: rules(maxOversPerBowler: 1));
      for (var i = 0; i < 6; i++) {
        s = ball(s); // b1 uses his single over
      }
      s = ScoringEngine.apply(
        s,
        const GameEvent.bowlerChanged(inningsIndex: 0, bowlerId: 'b2'),
      );
      for (var i = 0; i < 6; i++) {
        s = ball(s); // b2 uses his single over
      }
      expect(
        () => ScoringEngine.apply(
          s,
          const GameEvent.bowlerChanged(inningsIndex: 0, bowlerId: 'b1'),
        ),
        throwsA(isA<EngineException>()),
        reason: 'b1 has already bowled his quota',
      );
    });
  });

  group('result text uses team names', () {
    String teamName(String id) =>
        const {'A': 'Strikers', 'B': 'Chargers'}[id] ?? id;

    test('win by wickets names the winner', () {
      const r = MatchResult(
        type: MatchResultType.winByWickets,
        winnerTeamId: 'B',
        margin: 5,
        marginUnit: 'wickets',
        summary: 'B won by 5 wickets',
      );
      expect(Projections.resultText(r, teamName), 'Chargers won by 5 wickets');
    });

    test('win by runs names the winner and singularises', () {
      const r = MatchResult(
        type: MatchResultType.winByRuns,
        winnerTeamId: 'A',
        margin: 1,
        marginUnit: 'runs',
        summary: 'A won by 1 runs',
      );
      expect(Projections.resultText(r, teamName), 'Strikers won by 1 run');
    });

    test('tie and no-result need no team name', () {
      expect(
        Projections.resultText(
          const MatchResult(type: MatchResultType.tie, summary: ''),
          teamName,
        ),
        'Match tied',
      );
      expect(
        Projections.resultText(
          const MatchResult(type: MatchResultType.noResult, summary: ''),
          teamName,
        ),
        'No result',
      );
    });

    test('never leaks a raw id when the team is unknown', () {
      const r = MatchResult(
        type: MatchResultType.winByWickets,
        winnerTeamId: 'uuid-1234',
        margin: 3,
        marginUnit: 'wickets',
        summary: 'uuid-1234 won by 3 wickets',
      );
      // A resolver that falls back to a friendly label (as MatchSession does).
      String safeName(String id) => 'Team';
      expect(Projections.resultText(r, safeName), 'Team won by 3 wickets');
    });
  });
}
