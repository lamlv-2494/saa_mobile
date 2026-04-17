import 'package:freezed_annotation/freezed_annotation.dart';

part 'spotlight_data.freezed.dart';
part 'spotlight_data.g.dart';

@freezed
class SpotlightEntry with _$SpotlightEntry {
  const factory SpotlightEntry({
    required String userId,
    required String name,
    @Default(0.0) double x,
    @Default(0.0) double y,
  }) = _SpotlightEntry;

  factory SpotlightEntry.fromJson(Map<String, dynamic> json) =>
      _$SpotlightEntryFromJson(json);
}

@freezed
class SpotlightActivity with _$SpotlightActivity {
  const factory SpotlightActivity({
    required String timestamp,
    required String receiverName,
  }) = _SpotlightActivity;

  factory SpotlightActivity.fromJson(Map<String, dynamic> json) =>
      _$SpotlightActivityFromJson(json);
}

@freezed
class SpotlightData with _$SpotlightData {
  const factory SpotlightData({
    @Default([]) List<SpotlightEntry> entries,
    @Default(0) int totalKudos,
    @Default([]) List<SpotlightActivity> recentActivity,
  }) = _SpotlightData;

  factory SpotlightData.fromJson(Map<String, dynamic> json) =>
      _$SpotlightDataFromJson(json);
}
