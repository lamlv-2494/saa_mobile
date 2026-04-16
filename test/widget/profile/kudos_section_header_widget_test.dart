import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/profile/presentation/widgets/kudos_section_header_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

Widget _buildWidget() {
  return TranslationProvider(
    child: const MaterialApp(
      home: Scaffold(body: KudosSectionHeaderWidget()),
    ),
  );
}

void main() {
  group('KudosSectionHeaderWidget', () {
    testWidgets('hiển thị subtitle "Sun* Annual Awards 2025"', (tester) async {
      await tester.pumpWidget(_buildWidget());
      await tester.pumpAndSettle();

      expect(find.text('Sun* Annual Awards 2025'), findsOneWidget);
    });

    testWidgets('hiển thị title "KUDOS"', (tester) async {
      await tester.pumpWidget(_buildWidget());
      await tester.pumpAndSettle();

      expect(find.text('KUDOS'), findsOneWidget);
    });

    testWidgets('render Stack với banner image background', (tester) async {
      await tester.pumpWidget(_buildWidget());
      await tester.pumpAndSettle();

      // Widget phải chứa Stack với image background bên trong
      expect(
        find.descendant(
          of: find.byType(KudosSectionHeaderWidget),
          matching: find.byType(Stack),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(KudosSectionHeaderWidget),
          matching: find.byType(Image),
        ),
        findsOneWidget,
      );
    });
  });
}
