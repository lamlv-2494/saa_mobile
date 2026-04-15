import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/kudos/data/models/send_kudos_state.dart';

import '../../helpers/kudos_test_helpers.dart';

void main() {
  group('SendKudosState - default values', () {
    test('default state has expected empty/null values', () {
      const state = SendKudosState();

      expect(state.recipientId, isNull);
      expect(state.recipientName, isNull);
      expect(state.recipientAvatar, isNull);
      expect(state.title, '');
      expect(state.message, '');
      expect(state.hashtags, isEmpty);
      expect(state.imagePreviews, isEmpty);
      expect(state.isAnonymous, isFalse);
      expect(state.isSubmitting, isFalse);
      expect(state.isDirty, isFalse);
      expect(state.availableHashtags, isEmpty);
      expect(state.allUsers, isEmpty);
      expect(state.isLoadingUsers, isFalse);
      expect(state.senderAlias, isNull);
      expect(state.validationErrors, isEmpty);
      expect(state.showErrorBanner, isFalse);
      expect(state.shakeKey, 0);
    });
  });

  group('SendKudosState - copyWith', () {
    test('copyWith updates individual fields', () {
      const state = SendKudosState();
      final updated = state.copyWith(
        recipientId: 'user-1',
        recipientName: 'Nguyễn Văn A',
        title: 'HERO',
        message: 'Cảm ơn bạn!',
        isAnonymous: true,
        isDirty: true,
      );

      expect(updated.recipientId, 'user-1');
      expect(updated.recipientName, 'Nguyễn Văn A');
      expect(updated.title, 'HERO');
      expect(updated.message, 'Cảm ơn bạn!');
      expect(updated.isAnonymous, isTrue);
      expect(updated.isDirty, isTrue);
      // unchanged fields
      expect(updated.isSubmitting, isFalse);
      expect(updated.hashtags, isEmpty);
    });

    test('copyWith updates hashtags list', () {
      const state = SendKudosState();
      final tags = [createHashtag(id: 1, name: '#teamwork')];
      final updated = state.copyWith(hashtags: tags);

      expect(updated.hashtags.length, 1);
      expect(updated.hashtags.first.name, '#teamwork');
    });

    test('copyWith updates validationErrors map', () {
      const state = SendKudosState();
      final updated = state.copyWith(
        validationErrors: {'recipient': 'Required', 'title': 'Required'},
      );

      expect(updated.validationErrors['recipient'], 'Required');
      expect(updated.validationErrors['title'], 'Required');
    });
  });

  group('SendKudosState - isFormValid', () {
    test('isFormValid is false when required fields are empty', () {
      const state = SendKudosState();
      expect(state.isFormValid, isFalse);
    });

    test('isFormValid is true when all required fields are filled', () {
      final state = SendKudosState(
        recipientId: 'user-1',
        title: 'HERO',
        message: 'Cảm ơn!',
        hashtags: [createHashtag(id: 1, name: '#teamwork')],
      );
      expect(state.isFormValid, isTrue);
    });

    test('isFormValid is false when only recipient is missing', () {
      final state = SendKudosState(
        title: 'HERO',
        message: 'Cảm ơn!',
        hashtags: [createHashtag(id: 1, name: '#teamwork')],
      );
      expect(state.isFormValid, isFalse);
    });

    test('isFormValid is false when hashtags is empty', () {
      const state = SendKudosState(
        recipientId: 'user-1',
        title: 'HERO',
        message: 'Cảm ơn!',
      );
      expect(state.isFormValid, isFalse);
    });

    test('isFormValid is false when title is empty', () {
      final state = SendKudosState(
        recipientId: 'user-1',
        message: 'Cảm ơn!',
        hashtags: [createHashtag(id: 1, name: '#teamwork')],
      );
      expect(state.isFormValid, isFalse);
    });

    test('isFormValid is false when message is empty', () {
      final state = SendKudosState(
        recipientId: 'user-1',
        title: 'HERO',
        hashtags: [createHashtag(id: 1, name: '#teamwork')],
      );
      expect(state.isFormValid, isFalse);
    });
  });
}
