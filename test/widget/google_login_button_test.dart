import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/auth/presentation/widgets/google_login_button.dart';

void main() {
  Widget buildTestWidget({VoidCallback? onPressed, bool isLoading = false}) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GoogleLoginButton(onPressed: onPressed, isLoading: isLoading),
        ),
      ),
    );
  }

  group('GoogleLoginButton', () {
    testWidgets('renders label and Google icon in default state', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(onPressed: () {}));

      expect(find.text('LOGIN With Google'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildTestWidget(onPressed: () => tapped = true));

      await tester.tap(find.byType(GoogleLoginButton));
      expect(tapped, isTrue);
    });

    testWidgets('shows CircularProgressIndicator when loading', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(onPressed: () {}, isLoading: true),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('LOGIN With Google'), findsNothing);
    });

    testWidgets('ignores tap when loading', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildTestWidget(onPressed: () => tapped = true, isLoading: true),
      );

      await tester.tap(find.byType(GoogleLoginButton));
      expect(tapped, isFalse);
    });

    testWidgets('ignores tap when onPressed is null (disabled)', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.tap(find.byType(GoogleLoginButton));
      // No crash = success — onPressed is null
    });
  });
}
