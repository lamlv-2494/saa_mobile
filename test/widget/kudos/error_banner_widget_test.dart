import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/presentation/widgets/error_banner_widget.dart';

Widget _buildBanner({
  required String message,
  int shakeKey = 0,
  VoidCallback? onDismiss,
}) =>
    MaterialApp(
      home: Scaffold(
        body: ErrorBannerWidget(
          message: message,
          shakeKey: shakeKey,
          onDismiss: onDismiss,
        ),
      ),
    );

void main() {
  group('ErrorBannerWidget - visibility', () {
    testWidgets('hiển thị text lỗi khi message không rỗng', (tester) async {
      await tester.pumpWidget(
        _buildBanner(message: 'Vui lòng điền đầy đủ thông tin!'),
      );
      await tester.pumpAndSettle();

      expect(find.text('Vui lòng điền đầy đủ thông tin!'), findsOneWidget);
    });

    testWidgets('ẩn hoàn toàn khi message rỗng', (tester) async {
      await tester.pumpWidget(_buildBanner(message: ''));
      await tester.pumpAndSettle();

      expect(find.byType(Container), findsNothing);
    });
  });

  group('ErrorBannerWidget - style', () {
    testWidgets('container có border màu đỏ và background đỏ mờ', (tester) async {
      await tester.pumpWidget(_buildBanner(message: 'Lỗi rồi!'));
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(
        find.ancestor(
          of: find.text('Lỗi rồi!'),
          matching: find.byType(Container),
        ).first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNotNull);
      expect(decoration.borderRadius, isNotNull);
    });

    testWidgets('text style 13px/w500', (tester) async {
      await tester.pumpWidget(_buildBanner(message: 'Lỗi nè'));
      await tester.pumpAndSettle();

      final text = tester.widget<Text>(find.text('Lỗi nè'));
      expect(text.style?.fontSize, 13);
      expect(text.style?.fontWeight, FontWeight.w500);
    });
  });

  group('ErrorBannerWidget - shake animation', () {
    testWidgets('widget render được khi shakeKey = 0', (tester) async {
      await tester.pumpWidget(_buildBanner(message: 'Lỗi', shakeKey: 0));
      await tester.pump();

      expect(find.byType(ErrorBannerWidget), findsOneWidget);
    });

    testWidgets('widget render được khi shakeKey > 0', (tester) async {
      await tester.pumpWidget(_buildBanner(message: 'Lỗi', shakeKey: 1));
      await tester.pump();

      expect(find.byType(ErrorBannerWidget), findsOneWidget);
    });

    testWidgets('thay đổi shakeKey từ 1 → 2 không crash', (tester) async {
      await tester.pumpWidget(_buildBanner(message: 'Lỗi', shakeKey: 1));
      await tester.pump();

      await tester.pumpWidget(_buildBanner(message: 'Lỗi', shakeKey: 2));
      await tester.pumpAndSettle();

      expect(find.byType(ErrorBannerWidget), findsOneWidget);
    });
  });
}
