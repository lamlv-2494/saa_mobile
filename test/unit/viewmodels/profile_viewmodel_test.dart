import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/repositories/kudos_repository.dart';
import 'package:saa_mobile/features/profile/data/models/kudos_filter_type.dart';
import 'package:saa_mobile/features/profile/data/repositories/profile_repository.dart';
import 'package:saa_mobile/features/profile/presentation/viewmodels/profile_viewmodel.dart';

import '../../helpers/kudos_test_helpers.dart';
import '../../helpers/profile_mocks.dart';
import '../../helpers/profile_test_helpers.dart';

class MockKudosRepository extends Mock implements KudosRepository {}

ProviderContainer createProfileContainer({
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

  /// Stub tất cả API calls cho build() thành công
  void stubBuildSuccess({
    List<Kudos>? kudosList,
    int kudosCount = 5,
  }) {
    when(() => mockProfileRepo.getMyProfile())
        .thenAnswer((_) async => createUserProfile());
    when(() => mockProfileRepo.getMyStats())
        .thenAnswer((_) async => createPersonalStats());
    when(() => mockProfileRepo.getMyIconBadges())
        .thenAnswer((_) async => createIconBadgeList());
    when(
      () => mockProfileRepo.getKudosHistory(
        userId: any(named: 'userId'),
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

  group('ProfileViewModel.build', () {
    test('fetch profile, stats, iconBadges, kudos (page 1, filter: sent)',
        () async {
      // Arrange
      final profile = createUserProfile(name: 'Trần Văn B');
      final stats = createPersonalStats(kudosReceived: 50);
      final iconBadges = createIconBadgeList(count: 2);
      final kudos = [createKudos(id: 'k1'), createKudos(id: 'k2')];

      when(() => mockProfileRepo.getMyProfile())
          .thenAnswer((_) async => profile);
      when(() => mockProfileRepo.getMyStats())
          .thenAnswer((_) async => stats);
      when(() => mockProfileRepo.getMyIconBadges())
          .thenAnswer((_) async => iconBadges);
      when(
        () => mockProfileRepo.getKudosHistory(
          userId: profile.id,
          filter: 'sent',
          page: 1,
          limit: 20,
        ),
      ).thenAnswer((_) async => kudos);

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      // Act
      final state = await container.read(profileViewModelProvider.future);

      // Assert
      expect(state.profile, profile);
      expect(state.personalStats, stats);
      expect(state.iconBadges, iconBadges);
      expect(state.kudosList, kudos);
      expect(state.kudosFilter, KudosFilterType.sent);
      expect(state.hasMoreKudos, false); // 2 < 20
    });

    test('hasMoreKudos = true khi kudos.length >= 20', () async {
      // Arrange
      stubBuildSuccess(kudosCount: 20);

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      // Act
      final state = await container.read(profileViewModelProvider.future);

      // Assert
      expect(state.hasMoreKudos, true);
      expect(state.kudosList.length, 20);
    });

    test('trả về error khi getMyProfile throw exception', () async {
      // Arrange
      when(() => mockProfileRepo.getMyProfile())
          .thenThrow(Exception('Network error'));
      when(() => mockProfileRepo.getMyStats())
          .thenAnswer((_) async => createPersonalStats());
      when(() => mockProfileRepo.getMyIconBadges())
          .thenAnswer((_) async => createIconBadgeList());
      when(
        () => mockProfileRepo.getKudosHistory(
          userId: any(named: 'userId'),
          filter: any(named: 'filter'),
          page: any(named: 'page'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => []);

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      // Act — đợi provider resolve (sẽ thành AsyncError)
      await expectLater(
        container.read(profileViewModelProvider.future),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('ProfileViewModel.changeFilter', () {
    test('đổi filter sang sent, reset page, reload kudos', () async {
      // Arrange
      final sentKudos = [createKudos(id: 'sent-1'), createKudos(id: 'sent-2')];
      stubBuildSuccess();

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container.read(profileViewModelProvider.future);

      // Stub lần gọi thứ hai cho filter 'sent'
      when(
        () => mockProfileRepo.getKudosHistory(
          userId: any(named: 'userId'),
          filter: 'sent',
          page: 1,
          limit: 20,
        ),
      ).thenAnswer((_) async => sentKudos);

      // Act
      final notifier = container.read(profileViewModelProvider.notifier);
      await notifier.changeFilter(KudosFilterType.sent);

      // Assert
      final state = container.read(profileViewModelProvider).value!;
      expect(state.kudosFilter, KudosFilterType.sent);
      expect(state.kudosList, sentKudos);
      expect(state.hasMoreKudos, false); // 2 < 20
    });

    test('đổi filter về received sau khi đã chuyển sang sent', () async {
      // Arrange
      final receivedKudos = [createKudos(id: 'recv-1')];
      stubBuildSuccess();

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container.read(profileViewModelProvider.future);

      // Đổi sang sent trước
      when(
        () => mockProfileRepo.getKudosHistory(
          userId: any(named: 'userId'),
          filter: 'sent',
          page: 1,
          limit: 20,
        ),
      ).thenAnswer((_) async => [createKudos(id: 'sent-1')]);

      final notifier = container.read(profileViewModelProvider.notifier);
      await notifier.changeFilter(KudosFilterType.sent);

      // Stub cho filter received
      when(
        () => mockProfileRepo.getKudosHistory(
          userId: any(named: 'userId'),
          filter: 'received',
          page: 1,
          limit: 20,
        ),
      ).thenAnswer((_) async => receivedKudos);

      // Act — đổi về received
      await notifier.changeFilter(KudosFilterType.received);

      // Assert
      final state = container.read(profileViewModelProvider).value!;
      expect(state.kudosFilter, KudosFilterType.received);
      expect(state.kudosList, receivedKudos);
    });
  });

  group('ProfileViewModel.loadMoreKudos', () {
    test('append thêm kudos vào danh sách khi load page 2', () async {
      // Arrange — page 1 trả 20 items
      stubBuildSuccess(kudosCount: 20);

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container.read(profileViewModelProvider.future);

      // Stub page 2
      final page2Kudos =
          List.generate(5, (i) => createKudos(id: 'page2-$i'));
      when(
        () => mockProfileRepo.getKudosHistory(
          userId: any(named: 'userId'),
          filter: 'sent',
          page: 2,
          limit: 20,
        ),
      ).thenAnswer((_) async => page2Kudos);

      // Act
      final notifier = container.read(profileViewModelProvider.notifier);
      await notifier.loadMoreKudos();

      // Assert
      final state = container.read(profileViewModelProvider).value!;
      expect(state.kudosList.length, 25); // 20 + 5
      expect(state.hasMoreKudos, false); // 5 < 20
    });

    test('không load thêm khi hasMoreKudos = false', () async {
      // Arrange — page 1 trả 5 items (< 20)
      stubBuildSuccess(kudosCount: 5);

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container.read(profileViewModelProvider.future);

      // Act
      final notifier = container.read(profileViewModelProvider.notifier);
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

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container.read(profileViewModelProvider.future);

      // Stub page 2 — lỗi
      when(
        () => mockProfileRepo.getKudosHistory(
          userId: any(named: 'userId'),
          filter: 'sent',
          page: 2,
          limit: 20,
        ),
      ).thenThrow(Exception('API error'));

      // Act
      final notifier = container.read(profileViewModelProvider.notifier);
      await notifier.loadMoreKudos();

      // Assert — danh sách không thay đổi
      final state = container.read(profileViewModelProvider).value!;
      expect(state.kudosList.length, 20);
    });
  });

  group('ProfileViewModel.toggleHeart', () {
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

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container.read(profileViewModelProvider.future);

      // Act
      final notifier = container.read(profileViewModelProvider.notifier);
      await notifier.toggleHeart('k1');

      // Assert
      final state = container.read(profileViewModelProvider).value!;
      final updated = state.kudosList.firstWhere((k) => k.id == 'k1');
      expect(updated.isLikedByMe, true);
      expect(updated.heartCount, 6);
      verify(() => mockKudosRepo.likeKudos('k1')).called(1);
    });

    test('optimistic update: giảm heartCount và set isLikedByMe = false',
        () async {
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

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container.read(profileViewModelProvider.future);

      // Act
      final notifier = container.read(profileViewModelProvider.notifier);
      await notifier.toggleHeart('k1');

      // Assert
      final state = container.read(profileViewModelProvider).value!;
      final updated = state.kudosList.firstWhere((k) => k.id == 'k1');
      expect(updated.isLikedByMe, false);
      expect(updated.heartCount, 4);
      verify(() => mockKudosRepo.unlikeKudos('k1')).called(1);
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

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container.read(profileViewModelProvider.future);

      // Act
      final notifier = container.read(profileViewModelProvider.notifier);
      await notifier.toggleHeart('k1');

      // Assert — rollback về trạng thái ban đầu
      final state = container.read(profileViewModelProvider).value!;
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

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container.read(profileViewModelProvider.future);

      // Act
      final notifier = container.read(profileViewModelProvider.notifier);
      await notifier.toggleHeart('k1');

      // Assert — không thay đổi
      final state = container.read(profileViewModelProvider).value!;
      final unchanged = state.kudosList.firstWhere((k) => k.id == 'k1');
      expect(unchanged.isLikedByMe, false);
      expect(unchanged.heartCount, 5);
      verifyNever(() => mockKudosRepo.likeKudos(any()));
    });

    test('không toggle khi kudosId không tồn tại', () async {
      // Arrange
      stubBuildSuccess(kudosCount: 2);

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container.read(profileViewModelProvider.future);

      // Act
      final notifier = container.read(profileViewModelProvider.notifier);
      await notifier.toggleHeart('nonexistent');

      // Assert
      verifyNever(() => mockKudosRepo.likeKudos(any()));
      verifyNever(() => mockKudosRepo.unlikeKudos(any()));
    });
  });

  group('ProfileViewModel.refresh', () {
    test('reload toàn bộ data', () async {
      // Arrange
      stubBuildSuccess();

      final container = createProfileContainer(
        mockProfileRepo: mockProfileRepo,
        mockKudosRepo: mockKudosRepo,
      );
      addTearDown(container.dispose);

      await container.read(profileViewModelProvider.future);

      // Act
      final notifier = container.read(profileViewModelProvider.notifier);
      await notifier.refresh();

      // Assert — build được gọi 2 lần (init + refresh)
      verify(() => mockProfileRepo.getMyProfile()).called(2);
      verify(() => mockProfileRepo.getMyStats()).called(2);
      verify(() => mockProfileRepo.getMyIconBadges()).called(2);
    });
  });
}
