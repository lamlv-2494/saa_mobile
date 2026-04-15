import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saa_mobile/features/kudos/data/datasources/kudos_remote_datasource.dart';
import 'package:saa_mobile/features/kudos/data/models/send_kudos_state.dart';
import 'package:saa_mobile/features/kudos/data/repositories/kudos_repository.dart';

import '../../helpers/kudos_test_helpers.dart';

class MockKudosRemoteDatasource extends Mock implements KudosRemoteDatasource {}

void main() {
  late MockKudosRemoteDatasource mockDatasource;
  late KudosRepository repository;

  setUp(() {
    mockDatasource = MockKudosRemoteDatasource();
    repository = KudosRepository(mockDatasource);
  });

  // ─────────────────────────────────────────────────────────────
  group('searchUsers', () {
    test('returns user list from datasource', () async {
      final users = [
        createUserSummary(id: 'u1', name: 'Nguyễn A'),
        createUserSummary(id: 'u2', name: 'Nguyễn B'),
      ];
      when(
        () => mockDatasource.searchUsers('Nguyễn'),
      ).thenAnswer((_) async => users);

      final result = await repository.searchUsers('Nguyễn');

      expect(result, hasLength(2));
      expect(result.first.name, 'Nguyễn A');
      verify(() => mockDatasource.searchUsers('Nguyễn')).called(1);
    });

    test('throws friendly exception on datasource error', () async {
      when(
        () => mockDatasource.searchUsers(any()),
      ).thenThrow(Exception('network'));

      expect(() => repository.searchUsers('abc'), throwsException);
    });
  });

  // ─────────────────────────────────────────────────────────────
  group('createKudos', () {
    test('delegates to datasource and returns kudos id', () async {
      when(
        () => mockDatasource.createKudos(
          recipientId: any(named: 'recipientId'),
          title: any(named: 'title'),
          message: any(named: 'message'),
          hashtagIds: any(named: 'hashtagIds'),
          imageUrls: any(named: 'imageUrls'),
          isAnonymous: any(named: 'isAnonymous'),
        ),
      ).thenAnswer((_) async => '42');

      final id = await repository.createKudos(
        recipientId: 1,
        title: 'HERO',
        message: 'Cảm ơn!',
        hashtagIds: [1, 2],
      );

      expect(id, '42');
    });

    test('passes all params to datasource', () async {
      when(
        () => mockDatasource.createKudos(
          recipientId: 5,
          title: 'LEGEND',
          message: 'Amazing!',
          hashtagIds: [3],
          imageUrls: ['https://example.com/img.jpg'],
          isAnonymous: true,
        ),
      ).thenAnswer((_) async => '99');

      await repository.createKudos(
        recipientId: 5,
        title: 'LEGEND',
        message: 'Amazing!',
        hashtagIds: [3],
        imageUrls: ['https://example.com/img.jpg'],
        isAnonymous: true,
      );

      verify(
        () => mockDatasource.createKudos(
          recipientId: 5,
          title: 'LEGEND',
          message: 'Amazing!',
          hashtagIds: [3],
          imageUrls: ['https://example.com/img.jpg'],
          isAnonymous: true,
        ),
      ).called(1);
    });

    test('throws friendly exception on datasource error', () async {
      when(
        () => mockDatasource.createKudos(
          recipientId: any(named: 'recipientId'),
          title: any(named: 'title'),
          message: any(named: 'message'),
          hashtagIds: any(named: 'hashtagIds'),
          imageUrls: any(named: 'imageUrls'),
          isAnonymous: any(named: 'isAnonymous'),
        ),
      ).thenThrow(Exception('DB error'));

      expect(
        () => repository.createKudos(
          recipientId: 1,
          title: 'T',
          message: 'M',
          hashtagIds: [1],
        ),
        throwsException,
      );
    });
  });

  // ─────────────────────────────────────────────────────────────
  group('uploadKudosImage', () {
    test('returns public URL from datasource', () async {
      when(
        () => mockDatasource.uploadKudosImageBytes(any(), any()),
      ).thenAnswer((_) async => 'https://storage.example.com/img.jpg');

      final url = await repository.uploadKudosImage(
        bytes: [1, 2, 3],
        ext: 'jpg',
      );

      expect(url, 'https://storage.example.com/img.jpg');
    });

    test('throws on datasource error', () {
      when(
        () => mockDatasource.uploadKudosImageBytes(any(), any()),
      ).thenThrow(Exception('storage error'));

      expect(
        () => repository.uploadKudosImage(bytes: [1, 2, 3], ext: 'jpg'),
        throwsException,
      );
    });
  });

  // ─────────────────────────────────────────────────────────────
  group('deleteKudosImage', () {
    test('delegates to datasource', () async {
      when(
        () => mockDatasource.deleteKudosImage(any()),
      ).thenAnswer((_) async {});

      await repository.deleteKudosImage('https://storage.example.com/img.jpg');

      verify(
        () => mockDatasource.deleteKudosImage(
          'https://storage.example.com/img.jpg',
        ),
      ).called(1);
    });

    test('throws on datasource error', () {
      when(
        () => mockDatasource.deleteKudosImage(any()),
      ).thenThrow(Exception('delete error'));

      expect(
        () => repository.deleteKudosImage('https://example.com/img.jpg'),
        throwsException,
      );
    });
  });

  // ─────────────────────────────────────────────────────────────
  group('send kudos draft sync', () {
    test('upsertSendKudosDraft delegates to datasource', () async {
      const draft = SendKudosState(
        recipientId: '1',
        recipientName: 'Nguyen A',
        title: 'HERO',
        message: 'Cam on ban',
      );
      when(
        () => mockDatasource.upsertSendKudosDraft(draft),
      ).thenAnswer((_) async {});

      await repository.upsertSendKudosDraft(draft);

      verify(() => mockDatasource.upsertSendKudosDraft(draft)).called(1);
    });

    test('deleteSendKudosDraft delegates to datasource', () async {
      when(
        () => mockDatasource.deleteSendKudosDraft(),
      ).thenAnswer((_) async {});

      await repository.deleteSendKudosDraft();

      verify(() => mockDatasource.deleteSendKudosDraft()).called(1);
    });
  });
}
