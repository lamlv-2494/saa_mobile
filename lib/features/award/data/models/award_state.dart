import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:saa_mobile/features/home/data/models/award_category.dart';

part 'award_state.freezed.dart';

@freezed
class AwardState with _$AwardState {
  const AwardState._();

  const factory AwardState({
    @Default([]) List<AwardCategory> categories,
    @Default(0) int selectedIndex,
  }) = _AwardState;

  AwardCategory? get selectedCategory =>
      categories.isNotEmpty ? categories[selectedIndex] : null;
}
