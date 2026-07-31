import 'package:drift/drift.dart';

import 'app_db.dart';
import 'connection_native.dart'
    if (dart.library.js_interop) 'connection_web.dart';

/// Opens the local database with the right backend for the platform:
/// a SQLite file on mobile/desktop, or SQLite-in-WASM (IndexedDB-backed) on web.
AppDb openAppDatabase() => AppDb(openConnection());

/// Implemented per-platform (see connection_native.dart / connection_web.dart).
QueryExecutor openConnection() => openPlatformConnection();
