import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge.freezed.dart';
part 'badge.g.dart';

@freezed
class Badge with _$Badge {
  const factory Badge({
    required int id,
    required String name,
    required String imageUrl,
    String? description,
  }) = _Badge;

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
}
