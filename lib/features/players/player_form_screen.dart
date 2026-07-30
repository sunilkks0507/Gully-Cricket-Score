import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../application/providers.dart';
import '../../models/enums.dart';

/// Add or edit a full player profile: name (required) + optional nickname,
/// jersey number, email, role, batting/bowling hand, and a photo.
class PlayerFormScreen extends ConsumerStatefulWidget {
  const PlayerFormScreen({this.playerId, super.key});

  final String? playerId;

  @override
  ConsumerState<PlayerFormScreen> createState() => _PlayerFormScreenState();
}

class _PlayerFormScreenState extends ConsumerState<PlayerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _nickname = TextEditingController();
  final _jersey = TextEditingController();
  final _email = TextEditingController();

  PlayerRole? _role;
  BattingHand? _battingHand;
  BattingHand? _bowlingHand;
  String? _photoPath;
  DateTime? _createdAt;

  bool _loading = false;
  bool _saving = false;

  bool get _isEdit => widget.playerId != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) _load();
  }

  @override
  void dispose() {
    _name.dispose();
    _nickname.dispose();
    _jersey.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final player = await ref
        .read(playerRepositoryProvider)
        .get(widget.playerId!);
    if (player == null || !mounted) {
      setState(() => _loading = false);
      return;
    }
    _name.text = player.name;
    _nickname.text = player.nickname ?? '';
    _jersey.text = player.jerseyNo?.toString() ?? '';
    _email.text = player.email ?? '';
    _role = player.role;
    _battingHand = _handFrom(player.battingStyle);
    _bowlingHand = _handFrom(player.bowlingStyle);
    _photoPath = player.photoPath;
    _createdAt = player.createdAt;
    setState(() => _loading = false);
  }

  static BattingHand? _handFrom(String? name) {
    if (name == null) return null;
    for (final h in BattingHand.values) {
      if (h.name == name) return h;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? 'Edit player' : 'New player')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Center(child: _photoPicker()),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _name,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Name *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Name is required'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nickname,
                    decoration: const InputDecoration(
                      labelText: 'Sports nickname',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _jersey,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jersey number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return null;
                      final ok = RegExp(
                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                      ).hasMatch(v.trim());
                      return ok ? null : 'Enter a valid email';
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<PlayerRole?>(
                    initialValue: _role,
                    decoration: const InputDecoration(
                      labelText: 'Player role',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('—')),
                      for (final r in PlayerRole.values)
                        DropdownMenuItem(value: r, child: Text(_roleLabel(r))),
                    ],
                    onChanged: (v) => setState(() => _role = v),
                  ),
                  const SizedBox(height: 16),
                  _handSelector(
                    'Batting hand',
                    _battingHand,
                    (v) => setState(() => _battingHand = v),
                  ),
                  const SizedBox(height: 12),
                  _handSelector(
                    'Bowling arm',
                    _bowlingHand,
                    (v) => setState(() => _bowlingHand = v),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _saving ? null : _save,
                    icon: const Icon(Icons.check),
                    label: Text(_saving ? 'Saving…' : 'Save player'),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  Widget _photoPicker() {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 52,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          backgroundImage: _photoPath != null && File(_photoPath!).existsSync()
              ? FileImage(File(_photoPath!))
              : null,
          child: _photoPath == null
              ? Icon(Icons.person, size: 52, color: theme.colorScheme.outline)
              : null,
        ),
        Material(
          color: theme.colorScheme.primary,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: _pickPhoto,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                _photoPath == null ? Icons.add_a_photo : Icons.edit,
                size: 18,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _handSelector(
    String label,
    BattingHand? value,
    ValueChanged<BattingHand?> onChanged,
  ) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        SegmentedButton<BattingHand?>(
          emptySelectionAllowed: true,
          showSelectedIcon: false,
          segments: const [
            ButtonSegment(value: BattingHand.right, label: Text('Right')),
            ButtonSegment(value: BattingHand.left, label: Text('Left')),
          ],
          selected: value == null ? const {} : {value},
          onSelectionChanged: (s) => onChanged(s.isEmpty ? null : s.first),
        ),
      ],
    );
  }

  Future<void> _pickPhoto() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        imageQuality: 85,
      );
      if (picked == null) return;
      final dir = await getApplicationDocumentsDirectory();
      final photosDir = Directory(p.join(dir.path, 'player_photos'));
      await photosDir.create(recursive: true);
      final ext = p.extension(picked.path).isEmpty
          ? '.jpg'
          : p.extension(picked.path);
      final dest = p.join(photosDir.path, '${const Uuid().v4()}$ext');
      await File(picked.path).copy(dest);
      if (mounted) setState(() => _photoPath = dest);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not add photo: $e')),
      );
    }
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final navigator = GoRouter.of(context);
    try {
      await ref
          .read(playerRepositoryProvider)
          .savePlayer(
            id: widget.playerId,
            name: _name.text.trim(),
            nickname: _nickname.text.trim().isEmpty
                ? null
                : _nickname.text.trim(),
            jerseyNo: int.tryParse(_jersey.text.trim()),
            email: _email.text.trim().isEmpty ? null : _email.text.trim(),
            role: _role,
            battingHand: _battingHand,
            bowlingHand: _bowlingHand,
            photoPath: _photoPath,
            createdAt: _createdAt,
          );
      ref.invalidate(playersProvider);
      ref.invalidate(playerNamesProvider);
      navigator.pop();
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not save: $e')));
      }
    }
  }

  static String _roleLabel(PlayerRole r) => switch (r) {
    PlayerRole.batter => 'Batter',
    PlayerRole.bowler => 'Bowler',
    PlayerRole.allRounder => 'All-rounder',
    PlayerRole.keeper => 'Wicketkeeper',
  };
}
