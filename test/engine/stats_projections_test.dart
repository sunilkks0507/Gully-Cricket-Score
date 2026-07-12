import 'package:cricket_scoring/engine/projections.dart';
import 'package:cricket_scoring/engine/scoring_engine.dart';
import 'package:cricket_scoring/engine/stats.dart';
import 'package:cricket_scoring/engine/tournament_math.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import 'engine_harness.dart';

void main() {
  test('scorecard renders dismissal text and figures', () {
    var s = startedInnings(matchRules: rules(overs: 1));
    s = ball(s, runs: 4); // a1 4
    s = ball(s, runs: 1); // a1 -> a2 on strike
    s = ball(
      s,
      wicket: const Wicket(
        type: DismissalType.caught,
        outBatterId: 'a2',
        fielderId: 'b5',
        bowlerId: 'b1',
      ),
      newBatter: 'a3',
    );

    final card = Projections.scorecard(
      s.activeInnings!,
      names: {
        'a1': 'Rohit',
        'a2': 'Gill',
        'a3': 'Pant',
        'b1': 'Bumrah',
        'b5': 'Kohli',
      },
    );

    expect(card.total, 5);
    expect(card.wickets, 1);
    final gill = card.batters.firstWhere((b) => b.playerId == 'a2');
    expect(gill.dismissalText, 'c Kohli b Bumrah');
    expect(gill.notOut, isFalse);
    final rohit = card.batters.firstWhere((b) => b.playerId == 'a1');
    expect(rohit.runs, 5, reason: 'four + single');
    expect(rohit.fours, 1);
    expect(rohit.notOut, isTrue);

    final bumrah = card.bowlers.firstWhere((b) => b.playerId == 'b1');
    expect(bumrah.wickets, 1);
    expect(bumrah.runs, 5);
  });

  test('commentary reads back the log newest-first', () {
    final events = [
      const GameEvent.matchCreated(
        matchId: 'm1',
        rules: MatchRules(presetId: 't', oversPerInnings: 1, playersPerSide: 6),
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
          runsOffBat: 4,
        ),
      ),
    ];
    final lines = Projections.commentary(
      events,
      0,
      names: {'a1': 'Rohit', 'b1': 'Bumrah'},
    );
    expect(lines.first, contains('FOUR'));
    expect(lines.first, contains('Rohit'));
    expect(lines.first, startsWith('0.1'));
  });

  MatchState playCompletedMatch() {
    // Innings 1: A scores 4 in a 1-over match.
    var s = startedInnings(matchRules: rules(overs: 1));
    s = ball(s, runs: 4);
    for (var i = 0; i < 5; i++) {
      s = ball(s);
    }
    // Innings 2: B chases 5 with a six.
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
    s = ball(s, runs: 6);
    return s;
  }

  test('stats aggregate batting and bowling across innings', () {
    final s = playCompletedMatch();
    expect(s.status, MatchStatus.completed);

    final stats = StatsEngine.aggregate([s]);
    expect(stats['a1']!.runs, 4);
    expect(stats['a1']!.notOuts, 1);
    expect(stats['a1']!.ballsBowled, 1, reason: 'a1 bowled the chase ball');
    expect(stats['a1']!.runsConceded, 6);
    expect(stats['b1']!.runs, 6);
    expect(stats['b1']!.sixes, 1);
    expect(stats['b1']!.ballsBowled, 6, reason: 'b1 bowled innings 1');
    expect(stats['b1']!.matches, 1);
  });

  test('CompletedMatch.fromMatch captures innings and result', () {
    final s = playCompletedMatch();
    final cm = CompletedMatch.fromMatch(s)!;
    expect(cm.first.teamId, 'A');
    expect(cm.first.runs, 4);
    expect(cm.second.teamId, 'B');
    expect(cm.second.runs, 6);
    expect(cm.resultType, MatchResultType.winByWickets);
    expect(cm.winnerTeamId, 'B');
  });
}
