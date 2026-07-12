import 'package:cricket_scoring/engine/engine_exception.dart';
import 'package:cricket_scoring/engine/scoring_engine.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import 'engine_harness.dart';

void main() {
  group('§9 scenarios — runs & extras', () {
    test('1. dot ball', () {
      final s = ball(startedInnings());
      expect(inns(s).totalRuns, 0);
      expect(inns(s).legalBalls, 1);
      expect(inns(s).strikerId, 'a1');
    });

    test('2. single rotates strike', () {
      final s = ball(startedInnings(), runs: 1);
      expect(inns(s).totalRuns, 1);
      expect(inns(s).batters['a1']!.runs, 1);
      expect(inns(s).strikerId, 'a2', reason: 'odd run swaps strike');
    });

    test('3. two runs, no swap', () {
      final s = ball(startedInnings(), runs: 2);
      expect(inns(s).totalRuns, 2);
      expect(inns(s).strikerId, 'a1');
    });

    test('4. four and six increment counters, no swap', () {
      final four = ball(startedInnings(), runs: 4);
      expect(inns(four).batters['a1']!.fours, 1);
      expect(inns(four).strikerId, 'a1');

      final six = ball(startedInnings(), runs: 6);
      expect(inns(six).batters['a1']!.sixes, 1);
      expect(inns(six).totalRuns, 6);
      expect(inns(six).strikerId, 'a1');
    });

    test('5. wide: +1, not a legal ball, charged to bowler', () {
      final s = ball(startedInnings(), extra: ExtraType.wide);
      expect(inns(s).totalRuns, 1);
      expect(inns(s).legalBalls, 0);
      expect(inns(s).extras.wides, 1);
      expect(inns(s).bowlers['b1']!.runsConceded, 1);
      expect(inns(s).bowlers['b1']!.wides, 1);
      expect(inns(s).strikerId, 'a1');
    });

    test('6. wide + 2 byes run: +3 wides, still not legal', () {
      final s = ball(startedInnings(), extra: ExtraType.wide, extraRuns: 2);
      expect(inns(s).totalRuns, 3);
      expect(inns(s).extras.wides, 3);
      expect(inns(s).legalBalls, 0);
      expect(inns(s).strikerId, 'a1', reason: '2 runs is even, no swap');
    });

    test('7. no-ball, no run: +1, not legal, free hit pending', () {
      final s = ball(
        startedInnings(matchRules: rules(freeHit: true)),
        extra: ExtraType.noBall,
      );
      expect(inns(s).totalRuns, 1);
      expect(inns(s).legalBalls, 0);
      expect(inns(s).extras.noBalls, 1);
      expect(inns(s).freeHitPending, isTrue);
    });

    test(
      '8. no-ball + 4 off bat: +1 extra +4 to striker, bowler charged 5',
      () {
        final s = ball(
          startedInnings(matchRules: rules(freeHit: true)),
          extra: ExtraType.noBall,
          runs: 4,
        );
        expect(inns(s).totalRuns, 5);
        expect(inns(s).batters['a1']!.runs, 4);
        expect(inns(s).batters['a1']!.fours, 1);
        expect(inns(s).bowlers['b1']!.runsConceded, 5);
        expect(inns(s).freeHitPending, isTrue);
      },
    );

    test('9. bye 1 and leg-bye 3: legal, bowler not charged, correct swap', () {
      final bye = ball(startedInnings(), extra: ExtraType.bye, extraRuns: 1);
      expect(inns(bye).totalRuns, 1);
      expect(inns(bye).extras.byes, 1);
      expect(inns(bye).legalBalls, 1);
      expect(inns(bye).bowlers['b1']!.runsConceded, 0);
      expect(inns(bye).strikerId, 'a2', reason: '1 run swaps');

      final lb = ball(startedInnings(), extra: ExtraType.legBye, extraRuns: 3);
      expect(inns(lb).extras.legByes, 3);
      expect(inns(lb).strikerId, 'a2', reason: '3 runs swaps');
    });
  });

  group('§9 scenarios — wickets', () {
    test('10. bowled: bowler credited, new batter at striker end', () {
      final s = ball(
        startedInnings(),
        wicket: const Wicket(type: DismissalType.bowled, outBatterId: 'a1'),
        newBatter: 'a3',
      );
      expect(inns(s).wickets, 1);
      expect(inns(s).bowlers['b1']!.wickets, 1);
      expect(inns(s).batters['a1']!.isOut, isTrue);
      expect(inns(s).strikerId, 'a3');
      expect(inns(s).fow.single.batterId, 'a1');
      expect(inns(s).partnerships.length, 2);
      expect(inns(s).partnerships.first.unbroken, isFalse);
      expect(inns(s).partnerships.last.unbroken, isTrue);
    });

    test('11. caught without crossing: new batter on strike', () {
      final s = ball(
        startedInnings(),
        wicket: const Wicket(
          type: DismissalType.caught,
          outBatterId: 'a1',
          fielderId: 'b5',
        ),
        newBatter: 'a3',
      );
      expect(inns(s).strikerId, 'a3');
      expect(inns(s).nonStrikerId, 'a2');
    });

    test('11b. caught with batters crossed: survivor keeps strike', () {
      final s = ball(
        startedInnings(),
        wicket: const Wicket(
          type: DismissalType.caught,
          outBatterId: 'a1',
          fielderId: 'b5',
          battersCrossed: true,
        ),
        newBatter: 'a3',
      );
      expect(inns(s).strikerId, 'a2', reason: 'survivor crossed, on strike');
      expect(inns(s).nonStrikerId, 'a3');
    });

    test('12. run out (striker out, 1 completed)', () {
      final s = ball(
        startedInnings(),
        runs: 1,
        wicket: const Wicket(
          type: DismissalType.runOut,
          outBatterId: 'a1',
          runsCompletedBeforeOut: 1,
        ),
        newBatter: 'a3',
      );
      expect(inns(s).totalRuns, 1);
      expect(inns(s).wickets, 1);
      expect(inns(s).batters['a1']!.isOut, isTrue);
      expect(inns(s).bowlers['b1']!.wickets, 0, reason: 'no bowler credit');
      // 1 run completed → the survivor (a2) is on strike, new batter at other end.
      expect(inns(s).strikerId, 'a2');
      expect(inns(s).nonStrikerId, 'a3');
    });

    test('13. run out (non-striker out)', () {
      final s = ball(
        startedInnings(),
        runs: 1,
        wicket: const Wicket(
          type: DismissalType.runOut,
          outBatterId: 'a2',
          runsCompletedBeforeOut: 1,
        ),
        newBatter: 'a3',
      );
      expect(inns(s).wickets, 1);
      expect(inns(s).batters['a2']!.isOut, isTrue);
      expect(inns(s).batters.containsKey('a3'), isTrue);
    });

    test('14. stumped off a wide: allowed, still not a legal ball', () {
      final s = ball(
        startedInnings(),
        extra: ExtraType.wide,
        wicket: const Wicket(
          type: DismissalType.stumped,
          outBatterId: 'a1',
          fielderId: 'bk',
        ),
        newBatter: 'a3',
      );
      expect(inns(s).totalRuns, 1);
      expect(inns(s).legalBalls, 0);
      expect(inns(s).wickets, 1);
      expect(
        inns(s).bowlers['b1']!.wickets,
        1,
        reason: 'stumped credits bowler',
      );
      expect(inns(s).strikerId, 'a3');
    });

    test('15. free hit — bowled is rejected (not out)', () {
      var s = ball(
        startedInnings(matchRules: rules(freeHit: true)),
        extra: ExtraType.noBall,
      );
      expect(inns(s).freeHitPending, isTrue);
      expect(
        () => ball(
          s,
          wicket: const Wicket(type: DismissalType.bowled, outBatterId: 'a1'),
          newBatter: 'a3',
        ),
        throwsA(isA<EngineException>()),
      );
    });

    test('16. free hit that is itself a no-ball carries the free hit', () {
      var s = ball(
        startedInnings(matchRules: rules(freeHit: true)),
        extra: ExtraType.noBall,
      );
      expect(inns(s).freeHitPending, isTrue);
      s = ball(s, extra: ExtraType.noBall); // free-hit delivery is a no-ball
      expect(inns(s).freeHitPending, isTrue, reason: 'free hit carries over');
    });
  });

  group('§9 scenarios — over, strike, bowler limits', () {
    test('17. end-of-over swap combined with odd run on last ball', () {
      var s = startedInnings();
      for (var i = 0; i < 5; i++) {
        s = ball(s); // 5 dots, a1 keeps strike
      }
      s = ball(s, runs: 1); // single on 6th ball
      expect(inns(s).legalBalls, 6);
      expect(inns(s).completedOvers, 1);
      expect(inns(s).ballsThisOver, 0);
      expect(
        inns(s).strikerId,
        'a1',
        reason: 'running swap then over swap nets back to a1',
      );
      expect(inns(s).nonStrikerId, 'a2');
      expect(inns(s).previousBowlerId, 'b1');
    });

    test('18. bowler cannot bowl two overs in a row', () {
      var s = startedInnings();
      for (var i = 0; i < 6; i++) {
        s = ball(s);
      }
      expect(() => ball(s, bowler: 'b1'), throwsA(isA<EngineException>()));
    });

    test('19. bowler over-cap exceeded is rejected', () {
      var s = startedInnings(matchRules: rules(maxOversPerBowler: 1));
      for (var i = 0; i < 6; i++) {
        s = ball(s); // b1 completes his 1 allowed over
      }
      for (var i = 0; i < 6; i++) {
        s = ball(s, bowler: 'b2'); // b2 bowls over 2
      }
      // b1 is not consecutive now, but has used his 1-over quota.
      expect(() => ball(s, bowler: 'b1'), throwsA(isA<EngineException>()));
    });
  });

  group('§9 scenarios — innings end & result', () {
    test('20. all out at players-1 wickets ends the innings', () {
      var s = startedInnings(); // 6 a side → all out at 5
      final incoming = ['a3', 'a4', 'a5', 'a6', null];
      for (var w = 0; w < 5; w++) {
        s = ball(
          s,
          wicket: Wicket(
            type: DismissalType.bowled,
            outBatterId: inns(s).strikerId!,
          ),
          newBatter: incoming[w],
        );
      }
      expect(inns(s).wickets, 5);
      expect(s.status, MatchStatus.inningsBreak);
    });

    test('21. overs completed ends the innings', () {
      var s = startedInnings(matchRules: rules(overs: 1));
      for (var i = 0; i < 6; i++) {
        s = ball(s);
      }
      expect(inns(s).legalBalls, 6);
      expect(s.status, MatchStatus.inningsBreak);
    });

    test('22. target reached mid-innings → win by wickets', () {
      // Innings 1: score 4 in a 1-over innings.
      var s = startedInnings(matchRules: rules(overs: 1));
      s = ball(s, runs: 4);
      for (var i = 0; i < 5; i++) {
        s = ball(s);
      }
      expect(s.status, MatchStatus.inningsBreak);
      expect(s.innings1!.totalRuns, 4);

      // Innings 2: chase 5.
      s = ScoringEngine.apply(
        s,
        const GameEvent.inningsStarted(
          inningsIndex: 1,
          battingTeamId: 'B',
          bowlingTeamId: 'A',
          strikerId: 'b1',
          nonStrikerId: 'b2',
          bowlerId: 'a1',
        ),
      );
      expect(s.innings2!.target, 5);
      s = ball(s, runs: 4); // 4/0
      s = ball(s, runs: 2); // 6/0 → passes 5
      expect(s.status, MatchStatus.completed);
      expect(s.result!.type, MatchResultType.winByWickets);
      expect(s.result!.winnerTeamId, 'B');
    });

    test('23. scores level at the end → tie', () {
      var s = startedInnings(matchRules: rules(overs: 1));
      s = ball(s, runs: 1);
      s = ball(s, runs: 1);
      s = ball(s, runs: 1);
      for (var i = 0; i < 3; i++) {
        s = ball(s);
      }
      expect(s.innings1!.totalRuns, 3);
      expect(s.status, MatchStatus.inningsBreak);

      s = ScoringEngine.apply(
        s,
        const GameEvent.inningsStarted(
          inningsIndex: 1,
          battingTeamId: 'B',
          bowlingTeamId: 'A',
          strikerId: 'b1',
          nonStrikerId: 'b2',
          bowlerId: 'a1',
        ),
      );
      // Chase falls exactly level: 3 off 6 balls, overs done.
      s = ball(s, runs: 1);
      s = ball(s, runs: 1);
      s = ball(s, runs: 1);
      for (var i = 0; i < 3; i++) {
        s = ball(s);
      }
      expect(s.status, MatchStatus.completed);
      expect(s.result!.type, MatchResultType.tie);
    });
  });

  group('§9 scenarios — undo (fold prefixes) & last man', () {
    test('24. undoing a wicket restores the batter and FOW', () {
      final events = <GameEvent>[
        const GameEvent.matchCreated(
          matchId: 'm1',
          rules: MatchRules(
            presetId: 'test',
            oversPerInnings: 5,
            playersPerSide: 6,
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
        const GameEvent.ball(
          BallEvent(
            inningsIndex: 0,
            strikerId: 'a1',
            nonStrikerId: 'a2',
            bowlerId: 'b1',
            runsOffBat: 2,
          ),
        ),
        const GameEvent.ball(
          BallEvent(
            inningsIndex: 0,
            strikerId: 'a1',
            nonStrikerId: 'a2',
            bowlerId: 'b1',
            wicket: Wicket(type: DismissalType.bowled, outBatterId: 'a1'),
            newBatterId: 'a3',
          ),
        ),
      ];

      final withWicket = ScoringEngine.rebuild(events);
      expect(inns(withWicket).wickets, 1);
      expect(inns(withWicket).fow.length, 1);

      final undone = ScoringEngine.rebuild(
        events.sublist(0, events.length - 1),
      );
      expect(inns(undone).wickets, 0);
      expect(inns(undone).fow, isEmpty);
      expect(inns(undone).strikerId, 'a1');
      expect(inns(undone).totalRuns, 2);
    });

    test('25. undo across an over boundary restores bowler eligibility', () {
      final events = <GameEvent>[
        const GameEvent.matchCreated(
          matchId: 'm1',
          rules: MatchRules(
            presetId: 'test',
            oversPerInnings: 5,
            playersPerSide: 6,
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
        for (var i = 0; i < 6; i++)
          const GameEvent.ball(
            BallEvent(
              inningsIndex: 0,
              strikerId: 'a1',
              nonStrikerId: 'a2',
              bowlerId: 'b1',
            ),
          ),
      ];

      final afterOver = ScoringEngine.rebuild(events);
      expect(inns(afterOver).completedOvers, 1);
      expect(inns(afterOver).previousBowlerId, 'b1');

      // Undo the 6th ball → back mid-over, previousBowlerId cleared.
      final midOver = ScoringEngine.rebuild(
        events.sublist(0, events.length - 1),
      );
      expect(inns(midOver).ballsThisOver, 5);
      expect(inns(midOver).previousBowlerId, isNull);
    });

    test('26. last man stands: innings continues past players-1 wickets', () {
      var s = startedInnings(
        matchRules: rules(lastManStands: true), // 6 a side → maxWickets 6
      );
      final incoming = ['a3', 'a4', 'a5', 'a6', null];
      for (var w = 0; w < 5; w++) {
        s = ball(
          s,
          wicket: Wicket(
            type: DismissalType.bowled,
            outBatterId: inns(s).strikerId!,
          ),
          newBatter: incoming[w],
        );
      }
      expect(inns(s).wickets, 5);
      expect(
        s.status,
        MatchStatus.inProgress,
        reason: 'last man bats on, innings not over',
      );
      expect(inns(s).strikerId, isNotNull, reason: 'lone batter on strike');
      expect(inns(s).nonStrikerId, isNull);
    });
  });

  group('box-cricket specifics', () {
    test('LBW is rejected when disabled', () {
      expect(
        () => ball(
          startedInnings(matchRules: rules(lbw: false)),
          wicket: const Wicket(type: DismissalType.lbw, outBatterId: 'a1'),
          newBatter: 'a3',
        ),
        throwsA(isA<EngineException>()),
      );
    });

    test('six-and-out: an off-bat six dismisses the striker', () {
      final s = ball(
        startedInnings(matchRules: rules(sixAndOut: true)),
        runs: 6,
        newBatter: 'a3',
      );
      expect(inns(s).totalRuns, 6, reason: 'the six still counts');
      expect(inns(s).wickets, 1);
      expect(inns(s).batters['a1']!.isOut, isTrue);
      expect(inns(s).batters['a1']!.sixes, 1);
      expect(inns(s).strikerId, 'a3');
    });
  });
}
