import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/profile/data/models/kudos_filter_type.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_kudos_filter_dropdown.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

Widget _buildWidget({
  KudosFilterType currentFilter = KudosFilterType.received,
  int sentCount = 10,
  int receivedCount = 5,
  ValueChanged<KudosFilterType>? onChanged,
}) {
  return TranslationProvider(
    child: MaterialApp(
      home: Scaffold(
        body: ProfileKudosFilterDropdown(
          currentFilter: currentFilter,
          sentCount: sentCount,
          receivedCount: receivedCount,
          onChanged: onChanged ?? (_) {},
        ),
      ),
    ),
  );
}

void main() {
  group('ProfileKudosFilterDropdown - hiển thị', () {
    testWidgets('hiển thị label filter hiện tại (received)', (tester) async {
      await tester.pumpWidget(
        _buildWidget(currentFilter: KudosFilterType.received, receivedCount: 5),
      );
      await tester.pumpAndSettle();

      expect(find.text('Received (5)'), findsOneWidget);
    });

    testWidgets('hiển thị label filter hiện tại (sent)', (tester) async {
      await tester.pumpWidget(
        _buildWidget(currentFilter: KudosFilterType.sent, sentCount: 10),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sent (10)'), findsOneWidget);
    });

    testWidgets('không hiển thị overlay khi chưa tap', (tester) async {
      await tester.pumpWidget(_buildWidget());
      await tester.pumpAndSettle();

      // Chỉ có 1 text (button label), overlay chưa mở
      expect(find.text('Received (5)'), findsOneWidget);
    });
  });

  group('ProfileKudosFilterDropdown - tương tác', () {
    testWidgets('mở overlay khi tap button', (tester) async {
      await tester.pumpWidget(
        _buildWidget(currentFilter: KudosFilterType.received, receivedCount: 5, sentCount: 10),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Received (5)'));
      await tester.pumpAndSettle();

      // Overlay hiển thị cả 2 options
      expect(find.text('Received (5)'), findsNWidgets(2));
      expect(find.text('Sent (10)'), findsOneWidget);
    });

    testWidgets('gọi onChanged khi chọn filter khác', (tester) async {
      KudosFilterType? selected;
      await tester.pumpWidget(
        _buildWidget(
          currentFilter: KudosFilterType.received,
          sentCount: 10,
          receivedCount: 5,
          onChanged: (f) => selected = f,
        ),
      );
      await tester.pumpAndSettle();

      // Mở overlay
      await tester.tap(find.text('Received (5)'));
      await tester.pumpAndSettle();

      // Chọn "Sent"
      await tester.tap(find.text('Sent (10)'));
      await tester.pumpAndSettle();

      expect(selected, KudosFilterType.sent);
    });
  });
}
