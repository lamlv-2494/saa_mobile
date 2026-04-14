import 'package:flutter_test/flutter_test.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';

void main() {
  group('UserSummary', () {
    test('fromJson tạo đúng object', () {
      final json = {
        'id': 'u1',
        'name': 'Nguyễn Văn A',
        'avatar': 'https://example.com/a.png',
        'department': 'CECV1',
        'badgeLevel': 2,
      };
      final user = UserSummary.fromJson(json);
      expect(user.id, 'u1');
      expect(user.name, 'Nguyễn Văn A');
      expect(user.department, 'CECV1');
      expect(user.badgeLevel, 2);
    });

    test('toJson roundtrip', () {
      const user = UserSummary(id: 'u1', name: 'Test');
      final json = user.toJson();
      final restored = UserSummary.fromJson(json);
      expect(restored, user);
    });

    test('default values', () {
      const user = UserSummary(id: 'u1', name: 'Test');
      expect(user.avatar, '');
      expect(user.department, '');
      expect(user.badgeLevel, 0);
    });

    test('equality', () {
      const a = UserSummary(id: 'u1', name: 'Test');
      const b = UserSummary(id: 'u1', name: 'Test');
      expect(a, b);
    });

    test('copyWith', () {
      const user = UserSummary(id: 'u1', name: 'Test');
      final updated = user.copyWith(name: 'Updated');
      expect(updated.name, 'Updated');
      expect(updated.id, 'u1');
    });
  });
}
