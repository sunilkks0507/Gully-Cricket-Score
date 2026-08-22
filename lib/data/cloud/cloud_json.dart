/// Shared JSON helpers for the plain-Dart Firestore DTOs in `lib/data/cloud`.
///
/// These DTOs deliberately have **no Firebase imports**: they are pure Dart so
/// they can be unit-tested without an emulator, and so the models stay usable
/// from the (framework-free) engine side of the app. Everything is expressed as
/// `Map<String, dynamic>`; the Firestore repository (Phase C) is the only place
/// allowed to touch `cloud_firestore` types.
///
/// ## Timestamps
/// Every instant crosses the wire as **epoch milliseconds (UTC, `int`)**, not a
/// Firestore `Timestamp`. Reasons:
/// * keeps this layer Firebase-free;
/// * security rules can compare it directly (`request.time.toMillis()`);
/// * it matches the `int` we already keep locally and sorts identically.
///
/// If the repository ever writes `FieldValue.serverTimestamp()` into one of
/// these fields it MUST convert the returned `Timestamp` back to milliseconds
/// before calling `fromJson`. [CloudJson.requireTime] tolerates `int`, `num`,
/// ISO-8601 `String` and `DateTime` so that conversion is forgiving.
library;

/// Sentinel for `copyWith` so callers can tell "leave unchanged" apart from
/// "set this nullable field to null".
const Object cloudUnset = Object();

/// Static, dependency-free readers/writers used by every cloud DTO.
class CloudJson {
  const CloudJson._();

  /// Reads a required non-empty string.
  static String requireString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! String || value.isEmpty) {
      throw FormatException('Field "$key" must be a non-empty string', json);
    }
    return value;
  }

  /// Reads an optional string. Empty strings are normalised to `null` so a
  /// cleared field and an absent field behave the same.
  static String? optionalString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is! String) {
      throw FormatException('Field "$key" must be a string or null', json);
    }
    return value.isEmpty ? null : value;
  }

  /// Reads a required integer (accepts any `num` — Firestore may hand back a
  /// `double` for a whole number written by another client).
  static int requireInt(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is int) return value;
    if (value is num) return value.toInt();
    throw FormatException('Field "$key" must be a number', json);
  }

  /// Reads an integer, falling back to [fallback] when absent or null.
  static int optionalInt(
    Map<String, dynamic> json,
    String key, {
    int fallback = 0,
  }) {
    if (json[key] == null) return fallback;
    return requireInt(json, key);
  }

  /// Reads a boolean, falling back to [fallback] when absent or null.
  static bool optionalBool(
    Map<String, dynamic> json,
    String key, {
    bool fallback = false,
  }) {
    final value = json[key];
    if (value == null) return fallback;
    if (value is! bool) {
      throw FormatException('Field "$key" must be a bool', json);
    }
    return value;
  }

  /// Reads a required instant stored as epoch milliseconds (UTC).
  static DateTime requireTime(Map<String, dynamic> json, String key) {
    final value = optionalTime(json, key);
    if (value == null) {
      throw FormatException('Field "$key" must be an epoch-millis int', json);
    }
    return value;
  }

  /// Reads an optional instant. Tolerates `int`/`num` millis, an ISO-8601
  /// string, or an already-decoded [DateTime].
  static DateTime? optionalTime(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is DateTime) return value.toUtc();
    if (value is num) {
      return DateTime.fromMillisecondsSinceEpoch(value.toInt(), isUtc: true);
    }
    if (value is String) {
      final parsed = DateTime.tryParse(value);
      if (parsed == null) {
        throw FormatException('Field "$key" is not a valid timestamp', json);
      }
      return parsed.toUtc();
    }
    throw FormatException('Field "$key" is not a valid timestamp', json);
  }

  /// Encodes an instant as epoch milliseconds (UTC).
  static int millis(DateTime value) => value.toUtc().millisecondsSinceEpoch;

  /// Encodes an optional instant.
  static int? optionalMillis(DateTime? value) =>
      value == null ? null : millis(value);

  /// Reads a list of strings, tolerating an absent field (→ empty list).
  static List<String> stringList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return const <String>[];
    if (value is! List) {
      throw FormatException('Field "$key" must be a list', json);
    }
    return List<String>.unmodifiable(
      value.map((Object? e) {
        if (e is! String) {
          throw FormatException('Field "$key" must contain only strings', json);
        }
        return e;
      }),
    );
  }

  /// Order-sensitive list equality (the DTOs are value types).
  static bool listEquals(List<String> a, List<String> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  /// Drops null values so we never write explicit nulls into Firestore for
  /// fields that are simply absent. (Explicit nulls are meaningful for
  /// `scorerUid`, which is why callers opt in per map rather than globally.)
  static Map<String, dynamic> pruneNulls(Map<String, dynamic> json) {
    final out = <String, dynamic>{};
    json.forEach((key, value) {
      if (value != null) out[key] = value;
    });
    return out;
  }
}
