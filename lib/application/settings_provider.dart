import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Light/dark/system theme selection (session-scoped in v1).
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

/// Ask before destructive actions (delete match/tournament).
final confirmDeleteProvider = StateProvider<bool>((ref) => true);
