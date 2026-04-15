import 'package:freezed_annotation/freezed_annotation.dart';

part 'icon_badge.freezed.dart';
part 'icon_badge.g.dart';

@freezed
class IconBadge with _$IconBadge {
  const factory IconBadge({
    required int badgeId,
    required String badgeName,
    required String badgeImageUrl,
    DateTime? earnedAt,
  }) = _IconBadge;

  factory IconBadge.fromJson(Map<String, dynamic> json) =>
      _$IconBadgeFromJson(json);
}
