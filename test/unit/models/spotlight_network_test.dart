import 'package:flutter_test/flutter_test.dart';
import 'package:saa_mobile/features/kudos/data/models/spotlight_network.dart';

void main() {
  group('SpotlightNetwork', () {
    test('fromJson tạo đúng object', () {
      final json = {
        'nodes': [
          {'userId': 'u1', 'name': 'A', 'avatar': '', 'x': 10.0, 'y': 20.0},
        ],
        'edges': [
          {'fromUserId': 'u1', 'toUserId': 'u2', 'weight': 3},
        ],
        'totalKudos': 388,
      };
      final network = SpotlightNetwork.fromJson(json);
      expect(network.totalKudos, 388);
      expect(network.nodes.length, 1);
      expect(network.edges.first.weight, 3);
    });

    test('default empty', () {
      const network = SpotlightNetwork();
      expect(network.nodes, isEmpty);
      expect(network.edges, isEmpty);
      expect(network.totalKudos, 0);
    });
  });

  group('SpotlightNode', () {
    test('fromJson', () {
      final json = {
        'userId': 'u1',
        'name': 'User A',
        'avatar': '',
        'x': 100.5,
        'y': 200.3,
      };
      final node = SpotlightNode.fromJson(json);
      expect(node.userId, 'u1');
      expect(node.x, 100.5);
    });
  });

  group('SpotlightEdge', () {
    test('default weight = 1', () {
      const edge = SpotlightEdge(fromUserId: 'u1', toUserId: 'u2');
      expect(edge.weight, 1);
    });
  });
}
