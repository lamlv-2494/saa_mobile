// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kudos_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KudosInfoImpl _$$KudosInfoImplFromJson(Map<String, dynamic> json) =>
    _$KudosInfoImpl(
      bannerImageUrl: json['banner_image_url'] as String? ?? '',
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      isEnabled: json['is_enabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$KudosInfoImplToJson(_$KudosInfoImpl instance) =>
    <String, dynamic>{
      'banner_image_url': instance.bannerImageUrl,
      'title': instance.title,
      'description': instance.description,
      'is_enabled': instance.isEnabled,
    };
