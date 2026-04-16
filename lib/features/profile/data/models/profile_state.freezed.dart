// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProfileState {
  UserProfile? get profile => throw _privateConstructorUsedError;
  PersonalStats? get personalStats => throw _privateConstructorUsedError;
  List<IconBadge> get iconBadges => throw _privateConstructorUsedError;
  List<Kudos> get kudosList => throw _privateConstructorUsedError;
  KudosFilterType get kudosFilter => throw _privateConstructorUsedError;
  bool get hasMoreKudos => throw _privateConstructorUsedError;
  bool get isLoadingMoreKudos => throw _privateConstructorUsedError;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
    ProfileState value,
    $Res Function(ProfileState) then,
  ) = _$ProfileStateCopyWithImpl<$Res, ProfileState>;
  @useResult
  $Res call({
    UserProfile? profile,
    PersonalStats? personalStats,
    List<IconBadge> iconBadges,
    List<Kudos> kudosList,
    KudosFilterType kudosFilter,
    bool hasMoreKudos,
    bool isLoadingMoreKudos,
  });

  $UserProfileCopyWith<$Res>? get profile;
  $PersonalStatsCopyWith<$Res>? get personalStats;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = freezed,
    Object? personalStats = freezed,
    Object? iconBadges = null,
    Object? kudosList = null,
    Object? kudosFilter = null,
    Object? hasMoreKudos = null,
    Object? isLoadingMoreKudos = null,
  }) {
    return _then(
      _value.copyWith(
            profile: freezed == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                      as UserProfile?,
            personalStats: freezed == personalStats
                ? _value.personalStats
                : personalStats // ignore: cast_nullable_to_non_nullable
                      as PersonalStats?,
            iconBadges: null == iconBadges
                ? _value.iconBadges
                : iconBadges // ignore: cast_nullable_to_non_nullable
                      as List<IconBadge>,
            kudosList: null == kudosList
                ? _value.kudosList
                : kudosList // ignore: cast_nullable_to_non_nullable
                      as List<Kudos>,
            kudosFilter: null == kudosFilter
                ? _value.kudosFilter
                : kudosFilter // ignore: cast_nullable_to_non_nullable
                      as KudosFilterType,
            hasMoreKudos: null == hasMoreKudos
                ? _value.hasMoreKudos
                : hasMoreKudos // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMoreKudos: null == isLoadingMoreKudos
                ? _value.isLoadingMoreKudos
                : isLoadingMoreKudos // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $UserProfileCopyWith<$Res>(_value.profile!, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }

  /// Create a copy of ProfileState
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
}

/// @nodoc
abstract class _$$ProfileStateImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$ProfileStateImplCopyWith(
    _$ProfileStateImpl value,
    $Res Function(_$ProfileStateImpl) then,
  ) = __$$ProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UserProfile? profile,
    PersonalStats? personalStats,
    List<IconBadge> iconBadges,
    List<Kudos> kudosList,
    KudosFilterType kudosFilter,
    bool hasMoreKudos,
    bool isLoadingMoreKudos,
  });

  @override
  $UserProfileCopyWith<$Res>? get profile;
  @override
  $PersonalStatsCopyWith<$Res>? get personalStats;
}

/// @nodoc
class __$$ProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileStateImpl>
    implements _$$ProfileStateImplCopyWith<$Res> {
  __$$ProfileStateImplCopyWithImpl(
    _$ProfileStateImpl _value,
    $Res Function(_$ProfileStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = freezed,
    Object? personalStats = freezed,
    Object? iconBadges = null,
    Object? kudosList = null,
    Object? kudosFilter = null,
    Object? hasMoreKudos = null,
    Object? isLoadingMoreKudos = null,
  }) {
    return _then(
      _$ProfileStateImpl(
        profile: freezed == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as UserProfile?,
        personalStats: freezed == personalStats
            ? _value.personalStats
            : personalStats // ignore: cast_nullable_to_non_nullable
                  as PersonalStats?,
        iconBadges: null == iconBadges
            ? _value._iconBadges
            : iconBadges // ignore: cast_nullable_to_non_nullable
                  as List<IconBadge>,
        kudosList: null == kudosList
            ? _value._kudosList
            : kudosList // ignore: cast_nullable_to_non_nullable
                  as List<Kudos>,
        kudosFilter: null == kudosFilter
            ? _value.kudosFilter
            : kudosFilter // ignore: cast_nullable_to_non_nullable
                  as KudosFilterType,
        hasMoreKudos: null == hasMoreKudos
            ? _value.hasMoreKudos
            : hasMoreKudos // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMoreKudos: null == isLoadingMoreKudos
            ? _value.isLoadingMoreKudos
            : isLoadingMoreKudos // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ProfileStateImpl implements _ProfileState {
  const _$ProfileStateImpl({
    this.profile,
    this.personalStats,
    final List<IconBadge> iconBadges = const [],
    final List<Kudos> kudosList = const [],
    this.kudosFilter = KudosFilterType.received,
    this.hasMoreKudos = true,
    this.isLoadingMoreKudos = false,
  }) : _iconBadges = iconBadges,
       _kudosList = kudosList;

  @override
  final UserProfile? profile;
  @override
  final PersonalStats? personalStats;
  final List<IconBadge> _iconBadges;
  @override
  @JsonKey()
  List<IconBadge> get iconBadges {
    if (_iconBadges is EqualUnmodifiableListView) return _iconBadges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_iconBadges);
  }

  final List<Kudos> _kudosList;
  @override
  @JsonKey()
  List<Kudos> get kudosList {
    if (_kudosList is EqualUnmodifiableListView) return _kudosList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kudosList);
  }

  @override
  @JsonKey()
  final KudosFilterType kudosFilter;
  @override
  @JsonKey()
  final bool hasMoreKudos;
  @override
  @JsonKey()
  final bool isLoadingMoreKudos;

  @override
  String toString() {
    return 'ProfileState(profile: $profile, personalStats: $personalStats, iconBadges: $iconBadges, kudosList: $kudosList, kudosFilter: $kudosFilter, hasMoreKudos: $hasMoreKudos, isLoadingMoreKudos: $isLoadingMoreKudos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileStateImpl &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.personalStats, personalStats) ||
                other.personalStats == personalStats) &&
            const DeepCollectionEquality().equals(
              other._iconBadges,
              _iconBadges,
            ) &&
            const DeepCollectionEquality().equals(
              other._kudosList,
              _kudosList,
            ) &&
            (identical(other.kudosFilter, kudosFilter) ||
                other.kudosFilter == kudosFilter) &&
            (identical(other.hasMoreKudos, hasMoreKudos) ||
                other.hasMoreKudos == hasMoreKudos) &&
            (identical(other.isLoadingMoreKudos, isLoadingMoreKudos) ||
                other.isLoadingMoreKudos == isLoadingMoreKudos));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    profile,
    personalStats,
    const DeepCollectionEquality().hash(_iconBadges),
    const DeepCollectionEquality().hash(_kudosList),
    kudosFilter,
    hasMoreKudos,
    isLoadingMoreKudos,
  );

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      __$$ProfileStateImplCopyWithImpl<_$ProfileStateImpl>(this, _$identity);
}

abstract class _ProfileState implements ProfileState {
  const factory _ProfileState({
    final UserProfile? profile,
    final PersonalStats? personalStats,
    final List<IconBadge> iconBadges,
    final List<Kudos> kudosList,
    final KudosFilterType kudosFilter,
    final bool hasMoreKudos,
    final bool isLoadingMoreKudos,
  }) = _$ProfileStateImpl;

  @override
  UserProfile? get profile;
  @override
  PersonalStats? get personalStats;
  @override
  List<IconBadge> get iconBadges;
  @override
  List<Kudos> get kudosList;
  @override
  KudosFilterType get kudosFilter;
  @override
  bool get hasMoreKudos;
  @override
  bool get isLoadingMoreKudos;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
