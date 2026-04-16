// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'other_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OtherProfileState {
  UserProfile? get profile => throw _privateConstructorUsedError;
  int get kudosSentCount => throw _privateConstructorUsedError;
  int get kudosReceivedCount => throw _privateConstructorUsedError;
  List<Badge> get badges => throw _privateConstructorUsedError;
  List<Kudos> get kudosList => throw _privateConstructorUsedError;
  KudosFilterType get kudosFilter => throw _privateConstructorUsedError;
  bool get hasMoreKudos => throw _privateConstructorUsedError;
  bool get isLoadingMoreKudos => throw _privateConstructorUsedError;

  /// Create a copy of OtherProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtherProfileStateCopyWith<OtherProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtherProfileStateCopyWith<$Res> {
  factory $OtherProfileStateCopyWith(
    OtherProfileState value,
    $Res Function(OtherProfileState) then,
  ) = _$OtherProfileStateCopyWithImpl<$Res, OtherProfileState>;
  @useResult
  $Res call({
    UserProfile? profile,
    int kudosSentCount,
    int kudosReceivedCount,
    List<Badge> badges,
    List<Kudos> kudosList,
    KudosFilterType kudosFilter,
    bool hasMoreKudos,
    bool isLoadingMoreKudos,
  });

  $UserProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class _$OtherProfileStateCopyWithImpl<$Res, $Val extends OtherProfileState>
    implements $OtherProfileStateCopyWith<$Res> {
  _$OtherProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtherProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = freezed,
    Object? kudosSentCount = null,
    Object? kudosReceivedCount = null,
    Object? badges = null,
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
            kudosSentCount: null == kudosSentCount
                ? _value.kudosSentCount
                : kudosSentCount // ignore: cast_nullable_to_non_nullable
                      as int,
            kudosReceivedCount: null == kudosReceivedCount
                ? _value.kudosReceivedCount
                : kudosReceivedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            badges: null == badges
                ? _value.badges
                : badges // ignore: cast_nullable_to_non_nullable
                      as List<Badge>,
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

  /// Create a copy of OtherProfileState
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
}

/// @nodoc
abstract class _$$OtherProfileStateImplCopyWith<$Res>
    implements $OtherProfileStateCopyWith<$Res> {
  factory _$$OtherProfileStateImplCopyWith(
    _$OtherProfileStateImpl value,
    $Res Function(_$OtherProfileStateImpl) then,
  ) = __$$OtherProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UserProfile? profile,
    int kudosSentCount,
    int kudosReceivedCount,
    List<Badge> badges,
    List<Kudos> kudosList,
    KudosFilterType kudosFilter,
    bool hasMoreKudos,
    bool isLoadingMoreKudos,
  });

  @override
  $UserProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class __$$OtherProfileStateImplCopyWithImpl<$Res>
    extends _$OtherProfileStateCopyWithImpl<$Res, _$OtherProfileStateImpl>
    implements _$$OtherProfileStateImplCopyWith<$Res> {
  __$$OtherProfileStateImplCopyWithImpl(
    _$OtherProfileStateImpl _value,
    $Res Function(_$OtherProfileStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtherProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = freezed,
    Object? kudosSentCount = null,
    Object? kudosReceivedCount = null,
    Object? badges = null,
    Object? kudosList = null,
    Object? kudosFilter = null,
    Object? hasMoreKudos = null,
    Object? isLoadingMoreKudos = null,
  }) {
    return _then(
      _$OtherProfileStateImpl(
        profile: freezed == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as UserProfile?,
        kudosSentCount: null == kudosSentCount
            ? _value.kudosSentCount
            : kudosSentCount // ignore: cast_nullable_to_non_nullable
                  as int,
        kudosReceivedCount: null == kudosReceivedCount
            ? _value.kudosReceivedCount
            : kudosReceivedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        badges: null == badges
            ? _value._badges
            : badges // ignore: cast_nullable_to_non_nullable
                  as List<Badge>,
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

class _$OtherProfileStateImpl implements _OtherProfileState {
  const _$OtherProfileStateImpl({
    this.profile,
    this.kudosSentCount = 0,
    this.kudosReceivedCount = 0,
    final List<Badge> badges = const [],
    final List<Kudos> kudosList = const [],
    this.kudosFilter = KudosFilterType.received,
    this.hasMoreKudos = true,
    this.isLoadingMoreKudos = false,
  }) : _badges = badges,
       _kudosList = kudosList;

  @override
  final UserProfile? profile;
  @override
  @JsonKey()
  final int kudosSentCount;
  @override
  @JsonKey()
  final int kudosReceivedCount;
  final List<Badge> _badges;
  @override
  @JsonKey()
  List<Badge> get badges {
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
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
    return 'OtherProfileState(profile: $profile, kudosSentCount: $kudosSentCount, kudosReceivedCount: $kudosReceivedCount, badges: $badges, kudosList: $kudosList, kudosFilter: $kudosFilter, hasMoreKudos: $hasMoreKudos, isLoadingMoreKudos: $isLoadingMoreKudos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtherProfileStateImpl &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.kudosSentCount, kudosSentCount) ||
                other.kudosSentCount == kudosSentCount) &&
            (identical(other.kudosReceivedCount, kudosReceivedCount) ||
                other.kudosReceivedCount == kudosReceivedCount) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
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
    kudosSentCount,
    kudosReceivedCount,
    const DeepCollectionEquality().hash(_badges),
    const DeepCollectionEquality().hash(_kudosList),
    kudosFilter,
    hasMoreKudos,
    isLoadingMoreKudos,
  );

  /// Create a copy of OtherProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtherProfileStateImplCopyWith<_$OtherProfileStateImpl> get copyWith =>
      __$$OtherProfileStateImplCopyWithImpl<_$OtherProfileStateImpl>(
        this,
        _$identity,
      );
}

abstract class _OtherProfileState implements OtherProfileState {
  const factory _OtherProfileState({
    final UserProfile? profile,
    final int kudosSentCount,
    final int kudosReceivedCount,
    final List<Badge> badges,
    final List<Kudos> kudosList,
    final KudosFilterType kudosFilter,
    final bool hasMoreKudos,
    final bool isLoadingMoreKudos,
  }) = _$OtherProfileStateImpl;

  @override
  UserProfile? get profile;
  @override
  int get kudosSentCount;
  @override
  int get kudosReceivedCount;
  @override
  List<Badge> get badges;
  @override
  List<Kudos> get kudosList;
  @override
  KudosFilterType get kudosFilter;
  @override
  bool get hasMoreKudos;
  @override
  bool get isLoadingMoreKudos;

  /// Create a copy of OtherProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtherProfileStateImplCopyWith<_$OtherProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
