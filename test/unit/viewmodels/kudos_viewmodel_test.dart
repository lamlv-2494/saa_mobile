import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos_state.dart';
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
          .thenAnswer((_) async => createSpotlightNetwork());
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
          .thenAnswer((_) async => createSpotlightNetwork());
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
          .thenAnswer((_) async => createSpotlightNetwork());
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
          .thenAnswer((_) async => createSpotlightNetwork());
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
}
