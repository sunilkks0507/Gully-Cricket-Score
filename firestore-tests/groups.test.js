// Security-rule tests for groups, memberships and invites (Phase B).
// Runs against the local Firestore emulator via `npm test`; see package.json.
import { readFileSync } from 'node:fs';
import { afterAll, beforeAll, beforeEach, describe, expect, test } from 'vitest';
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from '@firebase/rules-unit-testing';
import {
  collectionGroup,
  deleteDoc,
  doc,
  getDoc,
  getDocs,
  query,
  setDoc,
  updateDoc,
  where,
  collection,
} from 'firebase/firestore';

const GID = 'g1';
const now = () => Date.now();
const DAY = 24 * 60 * 60 * 1000;

let env;

beforeAll(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-cricscore',
    firestore: { rules: readFileSync('../firestore.rules', 'utf8') },
  });
});

afterAll(async () => env?.cleanup());

beforeEach(async () => env.clearFirestore());

const db = (uid) => env.authenticatedContext(uid).firestore();
const anon = () => env.unauthenticatedContext().firestore();

const group = (owner = 'alice') => ({
  id: GID,
  name: 'Sunday Warriors',
  ownerUid: owner,
  createdAt: now(),
  updatedAt: now(),
  schemaVersion: 1,
});

const member = (uid, role, extra = {}) => ({
  groupId: GID,
  uid,
  role,
  joinedAt: now(),
  ...extra,
});

const invite = (code, extra = {}) => ({
  code,
  groupId: GID,
  groupName: 'Sunday Warriors',
  role: 'editor',
  createdByUid: 'alice',
  createdAt: now(),
  expiresAt: now() + 7 * DAY,
  maxUses: 5,
  useCount: 0,
  revoked: false,
  redeemedByUids: [],
  ...extra,
});

/** Seed with rules off: alice owns g1; optional extra members and invites. */
async function seed({ members = {}, invites = {} } = {}) {
  await env.withSecurityRulesDisabled(async (ctx) => {
    const fs = ctx.firestore();
    await setDoc(doc(fs, `groups/${GID}`), group());
    await setDoc(doc(fs, `groups/${GID}/members/alice`), member('alice', 'owner'));
    for (const [uid, role] of Object.entries(members)) {
      await setDoc(doc(fs, `groups/${GID}/members/${uid}`), member(uid, role));
    }
    for (const [code, data] of Object.entries(invites)) {
      await setDoc(doc(fs, `invites/${code}`), data);
    }
  });
}

describe('creating a group', () => {
  test('a signed-in user creates a group they own, then claims ownership', async () => {
    const fs = db('alice');
    await assertSucceeds(setDoc(doc(fs, `groups/${GID}`), group('alice')));
    await assertSucceeds(
      setDoc(doc(fs, `groups/${GID}/members/alice`), member('alice', 'owner')),
    );
    await assertSucceeds(getDoc(doc(fs, `groups/${GID}`)));
  });

  test('cannot create a group owned by someone else', async () => {
    await assertFails(setDoc(doc(db('alice'), `groups/${GID}`), group('bob')));
  });

  test('signed-out users cannot create groups', async () => {
    await assertFails(setDoc(doc(anon(), `groups/${GID}`), group('alice')));
  });

  test('a non-owner cannot claim owner membership', async () => {
    await seed();
    await assertFails(
      setDoc(doc(db('mallory'), `groups/${GID}/members/mallory`), member('mallory', 'owner')),
    );
  });
});

describe('reading', () => {
  test('non-members cannot read the group or its members', async () => {
    await seed();
    const fs = db('mallory');
    await assertFails(getDoc(doc(fs, `groups/${GID}`)));
    await assertFails(getDocs(collection(fs, `groups/${GID}/members`)));
  });

  test('members can read the group and list members', async () => {
    await seed({ members: { bob: 'viewer' } });
    const fs = db('bob');
    await assertSucceeds(getDoc(doc(fs, `groups/${GID}`)));
    await assertSucceeds(getDocs(collection(fs, `groups/${GID}/members`)));
  });

  test('"my groups" collection-group query on uid succeeds', async () => {
    await seed({ members: { bob: 'editor' } });
    const fs = db('bob');
    const snap = await assertSucceeds(
      getDocs(query(collectionGroup(fs, 'members'), where('uid', '==', 'bob'))),
    );
    expect(snap.docs.map((d) => d.data().groupId)).toEqual([GID]);
  });

  test('"my groups" cannot be used to list other people', async () => {
    await seed({ members: { bob: 'editor' } });
    await assertFails(
      getDocs(query(collectionGroup(db('mallory'), 'members'), where('uid', '==', 'bob'))),
    );
  });

  test('groups cannot be listed', async () => {
    await seed();
    await assertFails(getDocs(collection(db('alice'), 'groups')));
  });
});

describe('invites', () => {
  test('owner and editors create invites; viewers cannot', async () => {
    await seed({ members: { ed: 'editor', vic: 'viewer' } });
    await assertSucceeds(setDoc(doc(db('alice'), 'invites/CODEAAAAAA'), invite('CODEAAAAAA')));
    await assertSucceeds(
      setDoc(doc(db('ed'), 'invites/CODEBBBBBB'), invite('CODEBBBBBB', { createdByUid: 'ed' })),
    );
    await assertFails(
      setDoc(doc(db('vic'), 'invites/CODECCCCCC'), invite('CODECCCCCC', { createdByUid: 'vic' })),
    );
  });

  test('an invite can never grant ownership', async () => {
    await seed();
    await assertFails(
      setDoc(doc(db('alice'), 'invites/CODEAAAAAA'), invite('CODEAAAAAA', { role: 'owner' })),
    );
  });

  test('an invite must start unused and unexpired', async () => {
    await seed();
    const fs = db('alice');
    await assertFails(setDoc(doc(fs, 'invites/CODE1AAAAA'), invite('CODE1AAAAA', { useCount: 1 })));
    await assertFails(
      setDoc(doc(fs, 'invites/CODE2AAAAA'), invite('CODE2AAAAA', { expiresAt: now() - 1 })),
    );
    await assertFails(setDoc(doc(fs, 'invites/CODE3AAAAA'), invite('CODE3AAAAA', { maxUses: 51 })));
  });

  test('any signed-in user can look up a code, but not list codes', async () => {
    await seed({ invites: { CODEAAAAAA: invite('CODEAAAAAA') } });
    await assertSucceeds(getDoc(doc(db('bob'), 'invites/CODEAAAAAA')));
    await assertFails(getDoc(doc(anon(), 'invites/CODEAAAAAA')));
    await assertFails(getDocs(collection(db('bob'), 'invites')));
  });

  test('editors list their own group invites', async () => {
    await seed({ members: { ed: 'editor' }, invites: { CODEAAAAAA: invite('CODEAAAAAA') } });
    await assertSucceeds(
      getDocs(query(collection(db('ed'), 'invites'), where('groupId', '==', GID))),
    );
    await assertFails(
      getDocs(query(collection(db('mallory'), 'invites'), where('groupId', '==', GID))),
    );
  });

  test('owner revokes or extends an invite', async () => {
    await seed({ invites: { CODEAAAAAA: invite('CODEAAAAAA') } });
    const ref = doc(db('alice'), 'invites/CODEAAAAAA');
    await assertSucceeds(updateDoc(ref, { revoked: true }));
    await assertSucceeds(updateDoc(ref, { expiresAt: now() + 30 * DAY, maxUses: 10 }));
  });

  test('editors cannot recycle a code or lift its cap', async () => {
    await seed({
      members: { ed: 'editor' },
      invites: {
        CODEAAAAAA: invite('CODEAAAAAA', {
          maxUses: 2,
          useCount: 2,
          redeemedByUids: ['x', 'y'],
        }),
      },
    });
    const ref = doc(db('ed'), 'invites/CODEAAAAAA');
    await assertFails(updateDoc(ref, { useCount: 0 }));
    await assertFails(updateDoc(ref, { redeemedByUids: [] }));
    await assertFails(updateDoc(ref, { maxUses: 500 }));
    await assertFails(updateDoc(ref, { maxUses: 1 }), 'below uses already made');
    await assertFails(updateDoc(ref, { role: 'viewer' }));
  });
});

describe('redeeming an invite', () => {
  const redeem = (uid, code, role = 'editor') =>
    setDoc(
      doc(db(uid), `groups/${GID}/members/${uid}`),
      member(uid, role, { inviteCode: code, invitedByUid: 'alice' }),
    );

  test('a valid code lets bob join at the invited role, then burn one use', async () => {
    await seed({ invites: { CODEAAAAAA: invite('CODEAAAAAA') } });
    await assertSucceeds(redeem('bob', 'CODEAAAAAA'));
    await assertSucceeds(
      updateDoc(doc(db('bob'), 'invites/CODEAAAAAA'), {
        useCount: 1,
        redeemedByUids: ['bob'],
      }),
    );
    await assertSucceeds(getDoc(doc(db('bob'), `groups/${GID}`)));
  });

  test('cannot join at a higher role than the invite grants', async () => {
    await seed({ invites: { CODEAAAAAA: invite('CODEAAAAAA', { role: 'viewer' }) } });
    await assertFails(redeem('bob', 'CODEAAAAAA', 'editor'));
  });

  test('expired, revoked or used-up codes are rejected', async () => {
    await seed({
      invites: {
        EXPIREDAAA: invite('EXPIREDAAA', { expiresAt: now() - 1000 }),
        REVOKEDAAA: invite('REVOKEDAAA', { revoked: true }),
        USEDUPAAAA: invite('USEDUPAAAA', { maxUses: 1, useCount: 1 }),
      },
    });
    await assertFails(redeem('bob', 'EXPIREDAAA'));
    await assertFails(redeem('bob', 'REVOKEDAAA'));
    await assertFails(redeem('bob', 'USEDUPAAAA'));
  });

  test('a code for another group cannot be used here', async () => {
    await seed({ invites: { OTHERAAAAA: invite('OTHERAAAAA', { groupId: 'g2' }) } });
    await assertFails(redeem('bob', 'OTHERAAAAA'));
  });

  test('cannot join without a code, or on behalf of someone else', async () => {
    await seed({ invites: { CODEAAAAAA: invite('CODEAAAAAA') } });
    await assertFails(
      setDoc(doc(db('bob'), `groups/${GID}/members/bob`), member('bob', 'editor')),
    );
    await assertFails(
      setDoc(
        doc(db('bob'), `groups/${GID}/members/carol`),
        member('carol', 'editor', { inviteCode: 'CODEAAAAAA' }),
      ),
    );
  });

  test('the use count may only go up by one', async () => {
    // bob redeemed as a viewer, so only the redemption-bump rule applies.
    await seed({ members: { bob: 'viewer' }, invites: { CODEAAAAAA: invite('CODEAAAAAA') } });
    await assertFails(
      updateDoc(doc(db('bob'), 'invites/CODEAAAAAA'), { useCount: 0, redeemedByUids: ['bob'] }),
    );
    await assertFails(
      updateDoc(doc(db('bob'), 'invites/CODEAAAAAA'), { useCount: 2, redeemedByUids: ['bob'] }),
    );
  });
});

describe('managing members', () => {
  test('only the owner changes roles', async () => {
    await seed({ members: { bob: 'viewer', ed: 'editor' } });
    await assertSucceeds(updateDoc(doc(db('alice'), `groups/${GID}/members/bob`), { role: 'editor' }));
    await assertFails(updateDoc(doc(db('ed'), `groups/${GID}/members/bob`), { role: 'viewer' }));
    await assertFails(updateDoc(doc(db('bob'), `groups/${GID}/members/bob`), { role: 'owner' }));
  });

  test('members can leave; the owner removes others; the owner cannot be removed', async () => {
    await seed({ members: { bob: 'editor', carol: 'viewer' } });
    await assertSucceeds(deleteDoc(doc(db('bob'), `groups/${GID}/members/bob`)));
    await assertSucceeds(deleteDoc(doc(db('alice'), `groups/${GID}/members/carol`)));
    await assertFails(deleteDoc(doc(db('alice'), `groups/${GID}/members/alice`)));
  });

  test('an editor cannot remove another member', async () => {
    await seed({ members: { ed: 'editor', carol: 'viewer' } });
    await assertFails(deleteDoc(doc(db('ed'), `groups/${GID}/members/carol`)));
  });

  test('only the owner renames the group', async () => {
    await seed({ members: { ed: 'editor' } });
    await assertSucceeds(updateDoc(doc(db('alice'), `groups/${GID}`), { name: 'Renamed' }));
    await assertFails(updateDoc(doc(db('ed'), `groups/${GID}`), { name: 'Hijacked' }));
  });
});

describe('group content', () => {
  test('viewers are read-only; editors write', async () => {
    await seed({ members: { ed: 'editor', vic: 'viewer' } });
    const player = (id) => ({ id, groupId: GID, name: 'Ann' });
    await assertSucceeds(setDoc(doc(db('ed'), `groups/${GID}/players/p1`), player('p1')));
    await assertFails(setDoc(doc(db('vic'), `groups/${GID}/players/p2`), player('p2')));
    await assertSucceeds(getDoc(doc(db('vic'), `groups/${GID}/players/p1`)));
  });
});

describe('user profiles', () => {
  test('users write only their own public profile', async () => {
    await assertSucceeds(
      setDoc(doc(db('bob'), 'users/bob'), { uid: 'bob', displayName: 'Bob' }),
    );
    await assertFails(
      setDoc(doc(db('bob'), 'users/alice'), { uid: 'alice', displayName: 'Evil' }),
    );
    await assertSucceeds(getDoc(doc(db('alice'), 'users/bob')));
  });
});
