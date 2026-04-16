import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:saa_mobile/features/kudos/data/models/send_kudos_state.dart';
import 'package:saa_mobile/features/kudos/data/repositories/kudos_repository.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart';

import '../../helpers/kudos_test_helpers.dart';

class MockKudosRepository extends Mock implements KudosRepository {}

ProviderContainer makeContainer(MockKudosRepository repo) {
  return ProviderContainer(
    overrides: [kudosRepositoryProvider.overrideWithValue(repo)],
  );
}

void main() {
  late MockKudosRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(const SendKudosState());
  });

  setUp(() {
    mockRepo = MockKudosRepository();
    when(
      () => mockRepo.getHashtags(),
    ).thenAnswer((_) async => [createHashtag(id: 1, name: '#teamwork')]);
    when(
      () => mockRepo.fetchAllUsers(),
    ).thenAnswer((_) async => [createUserSummary(id: 'u1', name: 'User 1')]);
    when(() => mockRepo.upsertSendKudosDraft(any())).thenAnswer((_) async {});
    when(() => mockRepo.deleteSendKudosDraft()).thenAnswer((_) async {});
    when(() => mockRepo.getCurrentUserId()).thenAnswer((_) async => '99');
  });

  // ─────────────────────────────────────────────────────────────
  group('SendKudosViewModel.build', () {
    test('loads available hashtags on build', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);

      final state = await container.read(sendKudosViewModelProvider.future);

      expect(state.availableHashtags, hasLength(1));
      expect(state.availableHashtags.first.name, '#teamwork');
    });

    test('state starts with empty form fields', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);

      final state = await container.read(sendKudosViewModelProvider.future);

      expect(state.recipientId, isNull);
      expect(state.title, '');
      expect(state.message, '');
      expect(state.isSubmitting, isFalse);
      expect(state.isDirty, isFalse);
    });
  });

  // ─────────────────────────────────────────────────────────────
  group('SendKudosViewModel — field updates', () {
    test('selectRecipient sets recipient fields and isDirty', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.selectRecipient(
        id: 'u1',
        name: 'Nguyễn A',
        avatar: 'https://a.com/img.jpg',
      );

      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.recipientId, 'u1');
      expect(state.recipientName, 'Nguyễn A');
      expect(state.isDirty, isTrue);
    });

    test('clearRecipient resets recipient fields', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.selectRecipient(id: 'u1', name: 'A', avatar: '');
      vm.clearRecipient();

      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.recipientId, isNull);
      expect(state.recipientName, isNull);
    });

    test('updateTitle updates title and sets isDirty', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.updateTitle('HERO');

      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.title, 'HERO');
      expect(state.isDirty, isTrue);
    });

    test('updateMessage updates message and sets isDirty', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.updateMessage('Cảm ơn bạn!');

      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.message, 'Cảm ơn bạn!');
      expect(state.isDirty, isTrue);
    });

    test('toggleHashtag adds hashtag when not present', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      final tag = createHashtag(id: 1, name: '#teamwork');
      vm.toggleHashtag(tag);

      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.hashtags.length, 1);
      expect(state.isDirty, isTrue);
    });

    test('toggleHashtag removes hashtag when already present', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      final tag = createHashtag(id: 1, name: '#teamwork');
      vm.toggleHashtag(tag);
      vm.toggleHashtag(tag); // remove

      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.hashtags, isEmpty);
    });

    test('toggleHashtag does not add more than 5 hashtags', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      for (var i = 1; i <= 6; i++) {
        vm.toggleHashtag(createHashtag(id: i, name: '#tag$i'));
      }

      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.hashtags.length, 5);
    });

    test('toggleAnonymous flips isAnonymous flag', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.toggleAnonymous();

      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.isAnonymous, isTrue);
    });

    test('field update syncs draft to repository', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.updateTitle('HERO');
      await Future<void>.delayed(const Duration(milliseconds: 500));

      verify(() => mockRepo.upsertSendKudosDraft(any())).called(1);
    });
  });

  // ─────────────────────────────────────────────────────────────
  group('SendKudosViewModel — validation', () {
    test(
      'validate returns false and sets errors when required fields empty',
      () async {
        final container = makeContainer(mockRepo);
        addTearDown(container.dispose);
        await container.read(sendKudosViewModelProvider.future);

        final vm = container.read(sendKudosViewModelProvider.notifier);
        final valid = vm.validate();

        expect(valid, isFalse);
        final state = container.read(sendKudosViewModelProvider).value!;
        expect(state.validationErrors.containsKey('recipient'), isTrue);
        expect(state.validationErrors.containsKey('title'), isTrue);
        expect(state.validationErrors.containsKey('message'), isTrue);
        expect(state.validationErrors.containsKey('hashtag'), isTrue);
        expect(state.showErrorBanner, isTrue);
      },
    );

    test('validate fails when title is whitespace only', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.selectRecipient(id: 'u1', name: 'A', avatar: '');
      vm.updateTitle('   ');
      vm.updateMessage('Cảm ơn!');
      vm.toggleHashtag(createHashtag(id: 1, name: '#teamwork'));

      final valid = vm.validate();

      expect(valid, isFalse);
      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.validationErrors.containsKey('title'), isTrue);
    });

    test('validate fails when message is whitespace only', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.selectRecipient(id: 'u1', name: 'A', avatar: '');
      vm.updateTitle('HERO');
      vm.updateMessage('   ');
      vm.toggleHashtag(createHashtag(id: 1, name: '#teamwork'));

      final valid = vm.validate();

      expect(valid, isFalse);
      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.validationErrors.containsKey('message'), isTrue);
    });

    test('validate returns true when all fields are valid', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.selectRecipient(id: 'u1', name: 'A', avatar: '');
      vm.updateTitle('HERO');
      vm.updateMessage('Cảm ơn!');
      vm.toggleHashtag(createHashtag(id: 1, name: '#teamwork'));

      final valid = vm.validate();

      expect(valid, isTrue);
      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.validationErrors, isEmpty);
    });
  });

  // ─────────────────────────────────────────────────────────────
  group('SendKudosViewModel — submit', () {
    test('submit creates kudos and returns kudos id on success', () async {
      when(
        () => mockRepo.createKudos(
          recipientId: any(named: 'recipientId'),
          title: any(named: 'title'),
          message: any(named: 'message'),
          hashtagIds: any(named: 'hashtagIds'),
          imageUrls: any(named: 'imageUrls'),
          isAnonymous: any(named: 'isAnonymous'),
        ),
      ).thenAnswer((_) async => '42');

      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.selectRecipient(id: '1', name: 'A', avatar: '');
      vm.updateTitle('HERO');
      vm.updateMessage('Cảm ơn!');
      vm.toggleHashtag(createHashtag(id: 1, name: '#teamwork'));

      final result = await vm.submit();

      expect(result, '42');
      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.isSubmitting, isFalse);
    });

    test('submit returns null when form is invalid', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);

      final result = await vm.submit();

      expect(result, isNull);
      verifyNever(
        () => mockRepo.createKudos(
          recipientId: any(named: 'recipientId'),
          title: any(named: 'title'),
          message: any(named: 'message'),
          hashtagIds: any(named: 'hashtagIds'),
          imageUrls: any(named: 'imageUrls'),
          isAnonymous: any(named: 'isAnonymous'),
        ),
      );
    });

    test('submit sets isSubmitting=false and returns null on error', () async {
      when(
        () => mockRepo.createKudos(
          recipientId: any(named: 'recipientId'),
          title: any(named: 'title'),
          message: any(named: 'message'),
          hashtagIds: any(named: 'hashtagIds'),
          imageUrls: any(named: 'imageUrls'),
          isAnonymous: any(named: 'isAnonymous'),
        ),
      ).thenThrow(Exception('DB error'));

      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.selectRecipient(id: '1', name: 'A', avatar: '');
      vm.updateTitle('HERO');
      vm.updateMessage('Cảm ơn!');
      vm.toggleHashtag(createHashtag(id: 1, name: '#teamwork'));

      final result = await vm.submit();

      expect(result, isNull);
      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.isSubmitting, isFalse);
    });
  });

  // ─────────────────────────────────────────────────────────────
  group('SendKudosViewModel — images', () {
    test('addImage does not add more than 5 images', () async {
      when(
        () => mockRepo.uploadKudosImage(
          bytes: any(named: 'bytes'),
          ext: any(named: 'ext'),
        ),
      ).thenAnswer((inv) async => 'https://img.com/${inv.positionalArguments.hashCode}.jpg');

      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      for (var i = 0; i < 6; i++) {
        when(
          () => mockRepo.uploadKudosImage(
            bytes: any(named: 'bytes'),
            ext: any(named: 'ext'),
          ),
        ).thenAnswer((_) async => 'https://img.com/$i.jpg');
        await vm.addImage(bytes: [1, 2, 3], ext: 'jpg');
      }

      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.imagePreviews.length, 5);
    });
  });

  // ─────────────────────────────────────────────────────────────
  group('SendKudosViewModel — allUsers (pre-loaded)', () {
    test('build() pre-loads allUsers from fetchAllUsers', () async {
      final users = [createUserSummary(id: 'u1', name: 'A')];
      when(() => mockRepo.fetchAllUsers()).thenAnswer((_) async => users);

      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);

      final state = await container.read(sendKudosViewModelProvider.future);

      expect(state.allUsers, hasLength(1));
      expect(state.allUsers.first.name, 'A');
    });

    test('build() handles fetchAllUsers failure gracefully', () async {
      when(() => mockRepo.fetchAllUsers()).thenThrow(Exception('error'));

      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);

      final state = await container.read(sendKudosViewModelProvider.future);

      expect(state.allUsers, isEmpty);
    });
  });

  // ─────────────────────────────────────────────────────────────
  group('SendKudosViewModel — senderAlias', () {
    test('updateSenderAlias sets senderAlias', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.updateSenderAlias('Anh Hùng Xạ Điêu');

      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.senderAlias, 'Anh Hùng Xạ Điêu');
      expect(state.isDirty, isTrue);
    });

    test('toggleAnonymous off clears senderAlias', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.toggleAnonymous(); // ON
      vm.updateSenderAlias('Nickname');
      vm.toggleAnonymous(); // OFF → should clear alias

      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.isAnonymous, isFalse);
      expect(state.senderAlias, isNull);
    });
  });

  // ─────────────────────────────────────────────────────────────
  // ─────────────────────────────────────────────────────────────
  group('SendKudosViewModel — self-send validation', () {
    test('validate fails with recipient_self_send when recipientId == currentUserId', () async {
      when(() => mockRepo.getCurrentUserId()).thenAnswer((_) async => '42');

      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.selectRecipient(id: '42', name: 'Myself', avatar: '');
      vm.updateTitle('HERO');
      vm.updateMessage('Cảm ơn!');
      vm.toggleHashtag(createHashtag(id: 1, name: '#teamwork'));

      final valid = vm.validate();

      expect(valid, isFalse);
      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.validationErrors['recipient'], 'recipient_self_send');
    });

    test('validate passes when recipientId != currentUserId', () async {
      when(() => mockRepo.getCurrentUserId()).thenAnswer((_) async => '99');

      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.selectRecipient(id: '42', name: 'Other User', avatar: '');
      vm.updateTitle('HERO');
      vm.updateMessage('Cảm ơn!');
      vm.toggleHashtag(createHashtag(id: 1, name: '#teamwork'));

      final valid = vm.validate();

      expect(valid, isTrue);
    });
  });

  // ─────────────────────────────────────────────────────────────
  group('SendKudosViewModel — shakeKey & error banner dismiss', () {
    test('validate increments shakeKey on failure', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.validate();
      final s1 = container.read(sendKudosViewModelProvider).value!;
      expect(s1.shakeKey, 1);

      vm.validate();
      final s2 = container.read(sendKudosViewModelProvider).value!;
      expect(s2.shakeKey, 2);
    });

    test('validate does not increment shakeKey on success', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.selectRecipient(id: 'u1', name: 'A', avatar: '');
      vm.updateTitle('HERO');
      vm.updateMessage('Cảm ơn!');
      vm.toggleHashtag(createHashtag(id: 1, name: '#teamwork'));

      vm.validate();
      final state = container.read(sendKudosViewModelProvider).value!;
      expect(state.shakeKey, 0);
    });

    test('updating field dismisses error banner when showing', () async {
      final container = makeContainer(mockRepo);
      addTearDown(container.dispose);
      await container.read(sendKudosViewModelProvider.future);

      final vm = container.read(sendKudosViewModelProvider.notifier);
      vm.validate(); // triggers showErrorBanner = true
      expect(
        container.read(sendKudosViewModelProvider).value!.showErrorBanner,
        isTrue,
      );

      vm.updateTitle('test');
      expect(
        container.read(sendKudosViewModelProvider).value!.showErrorBanner,
        isFalse,
      );
    });
  });
}
