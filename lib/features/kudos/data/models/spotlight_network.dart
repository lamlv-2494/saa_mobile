import 'package:freezed_annotation/freezed_annotation.dart';

part 'spotlight_network.freezed.dart';
part 'spotlight_network.g.dart';

@freezed
class SpotlightNode with _$SpotlightNode {
  const factory SpotlightNode({
    required String userId,
    required String name,
    @Default('') String avatar,
    @Default(0.0) double x,
    @Default(0.0) double y,
  }) = _SpotlightNode;

  factory SpotlightNode.fromJson(Map<String, dynamic> json) =>
      _$SpotlightNodeFromJson(json);
}

@freezed
class SpotlightEdge with _$SpotlightEdge {
  const factory SpotlightEdge({
    required String fromUserId,
    required String toUserId,
    @Default(1) int weight,
  }) = _SpotlightEdge;

  factory SpotlightEdge.fromJson(Map<String, dynamic> json) =>
      _$SpotlightEdgeFromJson(json);
}

@freezed
class SpotlightNetwork with _$SpotlightNetwork {
  const factory SpotlightNetwork({
    @Default([]) List<SpotlightNode> nodes,
    @Default([]) List<SpotlightEdge> edges,
    @Default(0) int totalKudos,
  }) = _SpotlightNetwork;

  factory SpotlightNetwork.fromJson(Map<String, dynamic> json) =>
      _$SpotlightNetworkFromJson(json);
}
