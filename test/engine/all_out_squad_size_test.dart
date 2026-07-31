import 'package:cricket_scoring/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import 'engine_harness.dart';

/// The innings must end when the batting side actually runs out of batters —
/// which is driven by how many players are really in the XI, not by the
/// configured `playersPerSide` (setup allows fewer players than configured).
void main() {
  /// Take [count] wickets, bringing in [incoming] batters (null = nobody left).
  MatchState takeWickets(MatchState s, int count, List<String?> incoming) {
    for (var w = 0; w < count; w++) {
      s = ball(
        s,
        wicket: Wicket(
          type: DismissalType.bowled,
          outBatterId: inns(s).strikerId!,
        ),
        newBatter: incoming[w],
      );
    }
    return s;
  }

  test(
    'all out when the real squad runs out, even if playersPerSide is bigger',
    () {
      // Rules say 8 a side, but only 6 players were actually picked.
      var s = startedInnings(
        matchRules: rules(players: 8, lastManStands: false),
        squadSize: 6,
      );
      // a1 & a2 open; a3..a6 come in. After 5 wickets one batter is stranded.
      s = takeWickets(s, 5, ['a3', 'a4', 'a5', 'a6', null]);

      expect(inns(s).wickets, 5);
      expect(
        s.status,
        MatchStatus.inningsBreak,
        reason: 'no batter left — innings must end so innings 2 can start',
      );
    },
  );

  test('with lastManStands the lone batter continues instead', () {
    var s = startedInnings(
      matchRules: rules(players: 8, lastManStands: true),
      squadSize: 6,
    );
    s = takeWickets(s, 5, ['a3', 'a4', 'a5', 'a6', null]);

    expect(s.status, MatchStatus.inProgress, reason: 'last man bats on');
    expect(inns(s).strikerId, isNotNull);
  });

  test(
    'falls back to playersPerSide when squad size is unknown (old events)',
    () {
      // squadSize omitted => 0 => engine uses rules.playersPerSide (6) => all out at 5.
      var s = startedInnings(matchRules: rules(players: 6));
      s = takeWickets(s, 5, ['a3', 'a4', 'a5', 'a6', null]);
      expect(s.status, MatchStatus.inningsBreak);
    },
  );
}
