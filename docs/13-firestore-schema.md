# 13 — Firestore schema, security rules & cost model

The concrete cloud data-layer contract for **invite-based multi-user sharing**.
Companion to [ADR 0002](adr/0002-firebase-cloud-sync.md) and the phased plan in
[12-cloud-sync-plan.md](12-cloud-sync-plan.md); this document is the detail those two
deferred. It covers the collection layout, every field and why it exists, the per-role
access matrix, and what listeners actually cost during live scoring.

Artefacts this document describes:

| File | What it is |
| --- | --- |
| `firestore.rules` | The deployable security rules. Authoritative — this doc explains them, it does not override them. |
| `firestore.indexes.json` | Composite indexes + single-field overrides. |
| `lib/data/cloud/` | Pure-Dart DTOs and `FirestorePaths`. No Firebase imports; unit-testable. |
| `test/cloud/` | Round-trip and path tests. |

## 0. Principles

1. **Drift (SQLite) stays the source of truth.** Firestore is a replica. Every rule below
   assumes a client that can rebuild its whole world from local data.
2. **The event log is append-only and immutable in the cloud too.** `update` and `delete`
   on an event are denied for every role including owner. Undo moves a cursor; it never
   rewrites history.
3. **Events merge by union.** Documents are keyed by a client-generated `eventUuid`, so
   re-sending an event is idempotent and two devices can never produce a conflict for the
   same event.
4. **The group is the access boundary.** Every synced document carries `groupId` and lives
   under `groups/{gid}`. Data with no group never leaves the device.
5. **The rules are load-bearing, not a formality.** The UI hiding a button is not security.
   Every restriction below is enforced server-side.

## 1. Collection layout

```
users/{uid}                                     public profile (name, photo)
users/{uid}/private/profile                     email + tokens — self-readable only

groups/{gid}                                    the shareable workspace
groups/{gid}/members/{uid}                      membership + role (access source of truth)

invites/{code}                                  top-level: redeemer has no group access yet

groups/{gid}/players/{playerId}
groups/{gid}/teams/{teamId}
groups/{gid}/tournaments/{tournamentId}
groups/{gid}/matches/{matchId}
groups/{gid}/matches/{matchId}/events/{eventUuid}
```

Two layout decisions are worth calling out:

**Members are a subcollection, not an array on the group.** A membership check must be a
single `exists()` on a path the rules can build from the request alone
(`groups/$(gid)/members/$(request.auth.uid)`) — no query, no scan, one read. An array of
uids on the group document would force a `get()` of the whole group and would collide on
concurrent joins.

**Invites are top-level.** A person redeeming a code is not yet a member and therefore
cannot read `groups/{gid}` — so the code must be resolvable on its own. That is why the
invite denormalises `groupName`: the confirm screen has to be able to say *"Join Sunday
Warriors CC as editor?"* before any group access exists.

Paths are never written by hand anywhere in the app. `FirestorePaths`
(`lib/data/cloud/firestore_paths.dart`) is the only place they are constructed, and it
validates every id — an id containing `/` would nest a document one level deeper and land
outside the collection the rules protect.

## 2. Documents, field by field

### `users/{uid}` — public profile

| Field | Type | Why |
| --- | --- | --- |
| `uid` | string | Mirrors the doc id. Rules assert body-vs-path agreement. |
| `displayName` | string (1..80) | Shown in member lists and scoring attribution. |
| `photoUrl` | string? | From the Google account. |
| `createdAt` / `updatedAt` | int (epoch ms) | Housekeeping. |

Readable by **any signed-in user** — a member list has to render names for people whose
groups you do not share. `list` is denied, so the user base cannot be enumerated.

### `users/{uid}/private/profile` — private profile

| Field | Type | Why |
| --- | --- | --- |
| `email` | string | **Not** on the public doc. Email is PII; the public profile is world-readable to signed-in users, so email lives here where only the owner can read it. |
| `locale`, `notificationTokens` | string / list | Future use. |

### `groups/{gid}` — `CloudGroup`

| Field | Type | Why |
| --- | --- | --- |
| `id` | string | Mirrors the doc id so the rules can reject a body that disagrees with its path, and so exported JSON is self-describing. |
| `name` | string (1..60) | Display name. Length-capped in the rules. |
| `ownerUid` | string | Current owner. The rules read this for "is this the founder?" and to protect the owner's membership row from deletion. |
| `createdAt` | int (epoch ms) | |
| `updatedAt` | int (epoch ms) | Last-write-wins tie-break for concurrent edits of the group doc itself. |
| `description` | string? | Optional. Omitted rather than written as null. |
| `schemaVersion` | int | An older client can refuse to fold a document shape it does not understand instead of corrupting it. |

### `groups/{gid}/members/{uid}` — `CloudMembership`

| Field | Type | Why |
| --- | --- | --- |
| `uid` | string | Mirrors the doc id **and** is required in the body: "which groups am I in?" is a collection-group query over `members`, and a collection-group query cannot filter on the parent path. |
| `groupId` | string | Same reason — the collection-group result must say which group each row belongs to. |
| `role` | `'owner' \| 'editor' \| 'viewer'` | The access decision. The rules compare these exact strings; `MemberRole.wireName` is the Dart side of that contract. |
| `joinedAt` | int (epoch ms) | Ordering in the group switcher. |
| `displayName`, `photoUrl` | string? | **Denormalised** from `users/{uid}`. The members screen then costs one query instead of one query plus N profile reads. A stale name is cosmetic; each member refreshes their own copy on sign-in. |
| `invitedByUid` | string? | Audit trail. Null for the founding owner. |
| `inviteCode` | string? | **Load-bearing.** The rules read it back on create and re-fetch the invite to verify the join was legitimate (right group, right role, unexpired, unrevoked, uses left). Without it a client could mint itself a membership of any group whose id it guessed. Null only for the founding owner, who is authorised by `groups/{gid}.ownerUid` instead. |

### `invites/{code}` — `CloudInvite`

| Field | Type | Why |
| --- | --- | --- |
| `code` | string | Mirrors the doc id. 10 chars from a 31-symbol alphabet with no `0/O/1/I/L` — codes get read aloud and typed from photos. ~8×10^14 combinations. |
| `groupId` | string | Where redemption grants access. |
| `groupName` | string | Denormalised so a non-member can see what they are joining (they cannot read the group document yet). |
| `role` | `'editor' \| 'viewer'` | Granted on redemption. **Never `owner`** — rules-enforced. Ownership is transferred deliberately, never handed out by a code. |
| `createdByUid` | string | Audit; also the rules require the creator to name themselves. |
| `createdAt`, `expiresAt` | int (epoch ms) | Hard expiry — the rules compare `expiresAt > request.time.toMillis()`. Default TTL 7 days. |
| `maxUses` | int (1..50) | 1 = personal invite; higher for "share with the squad". |
| `useCount` | int | Redemptions so far. |
| `revoked` | bool | Kills a leaked code instantly, regardless of expiry or uses. |
| `redeemedByUids` | string[] | Audit trail; also makes a repeat redemption a no-op rather than an error. |

### `groups/{gid}/players|teams|tournaments/{id}`

Mirror the local Drift tables (see [06-data-model.md](06-data-model.md)) plus two required
fields: `id` (mirrors the doc id) and `groupId`. Both are asserted by the rules so a body
can never disagree with its path. Concurrent edits are last-write-wins on `updatedAt`;
these rarely collide in practice.

### `groups/{gid}/matches/{matchId}`

Mirrors the local `Matches` row, plus the cloud-only control fields. The rules **require**
these keys on every write, because a rule that indexes a missing key fails the whole
evaluation:

| Field | Type | Why |
| --- | --- | --- |
| `id`, `groupId` | string | Body-vs-path agreement. |
| `status` | string | `notStarted \| inProgress \| inningsBreak \| completed \| abandoned`. Drives which matches get listeners. |
| `scorerUid` | string \| **null** | The single-scorer lock. Must always be present — write an explicit `null`, never omit the key. |
| `eventCursor` | int | The undo cursor. Viewers fold events with `seq <= eventCursor`. |
| `revision` | int | Monotonic append counter (see §4). |
| `updatedAt` | int (epoch ms) | Last-write-wins. |
| `rulesJson`, `resultJson` | string | Serialised `MatchRules` / `MatchResult`, verbatim from local. Index-exempted. |
| `live` | map? | Denormalised live scoreline (score, wickets, overs, striker, non-striker, bowler, last 6 balls). Purely a cost optimisation — see §6. |

### `groups/{gid}/matches/{matchId}/events/{eventUuid}` — `CloudEventEnvelope`

| Field | Type | Why |
| --- | --- | --- |
| `eventUuid` | string | **The document id.** Keying by uuid rather than `seq` is what makes merging a union: the same event written twice (retry, outbox replay, two devices) lands on the same id and is idempotent. |
| `groupId`, `matchId` | string | Body-vs-path agreement; a client must not be able to file an event under one match while labelling it as another. |
| `seq` | int (1-based) | Per-match fold order. |
| `revision` | int | Strictly increasing append counter, never decremented by undo. Disambiguates two events sharing a `seq` (see §4). |
| `type` | string | The payload's `runtimeType` discriminator, denormalised so a listener can filter without parsing. One of the 10 kinds in `lib/models/game_event.dart`. |
| `payloadJson` | string | **Opaque.** The verbatim serialised `GameEvent` — the same string the local `Events.payloadJson` column holds. |
| `authorUid` | string | Who appended it. Survives a scorer handover, so "who scored this over?" is answerable. |
| `createdAt` | int (epoch ms) | Display/debug only. Never used for ordering — see §4. |
| `schemaVersion` | int | Envelope version. The payload is versioned by the domain models. |

**Why the payload is an opaque string.** The cloud layer never looks inside it. Adding a
field to `BallEvent`, or an 11th event kind, then needs no Firestore schema change, no
rules change and no index change. The bytes round-trip identically, so a scorecard folded
on device B is what device A folded. We also sidestep Firestore's map-key restrictions and
nesting limits. The cost is that events are not server-queryable by content — which we
never need, because all stats are folded on-device. `payloadJson` is
**index-exempted** in `firestore.indexes.json`: indexing a ~200-byte string on every one of
~500 events per match buys nothing and costs index storage and write latency.

**Timestamps are epoch-millis integers, not Firestore `Timestamp`s.** This keeps
`lib/data/cloud/` free of Firebase imports (so it is unit-testable as pure Dart), lets the
security rules compare against `request.time.toMillis()` directly, and matches what we
store locally. If the repository ever writes `FieldValue.serverTimestamp()` into one of
these fields it must convert the returned `Timestamp` back to millis before calling
`fromJson` — `CloudJson.requireTime` tolerates int, ISO-8601 string and `DateTime` to make
that boundary forgiving.

## 3. Access matrix

`✓` allowed, `—` denied. "Non-member" means signed in but not in this group.

| Path | Operation | Owner | Editor | Viewer | Non-member | Signed out |
| --- | --- | :-: | :-: | :-: | :-: | :-: |
| `users/{uid}` | get | ✓ | ✓ | ✓ | ✓ | — |
| `users/{uid}` | list | — | — | — | — | — |
| `users/{uid}` | write | self only | self only | self only | self only | — |
| `users/{uid}/private/**` | read/write | self only | self only | self only | self only | — |
| `groups/{gid}` | get | ✓ | ✓ | ✓ | — | — |
| `groups/{gid}` | list | — | — | — | — | — |
| `groups/{gid}` | create | ✓ (as own owner) | ✓ | ✓ | ✓ | — |
| `groups/{gid}` | update | ✓ | — | — | — | — |
| `groups/{gid}` | delete | ✓ | — | — | — | — |
| `.../members/{uid}` | get / list | ✓ | ✓ | ✓ | own row only | — |
| `.../members/{uid}` | create | own row (founder) | own row (valid invite) | own row (valid invite) | own row (valid invite) | — |
| `.../members/{uid}` | update (role) | ✓ (not own row) | — | — | — | — |
| `.../members/{uid}` | delete | ✓ (not the owner's) | self (leave) | self (leave) | — | — |
| `invites/{code}` | get | ✓ | ✓ | ✓ | ✓ | — |
| `invites/{code}` | list | ✓ own group | ✓ own group | — | — | — |
| `invites/{code}` | create | ✓ | ✓ | — | — | — |
| `invites/{code}` | update | ✓ revoke/extend | ✓ revoke/extend | burn one use | burn one use | — |
| `invites/{code}` | delete | ✓ | ✓ | — | — | — |
| `.../players\|teams\|tournaments` | read | ✓ | ✓ | ✓ | — | — |
| `.../players\|teams\|tournaments` | write | ✓ | ✓ | — | — | — |
| `.../matches/{id}` | read | ✓ | ✓ | ✓ | — | — |
| `.../matches/{id}` | create/update | ✓ | ✓ | — | — | — |
| `.../matches/{id}` | delete | ✓ | — | — | — | — |
| `.../matches/{id}` scorer lock | claim | ✓ any | self only | — | — | — |
| `.../matches/{id}` cursor/revision | move | ✓ | current scorer only | — | — | — |
| `.../events/{uuid}` | read | ✓ | ✓ | ✓ | — | — |
| `.../events/{uuid}` | create | current scorer only | current scorer only | — | — | — |
| `.../events/{uuid}` | update / delete | **—** | **—** | — | — | — |

Two rows carry most of the weight:

* **Viewers can read everything in the group and write nothing.** There is no rule anywhere
  that lets a `viewer` create, update or delete a group document.
* **Being an editor is necessary but not sufficient to score.** Appending to a match's
  event log additionally requires `match.scorerUid == request.auth.uid`. An owner is not
  exempt: the owner can *reassign* the lock (a match-document update) but cannot append
  events while someone else holds it.

## 4. Key flows

### Create a group
1. Client generates `gid`, writes `groups/{gid}` with `ownerUid = me`.
2. Client writes `groups/{gid}/members/{me}` with `role: owner`, no `inviteCode`. The rule
   authorises this by reading `groups/{gid}.ownerUid` — the *founding owner claim*.

These are two writes, not one transaction, because a rule cannot see a transaction as a
unit. If step 2 fails the group exists but is unreadable even to its creator; the client
retries step 2 on next launch (it is idempotent). A stray ownerless group is invisible and
harmless.

### Create and redeem an invite
1. Owner/editor generates a code and writes `invites/{code}` — the rules force
   `createdByUid == me`, `role != owner`, `useCount == 0`, `revoked == false`, a future
   `expiresAt` and `1 <= maxUses <= 50`.
2. The redeemer (any signed-in user) `get`s `invites/{code}` and sees `groupName` + `role`.
3. The redeemer writes `groups/{gid}/members/{me}` carrying `inviteCode`. The rule
   re-fetches the invite and independently verifies group, role, expiry, revocation and
   remaining uses. **This is the security boundary** — the client's claim to be invited is
   never taken on trust.
4. The redeemer bumps `useCount` and appends themselves to `redeemedByUids`. The rule
   allows only those two keys to change, only a `+1` increment, and only for someone who is
   already a member of that group.

> **Known trade-off.** Steps 3 and 4 are separate writes. A hostile client can do 3 and skip
> 4, so `maxUses` is a *soft* cap under a modified client. This is not privilege escalation
> — every membership still requires a valid, unexpired, unrevoked invite naming that exact
> group and role — but a single-use code could in principle be reused by several people who
> all obtained it. If that matters, move redemption into a callable Cloud Function and deny
> membership creation from clients entirely. Flagged for the project owner's decision.

### Score a match (the single-scorer lock)
1. An editor opens a match with `scorerUid == null` and sets `scorerUid = me` — the rules
   allow an editor to point the lock only at themselves.
2. Only that user may create documents in the match's `events` subcollection.
3. Everyone else in the group is a live viewer: they read events but every write is denied.
4. **Handover** is explicit: the new scorer sets `scorerUid = me` in a transaction (the
   UI's "Take over scoring"). The owner may also reassign the lock, which is the escape
   hatch when a scorer's phone dies mid-innings.
5. The cursor guard means a second editor cannot rewind someone else's innings: moving
   `eventCursor` or `revision` requires holding the lock (or being the owner).

### Undo, and why events carry `revision`
Undo does not delete cloud events — they are immutable and `update`/`delete` are denied for
everyone. Undo moves `matches/{id}.eventCursor` backwards. If the scorer then scores
something *different*, the new event reuses a `seq` that an abandoned event already
occupies.

`revision` resolves that. It is a strictly increasing counter of every append ever made to
the match, never decremented by undo. The fold rule is:

> take events with `seq <= match.eventCursor`; where two share a `seq`, keep the one with
> the highest `revision`.

This is deterministic and clock-free — it never trusts a device's `createdAt`, which is
exactly the kind of thing that goes wrong when a phone's clock is off. It is safe because
the single-scorer lock means only one device mints revisions at a time.
`CloudEventEnvelope.compare` implements the ordering.

Abandoned events accumulate as dead weight (a heavily re-scored match keeps its false
starts). That is deliberate: it is the audit trail, and it is cheap. A future cleanup could
delete `seq > eventCursor` events on match completion, but only via a Cloud Function —
clients can never delete events.

## 5. Security-rule notes

**`exists()` and `get()` each cost one document read per evaluation**, on top of the
operation itself. Results are cached *within* a single evaluation, but not across the
documents of a batched write. Concretely:

| Operation | Rule reads |
| --- | --- |
| Read anything in a group | 1 (`exists` membership) |
| Write a player/team/tournament/match | 2 (`exists` + `get` membership for the role) |
| Append one event | 3 (`exists` + `get` membership, `get` match for `scorerUid`) |
| Redeem an invite | 2 (`exists` + `get` invite) plus the group read |

**Custom claims are the documented scale-up path.** A Cloud Function on membership
create/update/delete stamps `{groups: {gid: role}}` onto the user's ID token; `isMember`
and `myRole` then read `request.auth.token.groups[gid]` for free, removing two of the three
reads on the event hot path. The costs are a Blaze plan (Functions require billing), up to
an hour of staleness on a token until refresh, and a 1000-byte claims budget (~40 groups).
Not worth it at club scale. Revisit if a single group ever exceeds a few thousand
events/day.

**Deliberate `list` denials.** `groups` and `users` cannot be listed at all; `invites` can
only be listed by an editor of the group being filtered on. Rules evaluate a query
per-returned-document, so an unconstrained `list` on a collection would let a signed-in
user page through everything and be filtered only afterwards.

**The invite code is a bearer token.** Anyone signed in who knows a code can read it and
redeem it. That is inherent to "join by code" and is why the code is long, expiring,
use-capped, revocable, and the collection unlistable. Share codes over a channel the group
trusts.

**Untested until the emulator lands.** These rules are written but not yet executed —
Phase E in [12-cloud-sync-plan.md](12-cloud-sync-plan.md) adds
`@firebase/rules-unit-testing` coverage. Do not treat them as verified before then; the
highest-value tests are: a viewer cannot write, a non-scorer editor cannot append events, a
non-member cannot read, a membership cannot be created without a valid invite, and events
cannot be updated or deleted.

## 6. Cost model — what live scoring actually costs

Free (Spark) tier: **50k reads / 20k writes / 20k deletes / 1 GiB per day.**

### Writes (the scorer's device)
Per delivery: 1 event create + 1 match-document update (cursor, `revision`, `live` block)
= **2 writes**. At ~250 events per innings that is ~500 writes per innings, **~1,000 writes
per match**. The free tier therefore covers roughly **20 matches per day**, which is a
full tournament Saturday. Batching helps latency but not the bill — Firestore charges per
document, not per request.

### Reads (the viewers) — this is the one to watch
A snapshot listener is billed **one read per document delivered**: the whole result set on
attach, then one per changed document.

| Scenario | Reads |
| --- | --- |
| Viewer attaches to a mid-match event log (250 events) | 250 |
| Viewer watching ball-by-ball via the events listener | 1 per ball, per viewer |
| Viewer watching only the match doc's `live` block | 1 per ball, per viewer |
| 5 viewers, full match (~500 balls incl. both innings) | ~2,500 + 5×250 on attach ≈ 3,750 |

Mitigations, in order of value:

1. **Two tiers of listener.** Casual viewers subscribe *only* to the match document and
   render from its denormalised `live` block — 1 read/ball instead of the whole event
   stream. The events listener is attached only on the commentary/full-scorecard screen.
2. **Bound the listener query.** Attach with `where('seq', isGreaterThan: lastSeenSeq)` and
   seed from the local Drift log, so re-joining a match does not re-download it. This
   matters more than it sounds: a listener that has been offline for over 30 minutes
   re-downloads its full result set on reconnect, and is charged for it.
3. **Detach on completion.** When `status == completed`, tear the listener down. A finished
   match is history; it does not need a live channel.
4. **Never listen to a whole group's matches unfiltered.** Use
   `where('status', isEqualTo: 'inProgress')` (indexed) for the live list.
5. **Coarsen if needed.** Writing the `live` block only at over ends and wickets cuts
   viewer reads ~6× at the cost of ball-by-ball liveness. Not recommended by default — the
   Phase D goal is updates within 1–2 s — but it is the lever if costs bite.

An idle app that syncs nothing costs nothing. Personal (no-group) mode never touches
Firestore at all.

## 7. Indexes

`firestore.indexes.json` declares:

* **Collection-group `members` on `uid`** (+ `joinedAt DESC`) — this is what makes "which
  groups am I in?" a single query. Both a single-field collection-group override and the
  composite are declared, because a collection-group query needs an explicit index even for
  a single equality filter.
* **`matches` by `status` + `updatedAt DESC`** — the live/recent match lists.
* **`matches` by `tournamentId` + `dateLocal DESC`** — the tournament fixture list.
* **`invites` by `groupId` + `createdAt DESC`** — the group's invite management screen.
* **Index exemptions** for `events.payloadJson`, `matches.rulesJson` and
  `matches.resultJson`. These are opaque blobs that are never queried; indexing them only
  costs storage and write latency.

Events need no composite index: they are read as `orderBy('seq')` or
`where('seq', isGreaterThan: n)`, both served by the automatic single-field index.

## 8. Deliberately not decided here

* **`CloudMatch` / `CloudPlayer` / `CloudTeam` / `CloudTournament` DTOs.** These mirror
  existing Drift rows and belong with the sync engine (Phase C). The *required* match
  fields are pinned in §2 because the rules depend on them.
* **Where `groupId` lives locally** — the Drift v3 migration is Phase C's problem.
* **Cloud Functions.** None are required by this design. Two are worth considering later:
  invite redemption (removes the soft-cap trade-off in §4) and custom-claims stamping
  (removes two reads per ball). Both require the Blaze plan.
* **Deleting a group.** The rules allow the owner to delete `groups/{gid}`, but Firestore
  does **not** cascade to subcollections — the children become orphans, still billed for
  storage and, worse, still readable by anyone who was a member (the rules read the
  membership doc, which also survives). Until a recursive delete exists (Cloud Function or
  the `firebase firestore:delete --recursive` CLI), the app should offer "leave group" and
  "archive", not "delete group". **Flagged as an open item.**
