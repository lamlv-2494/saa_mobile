// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserSummary _$UserSummaryFromJson(Map<String, dynamic> json) {
  return _UserSummary.fromJson(json);
}

/// @nodoc
mixin _$UserSummary {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  int get badgeLevel => throw _privateConstructorUsedError;
  String get heroTierUrl => throw _privateConstructorUsedError;

  /// Serializes this UserSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSummaryCopyWith<UserSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSummaryCopyWith<$Res> {
  factory $UserSummaryCopyWith(
    UserSummary value,
    $Res Function(UserSummary) then,
  ) = _$UserSummaryCopyWithImpl<$Res, UserSummary>;
  @useResult
  $Res call({
    String id,
    String name,
    String avatar,
    String department,
    int badgeLevel,
    String heroTierUrl,
  });
}

/// @nodoc
class _$UserSummaryCopyWithImpl<$Res, $Val extends UserSummary>
    implements $UserSummaryCopyWith<$Res> {
  _$UserSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = null,
    Object? department = null,
    Object? badgeLevel = null,
    Object? heroTierUrl = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            avatar: null == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as String,
            department: null == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String,
            badgeLevel: null == badgeLevel
                ? _value.badgeLevel
                : badgeLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            heroTierUrl: null == heroTierUrl
                ? _value.heroTierUrl
                : heroTierUrl // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSummaryImplCopyWith<$Res>
    implements $UserSummaryCopyWith<$Res> {
  factory _$$UserSummaryImplCopyWith(
    _$UserSummaryImpl value,
    $Res Function(_$UserSummaryImpl) then,
  ) = __$$UserSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String avatar,
    String department,
    int badgeLevel,
    String heroTierUrl,
  });
}

/// @nodoc
class __$$UserSummaryImplCopyWithImpl<$Res>
    extends _$UserSummaryCopyWithImpl<$Res, _$UserSummaryImpl>
    implements _$$UserSummaryImplCopyWith<$Res> {
  __$$UserSummaryImplCopyWithImpl(
    _$UserSummaryImpl _value,
    $Res Function(_$UserSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = null,
    Object? department = null,
    Object? badgeLevel = null,
    Object? heroTierUrl = null,
  }) {
    return _then(
      _$UserSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        avatar: null == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as String,
        department: null == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String,
        badgeLevel: null == badgeLevel
            ? _value.badgeLevel
            : badgeLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        heroTierUrl: null == heroTierUrl
            ? _value.heroTierUrl
            : heroTierUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSummaryImpl implements _UserSummary {
  const _$UserSummaryImpl({
    required this.id,
    required this.name,
    this.avatar = '',
    this.department = '',
    this.badgeLevel = 0,
    this.heroTierUrl = '',
  });

  factory _$UserSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String avatar;
  @override
  @JsonKey()
  final String department;
  @override
  @JsonKey()
  final int badgeLevel;
  @override
  @JsonKey()
  final String heroTierUrl;

  @override
  String toString() {
    return 'UserSummary(id: $id, name: $name, avatar: $avatar, department: $department, badgeLevel: $badgeLevel, heroTierUrl: $heroTierUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.badgeLevel, badgeLevel) ||
                other.badgeLevel == badgeLevel) &&
            (identical(other.heroTierUrl, heroTierUrl) ||
                other.heroTierUrl == heroTierUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    avatar,
    department,
    badgeLevel,
    heroTierUrl,
  );

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSummaryImplCopyWith<_$UserSummaryImpl> get copyWith =>
      __$$UserSummaryImplCopyWithImpl<_$UserSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSummaryImplToJson(this);
  }
}

abstract class _UserSummary implements UserSummary {
  const factory _UserSummary({
    required final String id,
    required final String name,
    final String avatar,
    final String department,
    final int badgeLevel,
    final String heroTierUrl,
  }) = _$UserSummaryImpl;

  factory _UserSummary.fromJson(Map<String, dynamic> json) =
      _$UserSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get avatar;
  @override
  String get department;
  @override
  int get badgeLevel;
  @override
  String get heroTierUrl;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSummaryImplCopyWith<_$UserSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
