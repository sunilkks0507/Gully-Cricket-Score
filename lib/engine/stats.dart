import '../models/models.dart';

/// Aggregated career (or tournament-scoped) stats for one player. Derived from
/// completed matches — see docs/09-stats-and-tournament.md. Pure Dart.
class PlayerCareerStat {
  PlayerCareerStat(this.playerId);

  final String playerId;
  final Set<String> _matchIds = {};

  // Batting
  int inningsBatted = 0;
  int runs = 0;
  int ballsFaced = 0;
  int notOuts = 0;
  int timesOut = 0;
  int fours = 0;
  int sixes = 0;
  int fifties = 0;
  int hundreds = 0;
  int highScore = 0;
  bool highScoreNotOut = false;

  // Bowling
  int ballsBowled = 0;
  int runsConceded = 0;
  int wickets = 0;
  int maidens = 0;
  int wides = 0;
  int noBalls = 0;
  int _bestWickets = -1;
  int _bestRuns = 0;

  // Fielding
  int catches = 0;
  int stumpings = 0;
  int runOuts = 0;

  int get matches => _matchIds.length;

  double get battingAverage => timesOut == 0 ? 0 : runs / timesOut;
  double get strikeRate => ballsFaced == 0 ? 0 : (runs * 100) / ballsFaced;
  double get economy => ballsBowled == 0 ? 0 : (runsConceded * 6) / ballsBowled;
  double get bowlingAverage => wickets == 0 ? 0 : runsConceded / wickets;
  double get bowlingStrikeRate => wickets == 0 ? 0 : ballsBowled / wickets;

  /// Best bowling as "W/R", or "-" if the player never took a wicket.
  String get bestBowling =>
      _bestWickets <= 0 ? '-' : '$_bestWickets/$_bestRuns';

  String get highScoreText => '$highScore${highScoreNotOut ? '*' : ''}';

  void _considerBest(int w, int r) {
    if (w > _bestWickets || (w == _bestWickets && r < _bestRuns)) {
      _bestWickets = w;
      _bestRuns = r;
    }
  }
}

/// Folds completed matches into per-player aggregate stats.
class StatsEngine {
  const StatsEngine._();

  /// Aggregate stats keyed by playerId across the given completed matches.
  static Map<String, PlayerCareerStat> aggregate(
    Iterable<MatchState> completedMatches,
  ) {
    final table = <String, PlayerCareerStat>{};
    PlayerCareerStat stat(String id) =>
        table.putIfAbsent(id, () => PlayerCareerStat(id));

    for (final match in completedMatches) {
      for (final inn in [match.innings1, match.innings2]) {
        if (inn == null) continue;
        _foldInnings(match.matchId, inn, stat);
      }
    }
    return table;
  }

  static void _foldInnings(
    String matchId,
    InningsState inn,
    PlayerCareerStat Function(String) stat,
  ) {
    // Batting
    for (final card in inn.batters.values) {
      if (!card.hasBatted) continue;
      final s = stat(card.playerId);
      s._matchIds.add(matchId);
      s.inningsBatted += 1;
      s.runs += card.runs;
      s.ballsFaced += card.balls;
      s.fours += card.fours;
      s.sixes += card.sixes;
      if (card.isOut) {
        s.timesOut += 1;
      } else {
        s.notOuts += 1;
      }
      if (card.runs >= 100) {
        s.hundreds += 1;
      } else if (card.runs >= 50) {
        s.fifties += 1;
      }
      if (card.runs > s.highScore) {
        s.highScore = card.runs;
        s.highScoreNotOut = !card.isOut;
      }
    }

    // Bowling
    for (final card in inn.bowlers.values) {
      if (card.balls == 0 && card.wides == 0 && card.noBalls == 0) continue;
      final s = stat(card.playerId);
      s._matchIds.add(matchId);
      s.ballsBowled += card.balls;
      s.runsConceded += card.runsConceded;
      s.wickets += card.wickets;
      s.maidens += card.maidens;
      s.wides += card.wides;
      s.noBalls += card.noBalls;
      s._considerBest(card.wickets, card.runsConceded);
    }

    // Fielding (from dismissals)
    for (final w in inn.dismissals.values) {
      final fielderId = w.fielderId;
      if (fielderId == null) continue;
      final s = stat(fielderId);
      s._matchIds.add(matchId);
      switch (w.type) {
        case DismissalType.caught:
          s.catches += 1;
        case DismissalType.stumped:
          s.stumpings += 1;
        case DismissalType.runOut:
          s.runOuts += 1;
        default:
          break;
      }
    }
  }
}
