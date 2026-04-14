import 'package:flutter_test/flutter_test.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos_state.dart';

import '../../../test/helpers/kudos_test_helpers.dart';

void main() {
  group('KudosState', () {
    test('default values', () {
      const state = KudosState();
      expect(state.highlightKudos, isEmpty);
      expect(state.allKudos, isEmpty);
      expect(state.personalStats, isNull);
      expect(state.topGiftRecipients, isEmpty);
      expect(state.spotlightData, isNull);
      expect(state.selectedHashtag, isNull);
      expect(state.selectedDepartment, isNull);
      expect(state.currentHighlightPage, 0);
      expect(state.hasMoreKudos, true);
      expect(state.availableHashtags, isEmpty);
      expect(state.availableDepartments, isEmpty);
    });

    test('copyWith cập nhật đúng field', () {
      final state = createKudosState();
      final updated = state.copyWith(currentHighlightPage: 3);
      expect(updated.currentHighlightPage, 3);
      expect(updated.highlightKudos.length, state.highlightKudos.length);
    });

    test('copyWith selectedHashtag', () {
      final state = createKudosState();
      final hashtag = createHashtag(id: 5, name: '#innovation');
      final updated = state.copyWith(selectedHashtag: hashtag);
      expect(updated.selectedHashtag?.name, '#innovation');
    });
  });
}
