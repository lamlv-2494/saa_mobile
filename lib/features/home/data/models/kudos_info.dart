// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kudos_info.freezed.dart';
part 'kudos_info.g.dart';

@freezed
class KudosInfo with _$KudosInfo {
  const factory KudosInfo({
    @JsonKey(name: 'banner_image_url') @Default('') String bannerImageUrl,
    required String title,
    @Default('') String description,
    @JsonKey(name: 'is_enabled') @Default(true) bool isEnabled,
  }) = _KudosInfo;

  factory KudosInfo.fromJson(Map<String, dynamic> json) =>
      _$KudosInfoFromJson(json);
}
