// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'award_prize.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AwardPrize _$AwardPrizeFromJson(Map<String, dynamic> json) {
  return _AwardPrize.fromJson(json);
}

/// @nodoc
mixin _$AwardPrize {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'award_category_id')
  int get awardCategoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'prize_type')
  String get prizeType => throw _privateConstructorUsedError;
  @JsonKey(name: 'value_amount')
  int get valueAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'note_vi')
  String get noteVi => throw _privateConstructorUsedError;
  @JsonKey(name: 'note_en')
  String get noteEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this AwardPrize to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AwardPrize
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AwardPrizeCopyWith<AwardPrize> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AwardPrizeCopyWith<$Res> {
  factory $AwardPrizeCopyWith(
    AwardPrize value,
    $Res Function(AwardPrize) then,
  ) = _$AwardPrizeCopyWithImpl<$Res, AwardPrize>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'award_category_id') int awardCategoryId,
    @JsonKey(name: 'prize_type') String prizeType,
    @JsonKey(name: 'value_amount') int valueAmount,
    @JsonKey(name: 'note_vi') String noteVi,
    @JsonKey(name: 'note_en') String noteEn,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class _$AwardPrizeCopyWithImpl<$Res, $Val extends AwardPrize>
    implements $AwardPrizeCopyWith<$Res> {
  _$AwardPrizeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AwardPrize
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? awardCategoryId = null,
    Object? prizeType = null,
    Object? valueAmount = null,
    Object? noteVi = null,
    Object? noteEn = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            awardCategoryId: null == awardCategoryId
                ? _value.awardCategoryId
                : awardCategoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            prizeType: null == prizeType
                ? _value.prizeType
                : prizeType // ignore: cast_nullable_to_non_nullable
                      as String,
            valueAmount: null == valueAmount
                ? _value.valueAmount
                : valueAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            noteVi: null == noteVi
                ? _value.noteVi
                : noteVi // ignore: cast_nullable_to_non_nullable
                      as String,
            noteEn: null == noteEn
                ? _value.noteEn
                : noteEn // ignore: cast_nullable_to_non_nullable
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
abstract class _$$AwardPrizeImplCopyWith<$Res>
    implements $AwardPrizeCopyWith<$Res> {
  factory _$$AwardPrizeImplCopyWith(
    _$AwardPrizeImpl value,
    $Res Function(_$AwardPrizeImpl) then,
  ) = __$$AwardPrizeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'award_category_id') int awardCategoryId,
    @JsonKey(name: 'prize_type') String prizeType,
    @JsonKey(name: 'value_amount') int valueAmount,
    @JsonKey(name: 'note_vi') String noteVi,
    @JsonKey(name: 'note_en') String noteEn,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class __$$AwardPrizeImplCopyWithImpl<$Res>
    extends _$AwardPrizeCopyWithImpl<$Res, _$AwardPrizeImpl>
    implements _$$AwardPrizeImplCopyWith<$Res> {
  __$$AwardPrizeImplCopyWithImpl(
    _$AwardPrizeImpl _value,
    $Res Function(_$AwardPrizeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AwardPrize
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? awardCategoryId = null,
    Object? prizeType = null,
    Object? valueAmount = null,
    Object? noteVi = null,
    Object? noteEn = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$AwardPrizeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        awardCategoryId: null == awardCategoryId
            ? _value.awardCategoryId
            : awardCategoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        prizeType: null == prizeType
            ? _value.prizeType
            : prizeType // ignore: cast_nullable_to_non_nullable
                  as String,
        valueAmount: null == valueAmount
            ? _value.valueAmount
            : valueAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        noteVi: null == noteVi
            ? _value.noteVi
            : noteVi // ignore: cast_nullable_to_non_nullable
                  as String,
        noteEn: null == noteEn
            ? _value.noteEn
            : noteEn // ignore: cast_nullable_to_non_nullable
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
class _$AwardPrizeImpl implements _AwardPrize {
  const _$AwardPrizeImpl({
    required this.id,
    @JsonKey(name: 'award_category_id') required this.awardCategoryId,
    @JsonKey(name: 'prize_type') required this.prizeType,
    @JsonKey(name: 'value_amount') required this.valueAmount,
    @JsonKey(name: 'note_vi') required this.noteVi,
    @JsonKey(name: 'note_en') required this.noteEn,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
  });

  factory _$AwardPrizeImpl.fromJson(Map<String, dynamic> json) =>
      _$$AwardPrizeImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'award_category_id')
  final int awardCategoryId;
  @override
  @JsonKey(name: 'prize_type')
  final String prizeType;
  @override
  @JsonKey(name: 'value_amount')
  final int valueAmount;
  @override
  @JsonKey(name: 'note_vi')
  final String noteVi;
  @override
  @JsonKey(name: 'note_en')
  final String noteEn;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @override
  String toString() {
    return 'AwardPrize(id: $id, awardCategoryId: $awardCategoryId, prizeType: $prizeType, valueAmount: $valueAmount, noteVi: $noteVi, noteEn: $noteEn, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AwardPrizeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.awardCategoryId, awardCategoryId) ||
                other.awardCategoryId == awardCategoryId) &&
            (identical(other.prizeType, prizeType) ||
                other.prizeType == prizeType) &&
            (identical(other.valueAmount, valueAmount) ||
                other.valueAmount == valueAmount) &&
            (identical(other.noteVi, noteVi) || other.noteVi == noteVi) &&
            (identical(other.noteEn, noteEn) || other.noteEn == noteEn) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    awardCategoryId,
    prizeType,
    valueAmount,
    noteVi,
    noteEn,
    sortOrder,
  );

  /// Create a copy of AwardPrize
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AwardPrizeImplCopyWith<_$AwardPrizeImpl> get copyWith =>
      __$$AwardPrizeImplCopyWithImpl<_$AwardPrizeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AwardPrizeImplToJson(this);
  }
}

abstract class _AwardPrize implements AwardPrize {
  const factory _AwardPrize({
    required final int id,
    @JsonKey(name: 'award_category_id') required final int awardCategoryId,
    @JsonKey(name: 'prize_type') required final String prizeType,
    @JsonKey(name: 'value_amount') required final int valueAmount,
    @JsonKey(name: 'note_vi') required final String noteVi,
    @JsonKey(name: 'note_en') required final String noteEn,
    @JsonKey(name: 'sort_order') final int sortOrder,
  }) = _$AwardPrizeImpl;

  factory _AwardPrize.fromJson(Map<String, dynamic> json) =
      _$AwardPrizeImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'award_category_id')
  int get awardCategoryId;
  @override
  @JsonKey(name: 'prize_type')
  String get prizeType;
  @override
  @JsonKey(name: 'value_amount')
  int get valueAmount;
  @override
  @JsonKey(name: 'note_vi')
  String get noteVi;
  @override
  @JsonKey(name: 'note_en')
  String get noteEn;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;

  /// Create a copy of AwardPrize
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AwardPrizeImplCopyWith<_$AwardPrizeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
