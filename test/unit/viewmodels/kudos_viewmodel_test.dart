import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos_state.dart';
import 'package:saa_mobile/features/kudos/data/models/secret_box.dart';
import 'package:saa_mobile/features/kudos/data/repositories/kudos_repository.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/kudos_viewmodel.dart';

import '../../helpers/kudos_test_helpers.dart';

class MockKudosRepository extends Mock implements KudosRepository {}

/// Container helper: tạo ProviderContainer với KudosViewModel đã có state sẵn
/// để test getKudosById mà không cần mock toàn bộ build() flow.
ProviderContainer createContainerWithState({
  required MockKudosRepository mockRepo,
  KudosState? initialState,
}) {
  final container = ProviderContainer(
    overrides: [
      kudosRepositoryProvider.overrideWithValue(mockRepo),
    ],
  );
  return container;
}

void main() {
  late MockKudosRepository mockRepo;

  setUp(() {
    mockRepo = MockKudosRepository();
  });

  group('KudosViewModel.getKudosById', () {
    test('trả về kudos từ allKudos khi cache hit', () async {
      // Arrange
      final targetKudos = createKudos(id: 'kudos-42', content: 'Cache hit all');
      final state = createKudosState(
        allKudos: [
          createKudos(id: 'kudos-1'),
          targetKudos,
          createKudos(id: 'kudos-3'),
        ],
        highlightKudos: [],
      );

      // Stub build() dependencies
      when(() => mockRepo.getHighlightKudos(
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          )).thenAnswer((_) async => []);
      when(() => mockRepo.getKudos(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          )).thenAnswer((_) async => state.allKudos);
      when(() => mockRepo.getPersonalStats())
          .thenAnswer((_) async => createPersonalStats());
      when(() => mockRepo.getTopRecipients())
          .thenAnswer((_) async => createTop10List());
      when(() => mockRepo.getSpotlight())
          .thenAnswer((_) async => createSpotlightData());
      when(() => mockRepo.getHashtags())
          .thenAnswer((_) async => []);
      when(() => mockRepo.getDepartments())
          .thenAnswer((_) async => []);

      final container = createContainerWithState(mockRepo: mockRepo);
      addTearDown(container.dispose);

      // Đợi build() hoàn thành
      final notifier = container.read(kudosViewModelProvider.notifier);
      await container.read(kudosViewModelProvider.future);

      // Act
      final result = await notifier.getKudosById('kudos-42');

      // Assert — tìm thấy trong allKudos, không gọi API
      expect(result, isNotNull);
      expect(result!.id, 'kudos-42');
      expect(result.content, 'Cache hit all');
      verifyNever(() => mockRepo.getKudosDetail(any()));
    });

    test('trả về kudos từ highlightKudos khi cache hit', () async {
      // Arrange
      final targetKudos = createKudos(
        id: 'highlight-7',
        content: 'Cache hit highlight',
        isHighlight: true,
      );

      when(() => mockRepo.getHighlightKudos(
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          )).thenAnswer((_) async => [targetKudos]);
      when(() => mockRepo.getKudos(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          )).thenAnswer((_) async => [createKudos(id: 'feed-1')]);
      when(() => mockRepo.getPersonalStats())
          .thenAnswer((_) async => createPersonalStats());
      when(() => mockRepo.getTopRecipients())
          .thenAnswer((_) async => createTop10List());
      when(() => mockRepo.getSpotlight())
          .thenAnswer((_) async => createSpotlightData());
      when(() => mockRepo.getHashtags())
          .thenAnswer((_) async => []);
      when(() => mockRepo.getDepartments())
          .thenAnswer((_) async => []);

      final container = createContainerWithState(mockRepo: mockRepo);
      addTearDown(container.dispose);

      final notifier = container.read(kudosViewModelProvider.notifier);
      await container.read(kudosViewModelProvider.future);

      // Act
      final result = await notifier.getKudosById('highlight-7');

      // Assert — tìm thấy trong highlightKudos, không gọi API
      expect(result, isNotNull);
      expect(result!.id, 'highlight-7');
      expect(result.content, 'Cache hit highlight');
      verifyNever(() => mockRepo.getKudosDetail(any()));
    });

    test('gọi API khi cache miss và trả về kết quả', () async {
      // Arrange
      final apiKudos = createKudos(id: 'deep-link-99', content: 'From API');

      when(() => mockRepo.getHighlightKudos(
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          )).thenAnswer((_) async => []);
      when(() => mockRepo.getKudos(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          )).thenAnswer((_) async => [createKudos(id: 'feed-1')]);
      when(() => mockRepo.getPersonalStats())
          .thenAnswer((_) async => createPersonalStats());
      when(() => mockRepo.getTopRecipients())
          .thenAnswer((_) async => createTop10List());
      when(() => mockRepo.getSpotlight())
          .thenAnswer((_) async => createSpotlightData());
      when(() => mockRepo.getHashtags())
          .thenAnswer((_) async => []);
      when(() => mockRepo.getDepartments())
          .thenAnswer((_) async => []);
      when(() => mockRepo.getKudosDetail('deep-link-99'))
          .thenAnswer((_) async => apiKudos);

      final container = createContainerWithState(mockRepo: mockRepo);
      addTearDown(container.dispose);

      final notifier = container.read(kudosViewModelProvider.notifier);
      await container.read(kudosViewModelProvider.future);

      // Act
      final result = await notifier.getKudosById('deep-link-99');

      // Assert — cache miss → gọi API
      expect(result, isNotNull);
      expect(result!.id, 'deep-link-99');
      expect(result.content, 'From API');
      verify(() => mockRepo.getKudosDetail('deep-link-99')).called(1);
    });

    test('trả về null khi API throw exception (404)', () async {
      // Arrange
      when(() => mockRepo.getHighlightKudos(
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          )).thenAnswer((_) async => []);
      when(() => mockRepo.getKudos(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          )).thenAnswer((_) async => []);
      when(() => mockRepo.getPersonalStats())
          .thenAnswer((_) async => createPersonalStats());
      when(() => mockRepo.getTopRecipients())
          .thenAnswer((_) async => createTop10List());
      when(() => mockRepo.getSpotlight())
          .thenAnswer((_) async => createSpotlightData());
      when(() => mockRepo.getHashtags())
          .thenAnswer((_) async => []);
      when(() => mockRepo.getDepartments())
          .thenAnswer((_) async => []);
      when(() => mockRepo.getKudosDetail('nonexistent'))
          .thenThrow(Exception('Không thể tải chi tiết kudos: 404'));

      final container = createContainerWithState(mockRepo: mockRepo);
      addTearDown(container.dispose);

      final notifier = container.read(kudosViewModelProvider.notifier);
      await container.read(kudosViewModelProvider.future);

      // Act
      final result = await notifier.getKudosById('nonexistent');

      // Assert — API lỗi → trả về null
      expect(result, isNull);
      verify(() => mockRepo.getKudosDetail('nonexistent')).called(1);
    });
  });

  // ─── toggleHeart ──────────────────────────────────────────────────────────

  group('KudosViewModel.toggleHeart', () {
    void stubBuild({
      required List<Kudos> allKudos,
      bool isBonusActive = false,
    }) {
      when(() => mockRepo.getHighlightKudos(
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          )).thenAnswer((_) async => []);
      when(() => mockRepo.getKudos(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          )).thenAnswer((_) async => allKudos);
      when(() => mockRepo.getPersonalStats()).thenAnswer(
        (_) async => createPersonalStats(isBonusActive: isBonusActive),
      );
      when(() => mockRepo.getTopRecipients()).thenAnswer((_) async => []);
      when(() => mockRepo.getSpotlight())
          .thenAnswer((_) async => createSpotlightData());
      when(() => mockRepo.getHashtags()).thenAnswer((_) async => []);
      when(() => mockRepo.getDepartments()).thenAnswer((_) async => []);
    }

    test('isBonusActive = false: like thêm 1 vào heartCount', () async {
      final kudos = createKudos(
        id: 'k1',
        heartCount: 10,
        isLikedByMe: false,
        canLike: true,
      );
      stubBuild(allKudos: [kudos], isBonusActive: false);
      when(() => mockRepo.likeKudos('k1')).thenAnswer((_) async {});

      final container = createContainerWithState(mockRepo: mockRepo);
      addTearDown(container.dispose);
      await container.read(kudosViewModelProvider.future);

      await container.read(kudosViewModelProvider.notifier).toggleHeart('k1');

      final updated = container
          .read(kudosViewModelProvider)
          .valueOrNull!
          .allKudos
          .firstWhere((k) => k.id == 'k1');
      expect(updated.heartCount, 11);
      expect(updated.isLikedByMe, isTrue);
    });

    test('isBonusActive = false: unlike trừ 1 từ heartCount', () async {
      final kudos = createKudos(
        id: 'k1',
        heartCount: 10,
        isLikedByMe: true,
        canLike: true,
      );
      stubBuild(allKudos: [kudos], isBonusActive: false);
      when(() => mockRepo.unlikeKudos('k1')).thenAnswer((_) async {});

      final container = createContainerWithState(mockRepo: mockRepo);
      addTearDown(container.dispose);
      await container.read(kudosViewModelProvider.future);

      await container.read(kudosViewModelProvider.notifier).toggleHeart('k1');

      final updated = container
          .read(kudosViewModelProvider)
          .valueOrNull!
          .allKudos
          .firstWhere((k) => k.id == 'k1');
      expect(updated.heartCount, 9);
      expect(updated.isLikedByMe, isFalse);
    });

    test('isBonusActive = true: like thêm 2 vào heartCount', () async {
      final kudos = createKudos(
        id: 'k1',
        heartCount: 10,
        isLikedByMe: false,
        canLike: true,
      );
      stubBuild(allKudos: [kudos], isBonusActive: true);
      when(() => mockRepo.likeKudos('k1')).thenAnswer((_) async {});

      final container = createContainerWithState(mockRepo: mockRepo);
      addTearDown(container.dispose);
      await container.read(kudosViewModelProvider.future);

      await container.read(kudosViewModelProvider.notifier).toggleHeart('k1');

      final updated = container
          .read(kudosViewModelProvider)
          .valueOrNull!
          .allKudos
          .firstWhere((k) => k.id == 'k1');
      // x2 bonus active → server adds 2, optimistic update phải match
      expect(updated.heartCount, 12);
      expect(updated.isLikedByMe, isTrue);
    });

    test('isBonusActive = true: unlike trừ 2 từ heartCount', () async {
      final kudos = createKudos(
        id: 'k1',
        heartCount: 10,
        isLikedByMe: true,
        canLike: true,
      );
      stubBuild(allKudos: [kudos], isBonusActive: true);
      when(() => mockRepo.unlikeKudos('k1')).thenAnswer((_) async {});

      final container = createContainerWithState(mockRepo: mockRepo);
      addTearDown(container.dispose);
      await container.read(kudosViewModelProvider.future);

      await container.read(kudosViewModelProvider.notifier).toggleHeart('k1');

      final updated = container
          .read(kudosViewModelProvider)
          .valueOrNull!
          .allKudos
          .firstWhere((k) => k.id == 'k1');
      // x2 bonus active → unlike trừ 2
      expect(updated.heartCount, 8);
      expect(updated.isLikedByMe, isFalse);
    });
  });

  // ─── openNextSecretBox ───────────────────────────────────────────────────

  group('KudosViewModel.openNextSecretBox', () {
    SecretBox makeBox({bool isOpened = false}) => SecretBox(
          id: 'box-1',
          userId: 'user-1',
          isOpened: isOpened,
          rewardType: 'badge',
          rewardValue: 'new_hero',
        );

    void stubBuildEmpty() {
      when(() => mockRepo.getHighlightKudos(
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          )).thenAnswer((_) async => []);
      when(() => mockRepo.getKudos(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          )).thenAnswer((_) async => []);
      when(() => mockRepo.getPersonalStats()).thenAnswer(
        (_) async => createPersonalStats(
          secretBoxesOpened: 1,
          secretBoxesUnopened: 2,
        ),
      );
      when(() => mockRepo.getTopRecipients()).thenAnswer((_) async => []);
      when(() => mockRepo.getSpotlight())
          .thenAnswer((_) async => createSpotlightData());
      when(() => mockRepo.getHashtags()).thenAnswer((_) async => []);
      when(() => mockRepo.getDepartments()).thenAnswer((_) async => []);
    }

    test('getNextSecretBox null → không gọi openSecretBox, state không đổi',
        () async {
      stubBuildEmpty();
      when(() => mockRepo.getNextSecretBox()).thenAnswer((_) async => null);

      final container = createContainerWithState(mockRepo: mockRepo);
      addTearDown(container.dispose);
      await container.read(kudosViewModelProvider.future);

      final statsBefore = container
          .read(kudosViewModelProvider)
          .valueOrNull!
          .personalStats;

      await container
          .read(kudosViewModelProvider.notifier)
          .openNextSecretBox();

      verifyNever(() => mockRepo.openSecretBox(any()));
      final statsAfter = container
          .read(kudosViewModelProvider)
          .valueOrNull!
          .personalStats;
      expect(statsAfter?.secretBoxesOpened, statsBefore?.secretBoxesOpened);
    });

    test('getNextSecretBox + openSecretBox success → stats opened+1, unopened-1',
        () async {
      stubBuildEmpty();
      when(() => mockRepo.getNextSecretBox())
          .thenAnswer((_) async => makeBox());
      when(() => mockRepo.openSecretBox('box-1'))
          .thenAnswer((_) async => makeBox(isOpened: true));

      final container = createContainerWithState(mockRepo: mockRepo);
      addTearDown(container.dispose);
      await container.read(kudosViewModelProvider.future);

      await container
          .read(kudosViewModelProvider.notifier)
          .openNextSecretBox();

      final stats = container
          .read(kudosViewModelProvider)
          .valueOrNull!
          .personalStats!;
      expect(stats.secretBoxesOpened, 2); // 1 + 1
      expect(stats.secretBoxesUnopened, 1); // 2 - 1
    });

    test('openSecretBox throw → stats không thay đổi', () async {
      stubBuildEmpty();
      when(() => mockRepo.getNextSecretBox())
          .thenAnswer((_) async => makeBox());
      when(() => mockRepo.openSecretBox('box-1'))
          .thenThrow(Exception('BOX_ALREADY_OPENED'));

      final container = createContainerWithState(mockRepo: mockRepo);
      addTearDown(container.dispose);
      await container.read(kudosViewModelProvider.future);

      final statsBefore = container
          .read(kudosViewModelProvider)
          .valueOrNull!
          .personalStats;

      await container
          .read(kudosViewModelProvider.notifier)
          .openNextSecretBox();

      final statsAfter = container
          .read(kudosViewModelProvider)
          .valueOrNull!
          .personalStats;
      expect(statsAfter?.secretBoxesOpened, statsBefore?.secretBoxesOpened);
      expect(statsAfter?.secretBoxesUnopened, statsBefore?.secretBoxesUnopened);
    });

    test('double-tap guard: chỉ 1 lần gọi openSecretBox', () async {
      stubBuildEmpty();
      when(() => mockRepo.getNextSecretBox())
          .thenAnswer((_) async => makeBox());

      // Delayed open: enough for the second call to hit the guard
      when(() => mockRepo.openSecretBox('box-1')).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 50));
        return makeBox(isOpened: true);
      });

      final container = createContainerWithState(mockRepo: mockRepo);
      addTearDown(container.dispose);
      await container.read(kudosViewModelProvider.future);

      final notifier =
          container.read(kudosViewModelProvider.notifier);
      // Fire twice concurrently — second should be blocked by guard
      await Future.wait([
        notifier.openNextSecretBox(),
        notifier.openNextSecretBox(),
      ]);

      verify(() => mockRepo.openSecretBox('box-1')).called(1);
    });
  });
}
