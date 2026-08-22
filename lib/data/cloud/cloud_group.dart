import 'cloud_json.dart';

/// A shareable workspace (club / league / squad) — the unit of sharing.
///
/// Firestore document: `groups/{groupId}`.
///
/// Every synced entity carries this group's id; data with **no** group stays
/// local-only (personal mode), so the app remains fully usable signed-out.
///
/// The `id` is duplicated into the document body on purpose:
/// * the security rules can assert `request.resource.data.id == groupId`, which
///   stops a client writing a body that disagrees with its own path;
/// * collection-group queries and exported JSON stay self-describing.
class CloudGroup {
  const CloudGroup({
    required this.id,
    required this.name,
    required this.ownerUid,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.schemaVersion = currentSchemaVersion,
  });

  /// Bumped when the shape of a group document changes incompatibly. Written on
  /// every document so an older client can refuse to fold data it cannot read
  /// instead of corrupting it.
  static const int currentSchemaVersion = 1;

  /// Firestore document id (== `groups/{groupId}`), a client-generated uuid.
  final String id;

  /// Display name, e.g. "Sunday Warriors CC". 1..60 chars (rules-enforced).
  final String name;

  /// Firebase Auth uid of the current owner. Transfer of ownership rewrites
  /// this field *and* the two membership docs, in a transaction.
  final String ownerUid;

  final DateTime createdAt;

  /// Last write to the group document itself (not its subcollections).
  /// Last-write-wins tie-break for concurrent edits from two devices.
  final DateTime updatedAt;

  final String? description;

  final int schemaVersion;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'ownerUid': ownerUid,
    'createdAt': CloudJson.millis(createdAt),
    'updatedAt': CloudJson.millis(updatedAt),
    if (description != null) 'description': description,
    'schemaVersion': schemaVersion,
  };

  factory CloudGroup.fromJson(Map<String, dynamic> json) => CloudGroup(
    id: CloudJson.requireString(json, 'id'),
    name: CloudJson.requireString(json, 'name'),
    ownerUid: CloudJson.requireString(json, 'ownerUid'),
    createdAt: CloudJson.requireTime(json, 'createdAt'),
    updatedAt: CloudJson.requireTime(json, 'updatedAt'),
    description: CloudJson.optionalString(json, 'description'),
    schemaVersion: CloudJson.optionalInt(
      json,
      'schemaVersion',
      fallback: currentSchemaVersion,
    ),
  );

  CloudGroup copyWith({
    String? id,
    String? name,
    String? ownerUid,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? description = cloudUnset,
    int? schemaVersion,
  }) => CloudGroup(
    id: id ?? this.id,
    name: name ?? this.name,
    ownerUid: ownerUid ?? this.ownerUid,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    description: identical(description, cloudUnset)
        ? this.description
        : description as String?,
    schemaVersion: schemaVersion ?? this.schemaVersion,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloudGroup &&
          other.id == id &&
          other.name == name &&
          other.ownerUid == ownerUid &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt &&
          other.description == description &&
          other.schemaVersion == schemaVersion;

  @override
  int get hashCode => Object.hash(
    id,
    name,
    ownerUid,
    createdAt,
    updatedAt,
    description,
    schemaVersion,
  );

  @override
  String toString() => 'CloudGroup($id, "$name", owner: $ownerUid)';
}
