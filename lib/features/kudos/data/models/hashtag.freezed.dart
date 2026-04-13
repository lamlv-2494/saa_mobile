// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hashtag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Hashtag _$HashtagFromJson(Map<String, dynamic> json) {
  return _Hashtag.fromJson(json);
}

/// @nodoc
mixin _$Hashtag {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this Hashtag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Hashtag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HashtagCopyWith<Hashtag> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HashtagCopyWith<$Res> {
  factory $HashtagCopyWith(Hashtag value, $Res Function(Hashtag) then) =
      _$HashtagCopyWithImpl<$Res, Hashtag>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$HashtagCopyWithImpl<$Res, $Val extends Hashtag>
    implements $HashtagCopyWith<$Res> {
  _$HashtagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Hashtag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HashtagImplCopyWith<$Res> implements $HashtagCopyWith<$Res> {
  factory _$$HashtagImplCopyWith(
    _$HashtagImpl value,
    $Res Function(_$HashtagImpl) then,
  ) = __$$HashtagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$HashtagImplCopyWithImpl<$Res>
    extends _$HashtagCopyWithImpl<$Res, _$HashtagImpl>
    implements _$$HashtagImplCopyWith<$Res> {
  __$$HashtagImplCopyWithImpl(
    _$HashtagImpl _value,
    $Res Function(_$HashtagImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Hashtag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$HashtagImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HashtagImpl implements _Hashtag {
  const _$HashtagImpl({required this.id, required this.name});

  factory _$HashtagImpl.fromJson(Map<String, dynamic> json) =>
      _$$HashtagImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'Hashtag(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HashtagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of Hashtag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HashtagImplCopyWith<_$HashtagImpl> get copyWith =>
      __$$HashtagImplCopyWithImpl<_$HashtagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HashtagImplToJson(this);
  }
}

abstract class _Hashtag implements Hashtag {
  const factory _Hashtag({required final int id, required final String name}) =
      _$HashtagImpl;

  factory _Hashtag.fromJson(Map<String, dynamic> json) = _$HashtagImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of Hashtag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HashtagImplCopyWith<_$HashtagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
