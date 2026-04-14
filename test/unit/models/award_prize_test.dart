import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/award/data/models/award_prize.dart';

void main() {
  group('AwardPrize', () {
    test('fromJson parses correctly', () {
      final json = {
        'id': 1,
        'award_category_id': 6,
        'prize_type': 'individual',
        'value_amount': 5000000,
        'note_vi': 'cho giải cá nhân',
        'note_en': 'for individual award',
        'sort_order': 1,
      };

      final prize = AwardPrize.fromJson(json);

      expect(prize.id, 1);
      expect(prize.awardCategoryId, 6);
      expect(prize.prizeType, 'individual');
      expect(prize.valueAmount, 5000000);
      expect(prize.noteVi, 'cho giải cá nhân');
      expect(prize.noteEn, 'for individual award');
      expect(prize.sortOrder, 1);
    });

    test('fromJson with team prize type', () {
      final json = {
        'id': 2,
        'award_category_id': 6,
        'prize_type': 'team',
        'value_amount': 8000000,
        'note_vi': 'cho giải tập thể',
        'note_en': 'for team award',
        'sort_order': 2,
      };

      final prize = AwardPrize.fromJson(json);

      expect(prize.prizeType, 'team');
      expect(prize.valueAmount, 8000000);
    });

    test('toJson produces correct keys', () {
      const prize = AwardPrize(
        id: 1,
        awardCategoryId: 6,
        prizeType: 'individual',
        valueAmount: 5000000,
        noteVi: 'cho giải cá nhân',
        noteEn: 'for individual award',
        sortOrder: 1,
      );

      final json = prize.toJson();

      expect(json['id'], 1);
      expect(json['award_category_id'], 6);
      expect(json['prize_type'], 'individual');
      expect(json['value_amount'], 5000000);
      expect(json['note_vi'], 'cho giải cá nhân');
      expect(json['note_en'], 'for individual award');
      expect(json['sort_order'], 1);
    });

    test('equality works', () {
      const a = AwardPrize(
        id: 1,
        awardCategoryId: 6,
        prizeType: 'individual',
        valueAmount: 5000000,
        noteVi: 'cho giải cá nhân',
        noteEn: 'for individual award',
        sortOrder: 1,
      );
      const b = AwardPrize(
        id: 1,
        awardCategoryId: 6,
        prizeType: 'individual',
        valueAmount: 5000000,
        noteVi: 'cho giải cá nhân',
        noteEn: 'for individual award',
        sortOrder: 1,
      );

      expect(a, equals(b));
    });
  });
}
