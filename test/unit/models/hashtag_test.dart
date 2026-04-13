import 'package:flutter_test/flutter_test.dart';
import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';

void main() {
  group('Hashtag', () {
    test('fromJson tạo đúng object', () {
      final json = {'id': 1, 'name': '#teamwork'};
      final hashtag = Hashtag.fromJson(json);
      expect(hashtag.id, 1);
      expect(hashtag.name, '#teamwork');
    });

    test('toJson roundtrip', () {
      const hashtag = Hashtag(id: 1, name: '#teamwork');
      final restored = Hashtag.fromJson(hashtag.toJson());
      expect(restored, hashtag);
    });
  });
}
