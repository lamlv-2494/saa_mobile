import 'package:flutter_test/flutter_test.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';

void main() {
  group('PersonalStats', () {
    test('fromJson tạo đúng object', () {
      final json = {
        'kudosReceived': 25,
        'kudosSent': 20,
        'heartsReceived': 30,
        'secretBoxesOpened': 3,
        'secretBoxesUnopened': 2,
        'starBadgeLevel': 1,
        'isBonusActive': true,
      };
      final stats = PersonalStats.fromJson(json);
      expect(stats.kudosReceived, 25);
      expect(stats.isBonusActive, true);
      expect(stats.starBadgeLevel, 1);
    });

    test('default values all zero', () {
      const stats = PersonalStats();
      expect(stats.kudosReceived, 0);
      expect(stats.kudosSent, 0);
      expect(stats.heartsReceived, 0);
      expect(stats.secretBoxesOpened, 0);
      expect(stats.secretBoxesUnopened, 0);
      expect(stats.starBadgeLevel, 0);
      expect(stats.isBonusActive, false);
    });

    test('toJson roundtrip', () {
      const stats = PersonalStats(kudosReceived: 10, isBonusActive: true);
      final restored = PersonalStats.fromJson(stats.toJson());
      expect(restored, stats);
    });
  });
}
