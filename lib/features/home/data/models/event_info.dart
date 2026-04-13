// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_info.freezed.dart';
part 'event_info.g.dart';

@freezed
class EventInfo with _$EventInfo {
  const factory EventInfo({
    @JsonKey(name: 'theme_name') required String themeName,
    @JsonKey(name: 'event_date') required DateTime eventDate,
    required String venue,
    @JsonKey(name: 'livestream_note') @Default('') String livestreamNote,
    @JsonKey(name: 'theme_description') @Default('') String themeDescription,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _EventInfo;

  factory EventInfo.fromJson(Map<String, dynamic> json) =>
      _$EventInfoFromJson(json);
}
