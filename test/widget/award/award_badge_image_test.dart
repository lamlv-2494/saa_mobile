import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/award/presentation/widgets/award_badge_image_widget.dart';

void main() {
  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });
  Widget buildTestWidget() {
    return const MaterialApp(
      home: Scaffold(
        body: AwardBadgeImage(
          slug: 'top-talent',
          semanticLabel: 'Huy hiệu giải Top Talent',
        ),
      ),
    );
  }

  group('AwardBadgeImage', () {
    testWidgets('renders 160x160 container', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(find.byType(Container).first);
      final boxDecoration = container.decoration as BoxDecoration?;

      expect(container.constraints?.maxWidth, 160);
      expect(container.constraints?.maxHeight, 160);
      expect(boxDecoration?.borderRadius, BorderRadius.circular(11.429));
    });

    testWidgets('has glow box shadow', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(find.byType(Container).first);
      final boxDecoration = container.decoration as BoxDecoration;

      expect(boxDecoration.boxShadow, isNotNull);
      expect(boxDecoration.boxShadow!.length, 2);
    });

    testWidgets('has semantic label', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Huy hiệu giải Top Talent'), findsOneWidget);
    });

    testWidgets('is centered', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Center), findsOneWidget);
    });
  });
}
