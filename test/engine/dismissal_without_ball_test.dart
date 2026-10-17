import 'package:cricket_scoring/engine/engine_exception.dart';
import 'package:cricket_scoring/engine/scoring_engine.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import 'engine_harness.dart';

/// Retired out / timed out take a wicket without a delivery being bowled.
void main() {
  MatchState out(
    MatchState s,
    String batter, {
    DismissalType type = DismissalType.retiredOut,
    String? next,
  }) => ScoringEngine.apply(
    s,
    GameEvent.dismissalWithoutBall(
      inningsIndex: s.currentInnings,
      wicket: Wicket(type: type, outBatterId: batter),
      newBatterId: next,
    ),
  );

  test('a wicket falls but no ball, run or bowler figure changes', () {
    var s = startedInnings(matchRules: rules(players: 4), squadSize: 4);
    s = ball(s, runs: 2);
    final before = inns(s);

    s = out(s, 'a1', next: 'a3');
    final inn = inns(s);
    expect(inn.wickets, 1);
    expect(inn.legalBalls, before.legalBalls);
    expect(inn.ballsThisOver, before.ballsThisOver);
    expect(inn.totalRuns, before.totalRuns);
    expect(inn.batters['a1']!.balls, before.batters['a1']!.balls);
    expect(inn.bowlers['b1'], before.bowlers['b1']);
    expect(inn.batters['a1']!.isOut, isTrue);
    expect(inn.dismissals['a1']!.type, DismissalType.retiredOut);
    expect(inn.fow.single.scoreAtFall, 2);
    expect(inn.strikerId, 'a3', reason: 'new batter at the vacated end');
    expect(inn.partnerships.last.batterAId, 'a3');
  });

  test('the non-striker can be timed out', () {
    var s = startedInnings(matchRules: rules(players: 4), squadSize: 4);
    s = out(s, 'a2', type: DismissalType.timedOut, next: 'a3');
    expect(inns(s).strikerId, 'a1');
    expect(inns(s).nonStrikerId, 'a3');
  });

  test('ends the innings when it is the last wicket', () {
    var s = startedInnings(matchRules: rules(players: 2), squadSize: 2);
    s = out(s, 'a1');
    expect(s.status, MatchStatus.inningsBreak);
  });

  test('leaves a lone batter under last man stands', () {
    var s = startedInnings(
      matchRules: rules(players: 2, lastManStands: true),
      squadSize: 2,
    );
    s = out(s, 'a1');
    expect(s.status, MatchStatus.inProgress);
    expect(inns(s).strikerId, 'a2');
    expect(inns(s).nonStrikerId, isNull);
  });

  test('ball-dependent dismissals are rejected', () {
    final s = startedInnings(matchRules: rules(players: 4), squadSize: 4);
    expect(
      () => out(s, 'a1', type: DismissalType.bowled),
      throwsA(isA<EngineException>()),
    );
  });

  test('older logs with retired out on a ball still fold', () {
    var s = startedInnings(matchRules: rules(players: 4), squadSize: 4);
    s = ball(
      s,
      wicket: const Wicket(type: DismissalType.retiredOut, outBatterId: 'a1'),
      newBatter: 'a3',
    );
    expect(inns(s).wickets, 1);
    expect(inns(s).legalBalls, 1, reason: 'old behaviour preserved');
  });
}
