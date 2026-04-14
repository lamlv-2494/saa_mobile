import 'package:flutter_test/flutter_test.dart';
import 'package:saa_mobile/features/kudos/data/models/department.dart';

void main() {
  group('Department', () {
    test('fromJson tạo đúng object', () {
      final json = {'id': 3, 'name': 'CECV1'};
      final dept = Department.fromJson(json);
      expect(dept.id, 3);
      expect(dept.name, 'CECV1');
    });

    test('toJson roundtrip', () {
      const dept = Department(id: 3, name: 'CECV1');
      final restored = Department.fromJson(dept.toJson());
      expect(restored, dept);
    });
  });
}
