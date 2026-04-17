import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:saa_mobile/shared/widgets/home_header_widget.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class MockSharedPrefs extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({'locale': 'vi'});
    prefs = await SharedPreferences.getInstance();
  });

  Widget buildTestWidget({
    double opacity = 0.9,
    bool hasUnread = false,
    String currentLocaleCode = 'vi',
    ValueChanged<String>? onLocaleChanged,
    VoidCallback? onSearchTap,
    VoidCallback? onNotificationTap,
  }) {
    return ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              HomeHeaderWidget(
                opacity: opacity,
                hasUnreadNotifications: hasUnread,
                currentLocaleCode: currentLocaleCode,
                onLocaleChanged: onLocaleChanged ?? (_) {},
                onSearchTap: onSearchTap,
                onNotificationTap: onNotificationTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  group('HomeHeaderWidget', () {
    testWidgets('shows notification badge when hasUnread is true',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(hasUnread: true));
      await tester.pumpAndSettle();

      final badgeFinder = find.byWidgetPredicate(
        (w) =>
            w is Container &&
            w.decoration is BoxDecoration &&
            (w.decoration as BoxDecoration).shape == BoxShape.circle &&
            (w.decoration as BoxDecoration).color?.toARGB32() ==
                const Color(0xFFD4271D).toARGB32(),
      );
      expect(badgeFinder, findsOneWidget);
    });

    testWidgets('hides notification badge when hasUnread is false',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(hasUnread: false));
      await tester.pumpAndSettle();

      final badgeFinder = find.byWidgetPredicate(
        (w) =>
            w is Container &&
            w.decoration is BoxDecoration &&
            (w.decoration as BoxDecoration).shape == BoxShape.circle &&
            (w.decoration as BoxDecoration).color?.toARGB32() ==
                const Color(0xFFD4271D).toARGB32(),
      );
      expect(badgeFinder, findsNothing);
    });

    testWidgets('calls onSearchTap when search area is tapped',
        (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        buildTestWidget(onSearchTap: () => tapped = true),
      );
      await tester.pumpAndSettle();

      final searchButton = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.label == t.accessibility.searchButton,
      );
      await tester.tap(searchButton);
      expect(tapped, true);
    });

    testWidgets('calls onNotificationTap when bell area is tapped',
        (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        buildTestWidget(onNotificationTap: () => tapped = true),
      );
      await tester.pumpAndSettle();

      final bellButton = find.byWidgetPredicate(
        (w) => w is Semantics && w.properties.label == t.accessibility.notificationButton,
      );
      await tester.tap(bellButton);
      expect(tapped, true);
    });
  });
}
