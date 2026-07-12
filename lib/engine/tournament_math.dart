import '../models/models.dart';

/// One team's innings in a completed match, reduced to what NRR needs.
class InningsSummary {
  const InningsSummary({
    required this.teamId,
    required this.runs,
    required this.legalBalls,
    required this.allOut,
    required this.allottedBalls,
  });

  final String teamId;
  final int runs;
  final int legalBalls;
  final bool allOut;

  /// Full overs allotted × 6 (used for the all-out adjustment).
  final int allottedBalls;

  /// Decimal overs used for NRR: the FULL allotment if bowled out, else actual.
  /// See docs/09 — the standard ICC all-out rule.
  double get oversForNrr => (allOut ? allottedBalls : legalBalls) / 6.0;
}

/// A completed tournament match reduced to points + NRR inputs.
class CompletedMatch {
  const CompletedMatch({
    required this.first,
    required this.second,
    required this.resultType,
    this.winnerTeamId,
  });

  final InningsSummary first;
  final InningsSummary second;
  final MatchResultType resultType;
  final String? winnerTeamId;

  /// Build from a completed [MatchState].
  static CompletedMatch? fromMatch(MatchState state) {
    final i1 = state.innings1;
    final i2 = state.innings2;
    final result = state.result;
    if (i1 == null || i2 == null || result == null) return null;
    final allotted = state.rules.ballsPerInnings;
    return CompletedMatch(
      first: InningsSummary(
        teamId: i1.battingTeamId,
        runs: i1.totalRuns,
        legalBalls: i1.legalBalls,
        allOut: i1.wickets >= state.rules.maxWickets,
        allottedBalls: allotted,
      ),
      second: InningsSummary(
        teamId: i2.battingTeamId,
        runs: i2.totalRuns,
        legalBalls: i2.legalBalls,
        allOut: i2.wickets >= state.rules.maxWickets,
        allottedBalls: allotted,
      ),
      resultType: result.type,
      winnerTeamId: result.winnerTeamId,
    );
  }
}

/// A row in the points table.
class PointsRow {
  PointsRow(this.teamId);

  final String teamId;
  int played = 0;
  int won = 0;
  int lost = 0;
  int tied = 0;
  int noResult = 0;
  int points = 0;

  double runsFor = 0;
  double oversFor = 0;
  double runsAgainst = 0;
  double oversAgainst = 0;

  double get nrr {
    final forRate = oversFor == 0 ? 0.0 : runsFor / oversFor;
    final againstRate = oversAgainst == 0 ? 0.0 : runsAgainst / oversAgainst;
    return forRate - againstRate;
  }
}

/// Points-table + NRR computation and fixture generation.
class TournamentMath {
  const TournamentMath._();

  /// Build the sorted points table for a set of completed matches.
  ///
  /// [teamIds] seeds every participating team so teams with no completed match
  /// still appear. Sort: points desc, then NRR desc, then teamId asc.
  static List<PointsRow> pointsTable(
    Iterable<String> teamIds,
    Iterable<CompletedMatch> matches, {
    int pointsWin = 2,
    int pointsTie = 1,
    int pointsNoResult = 1,
    int pointsLoss = 0,
  }) {
    final rows = <String, PointsRow>{
      for (final id in teamIds) id: PointsRow(id),
    };
    PointsRow row(String id) => rows.putIfAbsent(id, () => PointsRow(id));

    for (final m in matches) {
      final a = row(m.first.teamId);
      final b = row(m.second.teamId);
      a.played += 1;
      b.played += 1;

      // NRR aggregates (numerators/denominators summed across matches).
      a.runsFor += m.first.runs;
      a.oversFor += m.first.oversForNrr;
      a.runsAgainst += m.second.runs;
      a.oversAgainst += m.second.oversForNrr;

      b.runsFor += m.second.runs;
      b.oversFor += m.second.oversForNrr;
      b.runsAgainst += m.first.runs;
      b.oversAgainst += m.first.oversForNrr;

      switch (m.resultType) {
        case MatchResultType.tie:
          a.tied += 1;
          b.tied += 1;
          a.points += pointsTie;
          b.points += pointsTie;
        case MatchResultType.noResult:
          a.noResult += 1;
          b.noResult += 1;
          a.points += pointsNoResult;
          b.points += pointsNoResult;
        case MatchResultType.winByRuns:
        case MatchResultType.winByWickets:
        case MatchResultType.superOver:
          final winner = m.winnerTeamId;
          final winRow = winner == a.teamId ? a : b;
          final loseRow = winner == a.teamId ? b : a;
          winRow.won += 1;
          winRow.points += pointsWin;
          loseRow.lost += 1;
          loseRow.points += pointsLoss;
      }
    }

    final list = rows.values.toList();
    list.sort((x, y) {
      final byPoints = y.points.compareTo(x.points);
      if (byPoints != 0) return byPoints;
      final byNrr = y.nrr.compareTo(x.nrr);
      if (byNrr != 0) return byNrr;
      return x.teamId.compareTo(y.teamId);
    });
    return list;
  }

  /// Round-robin fixtures via the circle method. Each team plays every other
  /// once (or twice if [doubleRoundRobin]). Odd team counts get a bye each round
  /// (the paired "bye" fixture is omitted from the output).
  static List<FixtureSpec> roundRobin(
    List<String> teamIds, {
    bool doubleRoundRobin = false,
    String tournamentId = '',
  }) {
    final teams = [...teamIds];
    const bye = '__bye__';
    if (teams.length.isOdd) teams.add(bye);
    final n = teams.length;
    final roundsCount = n - 1;
    final half = n ~/ 2;

    final fixtures = <FixtureSpec>[];
    var round = 0;
    final rotating = [...teams];
    for (var r = 0; r < roundsCount; r++) {
      for (var i = 0; i < half; i++) {
        final home = rotating[i];
        final away = rotating[n - 1 - i];
        if (home != bye && away != bye) {
          fixtures.add(
            FixtureSpec(
              id: '$tournamentId-r${round + 1}-$home-$away',
              tournamentId: tournamentId,
              round: round + 1,
              teamAId: home,
              teamBId: away,
            ),
          );
        }
      }
      // Rotate all but the first element.
      final last = rotating.removeLast();
      rotating.insert(1, last);
      round += 1;
    }

    if (doubleRoundRobin) {
      final reverse = fixtures
          .map(
            (f) => FixtureSpec(
              id: '${f.id}-rev',
              tournamentId: tournamentId,
              round: (f.round ?? 0) + roundsCount,
              teamAId: f.teamBId,
              teamBId: f.teamAId,
            ),
          )
          .toList();
      fixtures.addAll(reverse);
    }
    return fixtures;
  }
}

/// A generated fixture (before it is persisted / linked to a match).
class FixtureSpec {
  const FixtureSpec({
    required this.id,
    required this.tournamentId,
    required this.teamAId,
    required this.teamBId,
    this.round,
  });

  final String id;
  final String tournamentId;
  final int? round;
  final String teamAId;
  final String teamBId;
}
