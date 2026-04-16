import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/profile/presentation/widgets/icon_collection_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

import '../../helpers/profile_test_helpers.dart';

Widget _buildWidget(int badgeCount) {
  return TranslationProvider(
    child: MaterialApp(
      home: Scaffold(
        body: IconCollectionWidget(
          iconBadges: createIconBadgeList(count: badgeCount),
        ),
      ),
    ),
  );
}

void main() {
  group('IconCollectionWidget - danh sách rỗng', () {
    testWidgets('ẩn toàn bộ widget khi không có icon', (tester) async {
      await tester.pumpWidget(_buildWidget(0));
      await tester.pumpAndSettle();

      expect(find.byType(IconCollectionWidget), findsOneWidget);
      // SizedBox.shrink() — không có Column, không có text
      expect(find.byType(Column), findsNothing);
    });
  });

  group('IconCollectionWidget - có icons', () {
    testWidgets('hiển thị label section', (tester) async {
      await tester.pumpWidget(_buildWidget(3));
      await tester.pumpAndSettle();

      expect(find.text('My icon collection'), findsOneWidget);
    });

    testWidgets('hiển thị đúng số lượng icon slots', (tester) async {
      await tester.pumpWidget(_buildWidget(3));
      await tester.pumpAndSettle();

      expect(find.byType(Container), findsAtLeastNWidgets(3));
    });

    testWidgets('hiển thị Row chứa icons', (tester) async {
      await tester.pumpWidget(_buildWidget(2));
      await tester.pumpAndSettle();

      expect(find.byType(Row), findsOneWidget);
    });
  });
}
