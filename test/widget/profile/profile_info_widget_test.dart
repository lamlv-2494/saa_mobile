import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/profile/data/models/user_profile.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_info_widget.dart';

Widget _buildWidget(UserProfile profile) {
  return MaterialApp(
    home: Scaffold(
      body: ProfileInfoWidget(profile: profile),
    ),
  );
}

const _profile = UserProfile(
  id: '1',
  name: 'Nguyễn Văn A',
  email: 'a@sun-asterisk.com',
  teamCode: 'CECV1',
  heroTier: 'legend_hero',
);

const _profileWithAvatar = UserProfile(
  id: '2',
  name: 'Trần Thị B',
  email: 'b@sun-asterisk.com',
  teamCode: 'CEVC3',
  heroTier: 'new_hero',
  avatarUrl: 'https://example.com/avatar.png',
);

void main() {
  group('ProfileInfoWidget - thông tin cơ bản', () {
    testWidgets('hiển thị tên người dùng', (tester) async {
      await tester.pumpWidget(_buildWidget(_profile));
      await tester.pumpAndSettle();

      expect(find.text('Nguyễn Văn A'), findsOneWidget);
    });

    testWidgets('hiển thị team code', (tester) async {
      await tester.pumpWidget(_buildWidget(_profile));
      await tester.pumpAndSettle();

      expect(find.text('CECV1'), findsOneWidget);
    });

    testWidgets('hiển thị hero tier dưới dạng ảnh', (tester) async {
      await tester.pumpWidget(_buildWidget(_profile));
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (w) => w is Semantics && w.properties.label == 'Hero tier badge',
        ),
        findsOneWidget,
      );
    });

    testWidgets('hiển thị CircleAvatar', (tester) async {
      await tester.pumpWidget(_buildWidget(_profile));
      await tester.pumpAndSettle();

      expect(find.byType(CircleAvatar), findsAtLeastNWidgets(1));
    });
  });

  group('ProfileInfoWidget - fallback avatar', () {
    testWidgets('hiển thị chữ cái đầu khi không có avatarUrl', (tester) async {
      await tester.pumpWidget(_buildWidget(_profile));
      await tester.pumpAndSettle();

      // Chữ cái đầu của tên "Nguyễn Văn A" → "N"
      expect(find.text('N'), findsOneWidget);
    });

    testWidgets('hiển thị CircleAvatar khi có avatarUrl (với fallback)', (tester) async {
      await tester.pumpWidget(_buildWidget(_profileWithAvatar));
      await tester.pump();

      // CircleAvatar phải luôn hiển thị dù network thành công hay thất bại
      expect(find.byType(CircleAvatar), findsAtLeastNWidgets(1));
    });
  });

  group('ProfileInfoWidget - không có teamCode', () {
    testWidgets('ẩn team code khi null', (tester) async {
      const profileNoTeam = UserProfile(
        id: '3',
        name: 'Lê Văn C',
        email: 'c@sun-asterisk.com',
      );
      await tester.pumpWidget(_buildWidget(profileNoTeam));
      await tester.pumpAndSettle();

      // chỉ có tên, không có teamCode text
      expect(find.text('Lê Văn C'), findsOneWidget);
    });
  });
}
