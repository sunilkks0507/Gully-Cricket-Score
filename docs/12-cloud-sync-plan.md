# 12 — Cloud Sync & Multi-User Sharing (implementation plan)

Companion to [ADR 0002](adr/0002-firebase-cloud-sync.md). Adds **Firebase (Firestore + Auth)**
as an optional cloud layer for **invite-based, multi-user shared data**, keeping the app
offline-first. Local Drift stays the source of truth; the engine/models are untouched.

## 0. Division of labour (important)

**You (project owner) do — Claude cannot:**
- Create the Firebase project in the console; enable **Authentication → Google** and
  **Firestore Database**.
- Install the CLIs and run `flutterfire configure` (logs in with *your* Google account; writes
  `lib/firebase_options.dart` and platform config). This must run on your machine.
- Own billing (start on the free Spark plan).

**Claude builds:** all Dart/Flutter code — auth flow, group/invite UI, the sync engine, the
Firestore repository, security rules (`firestore.rules`), and emulator-based tests.

## 1. Sharing model (recap)

- **Group** = a shareable workspace (club / league / squad). Fields: `name`, `ownerUid`,
  `createdAt`.
- **Membership**: `{ groupId, uid, role: owner|editor|viewer, joinedAt }`. A user may be in
  many groups; the app has an active-group switcher. `viewer` can watch live but not score.
- **Invite**: a short join **code** (and/or email). Redeeming a code adds a membership.
- Every synced entity carries a **`groupId`**. Data with no group stays **local-only**
  (personal mode) — the app works with no account at all.

## 2. Firestore data model

```
users/{uid}                       { displayName, email, photoUrl, createdAt }
groups/{groupId}                  { name, ownerUid, createdAt }
groups/{groupId}/members/{uid}    { role, joinedAt }          # membership source of truth
invites/{code}                    { groupId, role, createdBy, expiresAt, used }

groups/{groupId}/players/{playerId}         { ...player fields }
groups/{groupId}/teams/{teamId}             { ...team fields, roster: [playerId] }
groups/{groupId}/tournaments/{tournamentId} { ...tournament fields }
groups/{groupId}/matches/{matchId}          { rulesJson, teamAId, teamBId, status,
                                              resultJson, scorerUid, updatedAt, ... }
groups/{groupId}/matches/{matchId}/events/{eventUuid}
                                            { seq, type, payloadJson, authorUid, createdAt }
```

- **Events keyed by `eventUuid`** (not `seq`) so appends from any device dedupe by union.
  `seq` is retained for ordering; a per-match linear `seq` is guaranteed by the single-scorer
  lock (§4).
- Match doc holds `scorerUid` (who currently "holds the pencil") + `updatedAt`.

## 3. Local schema changes (Drift migration → v3)

- `Events`: add `eventUuid` (text, unique) and `syncState` (pending | synced).
- New tables: `Groups`, `Memberships`, plus `groupId` (nullable) on `Players`, `Teams`,
  `Matches`, `Tournaments` (null = local-only/personal).
- New **`Outbox`** table: `{ id, entity, entityId, groupId, opJson, createdAt }` — the durable
  queue of local changes awaiting push. Guarantees at-least-once sync across app restarts.

## 4. Sync engine

Offline-first, outbox + listeners, behind a new **`SyncRepository`** (the slot ADR 0001/`07`
reserved). Existing repositories enqueue to the Outbox on every write; nothing else changes.

- **Push:** a worker drains the Outbox when online → batched Firestore writes → mark `synced`.
- **Pull:** Firestore listeners on the active group's collections write remote changes into
  local Drift (dedupe events by `eventUuid`, then re-fold via the engine).
- **Per-match single active scorer (lock):** to bat/bowl entry, a device must hold
  `match.scorerUid`. Others are live viewers; taking over is an explicit "Start scoring" action
  (transaction on the match doc). This keeps each match's `Events` log strictly linear →
  **no event conflicts**.
- **Independent docs** (players, teams, tournaments, different matches): concurrent edits
  resolved last-write-wins on `updatedAt` (field-level for rosters). These rarely collide.
- **Auth session + Firestore cache** persist offline; Drift remains primary.

## 5. Security rules (sketch)

A document is accessible only to members of its group:

```
function member(gid) {
  return exists(/databases/$(db)/documents/groups/$(gid)/members/$(request.auth.uid));
}
match /groups/{gid}/{document=**} {
  allow read:  if member(gid);
  allow write: if member(gid);          // tighten: viewers read-only, scorer-lock on events
}
match /invites/{code} { allow get: if request.auth != null; }  // redeem via code
```

- Tighten later: `viewer` role read-only; event writes require `request.auth.uid ==
  get(match doc).scorerUid`; only `owner` can delete the group.
- `exists()`/`get()` cost one read per rule eval; move hot memberships to **custom claims**
  (set by a Cloud Function) if scale demands.

## 6. Phases & Definition of Done

- **A — Firebase + Auth.** FlutterFire wired; Google Sign-In; sign-in screen; account tile in
  Settings; app still fully usable signed-out (local mode). *DoD:* sign in/out works on Android
  + web; no regressions to offline flows.
- **B — Groups & invites.** Create group, generate/redeem join code, membership + roles,
  active-group switcher, "move my local data into a group." Firestore collections + first rules.
  *DoD:* two accounts can join one group and see each other's group listed.
- **C — Sync engine.** Schema v3 (eventUuid/syncState/Outbox/groupId); `SyncRepository`;
  repositories enqueue; push/pull for players/teams/tournaments/matches/events. *DoD:* create a
  player/match on device A → appears on device B in the same group; kill+relaunch preserves the
  outbox.
- **D — Live scoring sync.** Real-time listeners; per-match scorer lock; viewer mode; live
  header updates ball-by-ball on watchers. *DoD:* A scores, B watches updates within ~1–2 s; B
  can take over scoring; offline scoring later reconciles.
- **E — Hardening.** Role-based + scorer-lock rules; batched writes; sync only active/completed
  matches; Firebase-emulator integration tests for rules + a full-match sync; cost review;
  finalise ADR 0002 to *Accepted*.

## 7. Costs, limits, risks

- **Free tier (Spark):** ~50k reads / 20k writes / 1 GiB per day. A full innings ≈ 250 event
  writes; fine for hobby, but listener **read amplification** is the thing to watch — use
  coarse listeners and detach when a match completes. Blaze plan for growth.
- **Risks:** security-rule mistakes (data leak) → cover with emulator tests; two people trying
  to score one match → the scorer lock prevents it; runaway reads → cost caps + monitoring.

## 8. Backward compatibility

- No account, no network, no change: the app runs exactly as today (local-only).
- Cloud is strictly additive and opt-in. A user can keep matches local, or push them into a
  group to share. The pure engine and its tests are unaffected throughout.
