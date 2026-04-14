// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kudos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KudosImpl _$$KudosImplFromJson(Map<String, dynamic> json) => _$KudosImpl(
  id: json['id'] as String,
  sender: UserSummary.fromJson(json['sender'] as Map<String, dynamic>),
  receiver: UserSummary.fromJson(json['receiver'] as Map<String, dynamic>),
  content: json['content'] as String,
  hashtags:
      (json['hashtags'] as List<dynamic>?)
          ?.map((e) => Hashtag.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  heartCount: (json['heartCount'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  isHighlight: json['isHighlight'] as bool? ?? false,
  isAnonymous: json['isAnonymous'] as bool? ?? false,
  isLikedByMe: json['isLikedByMe'] as bool? ?? false,
  canLike: json['canLike'] as bool? ?? true,
  shareUrl: json['shareUrl'] as String? ?? '',
  awardTitle: json['awardTitle'] as String?,
  imageUrls:
      (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$KudosImplToJson(_$KudosImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'content': instance.content,
      'hashtags': instance.hashtags,
      'heartCount': instance.heartCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'isHighlight': instance.isHighlight,
      'isAnonymous': instance.isAnonymous,
      'isLikedByMe': instance.isLikedByMe,
      'canLike': instance.canLike,
      'shareUrl': instance.shareUrl,
      'awardTitle': instance.awardTitle,
      'imageUrls': instance.imageUrls,
    };
