import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'app_db.dart';

/// Opens the on-device SQLite file lazily. Used by the app; tests construct an
/// in-memory [AppDb] directly with `NativeDatabase.memory()`.
AppDb openAppDatabase() {
  final executor = LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'cricket_scoring.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
  return AppDb(executor);
}
