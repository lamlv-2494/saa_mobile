import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_summary.freezed.dart';
part 'user_summary.g.dart';

@freezed
class UserSummary with _$UserSummary {
  const factory UserSummary({
    required String id,
    required String name,
    @Default('') String avatar,
    @Default('') String department,
    @Default(0) int badgeLevel,
    @Default('') String heroTierUrl,
  }) = _UserSummary;

  factory UserSummary.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryFromJson(json);
}
