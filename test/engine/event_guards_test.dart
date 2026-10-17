import 'package:cricket_scoring/engine/engine_exception.dart';
import 'package:cricket_scoring/engine/scoring_engine.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import 'engine_harness.dart';

/// No in-play action may reopen an innings break or a finished match, or
/// target an innings other than the current one.
void main() {
  final inPlay = <String, GameEvent Function(int idx)>{
    'penalty': (i) => GameEvent.penalty(inningsIndex: i, runs: 5),
    'swap strike': (i) => GameEvent.swapStrike(inningsIndex: i),
    'bowler change': (i) =>
        GameEvent.bowlerChanged(inningsIndex: i, bowlerId: 'b2'),
    'batter replaced': (i) => GameEvent.batterReplaced(
      inningsIndex: i,
      outgoingId: 'a1',
      incomingId: 'a3',
    ),
    'end innings': (i) => GameEvent.endInnings(inningsIndex: i),
    'dismissal without ball': (i) => GameEvent.dismissalWithoutBall(
      inningsIndex: i,
      wicket: const Wicket(type: DismissalType.retiredOut, outBatterId: 'a1'),
    ),
    'ball': (i) => const GameEvent.ball(
      BallEvent(
        inningsIndex: 0,
        strikerId: 'a1',
        nonStrikerId: 'a2',
        bowlerId: 'b1',
      ),
    ),
  };

  MatchState inningsBreak() => ScoringEngine.apply(
    startedInnings(squadSize: 6),
    const GameEvent.endInnings(inningsIndex: 0),
  );

  MatchState completed() {
    var s = ScoringEngine.apply(
      inningsBreak(),
      const GameEvent.inningsStarted(
        inningsIndex: 1,
        battingTeamId: 'B',
        bowlingTeamId: 'A',
        strikerId: 'b1',
        nonStrikerId: 'b2',
        bowlerId: 'a1',
        battingSquadSize: 6,
      ),
    );
    s = ScoringEngine.apply(s, const GameEvent.endInnings(inningsIndex: 1));
    expect(s.status, MatchStatus.completed);
    return s;
  }

  for (final entry in inPlay.entries) {
    test('${entry.key} is rejected during the innings break', () {
      final s = inningsBreak();
      expect(
        () => ScoringEngine.apply(s, entry.value(0)),
        throwsA(isA<EngineException>()),
      );
    });

    test('${entry.key} is rejected after the result', () {
      final s = completed();
      expect(
        () => ScoringEngine.apply(s, entry.value(1)),
        throwsA(isA<EngineException>()),
      );
    });
  }

  test('an event for the other innings is rejected', () {
    final s = ScoringEngine.apply(
      inningsBreak(),
      const GameEvent.inningsStarted(
        inningsIndex: 1,
        battingTeamId: 'B',
        bowlingTeamId: 'A',
        strikerId: 'b1',
        nonStrikerId: 'b2',
        bowlerId: 'a1',
      ),
    );
    expect(
      () => ScoringEngine.apply(
        s,
        const GameEvent.penalty(inningsIndex: 0, runs: 5),
      ),
      throwsA(isA<EngineException>()),
    );
    expect(
      () => ScoringEngine.apply(s, const GameEvent.endInnings(inningsIndex: 0)),
      throwsA(isA<EngineException>()),
    );
  });

  test('the second innings cannot start before the first ends', () {
    final s = startedInnings(squadSize: 6);
    expect(
      () => ScoringEngine.apply(
        s,
        const GameEvent.inningsStarted(
          inningsIndex: 1,
          battingTeamId: 'B',
          bowlingTeamId: 'A',
          strikerId: 'b1',
          nonStrikerId: 'b2',
          bowlerId: 'a1',
        ),
      ),
      throwsA(isA<EngineException>()),
    );
  });

  test('in-play events still work during a live innings', () {
    var s = startedInnings(squadSize: 6);
    s = ScoringEngine.apply(
      s,
      const GameEvent.penalty(inningsIndex: 0, runs: 5),
    );
    s = ScoringEngine.apply(s, const GameEvent.swapStrike(inningsIndex: 0));
    expect(inns(s).totalRuns, 5);
    expect(inns(s).strikerId, 'a2');
    expect(s.status, MatchStatus.inProgress);
  });
}
