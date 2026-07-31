import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/live_match_controller.dart';
import '../../data/repositories/match_repository.dart';
import '../../engine/engine_exception.dart';
import '../../engine/projections.dart';
import '../../models/models.dart';

/// Live ball-by-ball scoring. Header + this-over strip + scoring pad, wired to
/// the pure engine via [LiveMatchController]. Every ball autosaves.
class LiveScoringScreen extends ConsumerStatefulWidget {
  const LiveScoringScreen({required this.matchId, super.key});

  final String matchId;

  @override
  ConsumerState<LiveScoringScreen> createState() => _LiveScoringScreenState();
}

class _LiveScoringScreenState extends ConsumerState<LiveScoringScreen> {
  /// Guards the auto-prompt so the picker opens once per vacant-bowler state.
  bool _bowlerPromptOpen = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(liveMatchProvider.notifier).open(widget.matchId),
    );
  }

  LiveMatchController get _ctrl => ref.read(liveMatchProvider.notifier);

  Future<void> _guard(Future<void> Function() action) async {
    try {
      await action();
      setState(() {}); // bowler selection may have been consumed
    } on EngineException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(liveMatchProvider);
    if (session == null || session.matchId != widget.matchId) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final state = session.state;
    final inn = state.activeInnings;

    // After an over ends the engine clears the bowler — prompt immediately
    // instead of making the scorer hunt for a button.
    if (_needsBowler(session) && !_bowlerPromptOpen) {
      // Latch synchronously: several builds can occur before the callback runs,
      // and each would otherwise stack another dialog.
      _bowlerPromptOpen = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _pickBowler(session, auto: true);
      });
    }

    final canChangeBowler =
        state.status == MatchStatus.inProgress && inn?.bowlerId != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live'),
        actions: [
          IconButton(
            tooltip: 'Undo',
            onPressed: session.canUndo ? () => _guard(_ctrl.undo) : null,
            icon: const Icon(Icons.undo),
          ),
          IconButton(
            tooltip: 'Redo',
            onPressed: session.canRedo ? () => _guard(_ctrl.redo) : null,
            icon: const Icon(Icons.redo),
          ),
          IconButton(
            tooltip: 'Scorecard',
            onPressed: () => context.pushNamed(
              'scorecard',
              pathParameters: {'id': widget.matchId},
            ),
            icon: const Icon(Icons.assignment_outlined),
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'bowler') _pickBowler(session);
              if (v == 'batter') _replaceBatter(session);
              if (v == 'rules') _editRules(session);
              if (v == 'endInnings') _confirmEndInnings();
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'bowler',
                enabled: canChangeBowler,
                child: const ListTile(
                  leading: Icon(Icons.sports_baseball),
                  title: Text('Change bowler'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'batter',
                enabled: state.status == MatchStatus.inProgress,
                child: const ListTile(
                  leading: Icon(Icons.swap_horiz),
                  title: Text('Replace batter'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'rules',
                enabled: state.status != MatchStatus.completed,
                child: const ListTile(
                  leading: Icon(Icons.tune),
                  title: Text('Edit match rules'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'endInnings',
                enabled: state.status == MatchStatus.inProgress,
                child: const ListTile(
                  leading: Icon(Icons.stop_circle_outlined),
                  title: Text('End innings'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Header/over strip scroll if the screen is short, so the scoring pad
          // is never pushed off-screen.
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (inn != null) _Header(session: session, innings: inn),
                  if (inn != null) _ThisOver(session: session),
                ],
              ),
            ),
          ),
          // Keep the pad clear of the gesture bar / navigation buttons.
          SafeArea(top: false, child: _statusArea(context, session)),
        ],
      ),
    );
  }

  /// Retired hurt / substitution: swap a batter at the crease for another.
  Future<void> _replaceBatter(MatchSession session) async {
    final inn = session.state.activeInnings;
    if (inn == null) return;
    final result = await showModalBottomSheet<_ReplaceChoice>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ReplaceBatterSheet(session: session),
    );
    if (result == null) return;
    await _guard(
      () => _ctrl.replaceBatter(
        outgoingId: result.outgoingId,
        incomingId: result.incomingId,
        retiredHurt: result.retiredHurt,
        incomingOnStrike: result.onStrike,
      ),
    );
  }

  /// Edit the rules mid-match (overs, bowler cap, toggles).
  Future<void> _editRules(MatchSession session) async {
    final updated = await showModalBottomSheet<MatchRules>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _EditRulesSheet(rules: session.state.rules),
    );
    if (updated == null) return;
    await _guard(() => _ctrl.changeRules(updated));
  }

  /// Manually close the innings — for "all out" with nobody left to bat, or to
  /// rescue an innings that can't continue.
  Future<void> _confirmEndInnings() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('End innings?'),
        content: const Text(
          'Close this innings at the current score. Use this when the side is '
          'all out and no batter is left to come in.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('End innings'),
          ),
        ],
      ),
    );
    if (ok == true) await _guard(_ctrl.endInnings);
  }

  /// True when play is live but nobody is bowling (start of a new over).
  bool _needsBowler(MatchSession session) {
    final inn = session.state.activeInnings;
    return session.state.status == MatchStatus.inProgress &&
        inn != null &&
        inn.bowlerId == null &&
        inn.strikerId != null;
  }

  Widget _statusArea(BuildContext context, MatchSession session) {
    final state = session.state;
    if (state.status == MatchStatus.completed) {
      return _CompletedBar(session: session);
    }
    if (state.status == MatchStatus.inningsBreak) {
      return _InningsBreakBar(
        session: session,
        onStart: () => _startInnings2(session),
      );
    }
    final inn = state.activeInnings!;
    // A ball normally needs two batters. A vacant non-striker's end is fine
    // under last-man-stands (the lone batter carries on); anything else means
    // nobody is left to come in, so offer a way out rather than letting every
    // tap fail with a validation error.
    final loneBatterOk = state.rules.lastManStands && inn.strikerId != null;
    if (inn.strikerId == null || (inn.nonStrikerId == null && !loneBatterOk)) {
      return _NoBatterBar(onEndInnings: _confirmEndInnings);
    }
    final effectiveBowler = inn.bowlerId;
    if (effectiveBowler == null) {
      return _BowlerPrompt(onPick: () => _pickBowler(session));
    }
    return _ScoringPad(
      freeHit: inn.freeHitPending,
      onRuns: (r) =>
          _guard(() => _ctrl.recordRuns(r, bowlerId: effectiveBowler)),
      onWicket: () => _wicket(session, effectiveBowler),
      onExtra: (type) => _extra(session, type, effectiveBowler),
      onSwap: () => _guard(_ctrl.swapStrike),
    );
  }

  /// Choose the bowler. At the start of an over the previous bowler is excluded
  /// (can't bowl two in a row); mid-over this is a swap, so the only exclusion
  /// is the bowler already bowling.
  ///
  /// [auto] marks the prompt shown automatically when an over ends — it can't be
  /// dismissed without choosing, since play can't continue without a bowler.
  Future<void> _pickBowler(MatchSession session, {bool auto = false}) async {
    final inn = session.state.activeInnings;
    if (inn == null) return;
    final midOver = inn.bowlerId != null;
    final excluded = midOver ? inn.bowlerId : inn.previousBowlerId;
    final candidates = session
        .rosterOf(inn.bowlingTeamId)
        .where((id) => id != excluded)
        .toList();

    try {
      final picked = await _choosePlayer(
        context,
        title: midOver
            ? 'Change bowler'
            : 'Over complete — pick the next bowler',
        ids: candidates,
        nameOf: session.nameOf,
        dismissible: !auto,
      );
      if (picked != null) {
        await _guard(() => _ctrl.changeBowler(picked));
      }
    } finally {
      if (auto && mounted) setState(() => _bowlerPromptOpen = false);
    }
  }

  Future<void> _extra(
    MatchSession session,
    ExtraType type,
    String bowler,
  ) async {
    if (type == ExtraType.wide) {
      final runs = await _chooseNumber(context, 'Wide + extra runs', 0, 5);
      if (runs != null) {
        await _guard(
          () => _ctrl.recordExtra(
            ExtraType.wide,
            extraRuns: runs,
            bowlerId: bowler,
          ),
        );
      }
    } else if (type == ExtraType.noBall) {
      final offBat = await _chooseNumber(
        context,
        'No ball — runs off the bat',
        0,
        6,
      );
      if (offBat != null) {
        await _guard(
          () => _ctrl.recordExtra(
            ExtraType.noBall,
            runsOffBat: offBat,
            bowlerId: bowler,
          ),
        );
      }
    } else {
      final runs = await _chooseNumber(
        context,
        type == ExtraType.bye ? 'Byes run' : 'Leg byes run',
        1,
        4,
      );
      if (runs != null) {
        await _guard(
          () => _ctrl.recordExtra(type, extraRuns: runs, bowlerId: bowler),
        );
      }
    }
  }

  Future<void> _wicket(MatchSession session, String bowler) async {
    final result = await showModalBottomSheet<_WicketChoice>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _WicketSheet(session: session),
    );
    if (result == null) return;
    await _guard(
      () => _ctrl.recordWicket(
        Wicket(
          type: result.type,
          outBatterId: result.outBatterId,
          fielderId: result.fielderId,
          bowlerId: _bowlerCredited(result.type) ? bowler : null,
          battersCrossed: result.battersCrossed,
        ),
        newBatterId: result.newBatterId,
        bowlerId: bowler,
      ),
    );
  }

  static bool _bowlerCredited(DismissalType t) => const {
    DismissalType.bowled,
    DismissalType.caught,
    DismissalType.lbw,
    DismissalType.stumped,
    DismissalType.hitWicket,
  }.contains(t);

  Future<void> _startInnings2(MatchSession session) async {
    final i1 = session.state.innings1!;
    final newBattingTeam = i1.bowlingTeamId;
    final newBowlingTeam = i1.battingTeamId;
    final batters = session.rosterOf(newBattingTeam);
    final bowlers = session.rosterOf(newBowlingTeam);

    final striker = await _choosePlayer(
      context,
      title: 'Innings 2 · Striker',
      ids: batters,
      nameOf: session.nameOf,
    );
    if (striker == null || !mounted) return;
    final nonStriker = await _choosePlayer(
      context,
      title: 'Innings 2 · Non-striker',
      ids: batters.where((id) => id != striker).toList(),
      nameOf: session.nameOf,
    );
    if (nonStriker == null || !mounted) return;
    final bowler = await _choosePlayer(
      context,
      title: 'Innings 2 · Opening bowler',
      ids: bowlers,
      nameOf: session.nameOf,
    );
    if (bowler == null) return;

    await _guard(
      () => _ctrl.startSecondInnings(
        battingTeamId: newBattingTeam,
        bowlingTeamId: newBowlingTeam,
        strikerId: striker,
        nonStrikerId: nonStriker,
        bowlerId: bowler,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header + this-over strip
// ---------------------------------------------------------------------------

class _Header extends StatelessWidget {
  const _Header({required this.session, required this.innings});

  final MatchSession session;
  final InningsState innings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final target = innings.target;
    final need = innings.runsRequired;
    final ballsLeft = session.state.rules.ballsPerInnings - innings.legalBalls;

    return Container(
      width: double.infinity,
      color: theme.colorScheme.primaryContainer,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${innings.totalRuns}/${innings.wickets}',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '(${innings.oversText})',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('CRR ${innings.runRate.toStringAsFixed(2)}'),
                  if (innings.freeHitPending)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'FREE HIT',
                        style: TextStyle(
                          color: theme.colorScheme.onTertiary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (target != null && need != null && need > 0)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Need $need off $ballsLeft · RRR '
                '${(need / (ballsLeft / 6)).toStringAsFixed(2)}',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          const Divider(height: 20),
          _batterLine(context, innings.strikerId, onStrike: true),
          _batterLine(context, innings.nonStrikerId, onStrike: false),
          const SizedBox(height: 4),
          _bowlerLine(context),
        ],
      ),
    );
  }

  Widget _batterLine(
    BuildContext context,
    String? id, {
    required bool onStrike,
  }) {
    if (id == null) return const SizedBox.shrink();
    final card = innings.batters[id];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            onStrike ? Icons.sports_cricket : Icons.circle_outlined,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text('${session.nameOf(id)}${onStrike ? ' *' : ''}')),
          Text('${card?.runs ?? 0} (${card?.balls ?? 0})'),
        ],
      ),
    );
  }

  Widget _bowlerLine(BuildContext context) {
    final id = innings.bowlerId;
    if (id == null) {
      return const Text('Bowler: —');
    }
    final b = innings.bowlers[id];
    return Row(
      children: [
        const Icon(Icons.sports_baseball, size: 16),
        const SizedBox(width: 8),
        Expanded(child: Text(session.nameOf(id))),
        Text(
          '${b?.oversText ?? '0.0'}-${b?.maidens ?? 0}-'
          '${b?.runsConceded ?? 0}-${b?.wickets ?? 0}',
        ),
      ],
    );
  }
}

class _ThisOver extends StatelessWidget {
  const _ThisOver({required this.session});

  final MatchSession session;

  @override
  Widget build(BuildContext context) {
    final tokens = _currentOverTokens(session);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Text('This over:  '),
          Expanded(
            child: Wrap(
              spacing: 6,
              children: [
                for (final t in tokens)
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: _tokenColor(context, t),
                    child: Text(t, style: const TextStyle(fontSize: 12)),
                  ),
                if (tokens.isEmpty) const Text('—'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Color _tokenColor(BuildContext context, String t) {
    final scheme = Theme.of(context).colorScheme;
    if (t == 'W') return scheme.errorContainer;
    if (t == '4' || t == '6') return scheme.tertiaryContainer;
    return scheme.surfaceContainerHighest;
  }
}

/// Tokens for the over currently in progress in the active innings.
List<String> _currentOverTokens(MatchSession session) {
  final idx = session.state.currentInnings;
  var over = <String>[];
  var legal = 0;
  for (final e in session.events) {
    if (e is! BallDelivery) continue;
    final b = e.ball;
    if (b.inningsIndex != idx) continue;
    final isLegal =
        b.extraType == ExtraType.none ||
        b.extraType == ExtraType.bye ||
        b.extraType == ExtraType.legBye;
    over.add(_token(b));
    if (isLegal) {
      legal += 1;
      if (legal % 6 == 0) over = [];
    }
  }
  return over;
}

String _token(BallEvent b) {
  final w = b.wicket != null ? 'W' : '';
  final base = switch (b.extraType) {
    ExtraType.wide => 'wd${b.extraRuns > 0 ? '+${b.extraRuns}' : ''}',
    ExtraType.noBall => 'nb${b.runsOffBat > 0 ? '+${b.runsOffBat}' : ''}',
    ExtraType.bye => 'b${b.extraRuns}',
    ExtraType.legBye => 'lb${b.extraRuns}',
    ExtraType.penalty => 'p${b.extraRuns}',
    ExtraType.none => b.runsOffBat == 0 ? '•' : '${b.runsOffBat}',
  };
  return w.isNotEmpty ? (base == '•' ? 'W' : '$base W') : base;
}

// ---------------------------------------------------------------------------
// Scoring pad + prompts
// ---------------------------------------------------------------------------

class _ScoringPad extends StatelessWidget {
  const _ScoringPad({
    required this.freeHit,
    required this.onRuns,
    required this.onWicket,
    required this.onExtra,
    required this.onSwap,
  });

  final bool freeHit;
  final ValueChanged<int> onRuns;
  final VoidCallback onWicket;
  final ValueChanged<ExtraType> onExtra;
  final VoidCallback onSwap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.6,
            children: [
              for (final r in [0, 1, 2, 3, 4, 6])
                _PadButton(label: '$r', onTap: () => onRuns(r)),
              _PadButton(
                label: 'W',
                color: Theme.of(context).colorScheme.errorContainer,
                onTap: onWicket,
              ),
              _PadButton(label: 'Swap', onTap: onSwap),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final e in [
                (ExtraType.wide, 'Wide'),
                (ExtraType.noBall, 'No Ball'),
                (ExtraType.bye, 'Bye'),
                (ExtraType.legBye, 'Leg Bye'),
              ])
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      onPressed: () => onExtra(e.$1),
                      child: Text(e.$2, textAlign: TextAlign.center),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            "Wides & no-balls don't count as a legal delivery",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          // Breathing room above the system navigation bar / gesture pill.
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _PadButton extends StatelessWidget {
  const _PadButton({required this.label, required this.onTap, this.color});

  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.zero,
      ),
      child: Text(label, style: const TextStyle(fontSize: 18)),
    );
  }
}

class _BowlerPrompt extends StatelessWidget {
  const _BowlerPrompt({required this.onPick});
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Over complete — pick the next bowler'),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onPick,
            icon: const Icon(Icons.sports_baseball),
            label: const Text('Select bowler'),
          ),
        ],
      ),
    );
  }
}

/// Shown when an end is vacant and no batter is left — the innings can't
/// continue, so offer the way out rather than failing every tap.
class _NoBatterBar extends StatelessWidget {
  const _NoBatterBar({required this.onEndInnings});
  final VoidCallback onEndInnings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Theme.of(context).colorScheme.errorContainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'No batter available to come in.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'The side is all out — close the innings to continue the match.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onEndInnings,
            icon: const Icon(Icons.stop_circle_outlined),
            label: const Text('End innings'),
          ),
        ],
      ),
    );
  }
}

class _InningsBreakBar extends StatelessWidget {
  const _InningsBreakBar({required this.session, required this.onStart});
  final MatchSession session;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final i1 = session.state.innings1!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${session.teamNameOf(i1.battingTeamId)}: '
            '${i1.totalRuns}/${i1.wickets} (${i1.oversText})',
          ),
          const SizedBox(height: 4),
          Text('Target: ${i1.totalRuns + 1}'),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: onStart,
            child: const Text('Start Innings 2'),
          ),
        ],
      ),
    );
  }
}

class _CompletedBar extends StatelessWidget {
  const _CompletedBar({required this.session});
  final MatchSession session;

  @override
  Widget build(BuildContext context) {
    // Compose the result from structured fields using real team names — the
    // engine only stores ids.
    final summary = Projections.resultText(
      session.state.result,
      session.teamNameOf,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.emoji_events, size: 40),
          const SizedBox(height: 8),
          Text(
            summary.isEmpty ? 'Match complete' : summary,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => context.pushNamed(
              'scorecard',
              pathParameters: {'id': session.matchId},
            ),
            child: const Text('View Scorecard'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Wicket sheet
// ---------------------------------------------------------------------------

class _WicketChoice {
  const _WicketChoice({
    required this.type,
    required this.outBatterId,
    this.fielderId,
    this.newBatterId,
    this.battersCrossed = false,
  });

  final DismissalType type;
  final String outBatterId;
  final String? fielderId;
  final String? newBatterId;
  final bool battersCrossed;
}

class _WicketSheet extends StatefulWidget {
  const _WicketSheet({required this.session});
  final MatchSession session;

  @override
  State<_WicketSheet> createState() => _WicketSheetState();
}

class _WicketSheetState extends State<_WicketSheet> {
  DismissalType? _type;
  String? _outBatter;
  String? _fielder;
  String? _newBatter;
  bool _crossed = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.session;
    final inn = s.state.activeInnings!;
    final rules = s.state.rules;
    _outBatter ??= inn.strikerId;

    final types = DismissalType.values.where((t) {
      if (t == DismissalType.lbw && !rules.lbwEnabled) return false;
      if (t == DismissalType.stumped && !rules.keeperPresent) return false;
      if (t == DismissalType.sixOut) return false; // auto rule
      return true;
    }).toList();

    final battingRoster = s.rosterOf(inn.battingTeamId);
    final outIds = inn.batters.values
        .where((c) => c.isOut)
        .map((c) => c.playerId)
        .toSet();
    final atCrease = {inn.strikerId, inn.nonStrikerId};
    final available = battingRoster
        .where((id) => !outIds.contains(id) && !atCrease.contains(id))
        .toList();
    final fielders = s.rosterOf(inn.bowlingTeamId);
    final needsFielder =
        _type == DismissalType.caught ||
        _type == DismissalType.stumped ||
        _type == DismissalType.runOut;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How was ${s.nameOf(inn.strikerId)} out?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final t in types)
                  ChoiceChip(
                    label: Text(t.name),
                    selected: _type == t,
                    onSelected: (_) => setState(() => _type = t),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (_type == DismissalType.runOut)
              DropdownButtonFormField<String>(
                initialValue: _outBatter,
                decoration: const InputDecoration(labelText: 'Who is out?'),
                items: [
                  for (final id in atCrease.whereType<String>())
                    DropdownMenuItem(value: id, child: Text(s.nameOf(id))),
                ],
                onChanged: (v) => setState(() => _outBatter = v),
              ),
            if (needsFielder)
              DropdownButtonFormField<String>(
                initialValue: _fielder,
                decoration: const InputDecoration(labelText: 'Fielder'),
                items: [
                  for (final id in fielders)
                    DropdownMenuItem(value: id, child: Text(s.nameOf(id))),
                ],
                onChanged: (v) => setState(() => _fielder = v),
              ),
            if (_type == DismissalType.caught || _type == DismissalType.runOut)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Batters crossed'),
                value: _crossed,
                onChanged: (v) => setState(() => _crossed = v ?? false),
              ),
            if (available.isNotEmpty)
              DropdownButtonFormField<String>(
                initialValue: _newBatter,
                decoration: const InputDecoration(labelText: 'Next batter in'),
                items: [
                  for (final id in available)
                    DropdownMenuItem(value: id, child: Text(s.nameOf(id))),
                ],
                onChanged: (v) => setState(() => _newBatter = v),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  rules.lastManStands
                      ? 'No batter left — the last man bats on alone.'
                      : 'No batter left — innings will end.',
                ),
              ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _type == null
                  ? null
                  : () => Navigator.pop(
                      context,
                      _WicketChoice(
                        type: _type!,
                        outBatterId: _outBatter ?? inn.strikerId!,
                        fielderId: needsFielder ? _fielder : null,
                        newBatterId: available.isEmpty ? null : _newBatter,
                        battersCrossed: _crossed,
                      ),
                    ),
              child: const Text('Confirm dismissal'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Replace batter (retired hurt / substitution)
// ---------------------------------------------------------------------------

class _ReplaceChoice {
  const _ReplaceChoice({
    required this.outgoingId,
    required this.incomingId,
    required this.retiredHurt,
    required this.onStrike,
  });

  final String outgoingId;
  final String incomingId;
  final bool retiredHurt;
  final bool onStrike;
}

class _ReplaceBatterSheet extends StatefulWidget {
  const _ReplaceBatterSheet({required this.session});
  final MatchSession session;

  @override
  State<_ReplaceBatterSheet> createState() => _ReplaceBatterSheetState();
}

class _ReplaceBatterSheetState extends State<_ReplaceBatterSheet> {
  String? _outgoing;
  String? _incoming;
  bool _retiredHurt = true;
  bool _onStrike = true;

  @override
  Widget build(BuildContext context) {
    final s = widget.session;
    final inn = s.state.activeInnings!;
    final atCrease = [
      inn.strikerId,
      inn.nonStrikerId,
    ].whereType<String>().toList();
    _outgoing ??= atCrease.isEmpty ? null : atCrease.first;

    // Anyone in the squad who is not out and not already batting can come in —
    // including a batter who retired hurt earlier and is now returning.
    final outIds = inn.batters.values
        .where((c) => c.isOut)
        .map((c) => c.playerId)
        .toSet();
    final available = s
        .rosterOf(inn.battingTeamId)
        .where((id) => !outIds.contains(id) && !atCrease.contains(id))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Replace batter',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _outgoing,
              decoration: const InputDecoration(labelText: 'Batter leaving'),
              items: [
                for (final id in atCrease)
                  DropdownMenuItem(value: id, child: Text(s.nameOf(id))),
              ],
              onChanged: (v) => setState(() => _outgoing = v),
            ),
            const SizedBox(height: 8),
            if (available.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('No replacement available in the squad.'),
              )
            else
              DropdownButtonFormField<String>(
                initialValue: _incoming,
                decoration: const InputDecoration(
                  labelText: 'Batter coming in',
                ),
                items: [
                  for (final id in available)
                    DropdownMenuItem(
                      value: id,
                      child: Text(
                        inn.batters[id]?.isRetiredNotOut == true
                            ? '${s.nameOf(id)} (returning)'
                            : s.nameOf(id),
                      ),
                    ),
                ],
                onChanged: (v) => setState(() => _incoming = v),
              ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Retired hurt'),
              subtitle: const Text(
                'Not a wicket — the batter can return later',
              ),
              value: _retiredHurt,
              onChanged: (v) => setState(() => _retiredHurt = v),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('New batter takes strike'),
              value: _onStrike,
              onChanged: (v) => setState(() => _onStrike = v),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: (_outgoing == null || _incoming == null)
                  ? null
                  : () => Navigator.pop(
                      context,
                      _ReplaceChoice(
                        outgoingId: _outgoing!,
                        incomingId: _incoming!,
                        retiredHurt: _retiredHurt,
                        onStrike: _onStrike,
                      ),
                    ),
              child: const Text('Confirm replacement'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Edit match rules mid-game
// ---------------------------------------------------------------------------

class _EditRulesSheet extends StatefulWidget {
  const _EditRulesSheet({required this.rules});
  final MatchRules rules;

  @override
  State<_EditRulesSheet> createState() => _EditRulesSheetState();
}

class _EditRulesSheetState extends State<_EditRulesSheet> {
  late int _overs = widget.rules.oversPerInnings;
  late int _maxOvers = widget.rules.maxOversPerBowler;
  late bool _lbw = widget.rules.lbwEnabled;
  late bool _freeHit = widget.rules.freeHitAfterNoBall;
  late bool _sixAndOut = widget.rules.sixAndOut;
  late bool _keeper = widget.rules.keeperPresent;
  late bool _lastMan = widget.rules.lastManStands;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit match rules',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Text(
              'Applies from now on. Balls already scored keep the rules they '
              'were played under.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            _stepper(
              'Overs per innings',
              _overs,
              1,
              (v) => setState(() => _overs = v),
            ),
            _stepper(
              'Max overs per bowler',
              _maxOvers,
              1,
              (v) => setState(() => _maxOvers = v),
            ),
            _toggle('LBW', _lbw, (v) => setState(() => _lbw = v)),
            _toggle(
              'Free hit after no-ball',
              _freeHit,
              (v) => setState(() => _freeHit = v),
            ),
            _toggle(
              'Six & out',
              _sixAndOut,
              (v) => setState(() => _sixAndOut = v),
            ),
            _toggle(
              'Wicketkeeper',
              _keeper,
              (v) => setState(() => _keeper = v),
            ),
            _toggle(
              'Last man stands',
              _lastMan,
              (v) => setState(() => _lastMan = v),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => Navigator.pop(
                context,
                widget.rules.copyWith(
                  oversPerInnings: _overs,
                  maxOversPerBowler: _maxOvers,
                  lbwEnabled: _lbw,
                  freeHitAfterNoBall: _freeHit,
                  sixAndOut: _sixAndOut,
                  keeperPresent: _keeper,
                  lastManStands: _lastMan,
                ),
              ),
              icon: const Icon(Icons.check),
              label: const Text('Apply rules'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepper(
    String label,
    int value,
    int min,
    ValueChanged<int> onChanged,
  ) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        IconButton.filledTonal(
          onPressed: value > min ? () => onChanged(value - 1) : null,
          icon: const Icon(Icons.remove),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('$value', style: const TextStyle(fontSize: 18)),
        ),
        IconButton.filledTonal(
          onPressed: () => onChanged(value + 1),
          icon: const Icon(Icons.add),
        ),
      ],
    ),
  );

  Widget _toggle(String label, bool value, ValueChanged<bool> onChanged) =>
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(label),
        value: value,
        onChanged: onChanged,
      );
}

// ---------------------------------------------------------------------------
// Shared pickers
// ---------------------------------------------------------------------------

Future<String?> _choosePlayer(
  BuildContext context, {
  required String title,
  required List<String> ids,
  required String Function(String) nameOf,
  bool dismissible = true,
}) {
  return showDialog<String>(
    context: context,
    barrierDismissible: dismissible,
    builder: (_) => PopScope(
      canPop: dismissible,
      child: SimpleDialog(
        title: Text(title),
        children: [
          for (final id in ids)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, id),
              child: Text(nameOf(id)),
            ),
          if (ids.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No eligible players.'),
            ),
        ],
      ),
    ),
  );
}

Future<int?> _chooseNumber(
  BuildContext context,
  String title,
  int min,
  int max,
) {
  return showDialog<int>(
    context: context,
    builder: (_) => SimpleDialog(
      title: Text(title),
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 8,
            children: [
              for (var i = min; i <= max; i++)
                FilledButton.tonal(
                  onPressed: () => Navigator.pop(context, i),
                  child: Text('$i'),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
