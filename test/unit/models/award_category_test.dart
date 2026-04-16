import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/home/data/models/award_category.dart';

void main() {
  group('AwardCategory (extended)', () {
    test('fromJson parses all new fields', () {
      final json = {
        'id': 1,
        'name': 'Top Talent',
        'name_en': 'Top Talent',
        'slug': 'top-talent',
        'description': 'Giải thưởng Top Talent vinh danh...',
        'description_en': 'The Top Talent award honors...',
        'image_url': '/awards/top_talent.png',
        'quantity': 10,
        'unit': 'Cá nhân',
        'unit_en': 'Individual',
        'prize_value': 7000000,
        'prize_note': 'cho mỗi giải thưởng',
        'prize_note_en': 'per award',
        'sort_order': 1,
        'award_prizes': <Map<String, dynamic>>[],
      };

      final category = AwardCategory.fromJson(json);

      expect(category.id, 1);
      expect(category.name, 'Top Talent');
      expect(category.nameEn, 'Top Talent');
      expect(category.slug, 'top-talent');
      expect(category.description, 'Giải thưởng Top Talent vinh danh...');
      expect(category.descriptionEn, 'The Top Talent award honors...');
      expect(category.imageUrl, '/awards/top_talent.png');
      expect(category.quantity, 10);
      expect(category.unit, 'Cá nhân');
      expect(category.unitEn, 'Individual');
      expect(category.prizeValue, 7000000);
      expect(category.prizeNote, 'cho mỗi giải thưởng');
      expect(category.prizeNoteEn, 'per award');
      expect(category.sortOrder, 1);
      expect(category.awardPrizes, isEmpty);
    });

    test('fromJson with nested award_prizes (Signature case)', () {
      final json = {
        'id': 6,
        'name': 'Signature 2025 - Creator',
        'slug': 'signature-2025-creator',
        'description': 'Giải thưởng Signature...',
        'image_url': '/awards/signature.png',
        'quantity': 1,
        'unit': 'Cá nhân hoặc tập thể',
        'prize_value': null,
        'prize_note': null,
        'sort_order': 6,
        'award_prizes': [
          {
            'id': 1,
            'award_category_id': 6,
            'prize_type': 'individual',
            'value_amount': 5000000,
            'note_vi': 'cho giải cá nhân',
            'note_en': 'for individual award',
            'sort_order': 1,
          },
          {
            'id': 2,
            'award_category_id': 6,
            'prize_type': 'team',
            'value_amount': 8000000,
            'note_vi': 'cho giải tập thể',
            'note_en': 'for team award',
            'sort_order': 2,
          },
        ],
      };

      final category = AwardCategory.fromJson(json);

      expect(category.prizeValue, isNull);
      expect(category.prizeNote, isNull);
      expect(category.awardPrizes, hasLength(2));
      expect(category.awardPrizes[0].prizeType, 'individual');
      expect(category.awardPrizes[0].valueAmount, 5000000);
      expect(category.awardPrizes[1].prizeType, 'team');
      expect(category.awardPrizes[1].valueAmount, 8000000);
    });

    test('fromJson backward compatible — missing new fields use defaults', () {
      final json = {
        'id': 1,
        'name': 'Top Talent',
        'image_url': '/awards/top_talent.png',
        'description': 'Some description',
        'sort_order': 1,
      };

      final category = AwardCategory.fromJson(json);

      expect(category.id, 1);
      expect(category.name, 'Top Talent');
      expect(category.nameEn, '');
      expect(category.slug, '');
      expect(category.descriptionEn, '');
      expect(category.quantity, 0);
      expect(category.unit, '');
      expect(category.unitEn, '');
      expect(category.prizeValue, isNull);
      expect(category.prizeNote, isNull);
      expect(category.prizeNoteEn, isNull);
      expect(category.awardPrizes, isEmpty);
    });
  });
}
