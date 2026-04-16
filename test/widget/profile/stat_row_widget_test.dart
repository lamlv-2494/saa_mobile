import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/profile/presentation/widgets/stat_row_widget.dart';

Widget _buildWidget({
  required String label,
  required String value,
}) {
  return MaterialApp(
    home: Scaffold(
      body: StatRowWidget(label: label, value: value),
    ),
  );
}

void main() {
  group('StatRowWidget', () {
    testWidgets('hiển thị label', (tester) async {
      await tester.pumpWidget(_buildWidget(label: 'Kudos nhận được', value: '5'));
      await tester.pumpAndSettle();

      expect(find.text('Kudos nhận được'), findsOneWidget);
    });

    testWidgets('hiển thị value', (tester) async {
      await tester.pumpWidget(_buildWidget(label: 'Kudos nhận được', value: '25'));
      await tester.pumpAndSettle();

      expect(find.text('25'), findsOneWidget);
    });

    testWidgets('layout Row có 2 phần tử text', (tester) async {
      await tester.pumpWidget(_buildWidget(label: 'Label', value: '0'));
      await tester.pumpAndSettle();

      expect(find.byType(Row), findsAtLeastNWidgets(1));
      expect(find.byType(Text), findsNWidgets(2));
    });
  });
}
