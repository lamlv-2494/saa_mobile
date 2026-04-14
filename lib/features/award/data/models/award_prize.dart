// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'award_prize.freezed.dart';
part 'award_prize.g.dart';

@freezed
class AwardPrize with _$AwardPrize {
  const factory AwardPrize({
    required int id,
    @JsonKey(name: 'award_category_id') required int awardCategoryId,
    @JsonKey(name: 'prize_type') required String prizeType,
    @JsonKey(name: 'value_amount') required int valueAmount,
    @JsonKey(name: 'note_vi') required String noteVi,
    @JsonKey(name: 'note_en') required String noteEn,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
  }) = _AwardPrize;

  factory AwardPrize.fromJson(Map<String, dynamic> json) =>
      _$AwardPrizeFromJson(json);
}
