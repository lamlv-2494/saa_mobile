// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:saa_mobile/features/award/data/models/award_prize.dart';

part 'award_category.freezed.dart';
part 'award_category.g.dart';

@freezed
class AwardCategory with _$AwardCategory {
  const factory AwardCategory({
    required int id,
    required String name,
    @JsonKey(name: 'name_en') @Default('') String nameEn,
    @Default('') String slug,
    @JsonKey(name: 'image_url') @Default('') String imageUrl,
    @Default('') String description,
    @JsonKey(name: 'description_en') @Default('') String descriptionEn,
    @Default(0) int quantity,
    @Default('') String unit,
    @JsonKey(name: 'unit_en') @Default('') String unitEn,
    @JsonKey(name: 'prize_value') int? prizeValue,
    @JsonKey(name: 'prize_note') String? prizeNote,
    @JsonKey(name: 'prize_note_en') String? prizeNoteEn,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'award_prizes') @Default([]) List<AwardPrize> awardPrizes,
  }) = _AwardCategory;

  factory AwardCategory.fromJson(Map<String, dynamic> json) =>
      _$AwardCategoryFromJson(json);
}
