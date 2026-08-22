import 'package:cricket_scoring/data/auth/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppUser', () {
    const user = AppUser(
      uid: 'abc123',
      displayName: 'Rohit Sharma',
      email: 'rohit@example.com',
      photoUrl: 'https://example.com/p.png',
    );

    test('survives a JSON round-trip', () {
      expect(AppUser.fromJson(user.toJson()), user);
    });

    test('tolerates a user with only a uid', () {
      const bare = AppUser(uid: 'u1');
      final json = bare.toJson();
      expect(json['displayName'], isNull);
      expect(AppUser.fromJson(json), bare);
    });

    test('value equality, not identity', () {
      expect(
        const AppUser(uid: 'u1', email: 'a@b.c'),
        const AppUser(uid: 'u1', email: 'a@b.c'),
      );
      expect(const AppUser(uid: 'u1'), isNot(const AppUser(uid: 'u2')));
    });

    test('label prefers name, then email, then uid', () {
      expect(user.label, 'Rohit Sharma');
      expect(const AppUser(uid: 'u1', email: 'a@b.c').label, 'a@b.c');
      expect(const AppUser(uid: 'u1').label, 'u1');
      // A blank display name must not win over a usable email.
      expect(
        const AppUser(uid: 'u1', displayName: '  ', email: 'a@b.c').label,
        'a@b.c',
      );
    });

    test('initials give the avatar something to draw', () {
      expect(user.initials, 'RS');
      expect(const AppUser(uid: 'u1', displayName: 'Kohli').initials, 'K');
      expect(const AppUser(uid: 'u1', email: 'a.b@x.com').initials, 'AB');
    });
  });
}
