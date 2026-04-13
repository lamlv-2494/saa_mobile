import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';

part 'kudos.freezed.dart';
part 'kudos.g.dart';

@freezed
class Kudos with _$Kudos {
  const factory Kudos({
    required String id,
    required UserSummary sender,
    required UserSummary receiver,
    required String content,
    @Default([]) List<Hashtag> hashtags,
    @Default(0) int heartCount,
    required DateTime createdAt,
    @Default(false) bool isHighlight,
    @Default(false) bool isAnonymous,
    @Default(false) bool isLikedByMe,
    @Default(true) bool canLike,
    @Default('') String shareUrl,
  }) = _Kudos;

  factory Kudos.fromJson(Map<String, dynamic> json) => _$KudosFromJson(json);
}
