// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EventInfo _$EventInfoFromJson(Map<String, dynamic> json) {
  return _EventInfo.fromJson(json);
}

/// @nodoc
mixin _$EventInfo {
  @JsonKey(name: 'theme_name')
  String get themeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_date')
  DateTime get eventDate => throw _privateConstructorUsedError;
  String get venue => throw _privateConstructorUsedError;
  @JsonKey(name: 'livestream_note')
  String get livestreamNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'theme_description')
  String get themeDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this EventInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventInfoCopyWith<EventInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventInfoCopyWith<$Res> {
  factory $EventInfoCopyWith(EventInfo value, $Res Function(EventInfo) then) =
      _$EventInfoCopyWithImpl<$Res, EventInfo>;
  @useResult
  $Res call({
    @JsonKey(name: 'theme_name') String themeName,
    @JsonKey(name: 'event_date') DateTime eventDate,
    String venue,
    @JsonKey(name: 'livestream_note') String livestreamNote,
    @JsonKey(name: 'theme_description') String themeDescription,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$EventInfoCopyWithImpl<$Res, $Val extends EventInfo>
    implements $EventInfoCopyWith<$Res> {
  _$EventInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeName = null,
    Object? eventDate = null,
    Object? venue = null,
    Object? livestreamNote = null,
    Object? themeDescription = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            themeName: null == themeName
                ? _value.themeName
                : themeName // ignore: cast_nullable_to_non_nullable
                      as String,
            eventDate: null == eventDate
                ? _value.eventDate
                : eventDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            venue: null == venue
                ? _value.venue
                : venue // ignore: cast_nullable_to_non_nullable
                      as String,
            livestreamNote: null == livestreamNote
                ? _value.livestreamNote
                : livestreamNote // ignore: cast_nullable_to_non_nullable
                      as String,
            themeDescription: null == themeDescription
                ? _value.themeDescription
                : themeDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EventInfoImplCopyWith<$Res>
    implements $EventInfoCopyWith<$Res> {
  factory _$$EventInfoImplCopyWith(
    _$EventInfoImpl value,
    $Res Function(_$EventInfoImpl) then,
  ) = __$$EventInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'theme_name') String themeName,
    @JsonKey(name: 'event_date') DateTime eventDate,
    String venue,
    @JsonKey(name: 'livestream_note') String livestreamNote,
    @JsonKey(name: 'theme_description') String themeDescription,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$EventInfoImplCopyWithImpl<$Res>
    extends _$EventInfoCopyWithImpl<$Res, _$EventInfoImpl>
    implements _$$EventInfoImplCopyWith<$Res> {
  __$$EventInfoImplCopyWithImpl(
    _$EventInfoImpl _value,
    $Res Function(_$EventInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EventInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeName = null,
    Object? eventDate = null,
    Object? venue = null,
    Object? livestreamNote = null,
    Object? themeDescription = null,
    Object? isActive = null,
  }) {
    return _then(
      _$EventInfoImpl(
        themeName: null == themeName
            ? _value.themeName
            : themeName // ignore: cast_nullable_to_non_nullable
                  as String,
        eventDate: null == eventDate
            ? _value.eventDate
            : eventDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        venue: null == venue
            ? _value.venue
            : venue // ignore: cast_nullable_to_non_nullable
                  as String,
        livestreamNote: null == livestreamNote
            ? _value.livestreamNote
            : livestreamNote // ignore: cast_nullable_to_non_nullable
                  as String,
        themeDescription: null == themeDescription
            ? _value.themeDescription
            : themeDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EventInfoImpl implements _EventInfo {
  const _$EventInfoImpl({
    @JsonKey(name: 'theme_name') required this.themeName,
    @JsonKey(name: 'event_date') required this.eventDate,
    required this.venue,
    @JsonKey(name: 'livestream_note') this.livestreamNote = '',
    @JsonKey(name: 'theme_description') this.themeDescription = '',
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$EventInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventInfoImplFromJson(json);

  @override
  @JsonKey(name: 'theme_name')
  final String themeName;
  @override
  @JsonKey(name: 'event_date')
  final DateTime eventDate;
  @override
  final String venue;
  @override
  @JsonKey(name: 'livestream_note')
  final String livestreamNote;
  @override
  @JsonKey(name: 'theme_description')
  final String themeDescription;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'EventInfo(themeName: $themeName, eventDate: $eventDate, venue: $venue, livestreamNote: $livestreamNote, themeDescription: $themeDescription, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventInfoImpl &&
            (identical(other.themeName, themeName) ||
                other.themeName == themeName) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.livestreamNote, livestreamNote) ||
                other.livestreamNote == livestreamNote) &&
            (identical(other.themeDescription, themeDescription) ||
                other.themeDescription == themeDescription) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    themeName,
    eventDate,
    venue,
    livestreamNote,
    themeDescription,
    isActive,
  );

  /// Create a copy of EventInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventInfoImplCopyWith<_$EventInfoImpl> get copyWith =>
      __$$EventInfoImplCopyWithImpl<_$EventInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventInfoImplToJson(this);
  }
}

abstract class _EventInfo implements EventInfo {
  const factory _EventInfo({
    @JsonKey(name: 'theme_name') required final String themeName,
    @JsonKey(name: 'event_date') required final DateTime eventDate,
    required final String venue,
    @JsonKey(name: 'livestream_note') final String livestreamNote,
    @JsonKey(name: 'theme_description') final String themeDescription,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$EventInfoImpl;

  factory _EventInfo.fromJson(Map<String, dynamic> json) =
      _$EventInfoImpl.fromJson;

  @override
  @JsonKey(name: 'theme_name')
  String get themeName;
  @override
  @JsonKey(name: 'event_date')
  DateTime get eventDate;
  @override
  String get venue;
  @override
  @JsonKey(name: 'livestream_note')
  String get livestreamNote;
  @override
  @JsonKey(name: 'theme_description')
  String get themeDescription;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of EventInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventInfoImplCopyWith<_$EventInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
