import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/repositories/kudos_repository.dart';
import 'package:saa_mobile/features/profile/data/models/kudos_filter_type.dart';
import 'package:saa_mobile/features/profile/data/repositories/profile_repository.dart';
import 'package:saa_mobile/features/profile/presentation/viewmodels/other_profile_viewmodel.dart';

import '../../helpers/kudos_test_helpers.dart';
import '../../helpers/profile_mocks.dart';
import '../../helpers/profile_test_helpers.dart';

class MockKudosRepository extends Mock implements KudosRepository {}

const _testUserId = 'user-other-123';

ProviderContainer createOtherProfileContainer({
  required MockProfileRepository mockProfileRepo,
  required MockKudosRepository mockKudosRepo,
}) {
  return ProviderContainer(
    overrides: [
      profileRepositoryProvider.overrideWithValue(mockProfileRepo),
      kudosRepositoryProvider.overrideWithValue(mockKudosRepo),
    ],
  );
}

void main() {
  late MockProfileRepository mockProfileRepo;
  late MockKudosRepository mockKudosRepo;

  setUp(() {
    mockProfileRepo = MockProfileRepository();
    mockKudosRepo = MockKudosRepository();
  });

  /// Stub tất cả API calls cho build(userId) thành công
  void stubBuildSuccess({
    String userId = _testUserId,
    List<Kudos>? kudosList,
    int kudosCount = 5,
  }) {
    when(() => mockProfileRepo.getUserProfile(userId))
        .thenAnswer((_) async => createUserProfile(id: userId));
    when(() => mockProfileRepo.getUserBadges(userId))
        .thenAnswer((_) async => createBadgeList());
    when(
      () => mockProfileRepo.getKudosHistory(
        userId: userId,
        filter: any(named: 'filter'),
        page: any(named: 'page'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer(
      (_) async =>
          kudosList ??
          List.generate(kudosCount, (i) => createKudos(id: 'kudos-$i')),
    );
  }

  group('OtherProfileViewModel.build', () {
    test('fetch profile, badges, kudos (page 1, filter: received)', () async {
      // Arrange
      final profile = createUserProfile(id: _testUserId, name: 'Lê Văn C');
      final badges = createBadgeList(count: 2);
      final kudos = [createKudos(id: 'k1'), createKudos(id: 'k2')];

      when(() => mockProfileRepo.getUserProfile(_testUserId))
          .thenAnswer((_) async => profile);
      when(() => mockProfileRepo.getUserBadges(_testUserId))
          .thenAnswer((_) async => badges);
      when(
        () => mockProfileRepo.getKudosHistory(
          userId: _testUserId,
          filter: 'received',
          page: 1,
          limit: 20,
        ),
      ).thenAnswer((_) async => kudos);

      final container = createOtherProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      // Act
      final state = await container
          .read(otherProfileViewModelProvider(_testUserId).future);

      // Assert
      expect(state.profile, profile);
      expect(state.badges, badges);
      expect(state.kudosList, kudos);
      expect(state.kudosFilter, KudosFilterType.received);
      expect(state.hasMoreKudos, false); // 2 < 20
    });

    test('hasMoreKudos = true khi kudos.length >= 20', () async {
      // Arrange
      stubBuildSuccess(kudosCount: 20);

      final container = createOtherProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      // Act
      final state = await container
          .read(otherProfileViewModelProvider(_testUserId).future);

      // Assert
      expect(state.hasMoreKudos, true);
      expect(state.kudosList.length, 20);
    });

    test('trả về error khi getUserProfile throw exception', () async {
      // Arrange
      when(() => mockProfileRepo.getUserProfile(_testUserId))
          .thenThrow(Exception('Network error'));
      when(() => mockProfileRepo.getUserBadges(_testUserId))
          .thenAnswer((_) async => createBadgeList());
      when(
        () => mockProfileRepo.getKudosHistory(
          userId: _testUserId,
          filter: any(named: 'filter'),
          page: any(named: 'page'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => []);

      final container = createOtherProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      // Act — đợi provider resolve (sẽ thành AsyncError)
      await expectLater(
        container.read(otherProfileViewModelProvider(_testUserId).future),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('OtherProfileViewModel.changeFilter', () {
    test('đổi filter sang sent, reset page, reload kudos', () async {
      // Arrange
      final sentKudos = [createKudos(id: 'sent-1')];
      stubBuildSuccess();

      final container = createOtherProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container
          .read(otherProfileViewModelProvider(_testUserId).future);

      // Stub cho filter 'sent'
      when(
        () => mockProfileRepo.getKudosHistory(
          userId: _testUserId,
          filter: 'sent',
          page: 1,
          limit: 20,
        ),
      ).thenAnswer((_) async => sentKudos);

      // Act
      final notifier = container
          .read(otherProfileViewModelProvider(_testUserId).notifier);
      await notifier.changeFilter(KudosFilterType.sent);

      // Assert
      final state =
          container.read(otherProfileViewModelProvider(_testUserId)).value!;
      expect(state.kudosFilter, KudosFilterType.sent);
      expect(state.kudosList, sentKudos);
      expect(state.hasMoreKudos, false);
    });
  });

  group('OtherProfileViewModel.loadMoreKudos', () {
    test('append thêm kudos vào danh sách khi load page 2', () async {
      // Arrange — page 1 trả 20 items
      stubBuildSuccess(kudosCount: 20);

      final container = createOtherProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container
          .read(otherProfileViewModelProvider(_testUserId).future);

      // Stub page 2
      final page2Kudos =
          List.generate(5, (i) => createKudos(id: 'page2-$i'));
      when(
        () => mockProfileRepo.getKudosHistory(
          userId: _testUserId,
          filter: 'received',
          page: 2,
          limit: 20,
        ),
      ).thenAnswer((_) async => page2Kudos);

      // Act
      final notifier = container
          .read(otherProfileViewModelProvider(_testUserId).notifier);
      await notifier.loadMoreKudos();

      // Assert
      final state =
          container.read(otherProfileViewModelProvider(_testUserId)).value!;
      expect(state.kudosList.length, 25); // 20 + 5
      expect(state.hasMoreKudos, false); // 5 < 20
    });

    test('không load thêm khi hasMoreKudos = false', () async {
      // Arrange — page 1 trả 5 items (< 20)
      stubBuildSuccess(kudosCount: 5);

      final container = createOtherProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container
          .read(otherProfileViewModelProvider(_testUserId).future);

      // Act
      final notifier = container
          .read(otherProfileViewModelProvider(_testUserId).notifier);
      await notifier.loadMoreKudos();

      // Assert — getKudosHistory chỉ được gọi 1 lần (build)
      verify(
        () => mockProfileRepo.getKudosHistory(
          userId: any(named: 'userId'),
          filter: any(named: 'filter'),
          page: any(named: 'page'),
          limit: any(named: 'limit'),
        ),
      ).called(1);
    });

    test('rollback page khi load more lỗi', () async {
      // Arrange
      stubBuildSuccess(kudosCount: 20);

      final container = createOtherProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container
          .read(otherProfileViewModelProvider(_testUserId).future);

      // Stub page 2 — lỗi
      when(
        () => mockProfileRepo.getKudosHistory(
          userId: _testUserId,
          filter: 'received',
          page: 2,
          limit: 20,
        ),
      ).thenThrow(Exception('API error'));

      // Act
      final notifier = container
          .read(otherProfileViewModelProvider(_testUserId).notifier);
      await notifier.loadMoreKudos();

      // Assert — danh sách không thay đổi
      final state =
          container.read(otherProfileViewModelProvider(_testUserId)).value!;
      expect(state.kudosList.length, 20);
    });
  });

  group('OtherProfileViewModel.toggleHeart', () {
    test('optimistic update: tăng heartCount và set isLikedByMe = true',
        () async {
      // Arrange
      final kudos = createKudos(
        id: 'k1',
        isLikedByMe: false,
        heartCount: 5,
        canLike: true,
      );
      stubBuildSuccess(kudosList: [kudos]);
      when(() => mockKudosRepo.likeKudos('k1'))
          .thenAnswer((_) async {});

      final container = createOtherProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container
          .read(otherProfileViewModelProvider(_testUserId).future);

      // Act
      final notifier = container
          .read(otherProfileViewModelProvider(_testUserId).notifier);
      await notifier.toggleHeart('k1');

      // Assert
      final state =
          container.read(otherProfileViewModelProvider(_testUserId)).value!;
      final updated = state.kudosList.firstWhere((k) => k.id == 'k1');
      expect(updated.isLikedByMe, true);
      expect(updated.heartCount, 6);
      verify(() => mockKudosRepo.likeKudos('k1')).called(1);
    });

    test('optimistic update: giảm heartCount khi unlike', () async {
      // Arrange
      final kudos = createKudos(
        id: 'k1',
        isLikedByMe: true,
        heartCount: 5,
        canLike: true,
      );
      stubBuildSuccess(kudosList: [kudos]);
      when(() => mockKudosRepo.unlikeKudos('k1'))
          .thenAnswer((_) async {});

      final container = createOtherProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container
          .read(otherProfileViewModelProvider(_testUserId).future);

      // Act
      final notifier = container
          .read(otherProfileViewModelProvider(_testUserId).notifier);
      await notifier.toggleHeart('k1');

      // Assert
      final state =
          container.read(otherProfileViewModelProvider(_testUserId)).value!;
      final updated = state.kudosList.firstWhere((k) => k.id == 'k1');
      expect(updated.isLikedByMe, false);
      expect(updated.heartCount, 4);
    });

    test('rollback khi API lỗi', () async {
      // Arrange
      final kudos = createKudos(
        id: 'k1',
        isLikedByMe: false,
        heartCount: 5,
        canLike: true,
      );
      stubBuildSuccess(kudosList: [kudos]);
      when(() => mockKudosRepo.likeKudos('k1'))
          .thenThrow(Exception('API error'));

      final container = createOtherProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container
          .read(otherProfileViewModelProvider(_testUserId).future);

      // Act
      final notifier = container
          .read(otherProfileViewModelProvider(_testUserId).notifier);
      await notifier.toggleHeart('k1');

      // Assert — rollback
      final state =
          container.read(otherProfileViewModelProvider(_testUserId)).value!;
      final rolledBack = state.kudosList.firstWhere((k) => k.id == 'k1');
      expect(rolledBack.isLikedByMe, false);
      expect(rolledBack.heartCount, 5);
    });

    test('không toggle khi canLike = false', () async {
      // Arrange
      final kudos = createKudos(
        id: 'k1',
        isLikedByMe: false,
        heartCount: 5,
        canLike: false,
      );
      stubBuildSuccess(kudosList: [kudos]);

      final container = createOtherProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container
          .read(otherProfileViewModelProvider(_testUserId).future);

      // Act
      final notifier = container
          .read(otherProfileViewModelProvider(_testUserId).notifier);
      await notifier.toggleHeart('k1');

      // Assert
      verifyNever(() => mockKudosRepo.likeKudos(any()));
    });
  });

  group('OtherProfileViewModel.refresh', () {
    test('reload toàn bộ data', () async {
      // Arrange
      stubBuildSuccess();

      final container = createOtherProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container
          .read(otherProfileViewModelProvider(_testUserId).future);

      // Act
      final notifier = container
          .read(otherProfileViewModelProvider(_testUserId).notifier);
      await notifier.refresh();

      // Assert — build được gọi 2 lần (init + refresh)
      verify(() => mockProfileRepo.getUserProfile(_testUserId)).called(2);
      verify(() => mockProfileRepo.getUserBadges(_testUserId)).called(2);
    });
  });
}
