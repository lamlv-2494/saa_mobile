import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/widgets/personal_stats_card.dart';

Widget _buildWidget({
  PersonalStats? stats,
  VoidCallback? onOpenSecretBox,
}) {
  return TranslationProvider(
    child: MaterialApp(
      home: Scaffold(
        body: PersonalStatsCard(
          stats: stats ??
              const PersonalStats(
                kudosReceived: 5,
                kudosSent: 25,
                heartsReceived: 10,
                secretBoxesOpened: 3,
                secretBoxesUnopened: 2,
              ),
          onOpenSecretBox: onOpenSecretBox,
        ),
      ),
    ),
  );
}

void main() {
  group('PersonalStatsCard - hiển thị stat rows', () {
    testWidgets('hiển thị giá trị kudosReceived', (tester) async {
      await tester.pumpWidget(_buildWidget());
      await tester.pumpAndSettle();

      expect(find.text('5'), findsAtLeastNWidgets(1));
    });

    testWidgets('hiển thị giá trị kudosSent', (tester) async {
      await tester.pumpWidget(_buildWidget());
      await tester.pumpAndSettle();

      expect(find.text('25'), findsAtLeastNWidgets(1));
    });

    testWidgets('hiển thị nút "Open secret box"', (tester) async {
      await tester.pumpWidget(_buildWidget());
      await tester.pumpAndSettle();

      expect(find.text(t.kudos.openSecretBox), findsOneWidget);
    });

    testWidgets('hiển thị divider', (tester) async {
      await tester.pumpWidget(_buildWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Divider), findsOneWidget);
    });
  });

  group('PersonalStatsCard - button state', () {
    testWidgets('button bình thường khi unopened > 0', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _buildWidget(
          stats: const PersonalStats(secretBoxesUnopened: 2),
          onOpenSecretBox: () => tapped = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(t.kudos.openSecretBox));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('button disabled khi unopened = 0', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _buildWidget(
          stats: const PersonalStats(secretBoxesUnopened: 0),
          onOpenSecretBox: () => tapped = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(t.kudos.openSecretBox));
      await tester.pumpAndSettle();

      expect(tapped, isFalse);
    });
  });
}
