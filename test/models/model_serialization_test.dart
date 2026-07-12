import 'package:cricket_scoring/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('BallEvent with a Wicket round-trips through JSON', () {
    final event = BallEvent(
      inningsIndex: 0,
      strikerId: 'p1',
      nonStrikerId: 'p2',
      bowlerId: 'p11',
      runsOffBat: 0,
      extraType: ExtraType.none,
      wicket: const Wicket(
        type: DismissalType.caught,
        outBatterId: 'p1',
        fielderId: 'p7',
        bowlerId: 'p11',
        oneTipOneHand: true,
      ),
      tsLocal: DateTime.utc(2026, 7, 12, 15, 30),
    );

    expect(BallEvent.fromJson(event.toJson()), event);
  });

  test('a wide with byes run round-trips', () {
    const event = BallEvent(
      inningsIndex: 1,
      strikerId: 'a',
      nonStrikerId: 'b',
      bowlerId: 'c',
      extraType: ExtraType.wide,
      extraRuns: 2,
    );
    expect(BallEvent.fromJson(event.toJson()), event);
  });

  test('a fully populated MatchState round-trips through JSON', () {
    const striker = BatterCard(
      playerId: 'p1',
      runs: 34,
      balls: 20,
      fours: 4,
      sixes: 1,
    );
    const nonStriker = BatterCard(playerId: 'p2', runs: 12, balls: 15);
    const bowler = BowlerCard(
      playerId: 'p11',
      balls: 18,
      runsConceded: 24,
      wickets: 1,
      wides: 1,
    );

    const innings1 = InningsState(
      battingTeamId: 'teamA',
      bowlingTeamId: 'teamB',
      totalRuns: 46,
      wickets: 1,
      legalBalls: 18,
      strikerId: 'p1',
      nonStrikerId: 'p2',
      bowlerId: 'p11',
      extras: Extras(wides: 1, byes: 2),
      batters: {'p1': striker, 'p2': nonStriker},
      bowlers: {'p11': bowler},
      fow: [
        FallOfWicket(
          wicketNo: 1,
          batterId: 'p3',
          scoreAtFall: 40,
          legalBallsAtFall: 15,
        ),
      ],
      partnerships: [
        Partnership(
          forWicket: 2,
          batterAId: 'p1',
          batterBId: 'p2',
          runs: 6,
          balls: 3,
        ),
      ],
      ballsThisOver: 0,
    );

    const state = MatchState(
      matchId: 'match-1',
      rules: MatchPresets.boxCricket,
      currentInnings: 0,
      innings1: innings1,
      status: MatchStatus.inProgress,
    );

    final restored = MatchState.fromJson(state.toJson());
    expect(restored, state);
    // Spot-check a nested derived getter still computes correctly after reload.
    expect(restored.innings1!.oversText, '3.0');
    expect(restored.activeInnings!.totalRuns, 46);
  });
}
