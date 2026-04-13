import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';

part 'gift_recipient_ranking.freezed.dart';
part 'gift_recipient_ranking.g.dart';

@freezed
class GiftRecipientRanking with _$GiftRecipientRanking {
  const factory GiftRecipientRanking({
    required int rank,
    required UserSummary user,
    @Default(0) int giftCount,
    @Default('') String rewardName,
  }) = _GiftRecipientRanking;

  factory GiftRecipientRanking.fromJson(Map<String, dynamic> json) =>
      _$GiftRecipientRankingFromJson(json);
}
