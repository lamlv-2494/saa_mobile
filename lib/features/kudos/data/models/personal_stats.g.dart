// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalStatsImpl _$$PersonalStatsImplFromJson(Map<String, dynamic> json) =>
    _$PersonalStatsImpl(
      kudosReceived: (json['kudosReceived'] as num?)?.toInt() ?? 0,
      kudosSent: (json['kudosSent'] as num?)?.toInt() ?? 0,
      heartsReceived: (json['heartsReceived'] as num?)?.toInt() ?? 0,
      secretBoxesOpened: (json['secretBoxesOpened'] as num?)?.toInt() ?? 0,
      secretBoxesUnopened: (json['secretBoxesUnopened'] as num?)?.toInt() ?? 0,
      starBadgeLevel: (json['starBadgeLevel'] as num?)?.toInt() ?? 0,
      isBonusActive: json['isBonusActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$PersonalStatsImplToJson(_$PersonalStatsImpl instance) =>
    <String, dynamic>{
      'kudosReceived': instance.kudosReceived,
      'kudosSent': instance.kudosSent,
      'heartsReceived': instance.heartsReceived,
      'secretBoxesOpened': instance.secretBoxesOpened,
      'secretBoxesUnopened': instance.secretBoxesUnopened,
      'starBadgeLevel': instance.starBadgeLevel,
      'isBonusActive': instance.isBonusActive,
    };
