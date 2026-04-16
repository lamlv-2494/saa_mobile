import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos_state.dart';
import 'package:saa_mobile/features/kudos/presentation/screens/kudos_screen.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/kudos_viewmodel.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';

import '../../helpers/kudos_test_helpers.dart';

// ─── Fake ViewModel với sender/receiver IDs đã biết ───

final _testKudos = createKudos(
  id: 'k-nav-1',
  sender: createUserSummary(
    id: 'sender-nav-aaa',
    name: 'Sender Nav',
    avatar: '',
  ),
  receiver: createUserSummary(
    id: 'receiver-nav-bbb',
    name: 'Receiver Nav',
    avatar: '',
  ),
  imageUrls: [],
);

class _FakeKudosVMWithAvatars extends KudosViewModel {
  @override
  FutureOr<KudosState> build() async => KudosState(
        allKudos: [_testKudos],
        highlightKudos: const [],
        allKudosPageList: [_testKudos],
        hasMoreAllKudosPage: false,
      );

  @override
  Future<void> loadAllKudosPage() async {}
}

Widget _buildWithRouter({
  required SharedPreferences prefs,
  required List<String> navigatedRoutes,
}) {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/home', builder: (_, _) => const KudosScreen()),
      GoRoute(
        path: '/profile/:userId',
        builder: (_, state) {
          navigatedRoutes.add(state.pathParameters['userId']!);
          return const Scaffold(body: Text('OtherProfile'));
        },
      ),
      GoRoute(path: '/kudos/:kudosId', builder: (_, _) => const SizedBox()),
      GoRoute(path: '/send-kudos', builder: (_, _) => const SizedBox()),
    ],
  );

  return ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      kudosViewModelProvider.overrideWith(() => _FakeKudosVMWithAvatars()),
    ],
    child: TranslationProvider(
      child: MaterialApp.router(routerConfig: router),
    ),
  );
}

void main() {
  late SharedPreferences prefs;
  late List<String> navigatedRoutes;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    navigatedRoutes = [];
  });

  group('KudosScreen - tap avatar pushes tới OtherProfile', () {
    testWidgets('tap sender avatar trong feed navigates to /profile/sender-nav-aaa',
        (tester) async {
      await tester.pumpWidget(
        _buildWithRouter(prefs: prefs, navigatedRoutes: navigatedRoutes),
      );
      await tester.pumpAndSettle();

      // Scroll đến feed card nếu chưa thấy
      final verticalScrollable = find.byWidgetPredicate(
        (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
      );
      await tester.scrollUntilVisible(
        find.text('Sender Nav'),
        300.0,
        scrollable: verticalScrollable.first,
      );

      // Sender avatar là CircleAvatar đầu tiên trong card
      final senderAvatar = find
          .ancestor(
            of: find.text('Sender Nav'),
            matching: find.byType(Column),
          )
          .first;
      final circleAvatarInSender = find.descendant(
        of: senderAvatar,
        matching: find.byType(CircleAvatar),
      );

      await tester.tap(circleAvatarInSender.first);
      await tester.pumpAndSettle();

      expect(navigatedRoutes, contains('sender-nav-aaa'));
    });

    testWidgets('tap receiver avatar trong feed navigates to /profile/receiver-nav-bbb',
        (tester) async {
      await tester.pumpWidget(
        _buildWithRouter(prefs: prefs, navigatedRoutes: navigatedRoutes),
      );
      await tester.pumpAndSettle();

      final verticalScrollable = find.byWidgetPredicate(
        (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
      );
      await tester.scrollUntilVisible(
        find.text('Receiver Nav'),
        300.0,
        scrollable: verticalScrollable.first,
      );

      final receiverAvatar = find
          .ancestor(
            of: find.text('Receiver Nav'),
            matching: find.byType(Column),
          )
          .first;
      final circleAvatarInReceiver = find.descendant(
        of: receiverAvatar,
        matching: find.byType(CircleAvatar),
      );

      await tester.tap(circleAvatarInReceiver.first);
      await tester.pumpAndSettle();

      expect(navigatedRoutes, contains('receiver-nav-bbb'));
    });
  });

  group('AllKudosPageView - tap avatar pushes tới OtherProfile', () {
    testWidgets('tap sender avatar trong AllKudos navigates to /profile/sender-nav-aaa',
        (tester) async {
      await tester.pumpWidget(
        _buildWithRouter(prefs: prefs, navigatedRoutes: navigatedRoutes),
      );
      await tester.pumpAndSettle();

      // Navigate to AllKudos page
      final verticalScrollable = find.byWidgetPredicate(
        (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
      );
      await tester.scrollUntilVisible(
        find.text('View all Kudos'),
        300.0,
        scrollable: verticalScrollable.first,
      );
      await tester.tap(find.text('View all Kudos'));
      await tester.pumpAndSettle();

      // Now on AllKudosPageView — tap sender avatar
      final senderAvatar = find
          .ancestor(
            of: find.text('Sender Nav'),
            matching: find.byType(Column),
          )
          .first;
      final circleAvatarInSender = find.descendant(
        of: senderAvatar,
        matching: find.byType(CircleAvatar),
      );

      await tester.tap(circleAvatarInSender.first);
      await tester.pumpAndSettle();

      expect(navigatedRoutes, contains('sender-nav-aaa'));
    });
  });
}
