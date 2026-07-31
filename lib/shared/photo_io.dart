import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Whether player photos can be stored on this platform.
bool get photosSupported => true;

/// An [ImageProvider] for a stored photo path, or null if absent/missing.
ImageProvider? photoImage(String? path) {
  if (path == null) return null;
  final file = File(path);
  return file.existsSync() ? FileImage(file) : null;
}

/// Copy a picked image into app storage; returns the persisted path.
Future<String?> savePlayerPhoto(String sourcePath) async {
  final dir = await getApplicationDocumentsDirectory();
  final photosDir = Directory(p.join(dir.path, 'player_photos'));
  await photosDir.create(recursive: true);
  final ext = p.extension(sourcePath).isEmpty
      ? '.jpg'
      : p.extension(sourcePath);
  final dest = p.join(photosDir.path, '${const Uuid().v4()}$ext');
  await File(sourcePath).copy(dest);
  return dest;
}
