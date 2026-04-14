// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'award_prize.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AwardPrizeImpl _$$AwardPrizeImplFromJson(Map<String, dynamic> json) =>
    _$AwardPrizeImpl(
      id: (json['id'] as num).toInt(),
      awardCategoryId: (json['award_category_id'] as num).toInt(),
      prizeType: json['prize_type'] as String,
      valueAmount: (json['value_amount'] as num).toInt(),
      noteVi: json['note_vi'] as String,
      noteEn: json['note_en'] as String,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AwardPrizeImplToJson(_$AwardPrizeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'award_category_id': instance.awardCategoryId,
      'prize_type': instance.prizeType,
      'value_amount': instance.valueAmount,
      'note_vi': instance.noteVi,
      'note_en': instance.noteEn,
      'sort_order': instance.sortOrder,
    };
