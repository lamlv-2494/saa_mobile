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
  @JsonKey(name: 'name_en')
  String get nameEn => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_en')
  String get descriptionEn => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_en')
  String get unitEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'prize_value')
  int? get prizeValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'prize_note')
  String? get prizeNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'prize_note_en')
  String? get prizeNoteEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'award_prizes')
  List<AwardPrize> get awardPrizes => throw _privateConstructorUsedError;

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
    @JsonKey(name: 'name_en') String nameEn,
    String slug,
    @JsonKey(name: 'image_url') String imageUrl,
    String description,
    @JsonKey(name: 'description_en') String descriptionEn,
    int quantity,
    String unit,
    @JsonKey(name: 'unit_en') String unitEn,
    @JsonKey(name: 'prize_value') int? prizeValue,
    @JsonKey(name: 'prize_note') String? prizeNote,
    @JsonKey(name: 'prize_note_en') String? prizeNoteEn,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'award_prizes') List<AwardPrize> awardPrizes,
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
    Object? nameEn = null,
    Object? slug = null,
    Object? imageUrl = null,
    Object? description = null,
    Object? descriptionEn = null,
    Object? quantity = null,
    Object? unit = null,
    Object? unitEn = null,
    Object? prizeValue = freezed,
    Object? prizeNote = freezed,
    Object? prizeNoteEn = freezed,
    Object? sortOrder = null,
    Object? awardPrizes = null,
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
            nameEn: null == nameEn
                ? _value.nameEn
                : nameEn // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            descriptionEn: null == descriptionEn
                ? _value.descriptionEn
                : descriptionEn // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            unit: null == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String,
            unitEn: null == unitEn
                ? _value.unitEn
                : unitEn // ignore: cast_nullable_to_non_nullable
                      as String,
            prizeValue: freezed == prizeValue
                ? _value.prizeValue
                : prizeValue // ignore: cast_nullable_to_non_nullable
                      as int?,
            prizeNote: freezed == prizeNote
                ? _value.prizeNote
                : prizeNote // ignore: cast_nullable_to_non_nullable
                      as String?,
            prizeNoteEn: freezed == prizeNoteEn
                ? _value.prizeNoteEn
                : prizeNoteEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            awardPrizes: null == awardPrizes
                ? _value.awardPrizes
                : awardPrizes // ignore: cast_nullable_to_non_nullable
                      as List<AwardPrize>,
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
    @JsonKey(name: 'name_en') String nameEn,
    String slug,
    @JsonKey(name: 'image_url') String imageUrl,
    String description,
    @JsonKey(name: 'description_en') String descriptionEn,
    int quantity,
    String unit,
    @JsonKey(name: 'unit_en') String unitEn,
    @JsonKey(name: 'prize_value') int? prizeValue,
    @JsonKey(name: 'prize_note') String? prizeNote,
    @JsonKey(name: 'prize_note_en') String? prizeNoteEn,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'award_prizes') List<AwardPrize> awardPrizes,
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
    Object? nameEn = null,
    Object? slug = null,
    Object? imageUrl = null,
    Object? description = null,
    Object? descriptionEn = null,
    Object? quantity = null,
    Object? unit = null,
    Object? unitEn = null,
    Object? prizeValue = freezed,
    Object? prizeNote = freezed,
    Object? prizeNoteEn = freezed,
    Object? sortOrder = null,
    Object? awardPrizes = null,
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
        nameEn: null == nameEn
            ? _value.nameEn
            : nameEn // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        descriptionEn: null == descriptionEn
            ? _value.descriptionEn
            : descriptionEn // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        unit: null == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String,
        unitEn: null == unitEn
            ? _value.unitEn
            : unitEn // ignore: cast_nullable_to_non_nullable
                  as String,
        prizeValue: freezed == prizeValue
            ? _value.prizeValue
            : prizeValue // ignore: cast_nullable_to_non_nullable
                  as int?,
        prizeNote: freezed == prizeNote
            ? _value.prizeNote
            : prizeNote // ignore: cast_nullable_to_non_nullable
                  as String?,
        prizeNoteEn: freezed == prizeNoteEn
            ? _value.prizeNoteEn
            : prizeNoteEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        awardPrizes: null == awardPrizes
            ? _value._awardPrizes
            : awardPrizes // ignore: cast_nullable_to_non_nullable
                  as List<AwardPrize>,
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
    @JsonKey(name: 'name_en') this.nameEn = '',
    this.slug = '',
    @JsonKey(name: 'image_url') this.imageUrl = '',
    this.description = '',
    @JsonKey(name: 'description_en') this.descriptionEn = '',
    this.quantity = 0,
    this.unit = '',
    @JsonKey(name: 'unit_en') this.unitEn = '',
    @JsonKey(name: 'prize_value') this.prizeValue,
    @JsonKey(name: 'prize_note') this.prizeNote,
    @JsonKey(name: 'prize_note_en') this.prizeNoteEn,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'award_prizes')
    final List<AwardPrize> awardPrizes = const [],
  }) : _awardPrizes = awardPrizes;

  factory _$AwardCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AwardCategoryImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'name_en')
  final String nameEn;
  @override
  @JsonKey()
  final String slug;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'description_en')
  final String descriptionEn;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final String unit;
  @override
  @JsonKey(name: 'unit_en')
  final String unitEn;
  @override
  @JsonKey(name: 'prize_value')
  final int? prizeValue;
  @override
  @JsonKey(name: 'prize_note')
  final String? prizeNote;
  @override
  @JsonKey(name: 'prize_note_en')
  final String? prizeNoteEn;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  final List<AwardPrize> _awardPrizes;
  @override
  @JsonKey(name: 'award_prizes')
  List<AwardPrize> get awardPrizes {
    if (_awardPrizes is EqualUnmodifiableListView) return _awardPrizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_awardPrizes);
  }

  @override
  String toString() {
    return 'AwardCategory(id: $id, name: $name, nameEn: $nameEn, slug: $slug, imageUrl: $imageUrl, description: $description, descriptionEn: $descriptionEn, quantity: $quantity, unit: $unit, unitEn: $unitEn, prizeValue: $prizeValue, prizeNote: $prizeNote, prizeNoteEn: $prizeNoteEn, sortOrder: $sortOrder, awardPrizes: $awardPrizes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AwardCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.unitEn, unitEn) || other.unitEn == unitEn) &&
            (identical(other.prizeValue, prizeValue) ||
                other.prizeValue == prizeValue) &&
            (identical(other.prizeNote, prizeNote) ||
                other.prizeNote == prizeNote) &&
            (identical(other.prizeNoteEn, prizeNoteEn) ||
                other.prizeNoteEn == prizeNoteEn) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            const DeepCollectionEquality().equals(
              other._awardPrizes,
              _awardPrizes,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    nameEn,
    slug,
    imageUrl,
    description,
    descriptionEn,
    quantity,
    unit,
    unitEn,
    prizeValue,
    prizeNote,
    prizeNoteEn,
    sortOrder,
    const DeepCollectionEquality().hash(_awardPrizes),
  );

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
    @JsonKey(name: 'name_en') final String nameEn,
    final String slug,
    @JsonKey(name: 'image_url') final String imageUrl,
    final String description,
    @JsonKey(name: 'description_en') final String descriptionEn,
    final int quantity,
    final String unit,
    @JsonKey(name: 'unit_en') final String unitEn,
    @JsonKey(name: 'prize_value') final int? prizeValue,
    @JsonKey(name: 'prize_note') final String? prizeNote,
    @JsonKey(name: 'prize_note_en') final String? prizeNoteEn,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'award_prizes') final List<AwardPrize> awardPrizes,
  }) = _$AwardCategoryImpl;

  factory _AwardCategory.fromJson(Map<String, dynamic> json) =
      _$AwardCategoryImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'name_en')
  String get nameEn;
  @override
  String get slug;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  String get description;
  @override
  @JsonKey(name: 'description_en')
  String get descriptionEn;
  @override
  int get quantity;
  @override
  String get unit;
  @override
  @JsonKey(name: 'unit_en')
  String get unitEn;
  @override
  @JsonKey(name: 'prize_value')
  int? get prizeValue;
  @override
  @JsonKey(name: 'prize_note')
  String? get prizeNote;
  @override
  @JsonKey(name: 'prize_note_en')
  String? get prizeNoteEn;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'award_prizes')
  List<AwardPrize> get awardPrizes;

  /// Create a copy of AwardCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AwardCategoryImplCopyWith<_$AwardCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
