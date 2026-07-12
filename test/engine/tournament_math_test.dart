import 'package:cricket_scoring/engine/tournament_math.dart';
import 'package:cricket_scoring/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NRR', () {
    test(
      'docs/09 worked example: A +1.50, B -1.50 with all-out adjustment',
      () {
        // A 180/6 in 20 overs; B all out 150 in 18 overs (allotted 20).
        const match = CompletedMatch(
          first: InningsSummary(
            teamId: 'A',
            runs: 180,
            legalBalls: 120,
            allOut: false,
            allottedBalls: 120,
          ),
          second: InningsSummary(
            teamId: 'B',
            runs: 150,
            legalBalls: 108, // 18 overs actually used
            allOut: true, // → NRR uses the full 20 overs
            allottedBalls: 120,
          ),
          resultType: MatchResultType.winByRuns,
          winnerTeamId: 'A',
        );

        final table = TournamentMath.pointsTable(['A', 'B'], [match]);
        final a = table.firstWhere((r) => r.teamId == 'A');
        final b = table.firstWhere((r) => r.teamId == 'B');

        expect(a.nrr, closeTo(1.50, 1e-9));
        expect(b.nrr, closeTo(-1.50, 1e-9));
        expect(a.points, 2);
        expect(b.points, 0);
        expect(a.won, 1);
        expect(b.lost, 1);
      },
    );
  });

  group('points table sorting', () {
    test('sorts by points, then NRR, then teamId', () {
      InningsSummary inn(String t, int r, {bool allOut = false}) =>
          InningsSummary(
            teamId: t,
            runs: r,
            legalBalls: 120,
            allOut: allOut,
            allottedBalls: 120,
          );

      // A beats B big; C beats A narrowly; so points: A=2,B=0,C=2 -> A vs C by NRR.
      final matches = [
        CompletedMatch(
          first: inn('A', 200),
          second: inn('B', 100),
          resultType: MatchResultType.winByRuns,
          winnerTeamId: 'A',
        ),
        CompletedMatch(
          first: inn('C', 150),
          second: inn('A', 149),
          resultType: MatchResultType.winByRuns,
          winnerTeamId: 'C',
        ),
      ];
      final table = TournamentMath.pointsTable(['A', 'B', 'C'], matches);
      expect(table.map((r) => r.teamId).toList(), ['A', 'C', 'B']);
    });

    test('tie and no-result award the configured points', () {
      InningsSummary inn(String t) => InningsSummary(
        teamId: t,
        runs: 100,
        legalBalls: 120,
        allOut: false,
        allottedBalls: 120,
      );
      final table = TournamentMath.pointsTable(
        ['A', 'B'],
        [
          CompletedMatch(
            first: inn('A'),
            second: inn('B'),
            resultType: MatchResultType.tie,
          ),
        ],
      );
      expect(table.every((r) => r.points == 1), isTrue);
      expect(table.every((r) => r.tied == 1), isTrue);
    });
  });

  group('round-robin fixtures', () {
    test('even teams: n*(n-1)/2 fixtures, every pair once', () {
      final f = TournamentMath.roundRobin(['A', 'B', 'C', 'D']);
      expect(f.length, 6);
      final pairs = f.map((x) => {x.teamAId, x.teamBId}).toList();
      expect(pairs.toSet().length, 6, reason: 'all pairs distinct');
    });

    test('odd teams: byes omitted, n*(n-1)/2 fixtures', () {
      final f = TournamentMath.roundRobin(['A', 'B', 'C']);
      expect(f.length, 3);
      expect(
        f.any((x) => x.teamAId.contains('bye') || x.teamBId.contains('bye')),
        isFalse,
      );
    });

    test('double round-robin doubles the fixtures', () {
      final f = TournamentMath.roundRobin([
        'A',
        'B',
        'C',
        'D',
      ], doubleRoundRobin: true);
      expect(f.length, 12);
    });
  });
}
