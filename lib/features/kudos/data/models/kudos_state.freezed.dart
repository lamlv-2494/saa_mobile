// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kudos_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$KudosState {
  List<Kudos> get highlightKudos => throw _privateConstructorUsedError;
  List<Kudos> get allKudos => throw _privateConstructorUsedError;
  PersonalStats? get personalStats => throw _privateConstructorUsedError;
  List<GiftRecipientRanking> get topGiftRecipients =>
      throw _privateConstructorUsedError;
  SpotlightData? get spotlightData => throw _privateConstructorUsedError;
  Hashtag? get selectedHashtag => throw _privateConstructorUsedError;
  Department? get selectedDepartment => throw _privateConstructorUsedError;
  int get currentHighlightPage => throw _privateConstructorUsedError;
  bool get hasMoreKudos => throw _privateConstructorUsedError;
  List<Hashtag> get availableHashtags => throw _privateConstructorUsedError;
  List<Department> get availableDepartments =>
      throw _privateConstructorUsedError; // All Kudos page (page index 1 trong PageView)
  List<Kudos> get allKudosPageList => throw _privateConstructorUsedError;
  bool get hasMoreAllKudosPage => throw _privateConstructorUsedError;
  bool get isLoadingMoreAllKudos => throw _privateConstructorUsedError;

  /// Create a copy of KudosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KudosStateCopyWith<KudosState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KudosStateCopyWith<$Res> {
  factory $KudosStateCopyWith(
    KudosState value,
    $Res Function(KudosState) then,
  ) = _$KudosStateCopyWithImpl<$Res, KudosState>;
  @useResult
  $Res call({
    List<Kudos> highlightKudos,
    List<Kudos> allKudos,
    PersonalStats? personalStats,
    List<GiftRecipientRanking> topGiftRecipients,
    SpotlightData? spotlightData,
    Hashtag? selectedHashtag,
    Department? selectedDepartment,
    int currentHighlightPage,
    bool hasMoreKudos,
    List<Hashtag> availableHashtags,
    List<Department> availableDepartments,
    List<Kudos> allKudosPageList,
    bool hasMoreAllKudosPage,
    bool isLoadingMoreAllKudos,
  });

  $PersonalStatsCopyWith<$Res>? get personalStats;
  $SpotlightDataCopyWith<$Res>? get spotlightData;
  $HashtagCopyWith<$Res>? get selectedHashtag;
  $DepartmentCopyWith<$Res>? get selectedDepartment;
}

/// @nodoc
class _$KudosStateCopyWithImpl<$Res, $Val extends KudosState>
    implements $KudosStateCopyWith<$Res> {
  _$KudosStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KudosState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? highlightKudos = null,
    Object? allKudos = null,
    Object? personalStats = freezed,
    Object? topGiftRecipients = null,
    Object? spotlightData = freezed,
    Object? selectedHashtag = freezed,
    Object? selectedDepartment = freezed,
    Object? currentHighlightPage = null,
    Object? hasMoreKudos = null,
    Object? availableHashtags = null,
    Object? availableDepartments = null,
    Object? allKudosPageList = null,
    Object? hasMoreAllKudosPage = null,
    Object? isLoadingMoreAllKudos = null,
  }) {
    return _then(
      _value.copyWith(
            highlightKudos: null == highlightKudos
                ? _value.highlightKudos
                : highlightKudos // ignore: cast_nullable_to_non_nullable
                      as List<Kudos>,
            allKudos: null == allKudos
                ? _value.allKudos
                : allKudos // ignore: cast_nullable_to_non_nullable
                      as List<Kudos>,
            personalStats: freezed == personalStats
                ? _value.personalStats
                : personalStats // ignore: cast_nullable_to_non_nullable
                      as PersonalStats?,
            topGiftRecipients: null == topGiftRecipients
                ? _value.topGiftRecipients
                : topGiftRecipients // ignore: cast_nullable_to_non_nullable
                      as List<GiftRecipientRanking>,
            spotlightData: freezed == spotlightData
                ? _value.spotlightData
                : spotlightData // ignore: cast_nullable_to_non_nullable
                      as SpotlightData?,
            selectedHashtag: freezed == selectedHashtag
                ? _value.selectedHashtag
                : selectedHashtag // ignore: cast_nullable_to_non_nullable
                      as Hashtag?,
            selectedDepartment: freezed == selectedDepartment
                ? _value.selectedDepartment
                : selectedDepartment // ignore: cast_nullable_to_non_nullable
                      as Department?,
            currentHighlightPage: null == currentHighlightPage
                ? _value.currentHighlightPage
                : currentHighlightPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMoreKudos: null == hasMoreKudos
                ? _value.hasMoreKudos
                : hasMoreKudos // ignore: cast_nullable_to_non_nullable
                      as bool,
            availableHashtags: null == availableHashtags
                ? _value.availableHashtags
                : availableHashtags // ignore: cast_nullable_to_non_nullable
                      as List<Hashtag>,
            availableDepartments: null == availableDepartments
                ? _value.availableDepartments
                : availableDepartments // ignore: cast_nullable_to_non_nullable
                      as List<Department>,
            allKudosPageList: null == allKudosPageList
                ? _value.allKudosPageList
                : allKudosPageList // ignore: cast_nullable_to_non_nullable
                      as List<Kudos>,
            hasMoreAllKudosPage: null == hasMoreAllKudosPage
                ? _value.hasMoreAllKudosPage
                : hasMoreAllKudosPage // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMoreAllKudos: null == isLoadingMoreAllKudos
                ? _value.isLoadingMoreAllKudos
                : isLoadingMoreAllKudos // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of KudosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PersonalStatsCopyWith<$Res>? get personalStats {
    if (_value.personalStats == null) {
      return null;
    }

    return $PersonalStatsCopyWith<$Res>(_value.personalStats!, (value) {
      return _then(_value.copyWith(personalStats: value) as $Val);
    });
  }

  /// Create a copy of KudosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpotlightDataCopyWith<$Res>? get spotlightData {
    if (_value.spotlightData == null) {
      return null;
    }

    return $SpotlightDataCopyWith<$Res>(_value.spotlightData!, (value) {
      return _then(_value.copyWith(spotlightData: value) as $Val);
    });
  }

  /// Create a copy of KudosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HashtagCopyWith<$Res>? get selectedHashtag {
    if (_value.selectedHashtag == null) {
      return null;
    }

    return $HashtagCopyWith<$Res>(_value.selectedHashtag!, (value) {
      return _then(_value.copyWith(selectedHashtag: value) as $Val);
    });
  }

  /// Create a copy of KudosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DepartmentCopyWith<$Res>? get selectedDepartment {
    if (_value.selectedDepartment == null) {
      return null;
    }

    return $DepartmentCopyWith<$Res>(_value.selectedDepartment!, (value) {
      return _then(_value.copyWith(selectedDepartment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$KudosStateImplCopyWith<$Res>
    implements $KudosStateCopyWith<$Res> {
  factory _$$KudosStateImplCopyWith(
    _$KudosStateImpl value,
    $Res Function(_$KudosStateImpl) then,
  ) = __$$KudosStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Kudos> highlightKudos,
    List<Kudos> allKudos,
    PersonalStats? personalStats,
    List<GiftRecipientRanking> topGiftRecipients,
    SpotlightData? spotlightData,
    Hashtag? selectedHashtag,
    Department? selectedDepartment,
    int currentHighlightPage,
    bool hasMoreKudos,
    List<Hashtag> availableHashtags,
    List<Department> availableDepartments,
    List<Kudos> allKudosPageList,
    bool hasMoreAllKudosPage,
    bool isLoadingMoreAllKudos,
  });

  @override
  $PersonalStatsCopyWith<$Res>? get personalStats;
  @override
  $SpotlightDataCopyWith<$Res>? get spotlightData;
  @override
  $HashtagCopyWith<$Res>? get selectedHashtag;
  @override
  $DepartmentCopyWith<$Res>? get selectedDepartment;
}

/// @nodoc
class __$$KudosStateImplCopyWithImpl<$Res>
    extends _$KudosStateCopyWithImpl<$Res, _$KudosStateImpl>
    implements _$$KudosStateImplCopyWith<$Res> {
  __$$KudosStateImplCopyWithImpl(
    _$KudosStateImpl _value,
    $Res Function(_$KudosStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KudosState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? highlightKudos = null,
    Object? allKudos = null,
    Object? personalStats = freezed,
    Object? topGiftRecipients = null,
    Object? spotlightData = freezed,
    Object? selectedHashtag = freezed,
    Object? selectedDepartment = freezed,
    Object? currentHighlightPage = null,
    Object? hasMoreKudos = null,
    Object? availableHashtags = null,
    Object? availableDepartments = null,
    Object? allKudosPageList = null,
    Object? hasMoreAllKudosPage = null,
    Object? isLoadingMoreAllKudos = null,
  }) {
    return _then(
      _$KudosStateImpl(
        highlightKudos: null == highlightKudos
            ? _value._highlightKudos
            : highlightKudos // ignore: cast_nullable_to_non_nullable
                  as List<Kudos>,
        allKudos: null == allKudos
            ? _value._allKudos
            : allKudos // ignore: cast_nullable_to_non_nullable
                  as List<Kudos>,
        personalStats: freezed == personalStats
            ? _value.personalStats
            : personalStats // ignore: cast_nullable_to_non_nullable
                  as PersonalStats?,
        topGiftRecipients: null == topGiftRecipients
            ? _value._topGiftRecipients
            : topGiftRecipients // ignore: cast_nullable_to_non_nullable
                  as List<GiftRecipientRanking>,
        spotlightData: freezed == spotlightData
            ? _value.spotlightData
            : spotlightData // ignore: cast_nullable_to_non_nullable
                  as SpotlightData?,
        selectedHashtag: freezed == selectedHashtag
            ? _value.selectedHashtag
            : selectedHashtag // ignore: cast_nullable_to_non_nullable
                  as Hashtag?,
        selectedDepartment: freezed == selectedDepartment
            ? _value.selectedDepartment
            : selectedDepartment // ignore: cast_nullable_to_non_nullable
                  as Department?,
        currentHighlightPage: null == currentHighlightPage
            ? _value.currentHighlightPage
            : currentHighlightPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMoreKudos: null == hasMoreKudos
            ? _value.hasMoreKudos
            : hasMoreKudos // ignore: cast_nullable_to_non_nullable
                  as bool,
        availableHashtags: null == availableHashtags
            ? _value._availableHashtags
            : availableHashtags // ignore: cast_nullable_to_non_nullable
                  as List<Hashtag>,
        availableDepartments: null == availableDepartments
            ? _value._availableDepartments
            : availableDepartments // ignore: cast_nullable_to_non_nullable
                  as List<Department>,
        allKudosPageList: null == allKudosPageList
            ? _value._allKudosPageList
            : allKudosPageList // ignore: cast_nullable_to_non_nullable
                  as List<Kudos>,
        hasMoreAllKudosPage: null == hasMoreAllKudosPage
            ? _value.hasMoreAllKudosPage
            : hasMoreAllKudosPage // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMoreAllKudos: null == isLoadingMoreAllKudos
            ? _value.isLoadingMoreAllKudos
            : isLoadingMoreAllKudos // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$KudosStateImpl implements _KudosState {
  const _$KudosStateImpl({
    final List<Kudos> highlightKudos = const [],
    final List<Kudos> allKudos = const [],
    this.personalStats,
    final List<GiftRecipientRanking> topGiftRecipients = const [],
    this.spotlightData,
    this.selectedHashtag,
    this.selectedDepartment,
    this.currentHighlightPage = 0,
    this.hasMoreKudos = true,
    final List<Hashtag> availableHashtags = const [],
    final List<Department> availableDepartments = const [],
    final List<Kudos> allKudosPageList = const [],
    this.hasMoreAllKudosPage = true,
    this.isLoadingMoreAllKudos = false,
  }) : _highlightKudos = highlightKudos,
       _allKudos = allKudos,
       _topGiftRecipients = topGiftRecipients,
       _availableHashtags = availableHashtags,
       _availableDepartments = availableDepartments,
       _allKudosPageList = allKudosPageList;

  final List<Kudos> _highlightKudos;
  @override
  @JsonKey()
  List<Kudos> get highlightKudos {
    if (_highlightKudos is EqualUnmodifiableListView) return _highlightKudos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_highlightKudos);
  }

  final List<Kudos> _allKudos;
  @override
  @JsonKey()
  List<Kudos> get allKudos {
    if (_allKudos is EqualUnmodifiableListView) return _allKudos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allKudos);
  }

  @override
  final PersonalStats? personalStats;
  final List<GiftRecipientRanking> _topGiftRecipients;
  @override
  @JsonKey()
  List<GiftRecipientRanking> get topGiftRecipients {
    if (_topGiftRecipients is EqualUnmodifiableListView)
      return _topGiftRecipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topGiftRecipients);
  }

  @override
  final SpotlightData? spotlightData;
  @override
  final Hashtag? selectedHashtag;
  @override
  final Department? selectedDepartment;
  @override
  @JsonKey()
  final int currentHighlightPage;
  @override
  @JsonKey()
  final bool hasMoreKudos;
  final List<Hashtag> _availableHashtags;
  @override
  @JsonKey()
  List<Hashtag> get availableHashtags {
    if (_availableHashtags is EqualUnmodifiableListView)
      return _availableHashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableHashtags);
  }

  final List<Department> _availableDepartments;
  @override
  @JsonKey()
  List<Department> get availableDepartments {
    if (_availableDepartments is EqualUnmodifiableListView)
      return _availableDepartments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableDepartments);
  }

  // All Kudos page (page index 1 trong PageView)
  final List<Kudos> _allKudosPageList;
  // All Kudos page (page index 1 trong PageView)
  @override
  @JsonKey()
  List<Kudos> get allKudosPageList {
    if (_allKudosPageList is EqualUnmodifiableListView)
      return _allKudosPageList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allKudosPageList);
  }

  @override
  @JsonKey()
  final bool hasMoreAllKudosPage;
  @override
  @JsonKey()
  final bool isLoadingMoreAllKudos;

  @override
  String toString() {
    return 'KudosState(highlightKudos: $highlightKudos, allKudos: $allKudos, personalStats: $personalStats, topGiftRecipients: $topGiftRecipients, spotlightData: $spotlightData, selectedHashtag: $selectedHashtag, selectedDepartment: $selectedDepartment, currentHighlightPage: $currentHighlightPage, hasMoreKudos: $hasMoreKudos, availableHashtags: $availableHashtags, availableDepartments: $availableDepartments, allKudosPageList: $allKudosPageList, hasMoreAllKudosPage: $hasMoreAllKudosPage, isLoadingMoreAllKudos: $isLoadingMoreAllKudos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KudosStateImpl &&
            const DeepCollectionEquality().equals(
              other._highlightKudos,
              _highlightKudos,
            ) &&
            const DeepCollectionEquality().equals(other._allKudos, _allKudos) &&
            (identical(other.personalStats, personalStats) ||
                other.personalStats == personalStats) &&
            const DeepCollectionEquality().equals(
              other._topGiftRecipients,
              _topGiftRecipients,
            ) &&
            (identical(other.spotlightData, spotlightData) ||
                other.spotlightData == spotlightData) &&
            (identical(other.selectedHashtag, selectedHashtag) ||
                other.selectedHashtag == selectedHashtag) &&
            (identical(other.selectedDepartment, selectedDepartment) ||
                other.selectedDepartment == selectedDepartment) &&
            (identical(other.currentHighlightPage, currentHighlightPage) ||
                other.currentHighlightPage == currentHighlightPage) &&
            (identical(other.hasMoreKudos, hasMoreKudos) ||
                other.hasMoreKudos == hasMoreKudos) &&
            const DeepCollectionEquality().equals(
              other._availableHashtags,
              _availableHashtags,
            ) &&
            const DeepCollectionEquality().equals(
              other._availableDepartments,
              _availableDepartments,
            ) &&
            const DeepCollectionEquality().equals(
              other._allKudosPageList,
              _allKudosPageList,
            ) &&
            (identical(other.hasMoreAllKudosPage, hasMoreAllKudosPage) ||
                other.hasMoreAllKudosPage == hasMoreAllKudosPage) &&
            (identical(other.isLoadingMoreAllKudos, isLoadingMoreAllKudos) ||
                other.isLoadingMoreAllKudos == isLoadingMoreAllKudos));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_highlightKudos),
    const DeepCollectionEquality().hash(_allKudos),
    personalStats,
    const DeepCollectionEquality().hash(_topGiftRecipients),
    spotlightData,
    selectedHashtag,
    selectedDepartment,
    currentHighlightPage,
    hasMoreKudos,
    const DeepCollectionEquality().hash(_availableHashtags),
    const DeepCollectionEquality().hash(_availableDepartments),
    const DeepCollectionEquality().hash(_allKudosPageList),
    hasMoreAllKudosPage,
    isLoadingMoreAllKudos,
  );

  /// Create a copy of KudosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KudosStateImplCopyWith<_$KudosStateImpl> get copyWith =>
      __$$KudosStateImplCopyWithImpl<_$KudosStateImpl>(this, _$identity);
}

abstract class _KudosState implements KudosState {
  const factory _KudosState({
    final List<Kudos> highlightKudos,
    final List<Kudos> allKudos,
    final PersonalStats? personalStats,
    final List<GiftRecipientRanking> topGiftRecipients,
    final SpotlightData? spotlightData,
    final Hashtag? selectedHashtag,
    final Department? selectedDepartment,
    final int currentHighlightPage,
    final bool hasMoreKudos,
    final List<Hashtag> availableHashtags,
    final List<Department> availableDepartments,
    final List<Kudos> allKudosPageList,
    final bool hasMoreAllKudosPage,
    final bool isLoadingMoreAllKudos,
  }) = _$KudosStateImpl;

  @override
  List<Kudos> get highlightKudos;
  @override
  List<Kudos> get allKudos;
  @override
  PersonalStats? get personalStats;
  @override
  List<GiftRecipientRanking> get topGiftRecipients;
  @override
  SpotlightData? get spotlightData;
  @override
  Hashtag? get selectedHashtag;
  @override
  Department? get selectedDepartment;
  @override
  int get currentHighlightPage;
  @override
  bool get hasMoreKudos;
  @override
  List<Hashtag> get availableHashtags;
  @override
  List<Department> get availableDepartments; // All Kudos page (page index 1 trong PageView)
  @override
  List<Kudos> get allKudosPageList;
  @override
  bool get hasMoreAllKudosPage;
  @override
  bool get isLoadingMoreAllKudos;

  /// Create a copy of KudosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KudosStateImplCopyWith<_$KudosStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
