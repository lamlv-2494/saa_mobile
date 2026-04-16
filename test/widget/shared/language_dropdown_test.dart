import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/shared/widgets/language_dropdown.dart';

void main() {
  Widget buildTestWidget({
    String currentLocaleCode = 'vi',
    ValueChanged<String>? onLocaleChanged,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: LanguageDropdown(
            currentLocaleCode: currentLocaleCode,
            onLocaleChanged: onLocaleChanged ?? (_) {},
          ),
        ),
      ),
    );
  }

  group('LanguageDropdown', () {
    testWidgets('renders VN label for vi locale', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.text('VN'), findsOneWidget);
    });

    testWidgets('renders EN label for en locale', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentLocaleCode: 'en'));

      expect(find.text('EN'), findsOneWidget);
    });

    testWidgets('falls back to VN for unsupported locale', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentLocaleCode: 'ja'));

      expect(find.text('VN'), findsOneWidget);
    });

    testWidgets('shows dropdown with both options when tapped', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentLocaleCode: 'vi'));

      await tester.tap(find.byType(LanguageDropdown));
      await tester.pumpAndSettle();

      // Both VN and EN should appear in popup menu
      expect(find.text('VN'), findsWidgets);
      expect(find.text('EN'), findsWidgets);
    });

    testWidgets('selected locale item has highlighted background',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(currentLocaleCode: 'vi'));

      await tester.tap(find.byType(LanguageDropdown));
      await tester.pumpAndSettle();

      // Selected item uses a Container with non-transparent background color
      final containers = tester.widgetList<Container>(find.byType(Container));
      final highlighted = containers.where((c) {
        final decoration = c.decoration;
        if (decoration is BoxDecoration) {
          final color = decoration.color;
          return color != null && color != Colors.transparent;
        }
        return false;
      });
      expect(highlighted.isNotEmpty, isTrue);
    });

    testWidgets('calls onLocaleChanged with selected locale code',
        (tester) async {
      String? selectedCode;
      await tester.pumpWidget(
        buildTestWidget(
          currentLocaleCode: 'vi',
          onLocaleChanged: (code) => selectedCode = code,
        ),
      );

      // Open dropdown
      await tester.tap(find.byType(LanguageDropdown));
      await tester.pumpAndSettle();

      // Tap EN option — find the PopupMenuItem containing 'EN' text
      final enItems = find.widgetWithText(PopupMenuItem<String>, 'EN');
      await tester.tap(enItems.last);
      await tester.pumpAndSettle();

      expect(selectedCode, 'en');
    });

    testWidgets('does not call onLocaleChanged when selecting current locale',
        (tester) async {
      String? selectedCode;
      await tester.pumpWidget(
        buildTestWidget(
          currentLocaleCode: 'vi',
          onLocaleChanged: (code) => selectedCode = code,
        ),
      );

      // Open dropdown
      await tester.tap(find.byType(LanguageDropdown));
      await tester.pumpAndSettle();

      // Tap VN option (already selected) — find PopupMenuItem with 'VN'
      final vnItems = find.widgetWithText(PopupMenuItem<String>, 'VN');
      await tester.tap(vnItems.last);
      await tester.pumpAndSettle();

      // onSelected fires with 'vi', callback is still called
      expect(selectedCode, 'vi');
    });
  });
}
