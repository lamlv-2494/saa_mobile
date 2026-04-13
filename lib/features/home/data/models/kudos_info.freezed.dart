// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kudos_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

KudosInfo _$KudosInfoFromJson(Map<String, dynamic> json) {
  return _KudosInfo.fromJson(json);
}

/// @nodoc
mixin _$KudosInfo {
  @JsonKey(name: 'banner_image_url')
  String get bannerImageUrl => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_enabled')
  bool get isEnabled => throw _privateConstructorUsedError;

  /// Serializes this KudosInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KudosInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KudosInfoCopyWith<KudosInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KudosInfoCopyWith<$Res> {
  factory $KudosInfoCopyWith(KudosInfo value, $Res Function(KudosInfo) then) =
      _$KudosInfoCopyWithImpl<$Res, KudosInfo>;
  @useResult
  $Res call({
    @JsonKey(name: 'banner_image_url') String bannerImageUrl,
    String title,
    String description,
    @JsonKey(name: 'is_enabled') bool isEnabled,
  });
}

/// @nodoc
class _$KudosInfoCopyWithImpl<$Res, $Val extends KudosInfo>
    implements $KudosInfoCopyWith<$Res> {
  _$KudosInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KudosInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bannerImageUrl = null,
    Object? title = null,
    Object? description = null,
    Object? isEnabled = null,
  }) {
    return _then(
      _value.copyWith(
            bannerImageUrl: null == bannerImageUrl
                ? _value.bannerImageUrl
                : bannerImageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            isEnabled: null == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KudosInfoImplCopyWith<$Res>
    implements $KudosInfoCopyWith<$Res> {
  factory _$$KudosInfoImplCopyWith(
    _$KudosInfoImpl value,
    $Res Function(_$KudosInfoImpl) then,
  ) = __$$KudosInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'banner_image_url') String bannerImageUrl,
    String title,
    String description,
    @JsonKey(name: 'is_enabled') bool isEnabled,
  });
}

/// @nodoc
class __$$KudosInfoImplCopyWithImpl<$Res>
    extends _$KudosInfoCopyWithImpl<$Res, _$KudosInfoImpl>
    implements _$$KudosInfoImplCopyWith<$Res> {
  __$$KudosInfoImplCopyWithImpl(
    _$KudosInfoImpl _value,
    $Res Function(_$KudosInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KudosInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bannerImageUrl = null,
    Object? title = null,
    Object? description = null,
    Object? isEnabled = null,
  }) {
    return _then(
      _$KudosInfoImpl(
        bannerImageUrl: null == bannerImageUrl
            ? _value.bannerImageUrl
            : bannerImageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        isEnabled: null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KudosInfoImpl implements _KudosInfo {
  const _$KudosInfoImpl({
    @JsonKey(name: 'banner_image_url') this.bannerImageUrl = '',
    required this.title,
    this.description = '',
    @JsonKey(name: 'is_enabled') this.isEnabled = true,
  });

  factory _$KudosInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$KudosInfoImplFromJson(json);

  @override
  @JsonKey(name: 'banner_image_url')
  final String bannerImageUrl;
  @override
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'is_enabled')
  final bool isEnabled;

  @override
  String toString() {
    return 'KudosInfo(bannerImageUrl: $bannerImageUrl, title: $title, description: $description, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KudosInfoImpl &&
            (identical(other.bannerImageUrl, bannerImageUrl) ||
                other.bannerImageUrl == bannerImageUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bannerImageUrl, title, description, isEnabled);

  /// Create a copy of KudosInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KudosInfoImplCopyWith<_$KudosInfoImpl> get copyWith =>
      __$$KudosInfoImplCopyWithImpl<_$KudosInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KudosInfoImplToJson(this);
  }
}

abstract class _KudosInfo implements KudosInfo {
  const factory _KudosInfo({
    @JsonKey(name: 'banner_image_url') final String bannerImageUrl,
    required final String title,
    final String description,
    @JsonKey(name: 'is_enabled') final bool isEnabled,
  }) = _$KudosInfoImpl;

  factory _KudosInfo.fromJson(Map<String, dynamic> json) =
      _$KudosInfoImpl.fromJson;

  @override
  @JsonKey(name: 'banner_image_url')
  String get bannerImageUrl;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'is_enabled')
  bool get isEnabled;

  /// Create a copy of KudosInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KudosInfoImplCopyWith<_$KudosInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
