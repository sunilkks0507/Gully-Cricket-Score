import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/settings_provider.dart';

/// Shows a delete confirmation dialog, honoring the "confirm before delete"
/// setting (returns true immediately if the user disabled confirmations).
Future<bool> confirmDelete(
  BuildContext context,
  WidgetRef ref, {
  required String title,
  required String message,
}) async {
  if (!ref.read(confirmDeleteProvider)) return true;
  final ok = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  return ok ?? false;
}
