import '../models/models.dart';

/// Pure validation for a delivery against the current innings + rules.
/// Returns an error message, or null if the ball is legal to apply.
/// See docs/04-scoring-engine-spec.md §7.
class BallValidator {
  const BallValidator._();

  static String? validate({
    required MatchRules rules,
    required InningsState innings,
    required BallEvent ball,
    required bool isFreeHitDelivery,
  }) {
    // A striker is always required.
    if (innings.strikerId == null) {
      return 'A new batter must come in before the next ball.';
    }
    // The non-striker's end may only be empty when a lone batter is carrying on
    // under last-man-stands; otherwise a new batter must come in.
    if (innings.nonStrikerId == null && !rules.lastManStands) {
      return 'A new batter must come in before the next ball.';
    }
    if (innings.nonStrikerId != null &&
        innings.strikerId == innings.nonStrikerId) {
      return 'Striker and non-striker must be different players.';
    }
    if (ball.strikerId != innings.strikerId) {
      return 'Ball striker (${ball.strikerId}) does not match the batter on '
          'strike (${innings.strikerId}).';
    }
    if (ball.nonStrikerId != innings.nonStrikerId) {
      return 'Ball non-striker does not match the batter off strike.';
    }

    // Runs off the bat are only possible on a normal delivery or a no-ball.
    if (ball.runsOffBat < 0 || ball.runsOffBat > 6) {
      return 'runsOffBat must be between 0 and 6.';
    }
    if (ball.extraType == ExtraType.wide && ball.runsOffBat != 0) {
      return 'A wide cannot be hit off the bat.';
    }
    if ((ball.extraType == ExtraType.bye ||
            ball.extraType == ExtraType.legBye ||
            ball.extraType == ExtraType.penalty) &&
        ball.runsOffBat != 0) {
      return 'Byes/leg-byes/penalty runs are not credited off the bat.';
    }
    if (ball.extraType == ExtraType.legBye &&
        rules.legByeRequiresShot == false) {
      // No constraint; flag exists only to enable the option in UI.
    }

    // Bowler eligibility (only matters at the start of a new over; mid-over the
    // bowler is fixed and cannot change).
    final startingNewOver = innings.ballsThisOver == 0;
    if (startingNewOver) {
      if (innings.previousBowlerId != null &&
          ball.bowlerId == innings.previousBowlerId) {
        return 'A bowler cannot bowl two overs in a row.';
      }
      final bowledBalls = innings.bowlers[ball.bowlerId]?.balls ?? 0;
      if (rules.maxOversPerBowler > 0 &&
          bowledBalls >= rules.maxOversPerBowler * 6) {
        return 'Bowler has reached the ${rules.maxOversPerBowler}-over limit.';
      }
    } else if (ball.bowlerId != innings.bowlerId) {
      return 'The bowler cannot change in the middle of an over.';
    }

    // Wicket legality for the context.
    final wicket = ball.wicket;
    if (wicket != null) {
      final err = _validateWicket(
        rules: rules,
        innings: innings,
        ball: ball,
        wicket: wicket,
        isFreeHitDelivery: isFreeHitDelivery,
      );
      if (err != null) return err;
    }

    return null;
  }

  static String? _validateWicket({
    required MatchRules rules,
    required InningsState innings,
    required BallEvent ball,
    required Wicket wicket,
    required bool isFreeHitDelivery,
  }) {
    // The out batter must be one of the two at the crease.
    if (wicket.outBatterId != innings.strikerId &&
        wicket.outBatterId != innings.nonStrikerId) {
      return 'The dismissed batter must be one of the two at the crease.';
    }
    // Only the striker can be out to a ball-striking dismissal; the non-striker
    // can only be run out (or obstructing).
    const strikerOnly = {
      DismissalType.bowled,
      DismissalType.caught,
      DismissalType.lbw,
      DismissalType.stumped,
      DismissalType.hitWicket,
      DismissalType.hitBallTwice,
      DismissalType.sixOut,
    };
    if (strikerOnly.contains(wicket.type) &&
        wicket.outBatterId != innings.strikerId) {
      return 'A ${wicket.type.name} dismissal must be the striker.';
    }

    if (wicket.type == DismissalType.lbw && !rules.lbwEnabled) {
      return 'LBW is disabled for this match.';
    }
    if (wicket.type == DismissalType.stumped && !rules.keeperPresent) {
      return 'Stumped is unavailable without a wicketkeeper.';
    }

    // Free hit: only run out (and obstruction-type) allowed.
    const freeHitAllowed = {
      DismissalType.runOut,
      DismissalType.obstructing,
      DismissalType.hitBallTwice,
    };
    if (isFreeHitDelivery && !freeHitAllowed.contains(wicket.type)) {
      return 'On a free hit only a run out is possible, not ${wicket.type.name}.';
    }

    // No-ball: same restricted set as a free hit (the delivery is illegal).
    if (ball.extraType == ExtraType.noBall &&
        !freeHitAllowed.contains(wicket.type)) {
      return 'Off a no-ball only a run out is possible, not ${wicket.type.name}.';
    }

    // Wide: stumped / run out / hit wicket / obstructing only.
    const wideAllowed = {
      DismissalType.stumped,
      DismissalType.runOut,
      DismissalType.hitWicket,
      DismissalType.obstructing,
    };
    if (ball.extraType == ExtraType.wide &&
        !wideAllowed.contains(wicket.type)) {
      return 'Off a wide, ${wicket.type.name} is not a possible dismissal.';
    }

    return null;
  }
}
