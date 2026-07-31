/// Platform-conditional photo helpers. On mobile/desktop these use the file
/// system; on web (no `dart:io`) they degrade gracefully (photos unsupported).
library;

export 'photo_web.dart' if (dart.library.io) 'photo_io.dart';
