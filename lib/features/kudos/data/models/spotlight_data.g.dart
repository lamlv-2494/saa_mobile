// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotlight_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpotlightEntryImpl _$$SpotlightEntryImplFromJson(Map<String, dynamic> json) =>
    _$SpotlightEntryImpl(
      userId: json['userId'] as String,
      name: json['name'] as String,
      x: (json['x'] as num?)?.toDouble() ?? 0.0,
      y: (json['y'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$SpotlightEntryImplToJson(
  _$SpotlightEntryImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'name': instance.name,
  'x': instance.x,
  'y': instance.y,
};

_$SpotlightActivityImpl _$$SpotlightActivityImplFromJson(
  Map<String, dynamic> json,
) => _$SpotlightActivityImpl(
  timestamp: json['timestamp'] as String,
  receiverName: json['receiverName'] as String,
);

Map<String, dynamic> _$$SpotlightActivityImplToJson(
  _$SpotlightActivityImpl instance,
) => <String, dynamic>{
  'timestamp': instance.timestamp,
  'receiverName': instance.receiverName,
};

_$SpotlightDataImpl _$$SpotlightDataImplFromJson(Map<String, dynamic> json) =>
    _$SpotlightDataImpl(
      entries:
          (json['entries'] as List<dynamic>?)
              ?.map((e) => SpotlightEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalKudos: (json['totalKudos'] as num?)?.toInt() ?? 0,
      recentActivity:
          (json['recentActivity'] as List<dynamic>?)
              ?.map(
                (e) => SpotlightActivity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SpotlightDataImplToJson(_$SpotlightDataImpl instance) =>
    <String, dynamic>{
      'entries': instance.entries,
      'totalKudos': instance.totalKudos,
      'recentActivity': instance.recentActivity,
    };
