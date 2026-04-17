import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_card.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_kudos_list_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

import '../../helpers/kudos_test_helpers.dart';

Widget _buildWidget({
  int kudosCount = 0,
  bool isLoadingMore = false,
}) {
  final kudosList = List.generate(
    kudosCount,
    (i) => createKudos(
      id: 'k-$i',
      sender: createUserSummary(id: 'sender-$i', avatar: ''),
      receiver: createUserSummary(id: 'receiver-$i', avatar: ''),
    ),
  );

  return ProviderScope(
    child: TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ProfileKudosListWidget(
              kudosList: kudosList,
              isLoadingMore: isLoadingMore,
            ),
          ),
        ),
      ),
    ),
  );
}


void main() {
  group('ProfileKudosListWidget - danh sách rỗng', () {
    testWidgets('hiển thị empty text khi không có kudos', (tester) async {
      await tester.pumpWidget(_buildWidget());
      await tester.pumpAndSettle();

      expect(find.text(t.profile.noKudosHistory), findsOneWidget);
    });

    testWidgets('không hiển thị KudosCard khi rỗng', (tester) async {
      await tester.pumpWidget(_buildWidget());
      await tester.pumpAndSettle();

      expect(find.byType(KudosCard), findsNothing);
    });
  });

  group('ProfileKudosListWidget - có kudos', () {
    testWidgets('hiển thị KudosCard cho mỗi kudos', (tester) async {
      await tester.pumpWidget(_buildWidget(kudosCount: 3));
      await tester.pumpAndSettle();

      expect(find.byType(KudosCard), findsNWidgets(3));
    });

    testWidgets('không hiển thị empty text khi có kudos', (tester) async {
      await tester.pumpWidget(_buildWidget(kudosCount: 2));
      await tester.pumpAndSettle();

      expect(find.text(t.profile.noKudosHistory), findsNothing);
    });
  });

  group('ProfileKudosListWidget - loading', () {
    testWidgets('hiển thị loading indicator khi isLoadingMore = true',
        (tester) async {
      await tester.pumpWidget(
        _buildWidget(kudosCount: 1, isLoadingMore: true),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('ẩn loading indicator khi isLoadingMore = false',
        (tester) async {
      await tester.pumpWidget(_buildWidget(kudosCount: 1));
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  group('ProfileKudosListWidget - spam label', () {
    testWidgets('hiển thị tag Spam khi kudos.isSpam = true', (tester) async {
      final spamKudos = createKudos(
        id: 'k-spam',
        isSpam: true,
        sender: createUserSummary(id: 's1', avatar: ''),
        receiver: createUserSummary(id: 'r1', avatar: ''),
      );
      await tester.pumpWidget(
        ProviderScope(
          child: TranslationProvider(
            child: MaterialApp(
              home: Scaffold(
                body: SingleChildScrollView(
                  child: ProfileKudosListWidget(
                    kudosList: [spamKudos],
                    isLoadingMore: false,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Spam'), findsOneWidget);
    });

    testWidgets('không hiển thị tag Spam khi kudos.isSpam = false',
        (tester) async {
      final normalKudos = createKudos(
        id: 'k-normal',
        sender: createUserSummary(id: 's1', avatar: ''),
        receiver: createUserSummary(id: 'r1', avatar: ''),
      );
      await tester.pumpWidget(
        ProviderScope(
          child: TranslationProvider(
            child: MaterialApp(
              home: Scaffold(
                body: SingleChildScrollView(
                  child: ProfileKudosListWidget(
                    kudosList: [normalKudos],
                    isLoadingMore: false,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Spam'), findsNothing);
    });
  });
}
