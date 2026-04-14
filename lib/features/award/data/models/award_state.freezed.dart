// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'award_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AwardState {
  List<AwardCategory> get categories => throw _privateConstructorUsedError;
  int get selectedIndex => throw _privateConstructorUsedError;

  /// Create a copy of AwardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AwardStateCopyWith<AwardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AwardStateCopyWith<$Res> {
  factory $AwardStateCopyWith(
    AwardState value,
    $Res Function(AwardState) then,
  ) = _$AwardStateCopyWithImpl<$Res, AwardState>;
  @useResult
  $Res call({List<AwardCategory> categories, int selectedIndex});
}

/// @nodoc
class _$AwardStateCopyWithImpl<$Res, $Val extends AwardState>
    implements $AwardStateCopyWith<$Res> {
  _$AwardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AwardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categories = null, Object? selectedIndex = null}) {
    return _then(
      _value.copyWith(
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<AwardCategory>,
            selectedIndex: null == selectedIndex
                ? _value.selectedIndex
                : selectedIndex // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AwardStateImplCopyWith<$Res>
    implements $AwardStateCopyWith<$Res> {
  factory _$$AwardStateImplCopyWith(
    _$AwardStateImpl value,
    $Res Function(_$AwardStateImpl) then,
  ) = __$$AwardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AwardCategory> categories, int selectedIndex});
}

/// @nodoc
class __$$AwardStateImplCopyWithImpl<$Res>
    extends _$AwardStateCopyWithImpl<$Res, _$AwardStateImpl>
    implements _$$AwardStateImplCopyWith<$Res> {
  __$$AwardStateImplCopyWithImpl(
    _$AwardStateImpl _value,
    $Res Function(_$AwardStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AwardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categories = null, Object? selectedIndex = null}) {
    return _then(
      _$AwardStateImpl(
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<AwardCategory>,
        selectedIndex: null == selectedIndex
            ? _value.selectedIndex
            : selectedIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$AwardStateImpl extends _AwardState {
  const _$AwardStateImpl({
    final List<AwardCategory> categories = const [],
    this.selectedIndex = 0,
  }) : _categories = categories,
       super._();

  final List<AwardCategory> _categories;
  @override
  @JsonKey()
  List<AwardCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final int selectedIndex;

  @override
  String toString() {
    return 'AwardState(categories: $categories, selectedIndex: $selectedIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AwardStateImpl &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_categories),
    selectedIndex,
  );

  /// Create a copy of AwardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AwardStateImplCopyWith<_$AwardStateImpl> get copyWith =>
      __$$AwardStateImplCopyWithImpl<_$AwardStateImpl>(this, _$identity);
}

abstract class _AwardState extends AwardState {
  const factory _AwardState({
    final List<AwardCategory> categories,
    final int selectedIndex,
  }) = _$AwardStateImpl;
  const _AwardState._() : super._();

  @override
  List<AwardCategory> get categories;
  @override
  int get selectedIndex;

  /// Create a copy of AwardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AwardStateImplCopyWith<_$AwardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
