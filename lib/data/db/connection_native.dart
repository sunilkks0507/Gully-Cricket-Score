import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Mobile/desktop: a SQLite file in the app documents directory, opened lazily
/// on a background isolate.
QueryExecutor openPlatformConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'cricket_scoring.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
