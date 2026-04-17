// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spotlight_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SpotlightEntry _$SpotlightEntryFromJson(Map<String, dynamic> json) {
  return _SpotlightEntry.fromJson(json);
}

/// @nodoc
mixin _$SpotlightEntry {
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;

  /// Serializes this SpotlightEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpotlightEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotlightEntryCopyWith<SpotlightEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotlightEntryCopyWith<$Res> {
  factory $SpotlightEntryCopyWith(
    SpotlightEntry value,
    $Res Function(SpotlightEntry) then,
  ) = _$SpotlightEntryCopyWithImpl<$Res, SpotlightEntry>;
  @useResult
  $Res call({String userId, String name, double x, double y});
}

/// @nodoc
class _$SpotlightEntryCopyWithImpl<$Res, $Val extends SpotlightEntry>
    implements $SpotlightEntryCopyWith<$Res> {
  _$SpotlightEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpotlightEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? x = null,
    Object? y = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            x: null == x
                ? _value.x
                : x // ignore: cast_nullable_to_non_nullable
                      as double,
            y: null == y
                ? _value.y
                : y // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SpotlightEntryImplCopyWith<$Res>
    implements $SpotlightEntryCopyWith<$Res> {
  factory _$$SpotlightEntryImplCopyWith(
    _$SpotlightEntryImpl value,
    $Res Function(_$SpotlightEntryImpl) then,
  ) = __$$SpotlightEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String name, double x, double y});
}

/// @nodoc
class __$$SpotlightEntryImplCopyWithImpl<$Res>
    extends _$SpotlightEntryCopyWithImpl<$Res, _$SpotlightEntryImpl>
    implements _$$SpotlightEntryImplCopyWith<$Res> {
  __$$SpotlightEntryImplCopyWithImpl(
    _$SpotlightEntryImpl _value,
    $Res Function(_$SpotlightEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpotlightEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? x = null,
    Object? y = null,
  }) {
    return _then(
      _$SpotlightEntryImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        x: null == x
            ? _value.x
            : x // ignore: cast_nullable_to_non_nullable
                  as double,
        y: null == y
            ? _value.y
            : y // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SpotlightEntryImpl implements _SpotlightEntry {
  const _$SpotlightEntryImpl({
    required this.userId,
    required this.name,
    this.x = 0.0,
    this.y = 0.0,
  });

  factory _$SpotlightEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpotlightEntryImplFromJson(json);

  @override
  final String userId;
  @override
  final String name;
  @override
  @JsonKey()
  final double x;
  @override
  @JsonKey()
  final double y;

  @override
  String toString() {
    return 'SpotlightEntry(userId: $userId, name: $name, x: $x, y: $y)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotlightEntryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, name, x, y);

  /// Create a copy of SpotlightEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotlightEntryImplCopyWith<_$SpotlightEntryImpl> get copyWith =>
      __$$SpotlightEntryImplCopyWithImpl<_$SpotlightEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SpotlightEntryImplToJson(this);
  }
}

abstract class _SpotlightEntry implements SpotlightEntry {
  const factory _SpotlightEntry({
    required final String userId,
    required final String name,
    final double x,
    final double y,
  }) = _$SpotlightEntryImpl;

  factory _SpotlightEntry.fromJson(Map<String, dynamic> json) =
      _$SpotlightEntryImpl.fromJson;

  @override
  String get userId;
  @override
  String get name;
  @override
  double get x;
  @override
  double get y;

  /// Create a copy of SpotlightEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotlightEntryImplCopyWith<_$SpotlightEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpotlightActivity _$SpotlightActivityFromJson(Map<String, dynamic> json) {
  return _SpotlightActivity.fromJson(json);
}

/// @nodoc
mixin _$SpotlightActivity {
  String get timestamp => throw _privateConstructorUsedError;
  String get receiverName => throw _privateConstructorUsedError;

  /// Serializes this SpotlightActivity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpotlightActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotlightActivityCopyWith<SpotlightActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotlightActivityCopyWith<$Res> {
  factory $SpotlightActivityCopyWith(
    SpotlightActivity value,
    $Res Function(SpotlightActivity) then,
  ) = _$SpotlightActivityCopyWithImpl<$Res, SpotlightActivity>;
  @useResult
  $Res call({String timestamp, String receiverName});
}

/// @nodoc
class _$SpotlightActivityCopyWithImpl<$Res, $Val extends SpotlightActivity>
    implements $SpotlightActivityCopyWith<$Res> {
  _$SpotlightActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpotlightActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? timestamp = null, Object? receiverName = null}) {
    return _then(
      _value.copyWith(
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverName: null == receiverName
                ? _value.receiverName
                : receiverName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SpotlightActivityImplCopyWith<$Res>
    implements $SpotlightActivityCopyWith<$Res> {
  factory _$$SpotlightActivityImplCopyWith(
    _$SpotlightActivityImpl value,
    $Res Function(_$SpotlightActivityImpl) then,
  ) = __$$SpotlightActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String timestamp, String receiverName});
}

/// @nodoc
class __$$SpotlightActivityImplCopyWithImpl<$Res>
    extends _$SpotlightActivityCopyWithImpl<$Res, _$SpotlightActivityImpl>
    implements _$$SpotlightActivityImplCopyWith<$Res> {
  __$$SpotlightActivityImplCopyWithImpl(
    _$SpotlightActivityImpl _value,
    $Res Function(_$SpotlightActivityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpotlightActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? timestamp = null, Object? receiverName = null}) {
    return _then(
      _$SpotlightActivityImpl(
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverName: null == receiverName
            ? _value.receiverName
            : receiverName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SpotlightActivityImpl implements _SpotlightActivity {
  const _$SpotlightActivityImpl({
    required this.timestamp,
    required this.receiverName,
  });

  factory _$SpotlightActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpotlightActivityImplFromJson(json);

  @override
  final String timestamp;
  @override
  final String receiverName;

  @override
  String toString() {
    return 'SpotlightActivity(timestamp: $timestamp, receiverName: $receiverName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotlightActivityImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.receiverName, receiverName) ||
                other.receiverName == receiverName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, receiverName);

  /// Create a copy of SpotlightActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotlightActivityImplCopyWith<_$SpotlightActivityImpl> get copyWith =>
      __$$SpotlightActivityImplCopyWithImpl<_$SpotlightActivityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SpotlightActivityImplToJson(this);
  }
}

abstract class _SpotlightActivity implements SpotlightActivity {
  const factory _SpotlightActivity({
    required final String timestamp,
    required final String receiverName,
  }) = _$SpotlightActivityImpl;

  factory _SpotlightActivity.fromJson(Map<String, dynamic> json) =
      _$SpotlightActivityImpl.fromJson;

  @override
  String get timestamp;
  @override
  String get receiverName;

  /// Create a copy of SpotlightActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotlightActivityImplCopyWith<_$SpotlightActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpotlightData _$SpotlightDataFromJson(Map<String, dynamic> json) {
  return _SpotlightData.fromJson(json);
}

/// @nodoc
mixin _$SpotlightData {
  List<SpotlightEntry> get entries => throw _privateConstructorUsedError;
  int get totalKudos => throw _privateConstructorUsedError;
  List<SpotlightActivity> get recentActivity =>
      throw _privateConstructorUsedError;

  /// Serializes this SpotlightData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpotlightData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotlightDataCopyWith<SpotlightData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotlightDataCopyWith<$Res> {
  factory $SpotlightDataCopyWith(
    SpotlightData value,
    $Res Function(SpotlightData) then,
  ) = _$SpotlightDataCopyWithImpl<$Res, SpotlightData>;
  @useResult
  $Res call({
    List<SpotlightEntry> entries,
    int totalKudos,
    List<SpotlightActivity> recentActivity,
  });
}

/// @nodoc
class _$SpotlightDataCopyWithImpl<$Res, $Val extends SpotlightData>
    implements $SpotlightDataCopyWith<$Res> {
  _$SpotlightDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpotlightData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? totalKudos = null,
    Object? recentActivity = null,
  }) {
    return _then(
      _value.copyWith(
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<SpotlightEntry>,
            totalKudos: null == totalKudos
                ? _value.totalKudos
                : totalKudos // ignore: cast_nullable_to_non_nullable
                      as int,
            recentActivity: null == recentActivity
                ? _value.recentActivity
                : recentActivity // ignore: cast_nullable_to_non_nullable
                      as List<SpotlightActivity>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SpotlightDataImplCopyWith<$Res>
    implements $SpotlightDataCopyWith<$Res> {
  factory _$$SpotlightDataImplCopyWith(
    _$SpotlightDataImpl value,
    $Res Function(_$SpotlightDataImpl) then,
  ) = __$$SpotlightDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<SpotlightEntry> entries,
    int totalKudos,
    List<SpotlightActivity> recentActivity,
  });
}

/// @nodoc
class __$$SpotlightDataImplCopyWithImpl<$Res>
    extends _$SpotlightDataCopyWithImpl<$Res, _$SpotlightDataImpl>
    implements _$$SpotlightDataImplCopyWith<$Res> {
  __$$SpotlightDataImplCopyWithImpl(
    _$SpotlightDataImpl _value,
    $Res Function(_$SpotlightDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpotlightData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? totalKudos = null,
    Object? recentActivity = null,
  }) {
    return _then(
      _$SpotlightDataImpl(
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<SpotlightEntry>,
        totalKudos: null == totalKudos
            ? _value.totalKudos
            : totalKudos // ignore: cast_nullable_to_non_nullable
                  as int,
        recentActivity: null == recentActivity
            ? _value._recentActivity
            : recentActivity // ignore: cast_nullable_to_non_nullable
                  as List<SpotlightActivity>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SpotlightDataImpl implements _SpotlightData {
  const _$SpotlightDataImpl({
    final List<SpotlightEntry> entries = const [],
    this.totalKudos = 0,
    final List<SpotlightActivity> recentActivity = const [],
  }) : _entries = entries,
       _recentActivity = recentActivity;

  factory _$SpotlightDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpotlightDataImplFromJson(json);

  final List<SpotlightEntry> _entries;
  @override
  @JsonKey()
  List<SpotlightEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  @JsonKey()
  final int totalKudos;
  final List<SpotlightActivity> _recentActivity;
  @override
  @JsonKey()
  List<SpotlightActivity> get recentActivity {
    if (_recentActivity is EqualUnmodifiableListView) return _recentActivity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentActivity);
  }

  @override
  String toString() {
    return 'SpotlightData(entries: $entries, totalKudos: $totalKudos, recentActivity: $recentActivity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotlightDataImpl &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.totalKudos, totalKudos) ||
                other.totalKudos == totalKudos) &&
            const DeepCollectionEquality().equals(
              other._recentActivity,
              _recentActivity,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_entries),
    totalKudos,
    const DeepCollectionEquality().hash(_recentActivity),
  );

  /// Create a copy of SpotlightData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotlightDataImplCopyWith<_$SpotlightDataImpl> get copyWith =>
      __$$SpotlightDataImplCopyWithImpl<_$SpotlightDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpotlightDataImplToJson(this);
  }
}

abstract class _SpotlightData implements SpotlightData {
  const factory _SpotlightData({
    final List<SpotlightEntry> entries,
    final int totalKudos,
    final List<SpotlightActivity> recentActivity,
  }) = _$SpotlightDataImpl;

  factory _SpotlightData.fromJson(Map<String, dynamic> json) =
      _$SpotlightDataImpl.fromJson;

  @override
  List<SpotlightEntry> get entries;
  @override
  int get totalKudos;
  @override
  List<SpotlightActivity> get recentActivity;

  /// Create a copy of SpotlightData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotlightDataImplCopyWith<_$SpotlightDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
