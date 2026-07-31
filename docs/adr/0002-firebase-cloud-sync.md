# ADR 0002 — Cloud sync & multi-user sharing: Firebase (Firestore + Auth)

- **Status:** Proposed
- **Date:** 2026-07-31
- **Supersedes:** nothing (extends [ADR 0001](0001-local-database.md); Drift stays)

## Context

v1 shipped offline-only (a stated non-goal was "no login / accounts / cloud sync").
We now want **multiple users to share data that stays in sync across all of them** —
specifically an **invite-based** model: a person creates a shared workspace and invites
specific others, rather than one global database everyone can edit.

The app is already **event-sourced**: every ball is an immutable, uuid-keyed `BallEvent`;
all state is derived by folding the append-only `Events` log; persistence sits behind
repositories. ADR 0001 and `docs/07-architecture.md` explicitly anticipated a future
`SyncRepository` that "replicates the append-only event log upstream."

## Decision

Add **Firebase** as an **optional cloud layer**, without replacing local storage:

1. **Cloud Firestore** mirrors the event log and the relational entities.
   Local **Drift (SQLite) remains the source of truth**; writes go local-first, then sync.
   The app stays fully usable offline and with no account (local "personal" mode).
2. **Firebase Auth (Google Sign-In)** identifies users. (Anonymous auth is insufficient for
   real sharing.)
3. **Sharing unit = Group** (a club / league / squad). A group has members with roles
   (owner / editor / viewer). All players, teams, tournaments, matches, and events created in
   a group's context sync to every member. Users may belong to many groups; invites are by
   email or a short join code.
4. **Per-match single active scorer.** To keep each match's event log linear and
   conflict-free, exactly one member "holds the pencil" at a time (others view live);
   the role can be handed over. Independent documents (different matches, players, teams,
   tournaments) sync concurrently with last-write-wins/field-merge.

### Why this shape
- Event-sourcing makes sync nearly conflict-free: events are append-only and immutable, so
  merging is union-by-uuid, not three-way row merges.
- Offline-first is the core value prop (scoring on a field with no signal). Firestore's own
  offline cache is a second safety net, not the primary store.
- Firestore's real-time listeners give **live shared scoring** (viewers see ball-by-ball
  updates) almost for free.

## Alternatives considered

- **Replace SQLite with Firestore entirely** — rejected: breaks true offline scoring and makes
  every read a potential network/cost event.
- **Realtime Database** — weaker querying than Firestore for stats/points-table; Firestore's
  document model maps more cleanly to the event log.
- **One global shared database** — rejected by product choice: no privacy or access control.
- **Supabase / custom backend** — viable, but Firebase's Auth + Firestore + offline cache +
  emulator suite is the fastest path for a Flutter app; revisit if cost/portability demands.

## Consequences

- New dependencies: `firebase_core`, `cloud_firestore`, `firebase_auth`, `google_sign_in`.
- **Accounts are now required for sharing** (opt-in; local-only mode still works without one).
  This intentionally crosses a v1 non-goal.
- New concepts in the data model: `User`, `Group`, `Membership`, `Invite`, and per-event
  `eventUuid` + `syncState` (a Drift schema migration). An **outbox** table drives reliable
  push; Firestore listeners drive pull.
- **Cost:** Firestore bills per read/write; ball-by-ball scoring is ~250 writes/innings and
  listener reads can amplify. Mitigate with batched writes, syncing only active/completed
  matches, and coarse listeners. Free (Spark) tier is fine for hobby scale; Blaze for growth.
- **Security rules** become load-bearing: a document is accessible only to members of its
  `groupId`. Enforced via membership docs (`exists(...)`) or custom claims for scale.
- Requires **the project owner** to create the Firebase project, enable Auth + Firestore, and
  run `flutterfire configure` (uses their Google account; generates `firebase_options.dart`).
  Claude can write all app code but cannot create or authenticate the Firebase account.
- The pure scoring engine, models, and existing UI are unaffected.

> Change to this decision → new ADR. Implementation is phased in `docs/12-cloud-sync-plan.md`.
