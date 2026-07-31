import 'package:flutter/widgets.dart';

/// Web has no local file system for persisting photos, so they're unsupported.
bool get photosSupported => false;

ImageProvider? photoImage(String? path) => null;

Future<String?> savePlayerPhoto(String sourcePath) async => null;
