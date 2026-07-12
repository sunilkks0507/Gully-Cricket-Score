import 'dart:convert';

import '../models/models.dart';

/// Serialises [GameEvent]s to/from the `Events` table (`type` + `payloadJson`).
/// The freezed union already carries a `runtimeType` discriminator, which we
/// also surface as the row `type` for cheap filtering/inspection.
class EventCodec {
  const EventCodec._();

  static ({String type, String payloadJson}) encode(GameEvent event) {
    final json = event.toJson();
    final type = (json['runtimeType'] as String?) ?? 'unknown';
    return (type: type, payloadJson: jsonEncode(json));
  }

  static GameEvent decode(String payloadJson) =>
      GameEvent.fromJson(jsonDecode(payloadJson) as Map<String, dynamic>);
}
