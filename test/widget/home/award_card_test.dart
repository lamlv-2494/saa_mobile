import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/home/data/models/award_category.dart';
import 'package:saa_mobile/features/home/presentation/widgets/award_card_widget.dart';

void main() {
  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  const testAward = AwardCategory(
    id: 1,
    name: 'Top Talent',
    imageUrl: '',
    description:
        'Giải thưởng Top Talent vinh danh những cá nhân xuất sắc toàn diện trên mọi phương diện trong năm vừa qua.',
  );

  Widget buildTestWidget({VoidCallback? onDetailsTap}) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 350,
            child: AwardCardWidget(
              award: testAward,
              onDetailsTap: onDetailsTap ?? () {},
            ),
          ),
        ),
      ),
    );
  }

  group('AwardCardWidget', () {
    testWidgets('renders award name and description', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('Top Talent'), findsWidgets);
      expect(
        find.textContaining('Giải thưởng Top Talent'),
        findsOneWidget,
      );
    });

    testWidgets('description has max 3 lines with ellipsis', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      final descText = tester.widgetList<Text>(
        find.textContaining('Giải thưởng Top Talent'),
      ).first;
      expect(descText.maxLines, 3);
      expect(descText.overflow, TextOverflow.ellipsis);
    });

    testWidgets('calls onDetailsTap when "Chi tiết" is tapped',
        (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        buildTestWidget(onDetailsTap: () => tapped = true),
      );

      // slang defaults to EN in test — button text is "Details"
      await tester.tap(find.text('Details'));
      expect(tapped, true);
    });
  });
}
