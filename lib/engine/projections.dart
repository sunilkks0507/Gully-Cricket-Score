import '../models/models.dart';

/// Builds display projections (scorecard, commentary) from engine state/events.
/// Pure Dart — no Flutter. Names are resolved via an id→name map supplied by the
/// caller (the engine itself never holds names).
class Projections {
  const Projections._();

  /// Human-readable dismissal text, e.g. "c Sharma b Khan", "run out (Patel)".
  static String dismissalText(Wicket? w, String Function(String) name) {
    if (w == null) return 'not out';
    final bowler = w.bowlerId == null ? '' : name(w.bowlerId!);
    final fielder = w.fielderId == null ? '' : name(w.fielderId!);
    return switch (w.type) {
      DismissalType.bowled => 'b $bowler',
      DismissalType.lbw => 'lbw b $bowler',
      DismissalType.caught =>
        'c $fielder b $bowler${w.oneTipOneHand ? ' (1t1h)' : ''}',
      DismissalType.stumped => 'st $fielder b $bowler',
      DismissalType.hitWicket => 'hit wicket b $bowler',
      DismissalType.runOut =>
        fielder.isEmpty ? 'run out' : 'run out ($fielder)',
      DismissalType.sixOut => 'six & out',
      DismissalType.retiredOut => 'retired out',
      DismissalType.obstructing => 'obstructing the field',
      DismissalType.hitBallTwice => 'hit the ball twice',
      DismissalType.timedOut => 'timed out',
    };
  }

  /// A fully computed innings scorecard.
  static InningsScorecard scorecard(
    InningsState inn, {
    Map<String, String> names = const {},
    List<int> powerplayOvers = const [],
  }) {
    String nm(String id) => names[id] ?? id;

    final batters = <BatterLine>[];
    for (final card in inn.batters.values) {
      final atCrease =
          card.playerId == inn.strikerId || card.playerId == inn.nonStrikerId;
      if (!card.hasBatted && !atCrease) continue;
      final notOut = !card.isOut;
      batters.add(
        BatterLine(
          playerId: card.playerId,
          name: nm(card.playerId),
          runs: card.runs,
          balls: card.balls,
          fours: card.fours,
          sixes: card.sixes,
          strikeRate: card.strikeRate,
          dismissalText: card.isOut
              ? dismissalText(inn.dismissals[card.playerId], nm)
              : (card.isRetiredNotOut ? 'retired hurt' : 'not out'),
          notOut: notOut,
        ),
      );
    }

    final bowlers = <BowlerLine>[];
    for (final card in inn.bowlers.values) {
      if (card.balls == 0 && card.wides == 0 && card.noBalls == 0) continue;
      bowlers.add(
        BowlerLine(
          playerId: card.playerId,
          name: nm(card.playerId),
          oversText: card.oversText,
          maidens: card.maidens,
          runs: card.runsConceded,
          wickets: card.wickets,
          economy: card.economy,
          wides: card.wides,
          noBalls: card.noBalls,
        ),
      );
    }

    return InningsScorecard(
      battingTeamId: inn.battingTeamId,
      bowlingTeamId: inn.bowlingTeamId,
      total: inn.totalRuns,
      wickets: inn.wickets,
      oversText: inn.oversText,
      runRate: inn.runRate,
      batters: batters,
      bowlers: bowlers,
      extras: inn.extras,
      fallOfWickets: inn.fow,
      partnerships: inn.partnerships,
      target: inn.target,
      powerplayOvers: powerplayOvers,
    );
  }

  /// Reverse-chronological, over-grouped commentary lines for an innings,
  /// derived from the event log.
  static List<String> commentary(
    List<GameEvent> events,
    int inningsIndex, {
    Map<String, String> names = const {},
  }) {
    String nm(String id) => names[id] ?? id;
    final lines = <String>[];
    var legalBalls = 0;

    for (final event in events) {
      if (event is! BallDelivery) continue;
      final b = event.ball;
      if (b.inningsIndex != inningsIndex) continue;

      final isLegal =
          b.extraType == ExtraType.none ||
          b.extraType == ExtraType.bye ||
          b.extraType == ExtraType.legBye;
      if (isLegal) legalBalls += 1;
      final label =
          '${legalBalls ~/ 6}.${legalBalls % 6 == 0 ? 6 : legalBalls % 6}';

      final buf = StringBuffer(
        '$label ${nm(b.bowlerId)} to ${nm(b.strikerId)}, ',
      );
      buf.write(_ballText(b, nm));
      lines.add(buf.toString());
    }
    return lines.reversed.toList();
  }

  static String _ballText(BallEvent b, String Function(String) nm) {
    final parts = <String>[];
    switch (b.extraType) {
      case ExtraType.none:
        parts.add(switch (b.runsOffBat) {
          0 => 'no run',
          4 => 'FOUR',
          6 => 'SIX',
          final r => '$r run${r == 1 ? '' : 's'}',
        });
      case ExtraType.wide:
        parts.add('wide${b.extraRuns > 0 ? ' + ${b.extraRuns}' : ''}');
      case ExtraType.noBall:
        parts.add('no ball');
        if (b.runsOffBat > 0) parts.add('${b.runsOffBat} off the bat');
      case ExtraType.bye:
        parts.add('${b.extraRuns} bye${b.extraRuns == 1 ? '' : 's'}');
      case ExtraType.legBye:
        parts.add('${b.extraRuns} leg bye${b.extraRuns == 1 ? '' : 's'}');
      case ExtraType.penalty:
        parts.add('${b.extraRuns} penalty');
    }
    if (b.wicket != null) {
      parts.add('OUT — ${dismissalText(b.wicket, nm)}');
    }
    return parts.join(', ');
  }
}
