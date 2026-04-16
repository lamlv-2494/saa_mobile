// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_badge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IconBadgeImpl _$$IconBadgeImplFromJson(Map<String, dynamic> json) =>
    _$IconBadgeImpl(
      badgeId: (json['badgeId'] as num).toInt(),
      badgeName: json['badgeName'] as String,
      badgeImageUrl: json['badgeImageUrl'] as String,
      earnedAt: json['earnedAt'] == null
          ? null
          : DateTime.parse(json['earnedAt'] as String),
    );

Map<String, dynamic> _$$IconBadgeImplToJson(_$IconBadgeImpl instance) =>
    <String, dynamic>{
      'badgeId': instance.badgeId,
      'badgeName': instance.badgeName,
      'badgeImageUrl': instance.badgeImageUrl,
      'earnedAt': instance.earnedAt?.toIso8601String(),
    };
