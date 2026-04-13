// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'award_category.freezed.dart';
part 'award_category.g.dart';

@freezed
class AwardCategory with _$AwardCategory {
  const factory AwardCategory({
    required int id,
    required String name,
    @JsonKey(name: 'image_url') @Default('') String imageUrl,
    @Default('') String description,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
  }) = _AwardCategory;

  factory AwardCategory.fromJson(Map<String, dynamic> json) =>
      _$AwardCategoryFromJson(json);
}
