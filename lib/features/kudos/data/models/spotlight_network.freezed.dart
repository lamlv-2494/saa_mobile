// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spotlight_network.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SpotlightNode _$SpotlightNodeFromJson(Map<String, dynamic> json) {
  return _SpotlightNode.fromJson(json);
}

/// @nodoc
mixin _$SpotlightNode {
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;

  /// Serializes this SpotlightNode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpotlightNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotlightNodeCopyWith<SpotlightNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotlightNodeCopyWith<$Res> {
  factory $SpotlightNodeCopyWith(
    SpotlightNode value,
    $Res Function(SpotlightNode) then,
  ) = _$SpotlightNodeCopyWithImpl<$Res, SpotlightNode>;
  @useResult
  $Res call({String userId, String name, String avatar, double x, double y});
}

/// @nodoc
class _$SpotlightNodeCopyWithImpl<$Res, $Val extends SpotlightNode>
    implements $SpotlightNodeCopyWith<$Res> {
  _$SpotlightNodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpotlightNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? avatar = null,
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
            avatar: null == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
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
abstract class _$$SpotlightNodeImplCopyWith<$Res>
    implements $SpotlightNodeCopyWith<$Res> {
  factory _$$SpotlightNodeImplCopyWith(
    _$SpotlightNodeImpl value,
    $Res Function(_$SpotlightNodeImpl) then,
  ) = __$$SpotlightNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String name, String avatar, double x, double y});
}

/// @nodoc
class __$$SpotlightNodeImplCopyWithImpl<$Res>
    extends _$SpotlightNodeCopyWithImpl<$Res, _$SpotlightNodeImpl>
    implements _$$SpotlightNodeImplCopyWith<$Res> {
  __$$SpotlightNodeImplCopyWithImpl(
    _$SpotlightNodeImpl _value,
    $Res Function(_$SpotlightNodeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpotlightNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? avatar = null,
    Object? x = null,
    Object? y = null,
  }) {
    return _then(
      _$SpotlightNodeImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        avatar: null == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
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
class _$SpotlightNodeImpl implements _SpotlightNode {
  const _$SpotlightNodeImpl({
    required this.userId,
    required this.name,
    this.avatar = '',
    this.x = 0.0,
    this.y = 0.0,
  });

  factory _$SpotlightNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpotlightNodeImplFromJson(json);

  @override
  final String userId;
  @override
  final String name;
  @override
  @JsonKey()
  final String avatar;
  @override
  @JsonKey()
  final double x;
  @override
  @JsonKey()
  final double y;

  @override
  String toString() {
    return 'SpotlightNode(userId: $userId, name: $name, avatar: $avatar, x: $x, y: $y)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotlightNodeImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, name, avatar, x, y);

  /// Create a copy of SpotlightNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotlightNodeImplCopyWith<_$SpotlightNodeImpl> get copyWith =>
      __$$SpotlightNodeImplCopyWithImpl<_$SpotlightNodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpotlightNodeImplToJson(this);
  }
}

abstract class _SpotlightNode implements SpotlightNode {
  const factory _SpotlightNode({
    required final String userId,
    required final String name,
    final String avatar,
    final double x,
    final double y,
  }) = _$SpotlightNodeImpl;

  factory _SpotlightNode.fromJson(Map<String, dynamic> json) =
      _$SpotlightNodeImpl.fromJson;

  @override
  String get userId;
  @override
  String get name;
  @override
  String get avatar;
  @override
  double get x;
  @override
  double get y;

  /// Create a copy of SpotlightNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotlightNodeImplCopyWith<_$SpotlightNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpotlightEdge _$SpotlightEdgeFromJson(Map<String, dynamic> json) {
  return _SpotlightEdge.fromJson(json);
}

/// @nodoc
mixin _$SpotlightEdge {
  String get fromUserId => throw _privateConstructorUsedError;
  String get toUserId => throw _privateConstructorUsedError;
  int get weight => throw _privateConstructorUsedError;

  /// Serializes this SpotlightEdge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpotlightEdge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotlightEdgeCopyWith<SpotlightEdge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotlightEdgeCopyWith<$Res> {
  factory $SpotlightEdgeCopyWith(
    SpotlightEdge value,
    $Res Function(SpotlightEdge) then,
  ) = _$SpotlightEdgeCopyWithImpl<$Res, SpotlightEdge>;
  @useResult
  $Res call({String fromUserId, String toUserId, int weight});
}

/// @nodoc
class _$SpotlightEdgeCopyWithImpl<$Res, $Val extends SpotlightEdge>
    implements $SpotlightEdgeCopyWith<$Res> {
  _$SpotlightEdgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpotlightEdge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? weight = null,
  }) {
    return _then(
      _value.copyWith(
            fromUserId: null == fromUserId
                ? _value.fromUserId
                : fromUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            toUserId: null == toUserId
                ? _value.toUserId
                : toUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            weight: null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SpotlightEdgeImplCopyWith<$Res>
    implements $SpotlightEdgeCopyWith<$Res> {
  factory _$$SpotlightEdgeImplCopyWith(
    _$SpotlightEdgeImpl value,
    $Res Function(_$SpotlightEdgeImpl) then,
  ) = __$$SpotlightEdgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fromUserId, String toUserId, int weight});
}

/// @nodoc
class __$$SpotlightEdgeImplCopyWithImpl<$Res>
    extends _$SpotlightEdgeCopyWithImpl<$Res, _$SpotlightEdgeImpl>
    implements _$$SpotlightEdgeImplCopyWith<$Res> {
  __$$SpotlightEdgeImplCopyWithImpl(
    _$SpotlightEdgeImpl _value,
    $Res Function(_$SpotlightEdgeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpotlightEdge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? weight = null,
  }) {
    return _then(
      _$SpotlightEdgeImpl(
        fromUserId: null == fromUserId
            ? _value.fromUserId
            : fromUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        toUserId: null == toUserId
            ? _value.toUserId
            : toUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SpotlightEdgeImpl implements _SpotlightEdge {
  const _$SpotlightEdgeImpl({
    required this.fromUserId,
    required this.toUserId,
    this.weight = 1,
  });

  factory _$SpotlightEdgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpotlightEdgeImplFromJson(json);

  @override
  final String fromUserId;
  @override
  final String toUserId;
  @override
  @JsonKey()
  final int weight;

  @override
  String toString() {
    return 'SpotlightEdge(fromUserId: $fromUserId, toUserId: $toUserId, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotlightEdgeImpl &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fromUserId, toUserId, weight);

  /// Create a copy of SpotlightEdge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotlightEdgeImplCopyWith<_$SpotlightEdgeImpl> get copyWith =>
      __$$SpotlightEdgeImplCopyWithImpl<_$SpotlightEdgeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpotlightEdgeImplToJson(this);
  }
}

abstract class _SpotlightEdge implements SpotlightEdge {
  const factory _SpotlightEdge({
    required final String fromUserId,
    required final String toUserId,
    final int weight,
  }) = _$SpotlightEdgeImpl;

  factory _SpotlightEdge.fromJson(Map<String, dynamic> json) =
      _$SpotlightEdgeImpl.fromJson;

  @override
  String get fromUserId;
  @override
  String get toUserId;
  @override
  int get weight;

  /// Create a copy of SpotlightEdge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotlightEdgeImplCopyWith<_$SpotlightEdgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpotlightNetwork _$SpotlightNetworkFromJson(Map<String, dynamic> json) {
  return _SpotlightNetwork.fromJson(json);
}

/// @nodoc
mixin _$SpotlightNetwork {
  List<SpotlightNode> get nodes => throw _privateConstructorUsedError;
  List<SpotlightEdge> get edges => throw _privateConstructorUsedError;
  int get totalKudos => throw _privateConstructorUsedError;

  /// Serializes this SpotlightNetwork to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpotlightNetwork
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotlightNetworkCopyWith<SpotlightNetwork> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotlightNetworkCopyWith<$Res> {
  factory $SpotlightNetworkCopyWith(
    SpotlightNetwork value,
    $Res Function(SpotlightNetwork) then,
  ) = _$SpotlightNetworkCopyWithImpl<$Res, SpotlightNetwork>;
  @useResult
  $Res call({
    List<SpotlightNode> nodes,
    List<SpotlightEdge> edges,
    int totalKudos,
  });
}

/// @nodoc
class _$SpotlightNetworkCopyWithImpl<$Res, $Val extends SpotlightNetwork>
    implements $SpotlightNetworkCopyWith<$Res> {
  _$SpotlightNetworkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpotlightNetwork
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? edges = null,
    Object? totalKudos = null,
  }) {
    return _then(
      _value.copyWith(
            nodes: null == nodes
                ? _value.nodes
                : nodes // ignore: cast_nullable_to_non_nullable
                      as List<SpotlightNode>,
            edges: null == edges
                ? _value.edges
                : edges // ignore: cast_nullable_to_non_nullable
                      as List<SpotlightEdge>,
            totalKudos: null == totalKudos
                ? _value.totalKudos
                : totalKudos // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SpotlightNetworkImplCopyWith<$Res>
    implements $SpotlightNetworkCopyWith<$Res> {
  factory _$$SpotlightNetworkImplCopyWith(
    _$SpotlightNetworkImpl value,
    $Res Function(_$SpotlightNetworkImpl) then,
  ) = __$$SpotlightNetworkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<SpotlightNode> nodes,
    List<SpotlightEdge> edges,
    int totalKudos,
  });
}

/// @nodoc
class __$$SpotlightNetworkImplCopyWithImpl<$Res>
    extends _$SpotlightNetworkCopyWithImpl<$Res, _$SpotlightNetworkImpl>
    implements _$$SpotlightNetworkImplCopyWith<$Res> {
  __$$SpotlightNetworkImplCopyWithImpl(
    _$SpotlightNetworkImpl _value,
    $Res Function(_$SpotlightNetworkImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpotlightNetwork
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? edges = null,
    Object? totalKudos = null,
  }) {
    return _then(
      _$SpotlightNetworkImpl(
        nodes: null == nodes
            ? _value._nodes
            : nodes // ignore: cast_nullable_to_non_nullable
                  as List<SpotlightNode>,
        edges: null == edges
            ? _value._edges
            : edges // ignore: cast_nullable_to_non_nullable
                  as List<SpotlightEdge>,
        totalKudos: null == totalKudos
            ? _value.totalKudos
            : totalKudos // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SpotlightNetworkImpl implements _SpotlightNetwork {
  const _$SpotlightNetworkImpl({
    final List<SpotlightNode> nodes = const [],
    final List<SpotlightEdge> edges = const [],
    this.totalKudos = 0,
  }) : _nodes = nodes,
       _edges = edges;

  factory _$SpotlightNetworkImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpotlightNetworkImplFromJson(json);

  final List<SpotlightNode> _nodes;
  @override
  @JsonKey()
  List<SpotlightNode> get nodes {
    if (_nodes is EqualUnmodifiableListView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  final List<SpotlightEdge> _edges;
  @override
  @JsonKey()
  List<SpotlightEdge> get edges {
    if (_edges is EqualUnmodifiableListView) return _edges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_edges);
  }

  @override
  @JsonKey()
  final int totalKudos;

  @override
  String toString() {
    return 'SpotlightNetwork(nodes: $nodes, edges: $edges, totalKudos: $totalKudos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotlightNetworkImpl &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            const DeepCollectionEquality().equals(other._edges, _edges) &&
            (identical(other.totalKudos, totalKudos) ||
                other.totalKudos == totalKudos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_nodes),
    const DeepCollectionEquality().hash(_edges),
    totalKudos,
  );

  /// Create a copy of SpotlightNetwork
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotlightNetworkImplCopyWith<_$SpotlightNetworkImpl> get copyWith =>
      __$$SpotlightNetworkImplCopyWithImpl<_$SpotlightNetworkImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SpotlightNetworkImplToJson(this);
  }
}

abstract class _SpotlightNetwork implements SpotlightNetwork {
  const factory _SpotlightNetwork({
    final List<SpotlightNode> nodes,
    final List<SpotlightEdge> edges,
    final int totalKudos,
  }) = _$SpotlightNetworkImpl;

  factory _SpotlightNetwork.fromJson(Map<String, dynamic> json) =
      _$SpotlightNetworkImpl.fromJson;

  @override
  List<SpotlightNode> get nodes;
  @override
  List<SpotlightEdge> get edges;
  @override
  int get totalKudos;

  /// Create a copy of SpotlightNetwork
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotlightNetworkImplCopyWith<_$SpotlightNetworkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
