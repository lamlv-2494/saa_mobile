import 'package:flutter_test/flutter_test.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';

import '../../../test/helpers/kudos_test_helpers.dart';

void main() {
  group('Kudos', () {
    test('factory tạo đúng object với embedded UserSummary', () {
      final kudos = createKudos();
      expect(kudos.id, 'kudos-1');
      expect(kudos.sender.name, 'Người gửi');
      expect(kudos.receiver.name, 'Người nhận');
      expect(kudos.hashtags.length, 1);
      expect(kudos.heartCount, 10);
    });

    test('default values', () {
      final kudos = createKudos();
      expect(kudos.isHighlight, false);
      expect(kudos.isAnonymous, false);
      expect(kudos.isLikedByMe, false);
      expect(kudos.canLike, true);
    });

    test('toJson produces valid map', () {
      final kudos = createKudos();
      final json = kudos.toJson();
      expect(json['id'], 'kudos-1');
      expect(json['content'], 'Cảm ơn bạn đã hỗ trợ project!');
      expect(json['heartCount'], 10);
      // sender is a UserSummary object in toJson (not deep-serialized by default)
      expect(json.containsKey('sender'), true);
    });

    test('fromJson with raw map', () {
      final json = {
        'id': 'k1',
        'sender': {'id': 's1', 'name': 'Sender', 'avatar': '', 'department': '', 'badgeLevel': 0},
        'receiver': {'id': 'r1', 'name': 'Receiver', 'avatar': '', 'department': '', 'badgeLevel': 0},
        'content': 'Hello',
        'hashtags': <Map<String, dynamic>>[],
        'heartCount': 5,
        'createdAt': '2025-11-15T00:00:00.000',
        'isHighlight': false,
        'isAnonymous': false,
        'isLikedByMe': false,
        'canLike': true,
        'shareUrl': '',
      };
      final kudos = Kudos.fromJson(json);
      expect(kudos.id, 'k1');
      expect(kudos.sender.name, 'Sender');
      expect(kudos.heartCount, 5);
    });

    test('copyWith heartCount (optimistic update)', () {
      final kudos = createKudos(heartCount: 10, isLikedByMe: false);
      final liked = kudos.copyWith(heartCount: 11, isLikedByMe: true);
      expect(liked.heartCount, 11);
      expect(liked.isLikedByMe, true);
    });
  });
}
