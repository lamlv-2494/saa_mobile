// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_recipient_ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GiftRecipientRankingImpl _$$GiftRecipientRankingImplFromJson(
  Map<String, dynamic> json,
) => _$GiftRecipientRankingImpl(
  rank: (json['rank'] as num).toInt(),
  user: UserSummary.fromJson(json['user'] as Map<String, dynamic>),
  giftCount: (json['giftCount'] as num?)?.toInt() ?? 0,
  rewardName: json['rewardName'] as String? ?? '',
);

Map<String, dynamic> _$$GiftRecipientRankingImplToJson(
  _$GiftRecipientRankingImpl instance,
) => <String, dynamic>{
  'rank': instance.rank,
  'user': instance.user,
  'giftCount': instance.giftCount,
  'rewardName': instance.rewardName,
};
