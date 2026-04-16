import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/repositories/kudos_repository.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/kudos_detail_viewmodel.dart';

import '../../helpers/kudos_test_helpers.dart';

class MockKudosRepository extends Mock implements KudosRepository {}

void main() {
  late MockKudosRepository mockRepo;

  setUp(() {
    mockRepo = MockKudosRepository();
  });

  ProviderContainer createContainer(String kudosId) {
    return ProviderContainer(
      overrides: [
        kudosRepositoryProvider.overrideWithValue(mockRepo),
      ],
    );
  }

  group('KudosDetailViewModel.build', () {
    test('load kudos thường → trả về Kudos đầy đủ sender info', () async {
      final kudos = createKudos(
        id: '42',
        content: 'Cảm ơn!',
        isAnonymous: false,
      );
      when(() => mockRepo.getKudosDetail('42'))
          .thenAnswer((_) async => kudos);

      final container = createContainer('42');
      addTearDown(container.dispose);

      final result = await container.read(
        kudosDetailViewModelProvider('42').future,
      );

      expect(result, isNotNull);
      expect(result!.id, '42');
      expect(result.isAnonymous, false);
      expect(result.sender.name, isNotEmpty);
      verify(() => mockRepo.getKudosDetail('42')).called(1);
    });

    test('load kudos ẩn danh → isAnonymous=true, senderAlias có giá trị',
        () async {
      final kudos = createKudos(
        id: '99',
        isAnonymous: true,
        senderAlias: 'Anh Hùng Xạ Điêu',
      );
      when(() => mockRepo.getKudosDetail('99'))
          .thenAnswer((_) async => kudos);

      final container = createContainer('99');
      addTearDown(container.dispose);

      final result = await container.read(
        kudosDetailViewModelProvider('99').future,
      );

      expect(result, isNotNull);
      expect(result!.isAnonymous, true);
      expect(result.senderAlias, 'Anh Hùng Xạ Điêu');
    });

    test('kudos không tồn tại → state = error', () async {
      when(() => mockRepo.getKudosDetail('404'))
          .thenThrow(Exception('Không tìm thấy'));

      final container = createContainer('404');
      addTearDown(container.dispose);

      await container.read(
        kudosDetailViewModelProvider('404').future,
      ).then((_) => null).catchError((_) => null);

      // State should be AsyncError
      final asyncState = container.read(
        kudosDetailViewModelProvider('404'),
      );
      expect(asyncState, isA<AsyncError<Kudos?>>());
    });
  });

  group('KudosDetailViewModel.toggleHeart', () {
    test('toggle heart → cập nhật heartCount và isLikedByMe', () async {
      final kudos = createKudos(
        id: '10',
        heartCount: 5,
        isLikedByMe: false,
      );
      when(() => mockRepo.getKudosDetail('10'))
          .thenAnswer((_) async => kudos);
      when(() => mockRepo.likeKudos('10'))
          .thenAnswer((_) async {});

      final container = createContainer('10');
      addTearDown(container.dispose);

      await container.read(kudosDetailViewModelProvider('10').future);

      final notifier = container.read(
        kudosDetailViewModelProvider('10').notifier,
      );
      await notifier.toggleHeart();

      final updated = container.read(
        kudosDetailViewModelProvider('10'),
      );
      expect(updated.value?.heartCount, 6);
      expect(updated.value?.isLikedByMe, true);
    });

    test('unlike → giảm heartCount', () async {
      final kudos = createKudos(
        id: '11',
        heartCount: 3,
        isLikedByMe: true,
      );
      when(() => mockRepo.getKudosDetail('11'))
          .thenAnswer((_) async => kudos);
      when(() => mockRepo.unlikeKudos('11'))
          .thenAnswer((_) async {});

      final container = createContainer('11');
      addTearDown(container.dispose);

      await container.read(kudosDetailViewModelProvider('11').future);

      final notifier = container.read(
        kudosDetailViewModelProvider('11').notifier,
      );
      await notifier.toggleHeart();

      final updated = container.read(
        kudosDetailViewModelProvider('11'),
      );
      expect(updated.value?.heartCount, 2);
      expect(updated.value?.isLikedByMe, false);
    });

    test('toggle heart thất bại → rollback state', () async {
      final kudos = createKudos(
        id: '12',
        heartCount: 5,
        isLikedByMe: false,
      );
      when(() => mockRepo.getKudosDetail('12'))
          .thenAnswer((_) async => kudos);
      when(() => mockRepo.likeKudos('12'))
          .thenThrow(Exception('Network error'));

      final container = createContainer('12');
      addTearDown(container.dispose);

      await container.read(kudosDetailViewModelProvider('12').future);

      final notifier = container.read(
        kudosDetailViewModelProvider('12').notifier,
      );
      await notifier.toggleHeart();

      final updated = container.read(
        kudosDetailViewModelProvider('12'),
      );
      // Rollback to original
      expect(updated.value?.heartCount, 5);
      expect(updated.value?.isLikedByMe, false);
    });
  });
}
