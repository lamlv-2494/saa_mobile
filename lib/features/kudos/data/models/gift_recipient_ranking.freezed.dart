// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_recipient_ranking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GiftRecipientRanking _$GiftRecipientRankingFromJson(Map<String, dynamic> json) {
  return _GiftRecipientRanking.fromJson(json);
}

/// @nodoc
mixin _$GiftRecipientRanking {
  int get rank => throw _privateConstructorUsedError;
  UserSummary get user => throw _privateConstructorUsedError;
  int get giftCount => throw _privateConstructorUsedError;
  String get rewardName => throw _privateConstructorUsedError;

  /// Serializes this GiftRecipientRanking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GiftRecipientRanking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftRecipientRankingCopyWith<GiftRecipientRanking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftRecipientRankingCopyWith<$Res> {
  factory $GiftRecipientRankingCopyWith(
    GiftRecipientRanking value,
    $Res Function(GiftRecipientRanking) then,
  ) = _$GiftRecipientRankingCopyWithImpl<$Res, GiftRecipientRanking>;
  @useResult
  $Res call({int rank, UserSummary user, int giftCount, String rewardName});

  $UserSummaryCopyWith<$Res> get user;
}

/// @nodoc
class _$GiftRecipientRankingCopyWithImpl<
  $Res,
  $Val extends GiftRecipientRanking
>
    implements $GiftRecipientRankingCopyWith<$Res> {
  _$GiftRecipientRankingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftRecipientRanking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? user = null,
    Object? giftCount = null,
    Object? rewardName = null,
  }) {
    return _then(
      _value.copyWith(
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as UserSummary,
            giftCount: null == giftCount
                ? _value.giftCount
                : giftCount // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardName: null == rewardName
                ? _value.rewardName
                : rewardName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of GiftRecipientRanking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res> get user {
    return $UserSummaryCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GiftRecipientRankingImplCopyWith<$Res>
    implements $GiftRecipientRankingCopyWith<$Res> {
  factory _$$GiftRecipientRankingImplCopyWith(
    _$GiftRecipientRankingImpl value,
    $Res Function(_$GiftRecipientRankingImpl) then,
  ) = __$$GiftRecipientRankingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int rank, UserSummary user, int giftCount, String rewardName});

  @override
  $UserSummaryCopyWith<$Res> get user;
}

/// @nodoc
class __$$GiftRecipientRankingImplCopyWithImpl<$Res>
    extends _$GiftRecipientRankingCopyWithImpl<$Res, _$GiftRecipientRankingImpl>
    implements _$$GiftRecipientRankingImplCopyWith<$Res> {
  __$$GiftRecipientRankingImplCopyWithImpl(
    _$GiftRecipientRankingImpl _value,
    $Res Function(_$GiftRecipientRankingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftRecipientRanking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? user = null,
    Object? giftCount = null,
    Object? rewardName = null,
  }) {
    return _then(
      _$GiftRecipientRankingImpl(
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as UserSummary,
        giftCount: null == giftCount
            ? _value.giftCount
            : giftCount // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardName: null == rewardName
            ? _value.rewardName
            : rewardName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftRecipientRankingImpl implements _GiftRecipientRanking {
  const _$GiftRecipientRankingImpl({
    required this.rank,
    required this.user,
    this.giftCount = 0,
    this.rewardName = '',
  });

  factory _$GiftRecipientRankingImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftRecipientRankingImplFromJson(json);

  @override
  final int rank;
  @override
  final UserSummary user;
  @override
  @JsonKey()
  final int giftCount;
  @override
  @JsonKey()
  final String rewardName;

  @override
  String toString() {
    return 'GiftRecipientRanking(rank: $rank, user: $user, giftCount: $giftCount, rewardName: $rewardName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftRecipientRankingImpl &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.giftCount, giftCount) ||
                other.giftCount == giftCount) &&
            (identical(other.rewardName, rewardName) ||
                other.rewardName == rewardName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, rank, user, giftCount, rewardName);

  /// Create a copy of GiftRecipientRanking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftRecipientRankingImplCopyWith<_$GiftRecipientRankingImpl>
  get copyWith =>
      __$$GiftRecipientRankingImplCopyWithImpl<_$GiftRecipientRankingImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftRecipientRankingImplToJson(this);
  }
}

abstract class _GiftRecipientRanking implements GiftRecipientRanking {
  const factory _GiftRecipientRanking({
    required final int rank,
    required final UserSummary user,
    final int giftCount,
    final String rewardName,
  }) = _$GiftRecipientRankingImpl;

  factory _GiftRecipientRanking.fromJson(Map<String, dynamic> json) =
      _$GiftRecipientRankingImpl.fromJson;

  @override
  int get rank;
  @override
  UserSummary get user;
  @override
  int get giftCount;
  @override
  String get rewardName;

  /// Create a copy of GiftRecipientRanking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftRecipientRankingImplCopyWith<_$GiftRecipientRankingImpl>
  get copyWith => throw _privateConstructorUsedError;
}
