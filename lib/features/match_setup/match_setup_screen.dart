import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers.dart';
import '../../data/db/app_db.dart';
import '../../data/repositories/match_repository.dart';
import '../../models/models.dart';

/// New Match setup: type → rules (overs/players/joker) → teams from the pool →
/// toss → opening players → start. Follows the CricScore prototype flow.
class MatchSetupScreen extends ConsumerStatefulWidget {
  const MatchSetupScreen({
    this.tournamentId,
    this.teamAId,
    this.teamBId,
    super.key,
  });

  final String? tournamentId;

  /// Pre-selected tournament teams (when starting a fixture).
  final String? teamAId;
  final String? teamBId;

  @override
  ConsumerState<MatchSetupScreen> createState() => _MatchSetupScreenState();
}

class _MatchSetupScreenState extends ConsumerState<MatchSetupScreen> {
  late MatchType _matchType = widget.tournamentId != null
      ? MatchType.tournament
      : MatchType.standalone;
  String? _tournamentId;

  int _overs = 5;
  int _players = 6;
  int _maxOvers = 2;
  bool _joker = false;
  String? _jokerId;
  final bool _lbw = false;
  bool _freeHit = false;
  bool _sixAndOut = false;
  bool _lastManStands = false;
  bool _lastManMustRunTwo = false;
  bool _keeper = true;

  final _teamAName = TextEditingController(text: 'Team A');
  final _teamBName = TextEditingController(text: 'Team B');
  final Set<String> _teamA = {};
  final Set<String> _teamB = {};

  String _tossWinner = 'A'; // 'A' | 'B'
  TossDecision _tossDecision = TossDecision.bat;

  String? _strikerId;
  String? _nonStrikerId;
  String? _bowlerId;
  bool _starting = false;

  /// Existing tournament teams the two sides play as (tournament mode only).
  /// Standalone matches still create fresh teams from the typed names.
  String? _teamAId;
  String? _teamBId;

  bool get _tournamentMode =>
      _matchType == MatchType.tournament && _tournamentId != null;

  @override
  void initState() {
    super.initState();
    _tournamentId = widget.tournamentId;
    final a = widget.teamAId;
    final b = widget.teamBId;
    if (_tournamentId != null && a != null && b != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _selectTeam(isA: true, teamId: a);
        await _selectTeam(isA: false, teamId: b);
      });
    }
  }

  /// Pick a tournament team for one side: take its name and pre-fill its
  /// saved squad (minus anyone already on the other side).
  Future<void> _selectTeam({required bool isA, required String? teamId}) async {
    final repo = ref.read(teamRepositoryProvider);
    final team = teamId == null ? null : await repo.get(teamId);
    final squad = teamId == null
        ? const <Player>[]
        : await repo.players(teamId);
    if (!mounted) return;
    setState(() {
      final picked = isA ? _teamA : _teamB;
      final other = isA ? _teamB : _teamA;
      if (isA) {
        _teamAId = teamId;
      } else {
        _teamBId = teamId;
      }
      if (team != null) (isA ? _teamAName : _teamBName).text = team.name;
      picked
        ..clear()
        ..addAll(squad.map((p) => p.id).where((id) => !other.contains(id)));
      _strikerId = _nonStrikerId = _bowlerId = null;
    });
  }

  @override
  void dispose() {
    _teamAName.dispose();
    _teamBName.dispose();
    super.dispose();
  }

  bool get _battingFirstIsA =>
      (_tossWinner == 'A' && _tossDecision == TossDecision.bat) ||
      (_tossWinner == 'B' && _tossDecision == TossDecision.bowl);

  @override
  Widget build(BuildContext context) {
    final players = ref.watch(playersProvider);
    final tournaments = ref.watch(tournamentsProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: const Text('New Match')),
      body: players.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (pool) {
          if (pool.isEmpty) {
            return _EmptyPool(onAdd: () => context.pushNamed('players'));
          }
          String nameOf(String id) => pool.firstWhere((p) => p.id == id).name;
          final battingIds = (_battingFirstIsA ? _teamA : _teamB).toList();
          final bowlingIds = (_battingFirstIsA ? _teamB : _teamA).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _section('Match type', [
                SegmentedButton<MatchType>(
                  segments: const [
                    ButtonSegment(
                      value: MatchType.standalone,
                      label: Text('Standalone'),
                    ),
                    ButtonSegment(
                      value: MatchType.tournament,
                      label: Text('Tournament'),
                    ),
                  ],
                  selected: {_matchType},
                  onSelectionChanged: (s) => setState(() {
                    _matchType = s.first;
                    _teamAId = _teamBId = null;
                  }),
                ),
                if (_matchType == MatchType.tournament) ...[
                  const SizedBox(height: 12),
                  if (tournaments.isEmpty)
                    const Text(
                      'No tournaments yet. Create one from the Tournaments tab.',
                    )
                  else
                    DropdownButtonFormField<String>(
                      initialValue: _tournamentId,
                      decoration: const InputDecoration(
                        labelText: 'Pick tournament',
                      ),
                      items: [
                        for (final t in tournaments)
                          DropdownMenuItem(value: t.id, child: Text(t.name)),
                      ],
                      onChanged: (v) => setState(() {
                        _tournamentId = v;
                        _teamAId = _teamBId = null;
                      }),
                    ),
                ] else
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "Standalone matches don't affect any points table.",
                    ),
                  ),
              ]),
              _section('Match rules · Box cricket (no LBW)', [
                _Stepper(
                  label: 'Overs per innings',
                  value: _overs,
                  min: 1,
                  onChanged: (v) => setState(() => _overs = v),
                ),
                _Stepper(
                  label: 'Players per side',
                  value: _players,
                  min: 2,
                  onChanged: (v) => setState(() => _players = v),
                ),
                _Stepper(
                  label: 'Max overs per bowler',
                  value: _maxOvers,
                  min: 1,
                  onChanged: (v) => setState(() => _maxOvers = v),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Joker player'),
                  subtitle: const Text('One player who plays for both sides'),
                  value: _joker,
                  onChanged: (v) => setState(() {
                    _joker = v;
                    if (!v) _jokerId = null;
                  }),
                ),
                if (_joker)
                  DropdownButtonFormField<String>(
                    initialValue: _jokerId,
                    decoration: const InputDecoration(labelText: 'Joker'),
                    items: [
                      for (final p in pool)
                        DropdownMenuItem(value: p.id, child: Text(p.name)),
                    ],
                    onChanged: (v) => setState(() => _jokerId = v),
                  ),
                _toggle(
                  'Six & out',
                  _sixAndOut,
                  (v) => setState(() => _sixAndOut = v),
                ),
                _toggle(
                  'Last man stands',
                  _lastManStands,
                  (v) => setState(() => _lastManStands = v),
                ),
                if (_lastManStands)
                  _toggle(
                    "Last man: singles don't count",
                    _lastManMustRunTwo,
                    (v) => setState(() => _lastManMustRunTwo = v),
                  ),
                _toggle(
                  'Wicketkeeper',
                  _keeper,
                  (v) => setState(() => _keeper = v),
                ),
                _toggle(
                  'Free hit after no-ball',
                  _freeHit,
                  (v) => setState(() => _freeHit = v),
                ),
              ]),
              _section('Team A', [
                _teamField(isA: true),
                const SizedBox(height: 8),
                _PlayerPicker(
                  pool: pool,
                  selected: _teamA,
                  disabled: _teamB,
                  onToggle: (id) => setState(() {
                    _teamA.contains(id) ? _teamA.remove(id) : _teamA.add(id);
                  }),
                ),
              ]),
              _section('Team B', [
                _teamField(isA: false),
                const SizedBox(height: 8),
                _PlayerPicker(
                  pool: pool,
                  selected: _teamB,
                  disabled: _teamA,
                  onToggle: (id) => setState(() {
                    _teamB.contains(id) ? _teamB.remove(id) : _teamB.add(id);
                  }),
                ),
              ]),
              _section('Toss', [
                Row(
                  children: [
                    const Text('Winner:  '),
                    ChoiceChip(
                      label: Text(_teamAName.text),
                      selected: _tossWinner == 'A',
                      onSelected: (_) => setState(() => _tossWinner = 'A'),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: Text(_teamBName.text),
                      selected: _tossWinner == 'B',
                      onSelected: (_) => setState(() => _tossWinner = 'B'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Elected to:  '),
                    ChoiceChip(
                      label: const Text('Bat'),
                      selected: _tossDecision == TossDecision.bat,
                      onSelected: (_) =>
                          setState(() => _tossDecision = TossDecision.bat),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Bowl'),
                      selected: _tossDecision == TossDecision.bowl,
                      onSelected: (_) =>
                          setState(() => _tossDecision = TossDecision.bowl),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Batting first: '
                  '${_battingFirstIsA ? _teamAName.text : _teamBName.text}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ]),
              _section('Opening players', [
                _playerDropdown(
                  'Striker',
                  battingIds,
                  _strikerId,
                  nameOf,
                  (v) => setState(() => _strikerId = v),
                ),
                _playerDropdown(
                  'Non-striker',
                  battingIds,
                  _nonStrikerId,
                  nameOf,
                  (v) => setState(() => _nonStrikerId = v),
                ),
                _playerDropdown(
                  'Opening bowler',
                  bowlingIds,
                  _bowlerId,
                  nameOf,
                  (v) => setState(() => _bowlerId = v),
                ),
              ]),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _starting ? null : _start,
                icon: const Icon(Icons.play_arrow),
                label: Text(_starting ? 'Starting…' : 'Review & start'),
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  /// Standalone: a free-text team name. Tournament: pick one of the
  /// tournament's teams, so the result counts on its points table.
  Widget _teamField({required bool isA}) {
    if (!_tournamentMode) {
      return TextField(
        controller: isA ? _teamAName : _teamBName,
        decoration: const InputDecoration(labelText: 'Team name'),
      );
    }
    final ids = ref.watch(tournamentTeamIdsProvider(_tournamentId!)).value;
    final names = ref.watch(teamNamesProvider).value ?? const {};
    final current = isA ? _teamAId : _teamBId;
    final other = isA ? _teamBId : _teamAId;
    final options = (ids ?? const <String>[]).where((id) => id != other);
    return DropdownButtonFormField<String>(
      key: ValueKey('team-${isA ? 'A' : 'B'}-$_tournamentId-$current'),
      initialValue: current,
      decoration: const InputDecoration(labelText: 'Tournament team'),
      items: [
        for (final id in options)
          DropdownMenuItem(value: id, child: Text(names[id] ?? 'Team')),
      ],
      onChanged: (v) => _selectTeam(isA: isA, teamId: v),
    );
  }

  Widget _section(String title, List<Widget> children) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    ),
  );

  Widget _toggle(String label, bool value, ValueChanged<bool> onChanged) =>
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(label),
        value: value,
        onChanged: onChanged,
      );

  Widget _playerDropdown(
    String label,
    List<String> ids,
    String? value,
    String Function(String) nameOf,
    ValueChanged<String?> onChanged,
  ) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: DropdownButtonFormField<String>(
      initialValue: ids.contains(value) ? value : null,
      decoration: InputDecoration(labelText: label),
      items: [
        for (final id in ids)
          DropdownMenuItem(value: id, child: Text(nameOf(id))),
      ],
      onChanged: onChanged,
    ),
  );

  Future<void> _start() async {
    final messenger = ScaffoldMessenger.of(context);
    final xiA = {..._teamA, if (_joker && _jokerId != null) _jokerId!}.toList();
    final xiB = {..._teamB, if (_joker && _jokerId != null) _jokerId!}.toList();

    String? err;
    if (xiA.length < 2 || xiB.length < 2) {
      err = 'Each team needs at least 2 players.';
    } else if (_strikerId == null ||
        _nonStrikerId == null ||
        _bowlerId == null) {
      err = 'Pick the opening striker, non-striker and bowler.';
    } else if (_strikerId == _nonStrikerId) {
      err = 'Striker and non-striker must differ.';
    } else if (_matchType == MatchType.tournament && _tournamentId == null) {
      err = 'Pick a tournament (or switch to standalone).';
    } else if (_tournamentMode && (_teamAId == null || _teamBId == null)) {
      err = 'Pick both tournament teams.';
    }
    if (err != null) {
      messenger.showSnackBar(SnackBar(content: Text(err)));
      return;
    }

    setState(() => _starting = true);
    try {
      final teamRepo = ref.read(teamRepositoryProvider);
      // Tournament matches play as the tournament's own teams (so results
      // reach its points table); standalone matches get fresh teams.
      final teamAId = _tournamentMode
          ? _teamAId!
          : await teamRepo.createTeam(name: _teamAName.text.trim());
      final teamBId = _tournamentMode
          ? _teamBId!
          : await teamRepo.createTeam(name: _teamBName.text.trim());
      // The joker plays for both sides in this match only — keep them off
      // the teams' saved squads.
      await teamRepo.setRoster(teamAId, _teamA.toList());
      await teamRepo.setRoster(teamBId, _teamB.toList());

      final battingFirst = _battingFirstIsA ? teamAId : teamBId;
      final rules = MatchRules(
        presetId: 'box_cricket',
        label: 'Box Cricket',
        oversPerInnings: _overs,
        playersPerSide: _players,
        maxOversPerBowler: _maxOvers,
        lbwEnabled: _lbw,
        freeHitAfterNoBall: _freeHit,
        keeperPresent: _keeper,
        sixAndOut: _sixAndOut,
        lastManStands: _lastManStands,
        lastManMustRunTwo: _lastManStands && _lastManMustRunTwo,
        jokerBatsBothSides: _joker,
      );

      final matchId = await ref
          .read(matchRepositoryProvider)
          .startMatch(
            MatchSetupData(
              rules: rules,
              matchType: _matchType,
              teamAId: teamAId,
              teamBId: teamBId,
              xiA: xiA,
              xiB: xiB,
              battingFirstTeamId: battingFirst,
              strikerId: _strikerId!,
              nonStrikerId: _nonStrikerId!,
              openingBowlerId: _bowlerId!,
              tournamentId: _tournamentId,
              jokerPlayerId: _joker ? _jokerId : null,
              tossWinnerTeamId: _tossWinner == 'A' ? teamAId : teamBId,
              tossDecision: _tossDecision,
            ),
          );
      ref.invalidate(matchesProvider);
      ref.invalidate(inProgressMatchProvider);
      ref.invalidate(fixturesProvider);
      ref.invalidate(teamsProvider);
      if (mounted) {
        context.pushReplacementNamed('match', pathParameters: {'id': matchId});
      }
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Could not start: $e')));
      if (mounted) setState(() => _starting = false);
    }
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0,
  });

  final String label;
  final int value;
  final int min;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
  }
}

class _PlayerPicker extends StatelessWidget {
  const _PlayerPicker({
    required this.pool,
    required this.selected,
    required this.disabled,
    required this.onToggle,
  });

  final List<dynamic> pool; // Player rows
  final Set<String> selected;
  final Set<String> disabled;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        for (final p in pool)
          FilterChip(
            label: Text(p.name as String),
            selected: selected.contains(p.id),
            onSelected: disabled.contains(p.id)
                ? null
                : (_) => onToggle(p.id as String),
          ),
      ],
    );
  }
}

class _EmptyPool extends StatelessWidget {
  const _EmptyPool({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Add players to the pool first.'),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.person_add),
            label: const Text('Go to Players'),
          ),
        ],
      ),
    );
  }
}
