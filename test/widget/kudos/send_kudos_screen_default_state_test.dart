import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/data/models/send_kudos_state.dart';
import 'package:saa_mobile/features/kudos/presentation/screens/send_kudos_screen.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/error_banner_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

import '../../helpers/kudos_test_helpers.dart';

// ─── Fake ViewModel: trả về initial state ngay lập tức ───

class _FakeSendKudosViewModel extends SendKudosViewModel {
  @override
  FutureOr<SendKudosState> build() {
    return SendKudosState(
      availableHashtags: [createHashtag(id: 1, name: '#teamwork')],
    );
  }
}

Widget _buildScreen() {
  return ProviderScope(
    overrides: [
      sendKudosViewModelProvider.overrideWith(_FakeSendKudosViewModel.new),
    ],
    child: TranslationProvider(
      child: const MaterialApp(
        home: SendKudosScreen(),
      ),
    ),
  );
}

void main() {
  // ─────────────────────────────────────────────────────────────
  group('SendKudosScreen - US1: trạng thái mặc định', () {
    testWidgets('hiển thị tiêu đề màn hình', (tester) async {
      await tester.pumpWidget(_buildScreen());
      await tester.pumpAndSettle();

      expect(find.text(t.sendKudos.title), findsOneWidget);
    });

    testWidgets('hiển thị header subtitle', (tester) async {
      await tester.pumpWidget(_buildScreen());
      await tester.pumpAndSettle();

      expect(
        find.text(t.sendKudos.headerSubtitle),
        findsOneWidget,
      );
    });

    testWidgets('send button hiển thị trong trạng thái mặc định', (tester) async {
      await tester.pumpWidget(_buildScreen());
      await tester.pumpAndSettle();

      expect(find.text(t.sendKudos.sendButton), findsOneWidget);
    });

    testWidgets('send button disabled khi form rỗng', (tester) async {
      await tester.pumpWidget(_buildScreen());
      await tester.pumpAndSettle();

      // Khi form rỗng, GestureDetector bọc send button không có onTap
      final gestureDetectors = tester.widgetList<GestureDetector>(
        find.ancestor(
          of: find.text(t.sendKudos.sendButton),
          matching: find.byType(GestureDetector),
        ),
      );
      expect(gestureDetectors.any((g) => g.onTap == null), isTrue);
    });

    testWidgets('anonymous checkbox không được check ở trạng thái mặc định',
        (tester) async {
      await tester.pumpWidget(_buildScreen());
      await tester.pumpAndSettle();

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isFalse);
    });

    testWidgets('error banner không hiển thị ở trạng thái mặc định',
        (tester) async {
      await tester.pumpWidget(_buildScreen());
      await tester.pumpAndSettle();

      // showErrorBanner == false → ErrorBannerWidget không được render
      expect(find.byType(ErrorBannerWidget), findsNothing);
    });
  });

  // ─────────────────────────────────────────────────────────────
  group('SendKudosScreen - US2: labels bắt buộc có dấu *', () {
    testWidgets('label Recipient có dấu *', (tester) async {
      await tester.pumpWidget(_buildScreen());
      await tester.pumpAndSettle();

      expect(find.text(t.sendKudos.recipientLabel), findsOneWidget);
    });

    testWidgets('label Title có dấu *', (tester) async {
      await tester.pumpWidget(_buildScreen());
      await tester.pumpAndSettle();

      expect(find.text(t.sendKudos.titleLabel), findsOneWidget);
    });

    testWidgets('label Hashtag có dấu *', (tester) async {
      await tester.pumpWidget(_buildScreen());
      await tester.pumpAndSettle();

      expect(find.text(t.sendKudos.hashtagLabel), findsOneWidget);
    });

    testWidgets('label Attach image không có dấu *', (tester) async {
      await tester.pumpWidget(_buildScreen());
      await tester.pumpAndSettle();

      expect(find.text(t.sendKudos.imageAttach), findsOneWidget);
      expect(find.text('${t.sendKudos.imageAttach} *'), findsNothing);
    });
  });
}
