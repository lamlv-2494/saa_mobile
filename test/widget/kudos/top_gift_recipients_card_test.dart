import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/data/models/gift_recipient_ranking.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/top_gift_recipients_card.dart';
import '../../helpers/kudos_test_helpers.dart';

void main() {
  Widget buildTestWidget({
    required List<GiftRecipientRanking> recipients,
    void Function(String userId)? onUserTap,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: TopGiftRecipientsCard(
            recipients: recipients,
            onUserTap: onUserTap,
          ),
        ),
      ),
    );
  }

  group('TopGiftRecipientsCard - rewardName', () {
    testWidgets('hiển thị rewardName cho mỗi recipient', (tester) async {
      final user = createUserSummary(
        id: 'top-1',
        name: 'Top 1',
        avatar: '', // tránh NetworkImage trong test
      );
      final recipient = createGiftRecipientRanking(rank: 1, user: user)
          .copyWith(rewardName: 'Nhận được 1 áo phông SAA');

      await tester.pumpWidget(
        buildTestWidget(recipients: [recipient]),
      );
      await tester.pump();

      expect(find.text('Nhận được 1 áo phông SAA'), findsOneWidget);
    });

    testWidgets('không hiển thị rewardName khi rỗng', (tester) async {
      final user = createUserSummary(
        id: 'top-1',
        name: 'Top 1',
        avatar: '', // tránh NetworkImage trong test
      );
      final recipient =
          createGiftRecipientRanking(rank: 1, user: user).copyWith(rewardName: '');

      await tester.pumpWidget(buildTestWidget(recipients: [recipient]));
      await tester.pump();

      // Chỉ có tên user, không có rewardName text nào khác
      expect(find.text('Top 1'), findsOneWidget);
    });
  });

  group('TopGiftRecipientsCard - tap navigation', () {
    testWidgets('tap row gọi onUserTap callback với đúng userId', (tester) async {
      final tappedIds = <String>[];
      final user = createUserSummary(
        id: 'user-tap-123',
        name: 'Người dùng test',
        avatar: '', // tránh NetworkImage trong test
      );
      final recipient =
          createGiftRecipientRanking(rank: 1, user: user).copyWith(rewardName: 'Nhận quà');

      await tester.pumpWidget(
        buildTestWidget(
          recipients: [recipient],
          onUserTap: tappedIds.add,
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Người dùng test'));
      await tester.pump();

      expect(tappedIds, ['user-tap-123']);
    });

    testWidgets('tap không crash khi onUserTap null', (tester) async {
      final user = createUserSummary(
        id: 'top-1',
        name: 'Top 1',
        avatar: '', // tránh NetworkImage trong test
      );
      final recipient = createGiftRecipientRanking(rank: 1, user: user);
      await tester.pumpWidget(
        buildTestWidget(recipients: [recipient], onUserTap: null),
      );
      await tester.pump();

      // Should not throw
      await tester.tap(find.text('Top 1'));
      await tester.pump();
    });
  });
}
