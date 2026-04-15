// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kudos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Kudos _$KudosFromJson(Map<String, dynamic> json) {
  return _Kudos.fromJson(json);
}

/// @nodoc
mixin _$Kudos {
  String get id => throw _privateConstructorUsedError;
  UserSummary get sender => throw _privateConstructorUsedError;
  UserSummary get receiver => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<Hashtag> get hashtags => throw _privateConstructorUsedError;
  int get heartCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isHighlight => throw _privateConstructorUsedError;
  bool get isAnonymous => throw _privateConstructorUsedError;
  bool get isLikedByMe => throw _privateConstructorUsedError;
  bool get canLike => throw _privateConstructorUsedError;
  String get shareUrl => throw _privateConstructorUsedError;
  String? get awardTitle => throw _privateConstructorUsedError;
  String? get senderAlias => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;

  /// Serializes this Kudos to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Kudos
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KudosCopyWith<Kudos> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KudosCopyWith<$Res> {
  factory $KudosCopyWith(Kudos value, $Res Function(Kudos) then) =
      _$KudosCopyWithImpl<$Res, Kudos>;
  @useResult
  $Res call({
    String id,
    UserSummary sender,
    UserSummary receiver,
    String content,
    List<Hashtag> hashtags,
    int heartCount,
    DateTime createdAt,
    bool isHighlight,
    bool isAnonymous,
    bool isLikedByMe,
    bool canLike,
    String shareUrl,
    String? awardTitle,
    String? senderAlias,
    List<String> imageUrls,
  });

  $UserSummaryCopyWith<$Res> get sender;
  $UserSummaryCopyWith<$Res> get receiver;
}

/// @nodoc
class _$KudosCopyWithImpl<$Res, $Val extends Kudos>
    implements $KudosCopyWith<$Res> {
  _$KudosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Kudos
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? receiver = null,
    Object? content = null,
    Object? hashtags = null,
    Object? heartCount = null,
    Object? createdAt = null,
    Object? isHighlight = null,
    Object? isAnonymous = null,
    Object? isLikedByMe = null,
    Object? canLike = null,
    Object? shareUrl = null,
    Object? awardTitle = freezed,
    Object? senderAlias = freezed,
    Object? imageUrls = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sender: null == sender
                ? _value.sender
                : sender // ignore: cast_nullable_to_non_nullable
                      as UserSummary,
            receiver: null == receiver
                ? _value.receiver
                : receiver // ignore: cast_nullable_to_non_nullable
                      as UserSummary,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            hashtags: null == hashtags
                ? _value.hashtags
                : hashtags // ignore: cast_nullable_to_non_nullable
                      as List<Hashtag>,
            heartCount: null == heartCount
                ? _value.heartCount
                : heartCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isHighlight: null == isHighlight
                ? _value.isHighlight
                : isHighlight // ignore: cast_nullable_to_non_nullable
                      as bool,
            isAnonymous: null == isAnonymous
                ? _value.isAnonymous
                : isAnonymous // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLikedByMe: null == isLikedByMe
                ? _value.isLikedByMe
                : isLikedByMe // ignore: cast_nullable_to_non_nullable
                      as bool,
            canLike: null == canLike
                ? _value.canLike
                : canLike // ignore: cast_nullable_to_non_nullable
                      as bool,
            shareUrl: null == shareUrl
                ? _value.shareUrl
                : shareUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            awardTitle: freezed == awardTitle
                ? _value.awardTitle
                : awardTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            senderAlias: freezed == senderAlias
                ? _value.senderAlias
                : senderAlias // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrls: null == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of Kudos
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res> get sender {
    return $UserSummaryCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }

  /// Create a copy of Kudos
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res> get receiver {
    return $UserSummaryCopyWith<$Res>(_value.receiver, (value) {
      return _then(_value.copyWith(receiver: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$KudosImplCopyWith<$Res> implements $KudosCopyWith<$Res> {
  factory _$$KudosImplCopyWith(
    _$KudosImpl value,
    $Res Function(_$KudosImpl) then,
  ) = __$$KudosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    UserSummary sender,
    UserSummary receiver,
    String content,
    List<Hashtag> hashtags,
    int heartCount,
    DateTime createdAt,
    bool isHighlight,
    bool isAnonymous,
    bool isLikedByMe,
    bool canLike,
    String shareUrl,
    String? awardTitle,
    String? senderAlias,
    List<String> imageUrls,
  });

  @override
  $UserSummaryCopyWith<$Res> get sender;
  @override
  $UserSummaryCopyWith<$Res> get receiver;
}

/// @nodoc
class __$$KudosImplCopyWithImpl<$Res>
    extends _$KudosCopyWithImpl<$Res, _$KudosImpl>
    implements _$$KudosImplCopyWith<$Res> {
  __$$KudosImplCopyWithImpl(
    _$KudosImpl _value,
    $Res Function(_$KudosImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Kudos
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? receiver = null,
    Object? content = null,
    Object? hashtags = null,
    Object? heartCount = null,
    Object? createdAt = null,
    Object? isHighlight = null,
    Object? isAnonymous = null,
    Object? isLikedByMe = null,
    Object? canLike = null,
    Object? shareUrl = null,
    Object? awardTitle = freezed,
    Object? senderAlias = freezed,
    Object? imageUrls = null,
  }) {
    return _then(
      _$KudosImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sender: null == sender
            ? _value.sender
            : sender // ignore: cast_nullable_to_non_nullable
                  as UserSummary,
        receiver: null == receiver
            ? _value.receiver
            : receiver // ignore: cast_nullable_to_non_nullable
                  as UserSummary,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        hashtags: null == hashtags
            ? _value._hashtags
            : hashtags // ignore: cast_nullable_to_non_nullable
                  as List<Hashtag>,
        heartCount: null == heartCount
            ? _value.heartCount
            : heartCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isHighlight: null == isHighlight
            ? _value.isHighlight
            : isHighlight // ignore: cast_nullable_to_non_nullable
                  as bool,
        isAnonymous: null == isAnonymous
            ? _value.isAnonymous
            : isAnonymous // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLikedByMe: null == isLikedByMe
            ? _value.isLikedByMe
            : isLikedByMe // ignore: cast_nullable_to_non_nullable
                  as bool,
        canLike: null == canLike
            ? _value.canLike
            : canLike // ignore: cast_nullable_to_non_nullable
                  as bool,
        shareUrl: null == shareUrl
            ? _value.shareUrl
            : shareUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        awardTitle: freezed == awardTitle
            ? _value.awardTitle
            : awardTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        senderAlias: freezed == senderAlias
            ? _value.senderAlias
            : senderAlias // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrls: null == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KudosImpl implements _Kudos {
  const _$KudosImpl({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.content,
    final List<Hashtag> hashtags = const [],
    this.heartCount = 0,
    required this.createdAt,
    this.isHighlight = false,
    this.isAnonymous = false,
    this.isLikedByMe = false,
    this.canLike = true,
    this.shareUrl = '',
    this.awardTitle,
    this.senderAlias,
    final List<String> imageUrls = const [],
  }) : _hashtags = hashtags,
       _imageUrls = imageUrls;

  factory _$KudosImpl.fromJson(Map<String, dynamic> json) =>
      _$$KudosImplFromJson(json);

  @override
  final String id;
  @override
  final UserSummary sender;
  @override
  final UserSummary receiver;
  @override
  final String content;
  final List<Hashtag> _hashtags;
  @override
  @JsonKey()
  List<Hashtag> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  @override
  @JsonKey()
  final int heartCount;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isHighlight;
  @override
  @JsonKey()
  final bool isAnonymous;
  @override
  @JsonKey()
  final bool isLikedByMe;
  @override
  @JsonKey()
  final bool canLike;
  @override
  @JsonKey()
  final String shareUrl;
  @override
  final String? awardTitle;
  @override
  final String? senderAlias;
  final List<String> _imageUrls;
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  String toString() {
    return 'Kudos(id: $id, sender: $sender, receiver: $receiver, content: $content, hashtags: $hashtags, heartCount: $heartCount, createdAt: $createdAt, isHighlight: $isHighlight, isAnonymous: $isAnonymous, isLikedByMe: $isLikedByMe, canLike: $canLike, shareUrl: $shareUrl, awardTitle: $awardTitle, senderAlias: $senderAlias, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KudosImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.receiver, receiver) ||
                other.receiver == receiver) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags) &&
            (identical(other.heartCount, heartCount) ||
                other.heartCount == heartCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isHighlight, isHighlight) ||
                other.isHighlight == isHighlight) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.isLikedByMe, isLikedByMe) ||
                other.isLikedByMe == isLikedByMe) &&
            (identical(other.canLike, canLike) || other.canLike == canLike) &&
            (identical(other.shareUrl, shareUrl) ||
                other.shareUrl == shareUrl) &&
            (identical(other.awardTitle, awardTitle) ||
                other.awardTitle == awardTitle) &&
            (identical(other.senderAlias, senderAlias) ||
                other.senderAlias == senderAlias) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sender,
    receiver,
    content,
    const DeepCollectionEquality().hash(_hashtags),
    heartCount,
    createdAt,
    isHighlight,
    isAnonymous,
    isLikedByMe,
    canLike,
    shareUrl,
    awardTitle,
    senderAlias,
    const DeepCollectionEquality().hash(_imageUrls),
  );

  /// Create a copy of Kudos
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KudosImplCopyWith<_$KudosImpl> get copyWith =>
      __$$KudosImplCopyWithImpl<_$KudosImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KudosImplToJson(this);
  }
}

abstract class _Kudos implements Kudos {
  const factory _Kudos({
    required final String id,
    required final UserSummary sender,
    required final UserSummary receiver,
    required final String content,
    final List<Hashtag> hashtags,
    final int heartCount,
    required final DateTime createdAt,
    final bool isHighlight,
    final bool isAnonymous,
    final bool isLikedByMe,
    final bool canLike,
    final String shareUrl,
    final String? awardTitle,
    final String? senderAlias,
    final List<String> imageUrls,
  }) = _$KudosImpl;

  factory _Kudos.fromJson(Map<String, dynamic> json) = _$KudosImpl.fromJson;

  @override
  String get id;
  @override
  UserSummary get sender;
  @override
  UserSummary get receiver;
  @override
  String get content;
  @override
  List<Hashtag> get hashtags;
  @override
  int get heartCount;
  @override
  DateTime get createdAt;
  @override
  bool get isHighlight;
  @override
  bool get isAnonymous;
  @override
  bool get isLikedByMe;
  @override
  bool get canLike;
  @override
  String get shareUrl;
  @override
  String? get awardTitle;
  @override
  String? get senderAlias;
  @override
  List<String> get imageUrls;

  /// Create a copy of Kudos
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KudosImplCopyWith<_$KudosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
