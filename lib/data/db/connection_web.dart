import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

/// Web: SQLite compiled to WASM, persisted via the best storage the browser
/// supports (OPFS / IndexedDB). Requires `web/sqlite3.wasm` and
/// `web/drift_worker.js` to be served alongside the app.
QueryExecutor openPlatformConnection() {
  return LazyDatabase(() async {
    final result = await WasmDatabase.open(
      databaseName: 'cricscore',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );
    return result.resolvedExecutor;
  });
}
