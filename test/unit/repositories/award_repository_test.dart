import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saa_mobile/features/award/data/datasources/award_remote_datasource.dart';
import 'package:saa_mobile/features/award/data/models/award_prize.dart';
import 'package:saa_mobile/features/award/data/repositories/award_repository.dart';
import 'package:saa_mobile/features/home/data/models/award_category.dart';

class MockAwardRemoteDatasource extends Mock
    implements AwardRemoteDatasource {}

void main() {
  late MockAwardRemoteDatasource mockDatasource;
  late AwardRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockAwardRemoteDatasource();
    repository = AwardRepositoryImpl(mockDatasource);
  });

  final sampleCategories = [
    const AwardCategory(
      id: 1,
      name: 'Top Talent',
      nameEn: 'Top Talent',
      slug: 'top-talent',
      quantity: 10,
      unit: 'Cá nhân',
      unitEn: 'Individual',
      prizeValue: 7000000,
      prizeNote: 'cho mỗi giải thưởng',
      prizeNoteEn: 'per award',
      sortOrder: 1,
    ),
    const AwardCategory(
      id: 6,
      name: 'Signature 2025 - Creator',
      slug: 'signature-2025-creator',
      quantity: 1,
      unit: 'Cá nhân hoặc tập thể',
      sortOrder: 6,
      awardPrizes: [
        AwardPrize(
          id: 1,
          awardCategoryId: 6,
          prizeType: 'individual',
          valueAmount: 5000000,
          noteVi: 'cho giải cá nhân',
          noteEn: 'for individual award',
        ),
        AwardPrize(
          id: 2,
          awardCategoryId: 6,
          prizeType: 'team',
          valueAmount: 8000000,
          noteVi: 'cho giải tập thể',
          noteEn: 'for team award',
        ),
      ],
    ),
  ];

  group('AwardRepository', () {
    test('getCategoriesWithPrizes returns categories from datasource', () async {
      when(() => mockDatasource.getCategoriesWithPrizes(locale: 'vi'))
          .thenAnswer((_) async => sampleCategories);

      final result = await repository.getCategoriesWithPrizes(locale: 'vi');

      expect(result, hasLength(2));
      expect(result[0].name, 'Top Talent');
      expect(result[1].awardPrizes, hasLength(2));
      verify(() => mockDatasource.getCategoriesWithPrizes(locale: 'vi'))
          .called(1);
    });

    test('getCategoriesWithPrizes passes locale en to datasource', () async {
      when(() => mockDatasource.getCategoriesWithPrizes(locale: 'en'))
          .thenAnswer((_) async => sampleCategories);

      await repository.getCategoriesWithPrizes(locale: 'en');

      verify(() => mockDatasource.getCategoriesWithPrizes(locale: 'en'))
          .called(1);
    });

    test('getCategoriesWithPrizes throws on datasource error', () async {
      when(() => mockDatasource.getCategoriesWithPrizes(locale: 'vi'))
          .thenThrow(Exception('Network error'));

      expect(
        () => repository.getCategoriesWithPrizes(locale: 'vi'),
        throwsException,
      );
    });
  });
}
