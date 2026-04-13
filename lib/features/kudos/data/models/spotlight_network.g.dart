// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotlight_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpotlightNodeImpl _$$SpotlightNodeImplFromJson(Map<String, dynamic> json) =>
    _$SpotlightNodeImpl(
      userId: json['userId'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String? ?? '',
      x: (json['x'] as num?)?.toDouble() ?? 0.0,
      y: (json['y'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$SpotlightNodeImplToJson(_$SpotlightNodeImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'avatar': instance.avatar,
      'x': instance.x,
      'y': instance.y,
    };

_$SpotlightEdgeImpl _$$SpotlightEdgeImplFromJson(Map<String, dynamic> json) =>
    _$SpotlightEdgeImpl(
      fromUserId: json['fromUserId'] as String,
      toUserId: json['toUserId'] as String,
      weight: (json['weight'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$SpotlightEdgeImplToJson(_$SpotlightEdgeImpl instance) =>
    <String, dynamic>{
      'fromUserId': instance.fromUserId,
      'toUserId': instance.toUserId,
      'weight': instance.weight,
    };

_$SpotlightNetworkImpl _$$SpotlightNetworkImplFromJson(
  Map<String, dynamic> json,
) => _$SpotlightNetworkImpl(
  nodes:
      (json['nodes'] as List<dynamic>?)
          ?.map((e) => SpotlightNode.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  edges:
      (json['edges'] as List<dynamic>?)
          ?.map((e) => SpotlightEdge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  totalKudos: (json['totalKudos'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$SpotlightNetworkImplToJson(
  _$SpotlightNetworkImpl instance,
) => <String, dynamic>{
  'nodes': instance.nodes,
  'edges': instance.edges,
  'totalKudos': instance.totalKudos,
};
