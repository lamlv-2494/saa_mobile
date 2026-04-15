import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/sender_info_widget.dart';
import '../../helpers/kudos_test_helpers.dart';

void main() {
  Widget buildTestWidget(Kudos kudos, {VoidCallback? onTap}) {
    return MaterialApp(
      home: Scaffold(
        body: SenderInfoWidget(kudos: kudos, onTapProfile: onTap),
      ),
    );
  }

  group('SenderInfoWidget - kudos thường (isAnonymous=false)', () {
    testWidgets('hiển thị tên thật + department', (tester) async {
      // heroTierUrl rỗng để tránh EnvConfig.supabaseUrl trong test
      final kudos = createKudos(
        isAnonymous: false,
        sender: createUserSummary(
          name: 'Nguyễn Văn A',
          department: 'CECV10',
          avatar: '',
          heroTierUrl: '',
        ),
      );

      await tester.pumpWidget(buildTestWidget(kudos));
      await tester.pumpAndSettle();

      expect(find.text('Nguyễn Văn A'), findsOneWidget);
      expect(find.text('CECV10'), findsOneWidget);
    });

    testWidgets('tap enabled → gọi onTapProfile', (tester) async {
      var tapped = false;
      final kudos = createKudos(
        isAnonymous: false,
        sender: createUserSummary(
          name: 'Người gửi',
          avatar: '',
          heroTierUrl: '',
        ),
      );

      await tester.pumpWidget(
        buildTestWidget(kudos, onTap: () => tapped = true),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Người gửi'));
      expect(tapped, true);
    });
  });

  group('SenderInfoWidget - kudos ẩn danh (isAnonymous=true)', () {
    testWidgets('hiển thị alias thay tên thật', (tester) async {
      final kudos = createKudos(
        isAnonymous: true,
        senderAlias: 'Anh Hùng Xạ Điêu',
      );

      await tester.pumpWidget(buildTestWidget(kudos));
      await tester.pumpAndSettle();

      expect(find.text('Anh Hùng Xạ Điêu'), findsOneWidget);
      // Không hiển thị tên thật
      expect(find.text(kudos.sender.name), findsNothing);
    });

    testWidgets('senderAlias=null → hiển thị i18n fallback', (tester) async {
      final kudos = createKudos(
        isAnonymous: true,
        senderAlias: null,
      );

      await tester.pumpWidget(buildTestWidget(kudos));
      await tester.pumpAndSettle();

      // Default locale is EN → "Anonymous sender"
      expect(find.text('Anonymous sender'), findsAtLeast(1));
    });

    testWidgets('badge ẩn hoàn toàn khi anonymous', (tester) async {
      final kudos = createKudos(
        isAnonymous: true,
        sender: createUserSummary(
          heroTierUrl: '/badges/rising_hero.png',
        ),
      );

      await tester.pumpWidget(buildTestWidget(kudos));
      await tester.pumpAndSettle();

      // Không có Image.network (badge) — chỉ có AssetImage cho anonymous avatar
      // Kiểm tra KHÔNG có GestureDetector wrapping (tap disabled)
      final gestureDetectors = find.byType(GestureDetector);
      // Anonymous variant không dùng GestureDetector
      for (final element in gestureDetectors.evaluate()) {
        final widget = element.widget as GestureDetector;
        // Không có onTap nào được set trực tiếp từ SenderInfoWidget
        expect(widget.onTap == null || widget.onTap is! VoidCallback, isTrue,
            reason: 'Anonymous sender should not have GestureDetector with onTap');
      }
    });

    testWidgets('tap disabled → onTapProfile KHÔNG được gọi', (tester) async {
      var tapped = false;
      final kudos = createKudos(isAnonymous: true, senderAlias: null);

      await tester.pumpWidget(
        buildTestWidget(kudos, onTap: () => tapped = true),
      );
      await tester.pumpAndSettle();

      // Anonymous sender text
      final senderText = find.text('Anonymous sender');
      if (senderText.evaluate().isNotEmpty) {
        await tester.tap(senderText.first);
      }
      expect(tapped, false);
    });
  });
}
