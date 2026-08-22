/// Barrel for the pure-Dart Firestore contract: DTOs for the cloud-only
/// entities plus the single source of truth for path strings.
///
/// Nothing here imports Firebase. The Firestore repository (Phase C) maps these
/// DTOs onto `cloud_firestore` documents; everything in this directory stays
/// unit-testable without an emulator.
///
/// Layout, field-by-field rationale and the role/access matrix live in
/// `docs/13-firestore-schema.md`; enforcement lives in `firestore.rules`.
library;

export 'cloud_event_envelope.dart';
export 'cloud_group.dart';
export 'cloud_invite.dart';
export 'cloud_json.dart';
export 'cloud_membership.dart';
export 'firestore_paths.dart';
export 'member_role.dart';
