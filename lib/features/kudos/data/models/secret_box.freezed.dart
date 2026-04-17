// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'secret_box.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SecretBox _$SecretBoxFromJson(Map<String, dynamic> json) {
  return _SecretBox.fromJson(json);
}

/// @nodoc
mixin _$SecretBox {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  bool get isOpened => throw _privateConstructorUsedError;
  DateTime? get openedAt => throw _privateConstructorUsedError;
  String? get rewardType => throw _privateConstructorUsedError;
  String? get rewardValue => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SecretBox to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SecretBox
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecretBoxCopyWith<SecretBox> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecretBoxCopyWith<$Res> {
  factory $SecretBoxCopyWith(SecretBox value, $Res Function(SecretBox) then) =
      _$SecretBoxCopyWithImpl<$Res, SecretBox>;
  @useResult
  $Res call({
    String id,
    String userId,
    bool isOpened,
    DateTime? openedAt,
    String? rewardType,
    String? rewardValue,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$SecretBoxCopyWithImpl<$Res, $Val extends SecretBox>
    implements $SecretBoxCopyWith<$Res> {
  _$SecretBoxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecretBox
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? isOpened = null,
    Object? openedAt = freezed,
    Object? rewardType = freezed,
    Object? rewardValue = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            isOpened: null == isOpened
                ? _value.isOpened
                : isOpened // ignore: cast_nullable_to_non_nullable
                      as bool,
            openedAt: freezed == openedAt
                ? _value.openedAt
                : openedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            rewardType: freezed == rewardType
                ? _value.rewardType
                : rewardType // ignore: cast_nullable_to_non_nullable
                      as String?,
            rewardValue: freezed == rewardValue
                ? _value.rewardValue
                : rewardValue // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SecretBoxImplCopyWith<$Res>
    implements $SecretBoxCopyWith<$Res> {
  factory _$$SecretBoxImplCopyWith(
    _$SecretBoxImpl value,
    $Res Function(_$SecretBoxImpl) then,
  ) = __$$SecretBoxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    bool isOpened,
    DateTime? openedAt,
    String? rewardType,
    String? rewardValue,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$SecretBoxImplCopyWithImpl<$Res>
    extends _$SecretBoxCopyWithImpl<$Res, _$SecretBoxImpl>
    implements _$$SecretBoxImplCopyWith<$Res> {
  __$$SecretBoxImplCopyWithImpl(
    _$SecretBoxImpl _value,
    $Res Function(_$SecretBoxImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SecretBox
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? isOpened = null,
    Object? openedAt = freezed,
    Object? rewardType = freezed,
    Object? rewardValue = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$SecretBoxImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        isOpened: null == isOpened
            ? _value.isOpened
            : isOpened // ignore: cast_nullable_to_non_nullable
                  as bool,
        openedAt: freezed == openedAt
            ? _value.openedAt
            : openedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        rewardType: freezed == rewardType
            ? _value.rewardType
            : rewardType // ignore: cast_nullable_to_non_nullable
                  as String?,
        rewardValue: freezed == rewardValue
            ? _value.rewardValue
            : rewardValue // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SecretBoxImpl implements _SecretBox {
  const _$SecretBoxImpl({
    required this.id,
    required this.userId,
    this.isOpened = false,
    this.openedAt,
    this.rewardType,
    this.rewardValue,
    this.createdAt,
  });

  factory _$SecretBoxImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecretBoxImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  @JsonKey()
  final bool isOpened;
  @override
  final DateTime? openedAt;
  @override
  final String? rewardType;
  @override
  final String? rewardValue;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'SecretBox(id: $id, userId: $userId, isOpened: $isOpened, openedAt: $openedAt, rewardType: $rewardType, rewardValue: $rewardValue, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecretBoxImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isOpened, isOpened) ||
                other.isOpened == isOpened) &&
            (identical(other.openedAt, openedAt) ||
                other.openedAt == openedAt) &&
            (identical(other.rewardType, rewardType) ||
                other.rewardType == rewardType) &&
            (identical(other.rewardValue, rewardValue) ||
                other.rewardValue == rewardValue) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    isOpened,
    openedAt,
    rewardType,
    rewardValue,
    createdAt,
  );

  /// Create a copy of SecretBox
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecretBoxImplCopyWith<_$SecretBoxImpl> get copyWith =>
      __$$SecretBoxImplCopyWithImpl<_$SecretBoxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecretBoxImplToJson(this);
  }
}

abstract class _SecretBox implements SecretBox {
  const factory _SecretBox({
    required final String id,
    required final String userId,
    final bool isOpened,
    final DateTime? openedAt,
    final String? rewardType,
    final String? rewardValue,
    final DateTime? createdAt,
  }) = _$SecretBoxImpl;

  factory _SecretBox.fromJson(Map<String, dynamic> json) =
      _$SecretBoxImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  bool get isOpened;
  @override
  DateTime? get openedAt;
  @override
  String? get rewardType;
  @override
  String? get rewardValue;
  @override
  DateTime? get createdAt;

  /// Create a copy of SecretBox
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecretBoxImplCopyWith<_$SecretBoxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
