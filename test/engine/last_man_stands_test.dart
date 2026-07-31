import 'package:cricket_scoring/engine/engine_exception.dart';
import 'package:cricket_scoring/engine/scoring_engine.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import 'engine_harness.dart';

void main() {
  /// A 3-man side batting with last-man-stands: after 2 wickets a1 is alone.
  MatchState loneBatterState() {
    var s = startedInnings(
      matchRules: rules(players: 3, lastManStands: true, overs: 5),
      squadSize: 3,
    );
    // a2 (non-striker) is run out, a3 comes in; then a3 goes, leaving a1 alone.
    s = ball(
      s,
      wicket: const Wicket(type: DismissalType.runOut, outBatterId: 'a2'),
      newBatter: 'a3',
    );
    s = ball(
      s,
      wicket: const Wicket(type: DismissalType.bowled, outBatterId: 'a1'),
      newBatter: null,
    );
    return s;
  }

  group('last man stands', () {
    test('a lone batter is left on strike and the innings continues', () {
      final s = loneBatterState();
      expect(s.status, MatchStatus.inProgress);
      expect(inns(s).wickets, 2);
      expect(inns(s).strikerId, isNotNull);
      expect(inns(s).nonStrikerId, isNull, reason: 'nobody at the other end');
    });

    test('the lone batter can face deliveries and score', () {
      var s = loneBatterState();
      final lone = inns(s).strikerId!;

      s = ball(s, runs: 4);
      expect(inns(s).totalRuns, 4);
      expect(inns(s).batters[lone]!.runs, 4);
      expect(inns(s).strikerId, lone, reason: 'still on strike');
    });

    test('odd runs count and the lone batter keeps strike', () {
      var s = loneBatterState();
      final lone = inns(s).strikerId!;

      s = ball(s, runs: 1);
      expect(inns(s).totalRuns, 1, reason: 'single counts normally');
      expect(inns(s).strikerId, lone, reason: 'nobody to swap with');
      expect(inns(s).nonStrikerId, isNull);
    });

    test('end of over does not strand the lone batter', () {
      var s = loneBatterState();
      final lone = inns(s).strikerId!;
      // 2 legal balls already bowled (the two wickets); finish the over.
      for (var i = 0; i < 4; i++) {
        s = ball(s);
      }
      expect(inns(s).completedOvers, 1);
      s = ScoringEngine.apply(
        s,
        const GameEvent.bowlerChanged(inningsIndex: 0, bowlerId: 'b2'),
      );
      expect(inns(s).strikerId, lone, reason: 'still batting after the over');
      expect(s.status, MatchStatus.inProgress);

      s = ball(s, runs: 2);
      expect(inns(s).batters[lone]!.runs, 2);
    });

    test('innings ends when the lone batter is out', () {
      var s = loneBatterState();
      final lone = inns(s).strikerId!;
      s = ball(
        s,
        wicket: Wicket(type: DismissalType.bowled, outBatterId: lone),
        newBatter: null,
      );
      expect(inns(s).wickets, 3);
      expect(s.status, MatchStatus.inningsBreak);
    });

    test('innings ends when the overs run out with the lone batter in', () {
      var s = startedInnings(
        matchRules: rules(players: 3, lastManStands: true, overs: 1),
        squadSize: 3,
      );
      s = ball(
        s,
        wicket: const Wicket(type: DismissalType.bowled, outBatterId: 'a1'),
        newBatter: 'a3',
      );
      s = ball(
        s,
        wicket: const Wicket(type: DismissalType.bowled, outBatterId: 'a3'),
        newBatter: null,
      );
      expect(s.status, MatchStatus.inProgress, reason: 'lone batter bats on');
      // 2 balls gone; 4 more completes the single over.
      for (var i = 0; i < 4; i++) {
        s = ball(s);
      }
      expect(inns(s).legalBalls, 6);
      expect(s.status, MatchStatus.inningsBreak);
    });

    test('without last-man-stands a lone batter cannot bat', () {
      var s = startedInnings(
        matchRules: rules(players: 4, lastManStands: false),
        squadSize: 4,
      );
      // 4-man side, no last-man-stands => all out at 3.
      s = ball(
        s,
        wicket: const Wicket(type: DismissalType.bowled, outBatterId: 'a1'),
        newBatter: 'a3',
      );
      s = ball(
        s,
        wicket: const Wicket(type: DismissalType.bowled, outBatterId: 'a3'),
        newBatter: 'a4',
      );
      s = ball(
        s,
        wicket: const Wicket(type: DismissalType.bowled, outBatterId: 'a4'),
        newBatter: null,
      );
      expect(s.status, MatchStatus.inningsBreak, reason: 'all out');
    });

    test('manual strike swap is rejected with only one batter', () {
      final s = loneBatterState();
      expect(
        () =>
            ScoringEngine.apply(s, const GameEvent.swapStrike(inningsIndex: 0)),
        throwsA(isA<EngineException>()),
      );
    });
  });

  group('batter replacement', () {
    test('retired hurt is not a wicket and the batter can return', () {
      var s = startedInnings(matchRules: rules(players: 4), squadSize: 4);
      s = ball(s, runs: 10 - 10); // a dot, a1 on strike

      // a1 retires hurt, a3 comes in.
      s = ScoringEngine.apply(
        s,
        const GameEvent.batterReplaced(
          inningsIndex: 0,
          outgoingId: 'a1',
          incomingId: 'a3',
          retiredHurt: true,
        ),
      );
      expect(inns(s).wickets, 0, reason: 'retired hurt is not a wicket');
      expect(inns(s).batters['a1']!.isRetiredNotOut, isTrue);
      expect(inns(s).strikerId, 'a3');

      // a1 returns later in place of a3.
      s = ScoringEngine.apply(
        s,
        const GameEvent.batterReplaced(
          inningsIndex: 0,
          outgoingId: 'a3',
          incomingId: 'a1',
        ),
      );
      expect(
        inns(s).batters['a1']!.isRetiredNotOut,
        isFalse,
        reason: 'resumes his innings',
      );
      expect(inns(s).strikerId, 'a1');
      // a1 can bat again.
      s = ball(s, runs: 4);
      expect(inns(s).batters['a1']!.runs, 4);
    });
  });

  group('rules changed mid-match', () {
    test('extending the overs lets play continue', () {
      var s = startedInnings(matchRules: rules(overs: 1), squadSize: 6);
      for (var i = 0; i < 6; i++) {
        s = ball(s);
      }
      expect(s.status, MatchStatus.inningsBreak, reason: '1 over done');

      // Bump to 2 overs — but the innings already closed, so it stays closed.
      final extended = ScoringEngine.apply(
        s,
        GameEvent.rulesChanged(rules: rules(overs: 2)),
      );
      expect(extended.rules.oversPerInnings, 2);
    });

    test('cutting the overs below what is bowled ends the innings at once', () {
      var s = startedInnings(matchRules: rules(overs: 5), squadSize: 6);
      for (var i = 0; i < 6; i++) {
        s = ball(s);
      }
      expect(s.status, MatchStatus.inProgress);

      s = ScoringEngine.apply(
        s,
        GameEvent.rulesChanged(rules: rules(overs: 1)),
      );
      expect(s.status, MatchStatus.inningsBreak);
    });

    test('new rules apply to later balls only', () {
      // Start with six-and-out off; a six is just runs.
      var s = startedInnings(matchRules: rules(sixAndOut: false), squadSize: 6);
      s = ball(s, runs: 6);
      expect(inns(s).wickets, 0);

      // Turn six-and-out on; the next six also costs a wicket.
      s = ScoringEngine.apply(
        s,
        GameEvent.rulesChanged(rules: rules(sixAndOut: true)),
      );
      s = ball(s, runs: 6, newBatter: 'a3');
      expect(inns(s).wickets, 1);
      expect(inns(s).totalRuns, 12, reason: 'both sixes counted');
    });
  });
}
