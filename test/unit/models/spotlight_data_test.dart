import 'package:flutter_test/flutter_test.dart';
import 'package:saa_mobile/features/kudos/data/models/spotlight_data.dart';

void main() {
  group('SpotlightEntry', () {
    test('fromJson tạo đúng object', () {
      final json = {
        'userId': 'u1',
        'name': 'Nguyen Van A',
        'x': 100.5,
        'y': 50.3,
      };
      final entry = SpotlightEntry.fromJson(json);
      expect(entry.userId, 'u1');
      expect(entry.name, 'Nguyen Van A');
      expect(entry.x, 100.5);
      expect(entry.y, 50.3);
    });

    test('default x và y là 0.0', () {
      const entry = SpotlightEntry(userId: 'u1', name: 'Test');
      expect(entry.x, 0.0);
      expect(entry.y, 0.0);
    });

    test('copyWith thay đổi đúng field', () {
      const entry = SpotlightEntry(userId: 'u1', name: 'A', x: 10.0, y: 20.0);
      final updated = entry.copyWith(name: 'B', x: 300.0);
      expect(updated.userId, 'u1');
      expect(updated.name, 'B');
      expect(updated.x, 300.0);
      expect(updated.y, 20.0);
    });

    test('toJson trả về đúng map', () {
      const entry = SpotlightEntry(userId: 'u2', name: 'Tran Thi B', x: 200.0, y: 80.0);
      final json = entry.toJson();
      expect(json['userId'], 'u2');
      expect(json['name'], 'Tran Thi B');
      expect(json['x'], 200.0);
      expect(json['y'], 80.0);
    });

    test('equality hoạt động đúng', () {
      const a = SpotlightEntry(userId: 'u1', name: 'A', x: 10.0, y: 20.0);
      const b = SpotlightEntry(userId: 'u1', name: 'A', x: 10.0, y: 20.0);
      expect(a, equals(b));
    });
  });

  group('SpotlightActivity', () {
    test('fromJson tạo đúng object', () {
      final json = {
        'timestamp': '10:30am',
        'receiverName': 'Le Van C',
      };
      final activity = SpotlightActivity.fromJson(json);
      expect(activity.timestamp, '10:30am');
      expect(activity.receiverName, 'Le Van C');
    });

    test('copyWith thay đổi đúng field', () {
      const activity = SpotlightActivity(timestamp: '09:00am', receiverName: 'A');
      final updated = activity.copyWith(receiverName: 'B');
      expect(updated.timestamp, '09:00am');
      expect(updated.receiverName, 'B');
    });

    test('toJson trả về đúng map', () {
      const activity = SpotlightActivity(timestamp: '2:15pm', receiverName: 'Pham D');
      final json = activity.toJson();
      expect(json['timestamp'], '2:15pm');
      expect(json['receiverName'], 'Pham D');
    });

    test('equality hoạt động đúng', () {
      const a = SpotlightActivity(timestamp: '01:00pm', receiverName: 'X');
      const b = SpotlightActivity(timestamp: '01:00pm', receiverName: 'X');
      expect(a, equals(b));
    });
  });

  group('SpotlightData', () {
    test('fromJson tạo đúng object', () {
      final json = {
        'entries': [
          {'userId': 'u1', 'name': 'A', 'x': 10.0, 'y': 20.0},
          {'userId': 'u2', 'name': 'B', 'x': 150.0, 'y': 60.0},
        ],
        'totalKudos': 388,
        'recentActivity': [
          {'timestamp': '10:00am', 'receiverName': 'A'},
        ],
      };
      final data = SpotlightData.fromJson(json);
      expect(data.totalKudos, 388);
      expect(data.entries.length, 2);
      expect(data.entries.first.name, 'A');
      expect(data.recentActivity.length, 1);
      expect(data.recentActivity.first.receiverName, 'A');
    });

    test('default empty', () {
      const data = SpotlightData();
      expect(data.entries, isEmpty);
      expect(data.totalKudos, 0);
      expect(data.recentActivity, isEmpty);
    });

    test('copyWith thay đổi đúng field', () {
      const data = SpotlightData(totalKudos: 10);
      final updated = data.copyWith(totalKudos: 20);
      expect(updated.totalKudos, 20);
      expect(updated.entries, isEmpty);
    });

    test('toJson trả về đúng map', () {
      const data = SpotlightData(
        entries: [SpotlightEntry(userId: 'u1', name: 'A', x: 5.0, y: 10.0)],
        totalKudos: 5,
        recentActivity: [SpotlightActivity(timestamp: '08:00am', receiverName: 'A')],
      );
      final json = data.toJson();
      expect(json['totalKudos'], 5);
      expect((json['entries'] as List).length, 1);
      expect((json['recentActivity'] as List).length, 1);
    });

    test('entries có thể chứa nhiều hơn 50 entries', () {
      final entries = List.generate(
        60,
        (i) => SpotlightEntry(userId: 'u$i', name: 'User $i', x: i * 10.0, y: i * 2.0),
      );
      final data = SpotlightData(entries: entries, totalKudos: 60);
      expect(data.entries.length, 60);
    });

    test('recentActivity có thể chứa tối đa 10 entries', () {
      final activities = List.generate(
        10,
        (i) => SpotlightActivity(timestamp: '$i:00am', receiverName: 'User $i'),
      );
      final data = SpotlightData(recentActivity: activities);
      expect(data.recentActivity.length, 10);
    });
  });
}
