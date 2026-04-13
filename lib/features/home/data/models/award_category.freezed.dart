// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'award_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AwardCategory _$AwardCategoryFromJson(Map<String, dynamic> json) {
  return _AwardCategory.fromJson(json);
}

/// @nodoc
mixin _$AwardCategory {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this AwardCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AwardCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AwardCategoryCopyWith<AwardCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AwardCategoryCopyWith<$Res> {
  factory $AwardCategoryCopyWith(
    AwardCategory value,
    $Res Function(AwardCategory) then,
  ) = _$AwardCategoryCopyWithImpl<$Res, AwardCategory>;
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'image_url') String imageUrl,
    String description,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class _$AwardCategoryCopyWithImpl<$Res, $Val extends AwardCategory>
    implements $AwardCategoryCopyWith<$Res> {
  _$AwardCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AwardCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? description = null,
    Object? sortOrder = null,
  }) {
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
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AwardCategoryImplCopyWith<$Res>
    implements $AwardCategoryCopyWith<$Res> {
  factory _$$AwardCategoryImplCopyWith(
    _$AwardCategoryImpl value,
    $Res Function(_$AwardCategoryImpl) then,
  ) = __$$AwardCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'image_url') String imageUrl,
    String description,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class __$$AwardCategoryImplCopyWithImpl<$Res>
    extends _$AwardCategoryCopyWithImpl<$Res, _$AwardCategoryImpl>
    implements _$$AwardCategoryImplCopyWith<$Res> {
  __$$AwardCategoryImplCopyWithImpl(
    _$AwardCategoryImpl _value,
    $Res Function(_$AwardCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AwardCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? description = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$AwardCategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AwardCategoryImpl implements _AwardCategory {
  const _$AwardCategoryImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'image_url') this.imageUrl = '',
    this.description = '',
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
  });

  factory _$AwardCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AwardCategoryImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @override
  String toString() {
    return 'AwardCategory(id: $id, name: $name, imageUrl: $imageUrl, description: $description, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AwardCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, imageUrl, description, sortOrder);

  /// Create a copy of AwardCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AwardCategoryImplCopyWith<_$AwardCategoryImpl> get copyWith =>
      __$$AwardCategoryImplCopyWithImpl<_$AwardCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AwardCategoryImplToJson(this);
  }
}

abstract class _AwardCategory implements AwardCategory {
  const factory _AwardCategory({
    required final int id,
    required final String name,
    @JsonKey(name: 'image_url') final String imageUrl,
    final String description,
    @JsonKey(name: 'sort_order') final int sortOrder,
  }) = _$AwardCategoryImpl;

  factory _AwardCategory.fromJson(Map<String, dynamic> json) =
      _$AwardCategoryImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  String get description;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;

  /// Create a copy of AwardCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AwardCategoryImplCopyWith<_$AwardCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
