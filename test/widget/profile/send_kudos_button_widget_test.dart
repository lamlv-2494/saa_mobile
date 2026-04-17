import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/profile/presentation/widgets/send_kudos_button_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

Widget _buildWidget({VoidCallback? onTap}) {
  return TranslationProvider(
    child: MaterialApp(
      home: Scaffold(
        body: SendKudosButtonWidget(
          userId: 'user-1',
          userName: 'Nguyễn Văn A',
          onTap: onTap ?? () {},
        ),
      ),
    ),
  );
}

void main() {
  group('SendKudosButtonWidget', () {
    testWidgets('hiển thị text "Send thanks"', (tester) async {
      await tester.pumpWidget(_buildWidget());
      await tester.pumpAndSettle();

      expect(find.text(t.profile.sendThanks), findsOneWidget);
    });

    testWidgets('hiển thị GestureDetector', (tester) async {
      await tester.pumpWidget(_buildWidget());
      await tester.pumpAndSettle();

      expect(find.byType(GestureDetector), findsAtLeastNWidgets(1));
    });

    testWidgets('gọi onTap khi tap button', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_buildWidget(onTap: () => tapped = true));
      await tester.pumpAndSettle();

      await tester.tap(find.text(t.profile.sendThanks));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });
  });
}
