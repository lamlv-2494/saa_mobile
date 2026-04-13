// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'award_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AwardCategoryImpl _$$AwardCategoryImplFromJson(Map<String, dynamic> json) =>
    _$AwardCategoryImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['image_url'] as String? ?? '',
      description: json['description'] as String? ?? '',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AwardCategoryImplToJson(_$AwardCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'description': instance.description,
      'sort_order': instance.sortOrder,
    };
