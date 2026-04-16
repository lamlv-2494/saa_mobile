import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/data/models/send_kudos_state.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/image_attachment_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

// ─── Fake ViewModel với danh sách ảnh tùy chỉnh ───

class _FakeVMEmpty extends SendKudosViewModel {
  @override
  FutureOr<SendKudosState> build() => const SendKudosState();
}

class _FakeVMWithImages extends SendKudosViewModel {
  final List<String> urls;
  _FakeVMWithImages(this.urls);

  @override
  FutureOr<SendKudosState> build() =>
      SendKudosState(imagePreviews: urls);
}

class _FakeVMFull extends SendKudosViewModel {
  @override
  FutureOr<SendKudosState> build() =>
      const SendKudosState(
        imagePreviews: ['url1', 'url2', 'url3', 'url4'],
      );
}

Widget _buildWith(SendKudosViewModel vm) {
  return ProviderScope(
    overrides: [
      sendKudosViewModelProvider.overrideWith(() => vm),
    ],
    child: TranslationProvider(
      child: const MaterialApp(
        home: Scaffold(body: ImageAttachmentWidget()),
      ),
    ),
  );
}

void main() {
  group('ImageAttachmentWidget - trạng thái rỗng', () {
    testWidgets('hiển thị nút thêm ảnh (camera icon) khi chưa có ảnh',
        (tester) async {
      await tester.pumpWidget(_buildWith(_FakeVMEmpty()));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);
    });

    testWidgets('không hiển thị thumbnail khi không có ảnh', (tester) async {
      await tester.pumpWidget(_buildWith(_FakeVMEmpty()));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsNothing);
    });
  });

  group('ImageAttachmentWidget - có ảnh đã thêm', () {
    testWidgets('hiển thị nút xóa (close icon) cho mỗi ảnh', (tester) async {
      await tester.pumpWidget(
        _buildWith(_FakeVMWithImages(['url1', 'url2'])),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsNWidgets(2));
    });

    testWidgets('vẫn hiển thị nút thêm ảnh khi chưa đủ tối đa', (tester) async {
      await tester.pumpWidget(
        _buildWith(_FakeVMWithImages(['url1', 'url2'])),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);
    });
  });

  group('ImageAttachmentWidget - đủ 4 ảnh (tối đa)', () {
    testWidgets('ẩn nút thêm ảnh khi đã có đủ 4 ảnh', (tester) async {
      await tester.pumpWidget(_buildWith(_FakeVMFull()));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.camera_alt_outlined), findsNothing);
    });

    testWidgets('hiển thị 4 nút xóa cho 4 ảnh', (tester) async {
      await tester.pumpWidget(_buildWith(_FakeVMFull()));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsNWidgets(4));
    });
  });
}
