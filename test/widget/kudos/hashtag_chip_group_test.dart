import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/presentation/widgets/hashtag_chip_group_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

import '../../helpers/kudos_test_helpers.dart';

Widget _buildWidget({
  List<String> hashtags = const [],
  void Function(dynamic)? onRemove,
  VoidCallback? onAddTap,
  bool hasError = false,
  int maxHashtags = 5,
}) {
  return TranslationProvider(
    child: MaterialApp(
      home: Scaffold(
        body: HashtagChipGroupWidget(
          selectedHashtags:
              hashtags.map((name) => createHashtag(name: name)).toList(),
          onRemove: onRemove ?? (_) {},
          onAddTap: onAddTap ?? () {},
          hasError: hasError,
          maxHashtags: maxHashtags,
        ),
      ),
    ),
  );
}

void main() {
  group('HashtagChipGroupWidget - trạng thái rỗng', () {
    testWidgets('hiển thị nút "+" khi chưa có hashtag', (tester) async {
      await tester.pumpWidget(_buildWidget(hashtags: []));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('không hiển thị chip khi danh sách rỗng', (tester) async {
      await tester.pumpWidget(_buildWidget(hashtags: []));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsNothing);
    });
  });

  group('HashtagChipGroupWidget - có hashtag đã chọn', () {
    testWidgets('hiển thị chip cho mỗi hashtag đã chọn', (tester) async {
      await tester.pumpWidget(
        _buildWidget(hashtags: ['#teamwork', '#dedicated']),
      );
      await tester.pumpAndSettle();

      expect(find.text('#teamwork'), findsOneWidget);
      expect(find.text('#dedicated'), findsOneWidget);
    });

    testWidgets('mỗi chip có nút xóa (Icons.close)', (tester) async {
      await tester.pumpWidget(
        _buildWidget(hashtags: ['#teamwork', '#dedicated']),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsNWidgets(2));
    });

    testWidgets('gọi onRemove khi tap nút xóa', (tester) async {
      dynamic removed;
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            home: Scaffold(
              body: HashtagChipGroupWidget(
                selectedHashtags: [
                  createHashtag(id: 1, name: '#teamwork'),
                ],
                onRemove: (tag) => removed = tag,
                onAddTap: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(removed, isNotNull);
    });
  });

  group('HashtagChipGroupWidget - giới hạn tối đa', () {
    testWidgets('ẩn nút "+" khi đạt maxHashtags', (tester) async {
      await tester.pumpWidget(
        _buildWidget(
          hashtags: ['#1', '#2', '#3', '#4', '#5'],
          maxHashtags: 5,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.add), findsNothing);
    });

    testWidgets('hiển thị nút "+" khi chưa đạt tối đa', (tester) async {
      await tester.pumpWidget(
        _buildWidget(
          hashtags: ['#1', '#2'],
          maxHashtags: 5,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });

  group('HashtagChipGroupWidget - trạng thái lỗi', () {
    testWidgets('gọi onAddTap khi tap nút "+"', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _buildWidget(
          hashtags: [],
          onAddTap: () => tapped = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });
  });
}
