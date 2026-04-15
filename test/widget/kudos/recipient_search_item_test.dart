import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/recipient_search_item.dart';

Widget _buildItem({
  required UserSummary user,
  VoidCallback? onTap,
}) =>
    MaterialApp(
      home: Scaffold(
        body: RecipientSearchItem(
          user: user,
          onTap: onTap ?? () {},
        ),
      ),
    );

void main() {
  group('RecipientSearchItem - avatar', () {
    testWidgets('hiển thị initials fallback khi avatar rỗng', (tester) async {
      const user = UserSummary(
        id: 'u1',
        name: 'Nguyễn Văn An',
        avatar: '',
        department: 'CECV1',
      );

      await tester.pumpWidget(_buildItem(user: user));
      await tester.pumpAndSettle();

      // Initials: N + A (first + last word)
      expect(find.text('NA'), findsOneWidget);
    });

    testWidgets('hiển thị initials "?" khi name rỗng', (tester) async {
      const user = UserSummary(id: 'u2', name: '', avatar: '', department: '');

      await tester.pumpWidget(_buildItem(user: user));
      await tester.pumpAndSettle();

      expect(find.text('?'), findsOneWidget);
    });

    testWidgets('CircleAvatar radius = 18 khi avatar rỗng', (tester) async {
      const user = UserSummary(
        id: 'u3',
        name: 'Test User',
        avatar: '',
        department: '',
      );

      await tester.pumpWidget(_buildItem(user: user));
      await tester.pumpAndSettle();

      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(avatar.radius, 18);
    });
  });

  group('RecipientSearchItem - text styles', () {
    testWidgets('name hiển thị đúng — 14px/w600/white', (tester) async {
      const user = UserSummary(
        id: 'u4',
        name: 'Trần Thị Bích',
        avatar: '',
        department: 'CECV2',
      );

      await tester.pumpWidget(_buildItem(user: user));
      await tester.pumpAndSettle();

      final nameText = tester.widget<Text>(
        find.text('Trần Thị Bích'),
      );
      expect(nameText.style?.fontSize, 14);
      expect(nameText.style?.fontWeight, FontWeight.w600);
      expect(nameText.style?.color, Colors.white);
    });

    testWidgets('department hiển thị đúng — 12px/w400/#999', (tester) async {
      const user = UserSummary(
        id: 'u5',
        name: 'Lê Văn C',
        avatar: '',
        department: 'CECV3',
      );

      await tester.pumpWidget(_buildItem(user: user));
      await tester.pumpAndSettle();

      final deptText = tester.widget<Text>(find.text('CECV3'));
      expect(deptText.style?.fontSize, 12);
      expect(deptText.style?.fontWeight, FontWeight.w400);
      expect(deptText.style?.color, const Color(0xFF999999));
    });

    testWidgets('department ẩn khi rỗng', (tester) async {
      const user = UserSummary(
        id: 'u6',
        name: 'Only Name',
        avatar: '',
        department: '',
      );

      await tester.pumpWidget(_buildItem(user: user));
      await tester.pumpAndSettle();

      expect(find.text(''), findsNothing);
    });
  });

  group('RecipientSearchItem - layout', () {
    testWidgets('item height = 56px', (tester) async {
      const user = UserSummary(
        id: 'u7',
        name: 'Test',
        avatar: '',
        department: 'CECV1',
      );

      await tester.pumpWidget(_buildItem(user: user));
      await tester.pumpAndSettle();

      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(Row),
          matching: find.byType(SizedBox),
        ).first,
      );
      expect(sizedBox.height, 56);
    });

    testWidgets('tap gọi onTap callback', (tester) async {
      var tapped = false;
      const user = UserSummary(
        id: 'u8',
        name: 'Tap Test',
        avatar: '',
        department: '',
      );

      await tester.pumpWidget(_buildItem(user: user, onTap: () => tapped = true));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(InkWell));
      expect(tapped, true);
    });
  });

  group('RecipientSearchItem - avatar với network URL', () {
    testWidgets('CircleAvatar dùng NetworkImage khi avatar không rỗng',
        (tester) async {
      const user = UserSummary(
        id: 'u9',
        name: 'Avatar User',
        avatar: 'https://example.com/avatar.png',
        department: 'CECV1',
      );

      await tester.pumpWidget(_buildItem(user: user));
      await tester.pump();

      // CircleAvatar có backgroundImage (NetworkImage)
      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(avatar.backgroundImage, isA<NetworkImage>());
    });
  });
}
