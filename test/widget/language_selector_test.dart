import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/shared/widgets/language_selector.dart';

void main() {
  Widget buildTestWidget({
    String currentLocaleCode = 'vi',
    VoidCallback? onTap,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: LanguageSelector(
            currentLocaleCode: currentLocaleCode,
            onTap: onTap ?? () {},
          ),
        ),
      ),
    );
  }

  group('LanguageSelector', () {
    testWidgets('renders VN label for vi locale', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('VN'), findsOneWidget);
    });

    testWidgets('renders EN label for en locale', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentLocaleCode: 'en'));

      expect(find.text('EN'), findsOneWidget);
    });

    testWidgets('falls back to VN for unsupported locale (ja)', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentLocaleCode: 'ja'));

      expect(find.text('VN'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildTestWidget(onTap: () => tapped = true));

      await tester.tap(find.byType(LanguageSelector));
      expect(tapped, isTrue);
    });

    testWidgets('falls back to VN for unknown locale', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentLocaleCode: 'zz'));

      expect(find.text('VN'), findsOneWidget);
    });
  });
}
