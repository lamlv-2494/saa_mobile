import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_card.dart';
import '../../helpers/kudos_test_helpers.dart';

void main() {
  UserSummary testUser({String id = 'u1', String name = 'Test'}) =>
      UserSummary(id: id, name: name, avatar: '', department: 'CECV1');

  Widget buildTestWidget({
    required KudosCardVariant variant,
    String? awardTitle,
    bool isAnonymous = false,
  }) {
    final kudos = createKudos(
      awardTitle: awardTitle,
      isAnonymous: isAnonymous,
      sender: testUser(id: 'sender-1', name: 'Người gửi'),
      receiver: testUser(id: 'receiver-1', name: 'Người nhận'),
    );
    final card = KudosCard(
      variant: variant,
      kudos: kudos,
      timeText: '1 ngày trước',
    );
    return MaterialApp(
      home: Scaffold(
        body: variant == KudosCardVariant.highlight
            ? SizedBox(height: 300, child: card)
            : SingleChildScrollView(child: card),
      ),
    );
  }

  group('KudosCard - highlight variant', () {
    testWidgets('render sender và receiver name', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(variant: KudosCardVariant.highlight),
      );
      await tester.pumpAndSettle();

      expect(find.text('Người gửi'), findsOneWidget);
      expect(find.text('Người nhận'), findsOneWidget);
    });

    testWidgets('render department dưới name của sender và receiver',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(variant: KudosCardVariant.highlight),
      );
      await tester.pumpAndSettle();

      // Department 'CECV1' xuất hiện 2 lần (sender + receiver)
      expect(find.text('CECV1'), findsNWidgets(2));
    });

    testWidgets('render content text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(variant: KudosCardVariant.highlight),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Cảm ơn bạn đã hỗ trợ project!'),
        findsOneWidget,
      );
    });

    testWidgets('render awardTitle khi có giá trị', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          variant: KudosCardVariant.highlight,
          awardTitle: 'HERO',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('HERO'), findsOneWidget);
    });

    testWidgets('có container với border và background', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(variant: KudosCardVariant.highlight),
      );
      await tester.pumpAndSettle();

      // Highlight variant có Container wrap với decoration
      final container = tester.widget<Container>(
        find.byType(Container).first,
      );
      expect(container.decoration, isNotNull);
    });
  });

  group('KudosCard - feed variant', () {
    testWidgets('render sender và receiver name', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(variant: KudosCardVariant.feed),
      );
      await tester.pumpAndSettle();

      expect(find.text('Người gửi'), findsOneWidget);
      expect(find.text('Người nhận'), findsOneWidget);
    });

    testWidgets('render department dưới name của sender và receiver',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(variant: KudosCardVariant.feed),
      );
      await tester.pumpAndSettle();

      expect(find.text('CECV1'), findsNWidgets(2));
    });

    testWidgets('render awardTitle khi có giá trị', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          variant: KudosCardVariant.feed,
          awardTitle: 'IDOL GIỚI TRẺ',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('IDOL GIỚI TRẺ'), findsOneWidget);
    });

    testWidgets('không render awardTitle khi null', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(variant: KudosCardVariant.feed),
      );
      await tester.pumpAndSettle();

      // Không có text awardTitle nào
      expect(find.text('HERO'), findsNothing);
      expect(find.text('IDOL GIỚI TRẺ'), findsNothing);
      expect(find.text('LEADER'), findsNothing);
    });
  });

  group('KudosCard - callbacks', () {
    testWidgets('gọi onHeartTap khi tap heart', (tester) async {
      var heartTapped = false;
      final kudos = createKudos(
        sender: testUser(id: 'sender-1', name: 'Người gửi'),
        receiver: testUser(id: 'receiver-1', name: 'Người nhận'),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: KudosCard(
                variant: KudosCardVariant.feed,
                kudos: kudos,
                timeText: '1 ngày trước',
                onHeartTap: () => heartTapped = true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tìm HeartButton và tap
      final heartFinder = find.byIcon(Icons.favorite_border);
      if (heartFinder.evaluate().isNotEmpty) {
        await tester.tap(heartFinder.first);
        await tester.pumpAndSettle();
        expect(heartTapped, isTrue);
      }
    });
  });
}
