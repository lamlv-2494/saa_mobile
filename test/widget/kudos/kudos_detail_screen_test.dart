import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saa_mobile/features/kudos/data/repositories/kudos_repository.dart';
import 'package:saa_mobile/features/kudos/presentation/screens/kudos_detail_screen.dart';
import '../../helpers/kudos_test_helpers.dart';

class MockKudosRepository extends Mock implements KudosRepository {}

Widget _buildScreen(String kudosId, MockKudosRepository repo) {
  return ProviderScope(
    overrides: [
      kudosRepositoryProvider.overrideWithValue(repo),
    ],
    child: MaterialApp(
      home: KudosDetailScreen(kudosId: kudosId),
    ),
  );
}

void main() {
  late MockKudosRepository mockRepo;

  setUp(() {
    mockRepo = MockKudosRepository();
    registerFallbackValue(createKudos());
  });

  group('KudosDetailScreen - kudos thường (isAnonymous=false)', () {
    testWidgets('hiển thị tên sender và receiver', (tester) async {
      final kudos = createKudos(
        id: 'k1',
        sender: createUserSummary(name: 'Nguyễn Văn A', avatar: ''),
        receiver: createUserSummary(name: 'Trần Thị B', avatar: ''),
        isAnonymous: false,
      );
      when(() => mockRepo.getKudosDetail('k1')).thenAnswer((_) async => kudos);

      await tester.pumpWidget(_buildScreen('k1', mockRepo));
      await tester.pumpAndSettle();

      expect(find.text('Nguyễn Văn A'), findsOneWidget);
      expect(find.text('Trần Thị B'), findsOneWidget);
    });

    testWidgets('hiển thị nội dung kudos', (tester) async {
      final kudos = createKudos(
        id: 'k2',
        content: 'Cảm ơn bạn đã hỗ trợ tận tình!',
        sender: createUserSummary(avatar: ''),
        receiver: createUserSummary(avatar: ''),
        isAnonymous: false,
      );
      when(() => mockRepo.getKudosDetail('k2')).thenAnswer((_) async => kudos);

      await tester.pumpWidget(_buildScreen('k2', mockRepo));
      await tester.pumpAndSettle();

      expect(find.text('Cảm ơn bạn đã hỗ trợ tận tình!'), findsOneWidget);
    });

    testWidgets('hiển thị hashtags', (tester) async {
      final kudos = createKudos(
        id: 'k3',
        hashtags: [
          createHashtag(id: 1, name: '#teamwork'),
          createHashtag(id: 2, name: '#dedicated'),
        ],
        sender: createUserSummary(avatar: ''),
        receiver: createUserSummary(avatar: ''),
        isAnonymous: false,
      );
      when(() => mockRepo.getKudosDetail('k3')).thenAnswer((_) async => kudos);

      await tester.pumpWidget(_buildScreen('k3', mockRepo));
      await tester.pumpAndSettle();

      expect(find.text('#teamwork'), findsOneWidget);
      expect(find.text('#dedicated'), findsOneWidget);
    });

    testWidgets('hiển thị heart count', (tester) async {
      final kudos = createKudos(
        id: 'k4',
        heartCount: 42,
        sender: createUserSummary(avatar: ''),
        receiver: createUserSummary(avatar: ''),
        isAnonymous: false,
      );
      when(() => mockRepo.getKudosDetail('k4')).thenAnswer((_) async => kudos);

      await tester.pumpWidget(_buildScreen('k4', mockRepo));
      await tester.pumpAndSettle();

      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('hiển thị award title khi có', (tester) async {
      final kudos = createKudos(
        id: 'k5',
        awardTitle: 'Legend Hero Award',
        sender: createUserSummary(avatar: ''),
        receiver: createUserSummary(avatar: ''),
        isAnonymous: false,
      );
      when(() => mockRepo.getKudosDetail('k5')).thenAnswer((_) async => kudos);

      await tester.pumpWidget(_buildScreen('k5', mockRepo));
      await tester.pumpAndSettle();

      expect(find.text('Legend Hero Award'), findsOneWidget);
    });
  });

  group('KudosDetailScreen - kudos ẩn danh (isAnonymous=true)', () {
    testWidgets('hiển thị alias thay tên thật sender', (tester) async {
      final kudos = createKudos(
        id: 'k6',
        isAnonymous: true,
        senderAlias: 'Anh Hùng Bí Ẩn',
        sender: createUserSummary(name: 'Tên Thật', avatar: ''),
        receiver: createUserSummary(name: 'Người nhận', avatar: ''),
      );
      when(() => mockRepo.getKudosDetail('k6')).thenAnswer((_) async => kudos);

      await tester.pumpWidget(_buildScreen('k6', mockRepo));
      await tester.pumpAndSettle();

      expect(find.text('Anh Hùng Bí Ẩn'), findsOneWidget);
      expect(find.text('Tên Thật'), findsNothing);
    });

    testWidgets('receiver vẫn hiển thị đầy đủ khi sender ẩn danh', (tester) async {
      final kudos = createKudos(
        id: 'k7',
        isAnonymous: true,
        senderAlias: 'Người ẩn',
        sender: createUserSummary(name: 'Ẩn Danh', avatar: ''),
        receiver: createUserSummary(name: 'Trần Thị B', avatar: ''),
      );
      when(() => mockRepo.getKudosDetail('k7')).thenAnswer((_) async => kudos);

      await tester.pumpWidget(_buildScreen('k7', mockRepo));
      await tester.pumpAndSettle();

      expect(find.text('Trần Thị B'), findsOneWidget);
    });
  });

  group('KudosDetailScreen - error state', () {
    testWidgets('hiển thị nút retry khi exception', (tester) async {
      when(() => mockRepo.getKudosDetail('k9'))
          .thenThrow(Exception('Network error'));

      await tester.pumpWidget(_buildScreen('k9', mockRepo));
      await tester.pumpAndSettle();

      expect(find.text('Retry'), findsOneWidget);
    });
  });
}
