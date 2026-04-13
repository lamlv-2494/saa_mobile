import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_stats.freezed.dart';
part 'personal_stats.g.dart';

@freezed
class PersonalStats with _$PersonalStats {
  const factory PersonalStats({
    @Default(0) int kudosReceived,
    @Default(0) int kudosSent,
    @Default(0) int heartsReceived,
    @Default(0) int secretBoxesOpened,
    @Default(0) int secretBoxesUnopened,
    @Default(0) int starBadgeLevel,
    @Default(false) bool isBonusActive,
  }) = _PersonalStats;

  factory PersonalStats.fromJson(Map<String, dynamic> json) =>
      _$PersonalStatsFromJson(json);
}
