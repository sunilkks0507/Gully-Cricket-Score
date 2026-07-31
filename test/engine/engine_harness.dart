import 'package:cricket_scoring/engine/scoring_engine.dart';
import 'package:cricket_scoring/models/models.dart';

/// Test helpers for driving the engine with concise event sequences.
///
/// Player id convention: batters a1,a2,a3,... for team A; bowlers b1,b2,...
/// for team B.

/// Box-cricket-ish rules with a fixed shape, tunable per test.
MatchRules rules({
  int overs = 5,
  int players = 6,
  int maxOversPerBowler = 5,
  bool lbw = false,
  bool freeHit = false,
  bool keeper = true,
  bool sixAndOut = false,
  bool lastManStands = false,
}) => MatchRules(
  presetId: 'test',
  label: 'Test',
  oversPerInnings: overs,
  playersPerSide: players,
  maxOversPerBowler: maxOversPerBowler,
  lbwEnabled: lbw,
  freeHitAfterNoBall: freeHit,
  keeperPresent: keeper,
  sixAndOut: sixAndOut,
  lastManStands: lastManStands,
);

/// A state with the first innings started: a1 on strike, a2 non-striker, b1 bowling.
MatchState startedInnings({MatchRules? matchRules, int squadSize = 0}) {
  final r = matchRules ?? rules();
  return ScoringEngine.rebuild([
    GameEvent.matchCreated(matchId: 'm1', rules: r, teamAId: 'A', teamBId: 'B'),
    GameEvent.inningsStarted(
      inningsIndex: 0,
      battingTeamId: 'A',
      bowlingTeamId: 'B',
      strikerId: 'a1',
      nonStrikerId: 'a2',
      bowlerId: 'b1',
      battingSquadSize: squadSize,
    ),
  ]);
}

/// Apply a raw [BallEvent] to [state] (defaults filled from the active innings).
MatchState ball(
  MatchState state, {
  int runs = 0,
  ExtraType extra = ExtraType.none,
  int extraRuns = 0,
  Wicket? wicket,
  String? newBatter,
  String? bowler,
  int? inningsIndex,
}) {
  final inn = state.activeInnings!;
  return ScoringEngine.apply(
    state,
    GameEvent.ball(
      BallEvent(
        inningsIndex: inningsIndex ?? state.currentInnings,
        strikerId: inn.strikerId!,
        nonStrikerId: inn.nonStrikerId,
        bowlerId: bowler ?? inn.bowlerId!,
        runsOffBat: runs,
        extraType: extra,
        extraRuns: extraRuns,
        isFreeHit: inn.freeHitPending,
        wicket: wicket,
        newBatterId: newBatter,
      ),
    ),
  );
}

/// The active innings of [state].
InningsState inns(MatchState state) => state.activeInnings!;
