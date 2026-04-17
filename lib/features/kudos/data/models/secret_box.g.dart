// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret_box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecretBoxImpl _$$SecretBoxImplFromJson(Map<String, dynamic> json) =>
    _$SecretBoxImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      isOpened: json['isOpened'] as bool? ?? false,
      openedAt: json['openedAt'] == null
          ? null
          : DateTime.parse(json['openedAt'] as String),
      rewardType: json['rewardType'] as String?,
      rewardValue: json['rewardValue'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SecretBoxImplToJson(_$SecretBoxImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'isOpened': instance.isOpened,
      'openedAt': instance.openedAt?.toIso8601String(),
      'rewardType': instance.rewardType,
      'rewardValue': instance.rewardValue,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
