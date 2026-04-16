// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSummaryImpl _$$UserSummaryImplFromJson(Map<String, dynamic> json) =>
    _$UserSummaryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String? ?? '',
      department: json['department'] as String? ?? '',
      badgeLevel: (json['badgeLevel'] as num?)?.toInt() ?? 0,
      heroTier: json['heroTier'] as String? ?? 'none',
    );

Map<String, dynamic> _$$UserSummaryImplToJson(_$UserSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'department': instance.department,
      'badgeLevel': instance.badgeLevel,
      'heroTier': instance.heroTier,
    };
