import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/repositories/kudos_repository.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/kudos_viewmodel.dart';

import '../../helpers/kudos_test_helpers.dart';

class MockKudosRepository extends Mock implements KudosRepository {}

/// Stub tất cả build() dependencies để ViewModel khởi tạo thành công.
void stubBuildDependencies(
  MockKudosRepository mockRepo, {
  List<Kudos>? allKudos,
  List<Kudos>? highlightKudos,
}) {
  when(() => mockRepo.getHighlightKudos(
        hashtagId: any(named: 'hashtagId'),
        departmentName: any(named: 'departmentName'),
      )).thenAnswer((_) async => highlightKudos ?? []);
  when(() => mockRepo.getKudos(
        page: any(named: 'page'),
        limit: any(named: 'limit'),
        hashtagId: any(named: 'hashtagId'),
        departmentName: any(named: 'departmentName'),
      )).thenAnswer((_) async => allKudos ?? []);
  when(() => mockRepo.getPersonalStats())
      .thenAnswer((_) async => createPersonalStats());
  when(() => mockRepo.getTopRecipients())
      .thenAnswer((_) async => createTop10List());
  when(() => mockRepo.getSpotlight())
      .thenAnswer((_) async => createSpotlightData());
  when(() => mockRepo.getHashtags()).thenAnswer((_) async => []);
  when(() => mockRepo.getDepartments()).thenAnswer((_) async => []);
}

/// Tạo container và đợi build() hoàn thành.
Future<({ProviderContainer container, KudosViewModel notifier})>
    createReadyContainer(MockKudosRepository mockRepo) async {
  final container = ProviderContainer(
    overrides: [kudosRepositoryProvider.overrideWithValue(mockRepo)],
  );
  final notifier = container.read(kudosViewModelProvider.notifier);
  await container.read(kudosViewModelProvider.future);
  return (container: container, notifier: notifier);
}

void main() {
  late MockKudosRepository mockRepo;

  setUp(() {
    mockRepo = MockKudosRepository();
  });

  // ──────────────────────────────────────────────────
  // 1. loadAllKudosPage
  // ──────────────────────────────────────────────────
  group('KudosViewModel.loadAllKudosPage', () {
    test('gọi repository.getKudos(page:1, limit:20) và cập nhật allKudosPageList',
        () async {
      // Arrange
      final page1Kudos = List.generate(
        20,
        (i) => createKudos(id: 'all-$i'),
      );
      stubBuildDependencies(mockRepo);

      // Stub riêng cho loadAllKudosPage — không filter
      when(() => mockRepo.getKudos(page: 1, limit: 20))
          .thenAnswer((_) async => page1Kudos);

      final result = await createReadyContainer(mockRepo);
      addTearDown(result.container.dispose);

      // Act
      await result.notifier.loadAllKudosPage();

      // Assert
      final state = result.container.read(kudosViewModelProvider).value!;
      expect(state.allKudosPageList, page1Kudos);
      expect(state.hasMoreAllKudosPage, true); // 20 items == pageLimit
      // build() gọi 1 lần + loadAllKudosPage() gọi 1 lần = 2 lần
      verify(() => mockRepo.getKudos(page: 1, limit: 20)).called(2);
    });

    test('hasMoreAllKudosPage = false khi trả về < 20 items', () async {
      // Arrange
      final fewKudos = List.generate(5, (i) => createKudos(id: 'few-$i'));
      stubBuildDependencies(mockRepo);
      when(() => mockRepo.getKudos(page: 1, limit: 20))
          .thenAnswer((_) async => fewKudos);

      final result = await createReadyContainer(mockRepo);
      addTearDown(result.container.dispose);

      // Act
      await result.notifier.loadAllKudosPage();

      // Assert
      final state = result.container.read(kudosViewModelProvider).value!;
      expect(state.allKudosPageList, fewKudos);
      expect(state.hasMoreAllKudosPage, false);
    });
  });

  // ──────────────────────────────────────────────────
  // 2. loadMoreAllKudos — pagination
  // ──────────────────────────────────────────────────
  group('KudosViewModel.loadMoreAllKudos', () {
    test('tăng page và append vào allKudosPageList', () async {
      // Arrange
      final page1 = List.generate(20, (i) => createKudos(id: 'p1-$i'));
      final page2 = List.generate(20, (i) => createKudos(id: 'p2-$i'));
      stubBuildDependencies(mockRepo);

      when(() => mockRepo.getKudos(page: 1, limit: 20))
          .thenAnswer((_) async => page1);
      when(() => mockRepo.getKudos(page: 2, limit: 20))
          .thenAnswer((_) async => page2);

      final result = await createReadyContainer(mockRepo);
      addTearDown(result.container.dispose);

      // Khởi tạo page 1
      await result.notifier.loadAllKudosPage();

      // Act — load page 2
      await result.notifier.loadMoreAllKudos();

      // Assert
      final state = result.container.read(kudosViewModelProvider).value!;
      expect(state.allKudosPageList.length, 40);
      expect(state.allKudosPageList.first.id, 'p1-0');
      expect(state.allKudosPageList.last.id, 'p2-19');
      expect(state.hasMoreAllKudosPage, true);
    });

    test('hasMoreAllKudosPage = false khi page mới trả về < 20 items',
        () async {
      // Arrange
      final page1 = List.generate(20, (i) => createKudos(id: 'p1-$i'));
      final page2 = List.generate(5, (i) => createKudos(id: 'p2-$i'));
      stubBuildDependencies(mockRepo);

      when(() => mockRepo.getKudos(page: 1, limit: 20))
          .thenAnswer((_) async => page1);
      when(() => mockRepo.getKudos(page: 2, limit: 20))
          .thenAnswer((_) async => page2);

      final result = await createReadyContainer(mockRepo);
      addTearDown(result.container.dispose);

      await result.notifier.loadAllKudosPage();

      // Act
      await result.notifier.loadMoreAllKudos();

      // Assert
      final state = result.container.read(kudosViewModelProvider).value!;
      expect(state.allKudosPageList.length, 25);
      expect(state.hasMoreAllKudosPage, false);
    });
  });

  // ──────────────────────────────────────────────────
  // 3. loadMoreAllKudos guard
  // ──────────────────────────────────────────────────
  group('KudosViewModel.loadMoreAllKudos guard', () {
    test('không gọi API khi hasMoreAllKudosPage = false', () async {
      // Arrange — page 1 trả về < 20 items → hasMore = false
      final fewKudos = List.generate(5, (i) => createKudos(id: 'few-$i'));
      stubBuildDependencies(mockRepo);
      when(() => mockRepo.getKudos(page: 1, limit: 20))
          .thenAnswer((_) async => fewKudos);

      final result = await createReadyContainer(mockRepo);
      addTearDown(result.container.dispose);

      await result.notifier.loadAllKudosPage();
      clearInteractions(mockRepo);

      // Act
      await result.notifier.loadMoreAllKudos();

      // Assert — không gọi thêm API nào
      verifyNever(() => mockRepo.getKudos(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            hashtagId: any(named: 'hashtagId'),
            departmentName: any(named: 'departmentName'),
          ));
      verifyNever(() => mockRepo.getKudos(page: 2, limit: 20));
    });

    test('không gọi API khi isLoadingMoreAllKudos = true (concurrent call)',
        () async {
      // Arrange
      final page1 = List.generate(20, (i) => createKudos(id: 'p1-$i'));
      stubBuildDependencies(mockRepo);
      when(() => mockRepo.getKudos(page: 1, limit: 20))
          .thenAnswer((_) async => page1);

      // Page 2 sẽ delay để mô phỏng loading
      final completer = Completer<List<Kudos>>();
      when(() => mockRepo.getKudos(page: 2, limit: 20))
          .thenAnswer((_) => completer.future);

      final result = await createReadyContainer(mockRepo);
      addTearDown(result.container.dispose);

      await result.notifier.loadAllKudosPage();

      // Act — gọi lần 1 (chưa complete)
      final firstCall = result.notifier.loadMoreAllKudos();

      // Gọi lần 2 ngay lập tức — phải bị skip vì isLoadingMore = true
      await result.notifier.loadMoreAllKudos();

      // Complete lần 1
      completer.complete(List.generate(20, (i) => createKudos(id: 'p2-$i')));
      await firstCall;

      // Assert — chỉ gọi page 2 đúng 1 lần
      verify(() => mockRepo.getKudos(page: 2, limit: 20)).called(1);
    });
  });

  // ──────────────────────────────────────────────────
  // 4. loadMoreAllKudos error — rollback page
  // ──────────────────────────────────────────────────
  group('KudosViewModel.loadMoreAllKudos error', () {
    test('rollback page counter và giữ nguyên data khi API lỗi', () async {
      // Arrange
      final page1 = List.generate(20, (i) => createKudos(id: 'p1-$i'));
      stubBuildDependencies(mockRepo);
      when(() => mockRepo.getKudos(page: 1, limit: 20))
          .thenAnswer((_) async => page1);
      when(() => mockRepo.getKudos(page: 2, limit: 20))
          .thenThrow(Exception('Network error'));

      final result = await createReadyContainer(mockRepo);
      addTearDown(result.container.dispose);

      await result.notifier.loadAllKudosPage();

      // Act — page 2 lỗi
      await result.notifier.loadMoreAllKudos();

      // Assert — data giữ nguyên page 1
      final state = result.container.read(kudosViewModelProvider).value!;
      expect(state.allKudosPageList.length, 20);
      expect(state.allKudosPageList.first.id, 'p1-0');
      expect(state.isLoadingMoreAllKudos, false);

      // Retry phải gọi lại page 2 (page counter đã rollback)
      when(() => mockRepo.getKudos(page: 2, limit: 20))
          .thenAnswer((_) async =>
              List.generate(20, (i) => createKudos(id: 'retry-$i')));
      await result.notifier.loadMoreAllKudos();

      final stateAfterRetry =
          result.container.read(kudosViewModelProvider).value!;
      expect(stateAfterRetry.allKudosPageList.length, 40);
      expect(stateAfterRetry.allKudosPageList.last.id, 'retry-19');
    });
  });

  // ──────────────────────────────────────────────────
  // 5. refreshAllKudos — reset page, replace list
  // ──────────────────────────────────────────────────
  group('KudosViewModel.refreshAllKudos', () {
    test('reset page và replace allKudosPageList (không append)', () async {
      // Arrange
      final page1 = List.generate(20, (i) => createKudos(id: 'old-$i'));
      final refreshed = List.generate(20, (i) => createKudos(id: 'new-$i'));
      stubBuildDependencies(mockRepo);

      // build() + loadAllKudosPage gọi getKudos(page:1) → trả page1
      when(() => mockRepo.getKudos(page: 1, limit: 20))
          .thenAnswer((_) async => page1);

      final result = await createReadyContainer(mockRepo);
      addTearDown(result.container.dispose);

      await result.notifier.loadAllKudosPage();
      expect(
        result.container.read(kudosViewModelProvider).value!
            .allKudosPageList.first.id,
        'old-0',
      );

      // Đổi stub để refreshAllKudos trả về data mới
      when(() => mockRepo.getKudos(page: 1, limit: 20))
          .thenAnswer((_) async => refreshed);

      // Act — refresh
      await result.notifier.refreshAllKudos();

      // Assert — data được replace, không phải append
      final state = result.container.read(kudosViewModelProvider).value!;
      expect(state.allKudosPageList.length, 20);
      expect(state.allKudosPageList.first.id, 'new-0');
      expect(state.allKudosPageList.last.id, 'new-19');
    });
  });

  // ──────────────────────────────────────────────────
  // 6. _updateKudosInState — sync 3 lists
  // ──────────────────────────────────────────────────
  group('KudosViewModel._updateKudosInState sync 3 lists', () {
    test(
        'toggleHeart cập nhật kudos đồng thời ở allKudos, highlightKudos, và allKudosPageList',
        () async {
      // Arrange — kudos-shared xuất hiện ở cả 3 list
      final sharedKudos = createKudos(
        id: 'kudos-shared',
        heartCount: 10,
        isLikedByMe: false,
        canLike: true,
      );

      final allKudos = [
        createKudos(id: 'feed-1'),
        sharedKudos,
        createKudos(id: 'feed-3'),
      ];
      final highlightKudos = [
        sharedKudos,
        createKudos(id: 'highlight-2', isHighlight: true),
      ];

      stubBuildDependencies(
        mockRepo,
        allKudos: allKudos,
        highlightKudos: highlightKudos,
      );

      // Stub loadAllKudosPage
      when(() => mockRepo.getKudos(page: 1, limit: 20))
          .thenAnswer((_) async => [
                createKudos(id: 'all-page-1'),
                sharedKudos,
                createKudos(id: 'all-page-3'),
              ]);

      // Stub likeKudos
      when(() => mockRepo.likeKudos('kudos-shared'))
          .thenAnswer((_) async {});

      final result = await createReadyContainer(mockRepo);
      addTearDown(result.container.dispose);

      // Load allKudosPageList
      await result.notifier.loadAllKudosPage();

      // Verify shared kudos ở cả 3 list trước khi toggle
      var state = result.container.read(kudosViewModelProvider).value!;
      expect(
        state.allKudos.firstWhere((k) => k.id == 'kudos-shared').isLikedByMe,
        false,
      );
      expect(
        state.highlightKudos
            .firstWhere((k) => k.id == 'kudos-shared')
            .isLikedByMe,
        false,
      );
      expect(
        state.allKudosPageList
            .firstWhere((k) => k.id == 'kudos-shared')
            .isLikedByMe,
        false,
      );

      // Act — toggleHeart
      await result.notifier.toggleHeart('kudos-shared');

      // Assert — cả 3 list đều được cập nhật
      state = result.container.read(kudosViewModelProvider).value!;

      final inAll = state.allKudos.firstWhere((k) => k.id == 'kudos-shared');
      expect(inAll.isLikedByMe, true);
      expect(inAll.heartCount, 11);

      final inHighlight =
          state.highlightKudos.firstWhere((k) => k.id == 'kudos-shared');
      expect(inHighlight.isLikedByMe, true);
      expect(inHighlight.heartCount, 11);

      final inPageList =
          state.allKudosPageList.firstWhere((k) => k.id == 'kudos-shared');
      expect(inPageList.isLikedByMe, true);
      expect(inPageList.heartCount, 11);
    });
  });
}

