// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'award_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AwardCategoryImpl _$$AwardCategoryImplFromJson(Map<String, dynamic> json) =>
    _$AwardCategoryImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      nameEn: json['name_en'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      description: json['description'] as String? ?? '',
      descriptionEn: json['description_en'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unit: json['unit'] as String? ?? '',
      unitEn: json['unit_en'] as String? ?? '',
      prizeValue: (json['prize_value'] as num?)?.toInt(),
      prizeNote: json['prize_note'] as String?,
      prizeNoteEn: json['prize_note_en'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      awardPrizes:
          (json['award_prizes'] as List<dynamic>?)
              ?.map((e) => AwardPrize.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AwardCategoryImplToJson(_$AwardCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'slug': instance.slug,
      'image_url': instance.imageUrl,
      'description': instance.description,
      'description_en': instance.descriptionEn,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'unit_en': instance.unitEn,
      'prize_value': instance.prizeValue,
      'prize_note': instance.prizeNote,
      'prize_note_en': instance.prizeNoteEn,
      'sort_order': instance.sortOrder,
      'award_prizes': instance.awardPrizes,
    };
