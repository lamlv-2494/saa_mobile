import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/profile/presentation/widgets/badge_collection_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

import '../../helpers/profile_test_helpers.dart';

Widget _buildWidget(int count) {
  return TranslationProvider(
    child: MaterialApp(
      home: Scaffold(
        body: BadgeCollectionWidget(badges: createBadgeList(count: count)),
      ),
    ),
  );
}

void main() {
  group('BadgeCollectionWidget - danh sách rỗng', () {
    testWidgets('ẩn toàn bộ section khi không có badge', (tester) async {
      await tester.pumpWidget(_buildWidget(0));
      await tester.pumpAndSettle();

      // SizedBox.shrink() — Column không render
      expect(find.byType(Wrap), findsNothing);
    });
  });

  group('BadgeCollectionWidget - có badges', () {
    testWidgets('hiển thị label section', (tester) async {
      await tester.pumpWidget(_buildWidget(2));
      await tester.pumpAndSettle();

      expect(find.text('Badge collection'), findsOneWidget);
    });

    testWidgets('hiển thị tên badge cho mỗi badge', (tester) async {
      await tester.pumpWidget(_buildWidget(2));
      await tester.pumpAndSettle();

      expect(find.text('Badge 1'), findsOneWidget);
      expect(find.text('Badge 2'), findsOneWidget);
    });

    testWidgets('hiển thị Wrap layout', (tester) async {
      await tester.pumpWidget(_buildWidget(3));
      await tester.pumpAndSettle();

      expect(find.byType(Wrap), findsOneWidget);
    });
  });
}
