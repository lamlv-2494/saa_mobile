// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'icon_badge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IconBadge _$IconBadgeFromJson(Map<String, dynamic> json) {
  return _IconBadge.fromJson(json);
}

/// @nodoc
mixin _$IconBadge {
  int get badgeId => throw _privateConstructorUsedError;
  String get badgeName => throw _privateConstructorUsedError;
  String get badgeImageUrl => throw _privateConstructorUsedError;
  DateTime? get earnedAt => throw _privateConstructorUsedError;

  /// Serializes this IconBadge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IconBadge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IconBadgeCopyWith<IconBadge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IconBadgeCopyWith<$Res> {
  factory $IconBadgeCopyWith(IconBadge value, $Res Function(IconBadge) then) =
      _$IconBadgeCopyWithImpl<$Res, IconBadge>;
  @useResult
  $Res call({
    int badgeId,
    String badgeName,
    String badgeImageUrl,
    DateTime? earnedAt,
  });
}

/// @nodoc
class _$IconBadgeCopyWithImpl<$Res, $Val extends IconBadge>
    implements $IconBadgeCopyWith<$Res> {
  _$IconBadgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IconBadge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? badgeId = null,
    Object? badgeName = null,
    Object? badgeImageUrl = null,
    Object? earnedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            badgeId: null == badgeId
                ? _value.badgeId
                : badgeId // ignore: cast_nullable_to_non_nullable
                      as int,
            badgeName: null == badgeName
                ? _value.badgeName
                : badgeName // ignore: cast_nullable_to_non_nullable
                      as String,
            badgeImageUrl: null == badgeImageUrl
                ? _value.badgeImageUrl
                : badgeImageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            earnedAt: freezed == earnedAt
                ? _value.earnedAt
                : earnedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IconBadgeImplCopyWith<$Res>
    implements $IconBadgeCopyWith<$Res> {
  factory _$$IconBadgeImplCopyWith(
    _$IconBadgeImpl value,
    $Res Function(_$IconBadgeImpl) then,
  ) = __$$IconBadgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int badgeId,
    String badgeName,
    String badgeImageUrl,
    DateTime? earnedAt,
  });
}

/// @nodoc
class __$$IconBadgeImplCopyWithImpl<$Res>
    extends _$IconBadgeCopyWithImpl<$Res, _$IconBadgeImpl>
    implements _$$IconBadgeImplCopyWith<$Res> {
  __$$IconBadgeImplCopyWithImpl(
    _$IconBadgeImpl _value,
    $Res Function(_$IconBadgeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IconBadge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? badgeId = null,
    Object? badgeName = null,
    Object? badgeImageUrl = null,
    Object? earnedAt = freezed,
  }) {
    return _then(
      _$IconBadgeImpl(
        badgeId: null == badgeId
            ? _value.badgeId
            : badgeId // ignore: cast_nullable_to_non_nullable
                  as int,
        badgeName: null == badgeName
            ? _value.badgeName
            : badgeName // ignore: cast_nullable_to_non_nullable
                  as String,
        badgeImageUrl: null == badgeImageUrl
            ? _value.badgeImageUrl
            : badgeImageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        earnedAt: freezed == earnedAt
            ? _value.earnedAt
            : earnedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IconBadgeImpl implements _IconBadge {
  const _$IconBadgeImpl({
    required this.badgeId,
    required this.badgeName,
    required this.badgeImageUrl,
    this.earnedAt,
  });

  factory _$IconBadgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$IconBadgeImplFromJson(json);

  @override
  final int badgeId;
  @override
  final String badgeName;
  @override
  final String badgeImageUrl;
  @override
  final DateTime? earnedAt;

  @override
  String toString() {
    return 'IconBadge(badgeId: $badgeId, badgeName: $badgeName, badgeImageUrl: $badgeImageUrl, earnedAt: $earnedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IconBadgeImpl &&
            (identical(other.badgeId, badgeId) || other.badgeId == badgeId) &&
            (identical(other.badgeName, badgeName) ||
                other.badgeName == badgeName) &&
            (identical(other.badgeImageUrl, badgeImageUrl) ||
                other.badgeImageUrl == badgeImageUrl) &&
            (identical(other.earnedAt, earnedAt) ||
                other.earnedAt == earnedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, badgeId, badgeName, badgeImageUrl, earnedAt);

  /// Create a copy of IconBadge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IconBadgeImplCopyWith<_$IconBadgeImpl> get copyWith =>
      __$$IconBadgeImplCopyWithImpl<_$IconBadgeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IconBadgeImplToJson(this);
  }
}

abstract class _IconBadge implements IconBadge {
  const factory _IconBadge({
    required final int badgeId,
    required final String badgeName,
    required final String badgeImageUrl,
    final DateTime? earnedAt,
  }) = _$IconBadgeImpl;

  factory _IconBadge.fromJson(Map<String, dynamic> json) =
      _$IconBadgeImpl.fromJson;

  @override
  int get badgeId;
  @override
  String get badgeName;
  @override
  String get badgeImageUrl;
  @override
  DateTime? get earnedAt;

  /// Create a copy of IconBadge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IconBadgeImplCopyWith<_$IconBadgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
