import 'package:flutter_test/flutter_test.dart';
import 'package:saa_mobile/features/kudos/data/models/gift_recipient_ranking.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';

void main() {
  group('GiftRecipientRanking', () {
    test('fromJson tạo đúng object', () {
      final json = {
        'rank': 1,
        'user': {
          'id': 'u1',
          'name': 'Top 1',
          'avatar': '',
          'department': 'CECV1',
          'badgeLevel': 3,
        },
        'giftCount': 15,
      };
      final ranking = GiftRecipientRanking.fromJson(json);
      expect(ranking.rank, 1);
      expect(ranking.user.name, 'Top 1');
      expect(ranking.giftCount, 15);
    });

    test('default giftCount = 0', () {
      const ranking = GiftRecipientRanking(
        rank: 1,
        user: UserSummary(id: 'u1', name: 'Test'),
      );
      expect(ranking.giftCount, 0);
    });
  });
}
