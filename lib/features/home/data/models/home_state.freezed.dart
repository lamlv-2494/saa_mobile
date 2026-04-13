// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeState {
  EventInfo get eventInfo => throw _privateConstructorUsedError;
  List<AwardCategory> get awards => throw _privateConstructorUsedError;
  KudosInfo get kudosInfo => throw _privateConstructorUsedError;
  int get unreadNotificationCount => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call({
    EventInfo eventInfo,
    List<AwardCategory> awards,
    KudosInfo kudosInfo,
    int unreadNotificationCount,
  });

  $EventInfoCopyWith<$Res> get eventInfo;
  $KudosInfoCopyWith<$Res> get kudosInfo;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventInfo = null,
    Object? awards = null,
    Object? kudosInfo = null,
    Object? unreadNotificationCount = null,
  }) {
    return _then(
      _value.copyWith(
            eventInfo: null == eventInfo
                ? _value.eventInfo
                : eventInfo // ignore: cast_nullable_to_non_nullable
                      as EventInfo,
            awards: null == awards
                ? _value.awards
                : awards // ignore: cast_nullable_to_non_nullable
                      as List<AwardCategory>,
            kudosInfo: null == kudosInfo
                ? _value.kudosInfo
                : kudosInfo // ignore: cast_nullable_to_non_nullable
                      as KudosInfo,
            unreadNotificationCount: null == unreadNotificationCount
                ? _value.unreadNotificationCount
                : unreadNotificationCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EventInfoCopyWith<$Res> get eventInfo {
    return $EventInfoCopyWith<$Res>(_value.eventInfo, (value) {
      return _then(_value.copyWith(eventInfo: value) as $Val);
    });
  }

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KudosInfoCopyWith<$Res> get kudosInfo {
    return $KudosInfoCopyWith<$Res>(_value.kudosInfo, (value) {
      return _then(_value.copyWith(kudosInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
    _$HomeStateImpl value,
    $Res Function(_$HomeStateImpl) then,
  ) = __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    EventInfo eventInfo,
    List<AwardCategory> awards,
    KudosInfo kudosInfo,
    int unreadNotificationCount,
  });

  @override
  $EventInfoCopyWith<$Res> get eventInfo;
  @override
  $KudosInfoCopyWith<$Res> get kudosInfo;
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
    _$HomeStateImpl _value,
    $Res Function(_$HomeStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventInfo = null,
    Object? awards = null,
    Object? kudosInfo = null,
    Object? unreadNotificationCount = null,
  }) {
    return _then(
      _$HomeStateImpl(
        eventInfo: null == eventInfo
            ? _value.eventInfo
            : eventInfo // ignore: cast_nullable_to_non_nullable
                  as EventInfo,
        awards: null == awards
            ? _value._awards
            : awards // ignore: cast_nullable_to_non_nullable
                  as List<AwardCategory>,
        kudosInfo: null == kudosInfo
            ? _value.kudosInfo
            : kudosInfo // ignore: cast_nullable_to_non_nullable
                  as KudosInfo,
        unreadNotificationCount: null == unreadNotificationCount
            ? _value.unreadNotificationCount
            : unreadNotificationCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl({
    required this.eventInfo,
    final List<AwardCategory> awards = const [],
    this.kudosInfo = const KudosInfo(
      title: '',
      description: '',
      isEnabled: false,
    ),
    this.unreadNotificationCount = 0,
  }) : _awards = awards;

  @override
  final EventInfo eventInfo;
  final List<AwardCategory> _awards;
  @override
  @JsonKey()
  List<AwardCategory> get awards {
    if (_awards is EqualUnmodifiableListView) return _awards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_awards);
  }

  @override
  @JsonKey()
  final KudosInfo kudosInfo;
  @override
  @JsonKey()
  final int unreadNotificationCount;

  @override
  String toString() {
    return 'HomeState(eventInfo: $eventInfo, awards: $awards, kudosInfo: $kudosInfo, unreadNotificationCount: $unreadNotificationCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.eventInfo, eventInfo) ||
                other.eventInfo == eventInfo) &&
            const DeepCollectionEquality().equals(other._awards, _awards) &&
            (identical(other.kudosInfo, kudosInfo) ||
                other.kudosInfo == kudosInfo) &&
            (identical(
                  other.unreadNotificationCount,
                  unreadNotificationCount,
                ) ||
                other.unreadNotificationCount == unreadNotificationCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    eventInfo,
    const DeepCollectionEquality().hash(_awards),
    kudosInfo,
    unreadNotificationCount,
  );

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState({
    required final EventInfo eventInfo,
    final List<AwardCategory> awards,
    final KudosInfo kudosInfo,
    final int unreadNotificationCount,
  }) = _$HomeStateImpl;

  @override
  EventInfo get eventInfo;
  @override
  List<AwardCategory> get awards;
  @override
  KudosInfo get kudosInfo;
  @override
  int get unreadNotificationCount;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
