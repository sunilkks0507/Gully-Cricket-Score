import '../models/models.dart';
import 'engine_exception.dart';
import 'validation.dart';

/// The pure-Dart scoring engine. `apply(state, event) -> state`, deterministic
/// and side-effect-free. State is derived by folding events; nothing is mutated.
/// See docs/04-scoring-engine-spec.md.
///
/// This file has ZERO Flutter imports (golden rule #1).
class ScoringEngine {
  const ScoringEngine._();

  /// Fold a full event log into the resulting [MatchState]. The first event must
  /// be a [MatchCreatedEvent].
  static MatchState rebuild(Iterable<GameEvent> events) {
    MatchState? state;
    for (final event in events) {
      if (state == null) {
        if (event is MatchCreatedEvent) {
          state = _created(event);
        } else {
          throw const EngineException('First event must be MatchCreated.');
        }
      } else {
        state = apply(state, event);
      }
    }
    if (state == null) throw const EngineException('No events to fold.');
    return state;
  }

  /// Apply a single event to a state, returning the next state.
  static MatchState apply(MatchState state, GameEvent event) {
    return switch (event) {
      MatchCreatedEvent() => _created(event),
      InningsStartedEvent() => _inningsStarted(state, event),
      BallDelivery(:final ball) => _ball(state, ball),
      PenaltyEvent() => _penalty(state, event),
      BatterReplacedEvent() => _batterReplaced(state, event),
      SwapStrikeEvent() => _swapStrike(state, event),
      BowlerChangedEvent() => _bowlerChanged(state, event),
      EndInningsEvent() => _endInnings(state, event),
    };
  }

  // ---------------------------------------------------------------------------
  // Setup events
  // ---------------------------------------------------------------------------

  static MatchState _created(MatchCreatedEvent e) => MatchState(
    matchId: e.matchId,
    rules: e.rules,
    status: MatchStatus.notStarted,
  );

  static MatchState _inningsStarted(MatchState state, InningsStartedEvent e) {
    if (e.strikerId == e.nonStrikerId) {
      throw const EngineException('Opening batters must be different players.');
    }
    final innings = InningsState(
      battingTeamId: e.battingTeamId,
      bowlingTeamId: e.bowlingTeamId,
      strikerId: e.strikerId,
      nonStrikerId: e.nonStrikerId,
      bowlerId: e.bowlerId,
      batters: {
        e.strikerId: BatterCard(playerId: e.strikerId),
        e.nonStrikerId: BatterCard(playerId: e.nonStrikerId),
      },
      bowlers: {e.bowlerId: BowlerCard(playerId: e.bowlerId)},
      partnerships: [
        Partnership(
          forWicket: 1,
          batterAId: e.strikerId,
          batterBId: e.nonStrikerId,
        ),
      ],
      target: e.inningsIndex == 1 ? (state.innings1?.totalRuns ?? 0) + 1 : null,
      battingSquadSize: e.battingSquadSize,
    );
    return e.inningsIndex == 0
        ? state.copyWith(
            innings1: innings,
            currentInnings: 0,
            status: MatchStatus.inProgress,
          )
        : state.copyWith(
            innings2: innings,
            currentInnings: 1,
            status: MatchStatus.inProgress,
          );
  }

  // ---------------------------------------------------------------------------
  // Ball delivery — the core algorithm (docs/04 §4)
  // ---------------------------------------------------------------------------

  static MatchState _ball(MatchState state, BallEvent ball) {
    final rules = state.rules;
    final idx = ball.inningsIndex;
    final inn = idx == 0 ? state.innings1 : state.innings2;
    if (inn == null) {
      throw EngineException('Innings $idx has not started.');
    }
    if (state.status != MatchStatus.inProgress) {
      throw const EngineException('The match is not in progress.');
    }

    final isFreeHitDelivery = inn.freeHitPending || ball.isFreeHit;
    final error = BallValidator.validate(
      rules: rules,
      innings: inn,
      ball: ball,
      isFreeHitDelivery: isFreeHitDelivery,
    );
    if (error != null) throw EngineException(error);

    final e = ball.extraType;
    final isLegal =
        e == ExtraType.none || e == ExtraType.bye || e == ExtraType.legBye;
    final strikerFaces = e != ExtraType.wide && e != ExtraType.penalty;
    final offBat = e == ExtraType.none || e == ExtraType.noBall;

    // Runs to the team total and runs charged to the bowler.
    final int teamRuns;
    final int bowlerRuns;
    var extras = inn.extras;
    switch (e) {
      case ExtraType.none:
        teamRuns = ball.runsOffBat;
        bowlerRuns = ball.runsOffBat;
      case ExtraType.wide:
        final w = rules.wideRun + ball.extraRuns;
        teamRuns = w;
        bowlerRuns = w;
        extras = extras.copyWith(wides: extras.wides + w);
      case ExtraType.noBall:
        teamRuns = rules.noBallPenalty + ball.runsOffBat + ball.extraRuns;
        bowlerRuns = rules.noBallPenalty + ball.runsOffBat;
        extras = extras.copyWith(
          noBalls: extras.noBalls + rules.noBallPenalty,
          byes: extras.byes + ball.extraRuns,
        );
      case ExtraType.bye:
        teamRuns = ball.extraRuns;
        bowlerRuns = 0;
        extras = extras.copyWith(byes: extras.byes + ball.extraRuns);
      case ExtraType.legBye:
        teamRuns = ball.extraRuns;
        bowlerRuns = 0;
        extras = extras.copyWith(legByes: extras.legByes + ball.extraRuns);
      case ExtraType.penalty:
        teamRuns = ball.extraRuns;
        bowlerRuns = 0;
        extras = extras.copyWith(penalties: extras.penalties + ball.extraRuns);
    }

    final batters = {...inn.batters};
    final bowlers = {...inn.bowlers};

    // Striker figures.
    final sId = inn.strikerId!;
    final sCard = batters[sId] ?? BatterCard(playerId: sId);
    batters[sId] = sCard.copyWith(
      runs: sCard.runs + (offBat ? ball.runsOffBat : 0),
      balls: sCard.balls + (strikerFaces ? 1 : 0),
      fours: sCard.fours + (offBat && ball.runsOffBat == 4 ? 1 : 0),
      sixes: sCard.sixes + (offBat && ball.runsOffBat == 6 ? 1 : 0),
    );

    // Bowler figures.
    final bId = ball.bowlerId;
    final bCard = bowlers[bId] ?? BowlerCard(playerId: bId);
    bowlers[bId] = bCard.copyWith(
      balls: bCard.balls + (isLegal ? 1 : 0),
      runsConceded: bCard.runsConceded + bowlerRuns,
      wides: bCard.wides + (e == ExtraType.wide ? 1 : 0),
      noBalls: bCard.noBalls + (e == ExtraType.noBall ? 1 : 0),
    );

    final newTotal = inn.totalRuns + teamRuns;
    final newLegalBalls = inn.legalBalls + (isLegal ? 1 : 0);
    var newBallsThisOver = inn.ballsThisOver + (isLegal ? 1 : 0);
    var newRunsThisOver = inn.runsConcededThisOver + bowlerRuns;

    // Runs physically run (drives strike rotation).
    final physical = switch (e) {
      ExtraType.none => ball.runsOffBat,
      ExtraType.noBall => ball.runsOffBat + ball.extraRuns,
      ExtraType.wide => ball.extraRuns,
      ExtraType.bye => ball.extraRuns,
      ExtraType.legBye => ball.extraRuns,
      ExtraType.penalty => 0,
    };

    var strikerId = inn.strikerId;
    var nonStrikerId = inn.nonStrikerId;

    // Partnership: add the runs and (if legal) a ball to the current stand.
    final partnerships = [...inn.partnerships];
    if (partnerships.isNotEmpty) {
      final last = partnerships.last;
      partnerships[partnerships.length - 1] = last.copyWith(
        runs: last.runs + teamRuns,
        balls: last.balls + (isLegal ? 1 : 0),
      );
    }

    // "Six and out" (box cricket): an off-the-bat six also dismisses the striker.
    var wicket = ball.wicket;
    if (wicket == null &&
        rules.sixAndOut &&
        e == ExtraType.none &&
        ball.runsOffBat == 6) {
      wicket = Wicket(type: DismissalType.sixOut, outBatterId: sId);
    }

    var newWickets = inn.wickets;
    var fow = inn.fow;
    var dismissals = inn.dismissals;
    var wicketCrossed = false;

    if (wicket != null) {
      newWickets += 1;
      final out = wicket.outBatterId;
      final outCard = batters[out] ?? BatterCard(playerId: out);
      batters[out] = outCard.copyWith(isOut: true);
      dismissals = {...inn.dismissals, out: wicket};

      const bowlerCredited = {
        DismissalType.bowled,
        DismissalType.caught,
        DismissalType.lbw,
        DismissalType.stumped,
        DismissalType.hitWicket,
      };
      if (bowlerCredited.contains(wicket.type)) {
        final credited = bowlers[bId]!;
        bowlers[bId] = credited.copyWith(wickets: credited.wickets + 1);
      }

      fow = [
        ...inn.fow,
        FallOfWicket(
          wicketNo: newWickets,
          batterId: out,
          scoreAtFall: newTotal,
          legalBallsAtFall: newLegalBalls,
        ),
      ];

      // Close the current partnership.
      if (partnerships.isNotEmpty) {
        partnerships[partnerships.length - 1] = partnerships.last.copyWith(
          unbroken: false,
        );
      }

      // Bring in the new batter at the out batter's end (or vacate the end).
      final nb = ball.newBatterId;
      if (nb != null) {
        batters[nb] = batters[nb] ?? BatterCard(playerId: nb);
        if (out == strikerId) {
          strikerId = nb;
        } else if (out == nonStrikerId) {
          nonStrikerId = nb;
        }
      } else {
        if (out == strikerId) {
          strikerId = null;
        } else if (out == nonStrikerId) {
          nonStrikerId = null;
        }
      }
      wicketCrossed = wicket.battersCrossed;
    }

    // Strike rotation from running (odd runs), combined with any crossing on the
    // dismissal. Boundaries are even, so they never rotate.
    if (physical.isOdd ^ wicketCrossed) {
      final tmp = strikerId;
      strikerId = nonStrikerId;
      nonStrikerId = tmp;
    }

    // Last man stands (box cricket): when a wicket leaves a lone survivor, they
    // bat on alone — keep them on strike with no non-striker.
    if (rules.lastManStands && strikerId == null && nonStrikerId != null) {
      strikerId = nonStrikerId;
      nonStrikerId = null;
    }

    // Free hit bookkeeping.
    final bool freeHitPending;
    if (e == ExtraType.noBall && rules.freeHitAfterNoBall) {
      freeHitPending = true;
    } else if (isLegal) {
      freeHitPending = false;
    } else {
      freeHitPending = inn.freeHitPending; // wide on a free hit carries it
    }

    // Over completion.
    var previousBowlerId = inn.previousBowlerId;
    String? currentBowlerId = bId;
    final overDone = isLegal && newBallsThisOver == 6;
    if (overDone) {
      if (newRunsThisOver == 0) {
        final over = bowlers[bId]!;
        bowlers[bId] = over.copyWith(maidens: over.maidens + 1);
      }
      final tmp = strikerId;
      strikerId = nonStrikerId;
      nonStrikerId = tmp;
      newBallsThisOver = 0;
      newRunsThisOver = 0;
      previousBowlerId = bId;
      currentBowlerId = null; // next over needs a (different) bowler chosen
    }

    // Innings end?
    // All out is driven by the players actually available to bat — a side can
    // take the field with fewer than the configured playersPerSide, and the
    // innings must still end when it runs out of batters.
    final squad = inn.battingSquadSize > 0
        ? inn.battingSquadSize
        : rules.playersPerSide;
    final maxWickets = rules.lastManStands ? squad : squad - 1;
    final allOut = newWickets >= maxWickets;
    final oversDone =
        rules.ballsPerInnings > 0 && newLegalBalls >= rules.ballsPerInnings;
    final target = inn.target;
    final targetReached = target != null && newTotal >= target;
    final ended = allOut || oversDone || targetReached;

    // Open a fresh partnership when a wicket fell and play continues.
    if (wicket != null && !ended && strikerId != null && nonStrikerId != null) {
      partnerships.add(
        Partnership(
          forWicket: newWickets + 1,
          batterAId: strikerId,
          batterBId: nonStrikerId,
        ),
      );
    }

    final newInnings = inn.copyWith(
      totalRuns: newTotal,
      wickets: newWickets,
      legalBalls: newLegalBalls,
      ballsThisOver: newBallsThisOver,
      runsConcededThisOver: newRunsThisOver,
      strikerId: strikerId,
      nonStrikerId: nonStrikerId,
      bowlerId: currentBowlerId,
      previousBowlerId: previousBowlerId,
      extras: extras,
      batters: batters,
      bowlers: bowlers,
      fow: fow,
      dismissals: dismissals,
      partnerships: partnerships,
      freeHitPending: freeHitPending,
    );

    return _withInnings(state, idx, newInnings, ended);
  }

  // ---------------------------------------------------------------------------
  // Other events
  // ---------------------------------------------------------------------------

  static MatchState _penalty(MatchState state, PenaltyEvent e) {
    final inn = e.inningsIndex == 0 ? state.innings1 : state.innings2;
    if (inn == null) {
      throw EngineException('Innings ${e.inningsIndex} not started.');
    }
    final newTotal = inn.totalRuns + e.runs;
    final newInnings = inn.copyWith(
      totalRuns: newTotal,
      extras: inn.extras.copyWith(penalties: inn.extras.penalties + e.runs),
    );
    final target = inn.target;
    final ended = target != null && newTotal >= target;
    return _withInnings(state, e.inningsIndex, newInnings, ended);
  }

  static MatchState _batterReplaced(MatchState state, BatterReplacedEvent e) {
    final inn = e.inningsIndex == 0 ? state.innings1 : state.innings2;
    if (inn == null) {
      throw EngineException('Innings ${e.inningsIndex} not started.');
    }

    final batters = {...inn.batters};
    batters[e.incomingId] ??= BatterCard(playerId: e.incomingId);
    if (e.retiredHurt) {
      final out = batters[e.outgoingId];
      if (out != null) {
        batters[e.outgoingId] = out.copyWith(isRetiredNotOut: true);
      }
    }

    var strikerId = inn.strikerId;
    var nonStrikerId = inn.nonStrikerId;
    if (e.outgoingId == strikerId) {
      strikerId = e.incomingId;
    } else if (e.outgoingId == nonStrikerId) {
      nonStrikerId = e.incomingId;
    } else if (strikerId == null) {
      strikerId = e.incomingId;
    } else {
      nonStrikerId ??= e.incomingId;
    }

    // Optionally put the incoming batter on strike.
    if (e.incomingOnStrike && strikerId != e.incomingId) {
      final tmp = strikerId;
      strikerId = nonStrikerId;
      nonStrikerId = tmp;
    }

    return _withInnings(
      state,
      e.inningsIndex,
      inn.copyWith(
        batters: batters,
        strikerId: strikerId,
        nonStrikerId: nonStrikerId,
      ),
      false,
    );
  }

  static MatchState _swapStrike(MatchState state, SwapStrikeEvent e) {
    final inn = e.inningsIndex == 0 ? state.innings1 : state.innings2;
    if (inn == null) {
      throw EngineException('Innings ${e.inningsIndex} not started.');
    }
    return _withInnings(
      state,
      e.inningsIndex,
      inn.copyWith(strikerId: inn.nonStrikerId, nonStrikerId: inn.strikerId),
      false,
    );
  }

  /// Set the current bowler. At the start of an over this enforces the
  /// consecutive-overs rule and the per-bowler cap; mid-over it is treated as a
  /// scorer correction / injury swap and only the cap is enforced.
  static MatchState _bowlerChanged(MatchState state, BowlerChangedEvent e) {
    final inn = e.inningsIndex == 0 ? state.innings1 : state.innings2;
    if (inn == null) {
      throw EngineException('Innings ${e.inningsIndex} not started.');
    }
    final rules = state.rules;
    if (inn.ballsThisOver == 0 &&
        inn.previousBowlerId != null &&
        e.bowlerId == inn.previousBowlerId) {
      throw const EngineException('A bowler cannot bowl two overs in a row.');
    }
    final bowled = inn.bowlers[e.bowlerId]?.balls ?? 0;
    // Only whole completed overs count against the cap; a bowler taking over
    // mid-over may finish it.
    if (rules.maxOversPerBowler > 0 &&
        bowled >= rules.maxOversPerBowler * 6 &&
        inn.ballsThisOver == 0) {
      throw EngineException(
        'Bowler has reached the ${rules.maxOversPerBowler}-over limit.',
      );
    }
    return _withInnings(
      state,
      e.inningsIndex,
      inn.copyWith(bowlerId: e.bowlerId),
      false,
    );
  }

  static MatchState _endInnings(MatchState state, EndInningsEvent e) {
    final inn = e.inningsIndex == 0 ? state.innings1 : state.innings2;
    if (inn == null) {
      throw EngineException('Innings ${e.inningsIndex} not started.');
    }
    return _withInnings(state, e.inningsIndex, inn, true);
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Store [innings] back on the state and set match status / result if the
  /// innings just [ended].
  static MatchState _withInnings(
    MatchState state,
    int idx,
    InningsState innings,
    bool ended,
  ) {
    var next = idx == 0
        ? state.copyWith(innings1: innings)
        : state.copyWith(innings2: innings);
    if (!ended) {
      return next.copyWith(status: MatchStatus.inProgress);
    }
    if (idx == 0) {
      return next.copyWith(status: MatchStatus.inningsBreak);
    }
    return next.copyWith(status: MatchStatus.completed, result: _result(next));
  }

  static MatchResult _result(MatchState state) {
    final rules = state.rules;
    final i1 = state.innings1!;
    final i2 = state.innings2!;

    if (i2.totalRuns > i1.totalRuns) {
      final inHand = (rules.playersPerSide - 1) - i2.wickets;
      return MatchResult(
        type: MatchResultType.winByWickets,
        winnerTeamId: i2.battingTeamId,
        margin: inHand,
        marginUnit: 'wickets',
        summary: '${i2.battingTeamId} won by $inHand wickets',
      );
    }
    if (i2.totalRuns == i1.totalRuns) {
      return const MatchResult(
        type: MatchResultType.tie,
        summary: 'Match tied',
      );
    }
    final margin = i1.totalRuns - i2.totalRuns;
    return MatchResult(
      type: MatchResultType.winByRuns,
      winnerTeamId: i1.battingTeamId,
      margin: margin,
      marginUnit: 'runs',
      summary: '${i1.battingTeamId} won by $margin runs',
    );
  }
}
