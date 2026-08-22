/// The identity of the person signed in to CricScore's (optional) cloud layer.
///
/// Deliberately a plain, hand-written Dart class:
///  * no `freezed` — the auth stack must not depend on code generation, so it
///    can be edited without running `build_runner`;
///  * no Firebase types — [AppUser] is what the UI and the future sync layer
///    see, so swapping or removing the auth provider stays a one-file change
///    (ADR 0002 keeps Drift as the source of truth; cloud identity is additive).
class AppUser {
  const AppUser({
    required this.uid,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  /// Rebuilds a user from the JSON shape used by `users/{uid}` in Firestore
  /// (see `docs/12-cloud-sync-plan.md` §2), so Phase B can reuse this.
  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    uid: json['uid'] as String,
    displayName: json['displayName'] as String?,
    email: json['email'] as String?,
    photoUrl: json['photoUrl'] as String?,
  );

  /// Stable cloud id. This is what group memberships will be keyed by.
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoUrl;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'uid': uid,
    'displayName': displayName,
    'email': email,
    'photoUrl': photoUrl,
  };

  /// Best-effort human label: a name if Google gave us one, else the email,
  /// else the raw uid. Never empty, so tiles always have something to show.
  String get label {
    final name = displayName?.trim();
    if (name != null && name.isNotEmpty) return name;
    final mail = email?.trim();
    if (mail != null && mail.isNotEmpty) return mail;
    return uid;
  }

  /// One or two letters for a fallback avatar when there is no photo.
  String get initials {
    final parts = label
        .split(RegExp(r'[\s@._-]+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUser &&
          other.uid == uid &&
          other.displayName == displayName &&
          other.email == email &&
          other.photoUrl == photoUrl;

  @override
  int get hashCode => Object.hash(uid, displayName, email, photoUrl);

  @override
  String toString() => 'AppUser($uid, $label)';
}
