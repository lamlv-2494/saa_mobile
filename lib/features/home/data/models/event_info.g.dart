// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventInfoImpl _$$EventInfoImplFromJson(Map<String, dynamic> json) =>
    _$EventInfoImpl(
      themeName: json['theme_name'] as String,
      eventDate: DateTime.parse(json['event_date'] as String),
      venue: json['venue'] as String,
      livestreamNote: json['livestream_note'] as String? ?? '',
      themeDescription: json['theme_description'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$EventInfoImplToJson(_$EventInfoImpl instance) =>
    <String, dynamic>{
      'theme_name': instance.themeName,
      'event_date': instance.eventDate.toIso8601String(),
      'venue': instance.venue,
      'livestream_note': instance.livestreamNote,
      'theme_description': instance.themeDescription,
      'is_active': instance.isActive,
    };
