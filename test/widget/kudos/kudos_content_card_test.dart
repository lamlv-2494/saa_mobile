import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_content_card.dart';

void main() {
  Widget buildTestWidget({
    String? awardTitle,
    String content = 'Cảm ơn bạn đã hỗ trợ project!',
    int heartCount = 10,
  }) {
    final hashtags = [const Hashtag(id: 1, name: '#teamwork')];
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: KudosContentCard(
            content: content,
            hashtags: hashtags,
            heartCount: heartCount,
            isLikedByMe: false,
            canLike: true,
            timeText: '1 ngày trước',
            awardTitle: awardTitle,
          ),
        ),
      ),
    );
  }

  group('KudosContentCard - awardTitle', () {
    testWidgets('hiển thị awardTitle khi có giá trị', (tester) async {
      await tester.pumpWidget(buildTestWidget(awardTitle: 'IDOL GIỚI TRẺ'));
      await tester.pumpAndSettle();

      expect(find.text('IDOL GIỚI TRẺ'), findsOneWidget);
    });

    testWidgets('không hiển thị awardTitle khi null', (tester) async {
      await tester.pumpWidget(buildTestWidget(awardTitle: null));
      await tester.pumpAndSettle();

      expect(find.text('IDOL GIỚI TRẺ'), findsNothing);
    });

    testWidgets('không hiển thị awardTitle khi rỗng', (tester) async {
      await tester.pumpWidget(buildTestWidget(awardTitle: ''));
      await tester.pumpAndSettle();

      expect(find.text('IDOL GIỚI TRẺ'), findsNothing);
    });

    testWidgets('awardTitle hiển thị trước content', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          awardTitle: 'LEADER',
          content: 'Nội dung kudos',
        ),
      );
      await tester.pumpAndSettle();

      final awardFinder = find.text('LEADER');
      final contentFinder = find.text('Nội dung kudos');

      expect(awardFinder, findsOneWidget);
      expect(contentFinder, findsOneWidget);

      // awardTitle nằm trên content (có vị trí y nhỏ hơn)
      final awardY = tester.getTopLeft(awardFinder).dy;
      final contentY = tester.getTopLeft(contentFinder).dy;
      expect(awardY, lessThan(contentY));
    });
  });
}
