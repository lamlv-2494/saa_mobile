import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/award/data/models/award_prize.dart';
import 'package:saa_mobile/features/award/presentation/widgets/award_badge_image_widget.dart';
import 'package:saa_mobile/features/award/presentation/widgets/award_info_block_widget.dart';
import 'package:saa_mobile/features/award/presentation/widgets/award_stat_row_widget.dart';
import 'package:saa_mobile/features/home/data/models/award_category.dart';

void main() {
  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  const singlePrizeCategory = AwardCategory(
    id: 1,
    name: 'Top Talent',
    slug: 'top-talent',
    description: 'Top Talent vinh danh những cá nhân xuất sắc.',
    quantity: 10,
    unit: 'Cá nhân',
    prizeValue: 7000000,
    prizeNote: 'cho mỗi giải thưởng',
    sortOrder: 1,
  );

  const signatureCategory = AwardCategory(
    id: 5,
    name: 'Signature 2025 - Creator',
    slug: 'signature-2025-creator',
    description: 'Signature desc.',
    quantity: 1,
    unit: 'Cá nhân hoặc tập thể',
    sortOrder: 5,
    awardPrizes: [
      AwardPrize(
        id: 1,
        awardCategoryId: 5,
        prizeType: 'individual',
        valueAmount: 5000000,
        noteVi: 'cho giải cá nhân',
        noteEn: 'for individual award',
      ),
      AwardPrize(
        id: 2,
        awardCategoryId: 5,
        prizeType: 'team',
        valueAmount: 8000000,
        noteVi: 'cho giải tập thể',
        noteEn: 'for team award',
      ),
    ],
  );

  Widget buildTestWidget(AwardCategory category) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: AwardInfoBlock(category: category, locale: 'vi'),
        ),
      ),
    );
  }

  group('AwardInfoBlock', () {
    testWidgets('renders badge image', (tester) async {
      await tester.pumpWidget(buildTestWidget(singlePrizeCategory));
      await tester.pump();

      expect(find.byType(AwardBadgeImage), findsOneWidget);
    });

    testWidgets('renders award name', (tester) async {
      await tester.pumpWidget(buildTestWidget(singlePrizeCategory));
      await tester.pump();

      expect(find.text('Top Talent'), findsOneWidget);
    });

    testWidgets('renders description', (tester) async {
      await tester.pumpWidget(buildTestWidget(singlePrizeCategory));
      await tester.pump();

      expect(
        find.text('Top Talent vinh danh những cá nhân xuất sắc.'),
        findsOneWidget,
      );
    });

    testWidgets('renders quantity stat row', (tester) async {
      await tester.pumpWidget(buildTestWidget(singlePrizeCategory));
      await tester.pump();

      // Quantity stat — value is padded to 2 digits
      expect(find.text('10'), findsOneWidget);
      expect(find.text('Cá nhân'), findsOneWidget);
    });

    testWidgets('renders single prize stat for normal category', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(singlePrizeCategory));
      await tester.pump();

      // Single prize row via AwardStatRow
      expect(find.byType(AwardStatRow), findsNWidgets(2)); // quantity + prize
      expect(find.text('cho mỗi giải thưởng'), findsOneWidget);
    });

    testWidgets('renders 2 prize rows for Signature category', (tester) async {
      await tester.pumpWidget(buildTestWidget(signatureCategory));
      await tester.pump();

      expect(find.text('cho giải cá nhân'), findsOneWidget);
      expect(find.text('cho giải tập thể'), findsOneWidget);
    });

    testWidgets('renders dividers', (tester) async {
      await tester.pumpWidget(buildTestWidget(singlePrizeCategory));
      await tester.pump();

      // Should have 2 dividers (after description and after quantity)
      final dividers = find.byWidgetPredicate(
        (w) => w is Container && w.color != null,
      );
      expect(dividers, findsAtLeast(2));
    });
  });
}
