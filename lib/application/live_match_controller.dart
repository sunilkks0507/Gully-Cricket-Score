import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/match_repository.dart';
import '../models/models.dart';
import 'providers.dart';

/// Holds the currently-open match. Every scoring action builds a [GameEvent],
/// validates + persists it through the repository (autosave), and reloads the
/// session. Undo/redo move the DB cursor and re-fold.
class LiveMatchController extends Notifier<MatchSession?> {
  @override
  MatchSession? build() => null;

  MatchRepository get _repo => ref.read(matchRepositoryProvider);

  Future<void> open(String matchId) async {
    state = await _repo.loadSession(matchId);
  }

  Future<void> _applyAndReload(GameEvent event) async {
    final session = state;
    if (session == null) return;
    await _repo.appendEvent(
      session.matchId,
      event,
    ); // may throw EngineException
    state = await _repo.loadSession(session.matchId);
  }

  int get _idx => state?.state.currentInnings ?? 0;

  BallEvent _ball({
    required int runsOffBat,
    ExtraType extra = ExtraType.none,
    int extraRuns = 0,
    Wicket? wicket,
    String? newBatterId,
    String? bowlerId,
  }) {
    final inn = state!.state.activeInnings!;
    return BallEvent(
      inningsIndex: _idx,
      strikerId: inn.strikerId!,
      nonStrikerId: inn.nonStrikerId!,
      bowlerId: bowlerId ?? inn.bowlerId!,
      runsOffBat: runsOffBat,
      extraType: extra,
      extraRuns: extraRuns,
      isFreeHit: inn.freeHitPending,
      wicket: wicket,
      newBatterId: newBatterId,
      tsLocal: DateTime.now(),
    );
  }

  Future<void> recordRuns(int runs, {String? bowlerId}) => _applyAndReload(
    GameEvent.ball(_ball(runsOffBat: runs, bowlerId: bowlerId)),
  );

  Future<void> recordExtra(
    ExtraType extra, {
    int extraRuns = 0,
    int runsOffBat = 0,
    String? bowlerId,
  }) => _applyAndReload(
    GameEvent.ball(
      _ball(
        runsOffBat: runsOffBat,
        extra: extra,
        extraRuns: extraRuns,
        bowlerId: bowlerId,
      ),
    ),
  );

  Future<void> recordWicket(
    Wicket wicket, {
    String? newBatterId,
    int runsOffBat = 0,
    ExtraType extra = ExtraType.none,
    int extraRuns = 0,
    String? bowlerId,
  }) => _applyAndReload(
    GameEvent.ball(
      _ball(
        runsOffBat: runsOffBat,
        extra: extra,
        extraRuns: extraRuns,
        wicket: wicket,
        newBatterId: newBatterId,
        bowlerId: bowlerId,
      ),
    ),
  );

  Future<void> swapStrike() =>
      _applyAndReload(GameEvent.swapStrike(inningsIndex: _idx));

  /// Manually close the innings (all out with nobody left to bat, retirements,
  /// forfeit). Also rescues an innings that can't otherwise proceed.
  Future<void> endInnings() =>
      _applyAndReload(GameEvent.endInnings(inningsIndex: _idx));

  /// Set the bowler — for the next over, or to swap mid-over.
  Future<void> changeBowler(String bowlerId) => _applyAndReload(
    GameEvent.bowlerChanged(inningsIndex: _idx, bowlerId: bowlerId),
  );

  Future<void> startSecondInnings({
    required String battingTeamId,
    required String bowlingTeamId,
    required String strikerId,
    required String nonStrikerId,
    required String bowlerId,
  }) => _applyAndReload(
    GameEvent.inningsStarted(
      inningsIndex: 1,
      battingTeamId: battingTeamId,
      bowlingTeamId: bowlingTeamId,
      strikerId: strikerId,
      nonStrikerId: nonStrikerId,
      bowlerId: bowlerId,
      // Real number of batters available, so "all out" is correct even when
      // the side has fewer players than the configured playersPerSide.
      battingSquadSize: state?.rosterOf(battingTeamId).length ?? 0,
    ),
  );

  Future<void> replaceBatter({
    required String outgoingId,
    required String incomingId,
    bool retiredHurt = false,
    bool incomingOnStrike = true,
  }) => _applyAndReload(
    GameEvent.batterReplaced(
      inningsIndex: _idx,
      outgoingId: outgoingId,
      incomingId: incomingId,
      retiredHurt: retiredHurt,
      incomingOnStrike: incomingOnStrike,
    ),
  );

  Future<void> undo() async {
    final session = state;
    if (session == null) return;
    state = await _repo.undo(session.matchId);
  }

  Future<void> redo() async {
    final session = state;
    if (session == null) return;
    state = await _repo.redo(session.matchId);
  }

  bool get needsNewBowler {
    final inn = state?.state.activeInnings;
    return inn != null && inn.bowlerId == null && inn.strikerId != null;
  }
}

final liveMatchProvider = NotifierProvider<LiveMatchController, MatchSession?>(
  LiveMatchController.new,
);
