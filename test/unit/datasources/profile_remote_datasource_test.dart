import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:saa_mobile/features/profile/data/models/badge.dart';
import 'package:saa_mobile/features/profile/data/models/icon_badge.dart';
import 'package:saa_mobile/features/profile/data/models/user_profile.dart';

// ─── Fake PostgREST builders ───
// Toàn bộ PostgREST builder hierarchy implement Future<T>.
// Mocktail không cho thenReturn(Future), nên dùng Fake cho tất cả.

class FakeFilterBuilder extends Fake
    implements
        PostgrestFilterBuilder<PostgrestList>,
        Future<PostgrestList> {
  final PostgrestList _listData;
  final PostgrestMap? _singleData;
  final Exception? _throwOnSingle;

  FakeFilterBuilder({
    PostgrestList listData = const [],
    PostgrestMap? singleData,
    Exception? throwOnSingle,
  })  : _listData = listData,
        _singleData = singleData,
        _throwOnSingle = throwOnSingle;

  @override
  PostgrestFilterBuilder<PostgrestList> eq(String column, Object value) => this;
  @override
  PostgrestFilterBuilder<PostgrestList> ilike(String column, Object value) =>
      this;
  @override
  PostgrestFilterBuilder<PostgrestList> isFilter(
          String column, Object? value) =>
      this;

  @override
  PostgrestTransformBuilder<PostgrestList> order(
    String column, {
    bool ascending = false,
    bool nullsFirst = false,
    String? referencedTable,
  }) =>
      this;

  @override
  PostgrestTransformBuilder<PostgrestList> limit(int count,
          {String? referencedTable}) =>
      this;

  @override
  PostgrestTransformBuilder<PostgrestList> range(int from, int to,
          {String? referencedTable}) =>
      this;

  @override
  PostgrestTransformBuilder<PostgrestMap> single() {
    if (_throwOnSingle != null) throw _throwOnSingle;
    return _FakeSingleBuilder(_singleData ?? {});
  }

  @override
  PostgrestTransformBuilder<PostgrestMap?> maybeSingle() =>
      _FakeMaybeSingleBuilder(_singleData);

  // ─── Future<PostgrestList> ───
  @override
  Stream<PostgrestList> asStream() => Stream.value(_listData);
  @override
  Future<PostgrestList> catchError(Function onError,
          {bool Function(Object error)? test}) =>
      Future.value(_listData).catchError(onError, test: test);
  @override
  Future<S> then<S>(FutureOr<S> Function(PostgrestList) onValue,
          {Function? onError}) =>
      Future.value(_listData).then(onValue, onError: onError);
  @override
  Future<PostgrestList> timeout(Duration timeLimit,
          {FutureOr<PostgrestList> Function()? onTimeout}) =>
      Future.value(_listData);
  @override
  Future<PostgrestList> whenComplete(FutureOr<void> Function() action) =>
      Future.value(_listData).whenComplete(action);
}

class _FakeSingleBuilder extends Fake
    implements
        PostgrestTransformBuilder<PostgrestMap>,
        Future<PostgrestMap> {
  final PostgrestMap _data;
  _FakeSingleBuilder(this._data);

  @override
  Stream<PostgrestMap> asStream() => Stream.value(_data);
  @override
  Future<PostgrestMap> catchError(Function onError,
          {bool Function(Object error)? test}) =>
      Future.value(_data).catchError(onError, test: test);
  @override
  Future<S> then<S>(FutureOr<S> Function(PostgrestMap) onValue,
          {Function? onError}) =>
      Future.value(_data).then(onValue, onError: onError);
  @override
  Future<PostgrestMap> timeout(Duration timeLimit,
          {FutureOr<PostgrestMap> Function()? onTimeout}) =>
      Future.value(_data);
  @override
  Future<PostgrestMap> whenComplete(FutureOr<void> Function() action) =>
      Future.value(_data).whenComplete(action);
}

class _FakeMaybeSingleBuilder extends Fake
    implements
        PostgrestTransformBuilder<PostgrestMap?>,
        Future<PostgrestMap?> {
  final PostgrestMap? _data;
  _FakeMaybeSingleBuilder(this._data);

  @override
  Stream<PostgrestMap?> asStream() => Stream.value(_data);
  @override
  Future<PostgrestMap?> catchError(Function onError,
          {bool Function(Object error)? test}) =>
      Future.value(_data).catchError(onError, test: test);
  @override
  Future<S> then<S>(FutureOr<S> Function(PostgrestMap?) onValue,
          {Function? onError}) =>
      Future.value(_data).then(onValue, onError: onError);
  @override
  Future<PostgrestMap?> timeout(Duration timeLimit,
          {FutureOr<PostgrestMap?> Function()? onTimeout}) =>
      Future.value(_data);
  @override
  Future<PostgrestMap?> whenComplete(FutureOr<void> Function() action) =>
      Future.value(_data).whenComplete(action);
}

/// Fake SupabaseQueryBuilder — select() trả FakeFilterBuilder.
class FakeQueryBuilder extends Fake implements SupabaseQueryBuilder {
  final FakeFilterBuilder _filterBuilder;
  FakeQueryBuilder(this._filterBuilder);

  @override
  PostgrestFilterBuilder<PostgrestList> select([String columns = '*']) =>
      _filterBuilder;
}

/// Fake SupabaseClient — dùng thay Mock vì from() trả SupabaseQueryBuilder
/// (implements Future), và mocktail từ chối thenReturn(Future).
class FakeSupabaseClient extends Fake implements SupabaseClient {
  final Map<String, FakeQueryBuilder> _tables = {};
  GoTrueClient? _authOverride;

  void stubTable(
    String name, {
    PostgrestList listData = const [],
    PostgrestMap? singleData,
    Exception? throwOnSingle,
  }) {
    _tables[name] = FakeQueryBuilder(FakeFilterBuilder(
      listData: listData,
      singleData: singleData,
      throwOnSingle: throwOnSingle,
    ));
  }

  void stubAuth(GoTrueClient auth) {
    _authOverride = auth;
  }

  @override
  SupabaseQueryBuilder from(String table) {
    final qb = _tables[table];
    if (qb == null) {
      throw StateError('Table "$table" chưa được stub trong test');
    }
    return qb;
  }

  @override
  GoTrueClient get auth => _authOverride ?? (throw StateError('Auth chưa stub'));
}

class MockGoTrueClient extends Mock implements GoTrueClient {}

// ─── Dữ liệu test ───

final _fakeAuthUser = User(
  id: 'auth-uuid-123',
  appMetadata: {},
  userMetadata: {},
  aud: 'authenticated',
  createdAt: DateTime(2025, 1, 1).toIso8601String(),
);

final _userRow = <String, dynamic>{
  'id': 1,
  'name': 'Nguyễn Văn A',
  'email': 'a@sun-asterisk.com',
  'avatar_url': 'https://example.com/avatar.png',
  'hero_tier': 'new_hero',
  'team_code': 'CECV1',
  'department': {'name': 'Division A'},
};

final _iconBadgeRows = <Map<String, dynamic>>[
  {
    'badge': {
      'id': 1,
      'name': 'Top Talent',
      'image_url': 'https://example.com/badge1.png',
    },
    'earned_at': '2025-12-01T00:00:00.000',
  },
  {
    'badge': {
      'id': 2,
      'name': 'Rising Star',
      'image_url': 'https://example.com/badge2.png',
    },
    'earned_at': '2025-11-15T00:00:00.000',
  },
];

final _badgeRows = <Map<String, dynamic>>[
  {
    'badge': {
      'id': 1,
      'name': 'Rising Hero',
      'image_url': 'https://example.com/badge1.png',
      'description': 'Huy hiệu hero',
    },
  },
  {
    'badge': {
      'id': 2,
      'name': 'Super Hero',
      'image_url': 'https://example.com/badge2.png',
      'description': null,
    },
  },
];

final _kudosRow = <String, dynamic>{
  'id': 100,
  'award_title': 'Best Team Player',
  'message': 'Cảm ơn bạn!',
  'award_category_name': 'Top Talent',
  'is_anonymous': false,
  'status': 'active',
  'created_at': '2025-12-01T10:00:00.000',
  'sender': {
    'id': 1,
    'name': 'Nguyễn Văn A',
    'avatar_url': 'https://example.com/a.png',
    'hero_tier': 'new_hero',
    'department': {'name': 'CECV1'},
  },
  'recipient': {
    'id': 2,
    'name': 'Trần Thị B',
    'avatar_url': 'https://example.com/b.png',
    'hero_tier': 'rising_hero',
    'department': {'name': 'Division A'},
  },
  'hashtags': [
    {
      'hashtag': {'id': 1, 'name': '#teamwork'},
    },
  ],
  'reactions': [
    {'count': 5},
  ],
  'photos': <Map<String, dynamic>>[],
};

final _statsRow = <String, dynamic>{
  'kudos_received_count': 25,
  'kudos_sent_count': 10,
  'hearts_received_count': 30,
  'secret_boxes_opened': 3,
  'secret_boxes_unopened': 2,
};

final _searchUserRows = <Map<String, dynamic>>[
  {
    'id': 1,
    'name': 'Nguyễn Văn A',
    'email': 'a@sun-asterisk.com',
    'avatar_url': 'https://example.com/a.png',
    'hero_tier': 'new_hero',
    'team_code': 'CECV1',
    'department': {'name': 'Division A'},
  },
];

void main() {
  late FakeSupabaseClient fakeClient;
  late MockGoTrueClient mockAuth;
  late ProfileRemoteDatasource datasource;

  setUp(() {
    fakeClient = FakeSupabaseClient();
    mockAuth = MockGoTrueClient();
    fakeClient.stubAuth(mockAuth);
    datasource = ProfileRemoteDatasource(fakeClient);
  });

  /// Stub user đăng nhập + users table trả userId cho auth lookup.
  void stubLoggedIn({required int userId}) {
    when(() => mockAuth.currentUser).thenReturn(_fakeAuthUser);
    fakeClient.stubTable('users', singleData: {'id': userId});
  }

  // ─── fetchMyProfile ───

  group('fetchMyProfile', () {
    test('trả về UserProfile khi đăng nhập thành công', () async {
      when(() => mockAuth.currentUser).thenReturn(_fakeAuthUser);
      // users table: maybeSingle trả {'id': 1} (chỉ lấy ['id']),
      // single trả _userRow. Cả 2 dùng chung singleData.
      fakeClient.stubTable('users', singleData: _userRow);

      final result = await datasource.fetchMyProfile();

      expect(result, isA<UserProfile>());
      expect(result.id, '1');
      expect(result.name, 'Nguyễn Văn A');
      expect(result.departmentName, 'Division A');
      expect(result.heroTier, 'new_hero');
    });

    test('throw Exception khi chưa đăng nhập', () async {
      when(() => mockAuth.currentUser).thenReturn(null);

      expect(
        () => datasource.fetchMyProfile(),
        throwsA(isA<Exception>()),
      );
    });
  });

  // ─── fetchUserProfile ───

  group('fetchUserProfile', () {
    test('trả về UserProfile theo userId', () async {
      fakeClient.stubTable('users', singleData: {
        ..._userRow,
        'id': 2,
        'name': 'Trần Thị B',
      });

      final result = await datasource.fetchUserProfile('2');

      expect(result, isA<UserProfile>());
      expect(result.id, '2');
      expect(result.name, 'Trần Thị B');
    });

    test('throw khi user không tồn tại', () async {
      fakeClient.stubTable('users', throwOnSingle: Exception('Not found'));

      expect(
        () => datasource.fetchUserProfile('999'),
        throwsA(isA<Exception>()),
      );
    });
  });

  // ─── fetchMyIconBadges ───

  group('fetchMyIconBadges', () {
    test('trả về List<IconBadge> khi đăng nhập', () async {
      stubLoggedIn(userId: 1);
      fakeClient.stubTable('user_badges', listData: _iconBadgeRows);

      final result = await datasource.fetchMyIconBadges();

      expect(result, isA<List<IconBadge>>());
      expect(result.length, 2);
      expect(result.first.badgeName, 'Top Talent');
      expect(result.first.badgeId, 1);
    });

    test('throw Exception khi chưa đăng nhập', () async {
      when(() => mockAuth.currentUser).thenReturn(null);

      expect(
        () => datasource.fetchMyIconBadges(),
        throwsA(isA<Exception>()),
      );
    });
  });

  // ─── fetchUserBadges ───

  group('fetchUserBadges', () {
    test('trả về List<Badge> theo userId', () async {
      fakeClient.stubTable('user_badges', listData: _badgeRows);

      final result = await datasource.fetchUserBadges('2');

      expect(result, isA<List<Badge>>());
      expect(result.length, 2);
      expect(result.first.name, 'Rising Hero');
    });

    test('trả về danh sách rỗng khi user không có badge', () async {
      fakeClient.stubTable('user_badges', listData: []);

      final result = await datasource.fetchUserBadges('3');

      expect(result, isEmpty);
    });
  });

  // ─── fetchMyStats ───

  group('fetchMyStats', () {
    test('trả về PersonalStats khi đăng nhập', () async {
      stubLoggedIn(userId: 1);
      fakeClient.stubTable('user_stats', singleData: _statsRow);

      final result = await datasource.fetchMyStats();

      expect(result, isA<PersonalStats>());
      expect(result.kudosReceived, 25);
      expect(result.kudosSent, 10);
      expect(result.heartsReceived, 30);
      expect(result.secretBoxesOpened, 3);
      expect(result.secretBoxesUnopened, 2);
    });

    test('trả về PersonalStats mặc định khi chưa đăng nhập', () async {
      when(() => mockAuth.currentUser).thenReturn(null);

      final result = await datasource.fetchMyStats();

      expect(result, const PersonalStats());
    });

    test('trả về PersonalStats mặc định khi không có data', () async {
      stubLoggedIn(userId: 1);
      fakeClient.stubTable('user_stats');

      final result = await datasource.fetchMyStats();

      expect(result, const PersonalStats());
    });
  });

  // ─── fetchKudosHistory ───

  group('fetchKudosHistory', () {
    test('trả về List<Kudos> với filter "sent"', () async {
      fakeClient.stubTable('kudos', listData: [_kudosRow]);

      final result = await datasource.fetchKudosHistory(
        userId: '1',
        filter: 'sent',
        page: 1,
        limit: 20,
      );

      expect(result, isA<List<Kudos>>());
      expect(result.length, 1);
      expect(result.first.content, 'Cảm ơn bạn!');
      expect(result.first.heartCount, 5);
    });

    test('trả về List<Kudos> với filter "received"', () async {
      fakeClient.stubTable('kudos', listData: [_kudosRow]);

      final result = await datasource.fetchKudosHistory(
        userId: '2',
        filter: 'received',
        page: 1,
        limit: 20,
      );

      expect(result, isA<List<Kudos>>());
      expect(result.length, 1);
    });

    test('trả về danh sách rỗng khi không có kudos', () async {
      fakeClient.stubTable('kudos', listData: []);

      final result = await datasource.fetchKudosHistory(
        userId: '1',
        filter: 'sent',
      );

      expect(result, isEmpty);
    });

    test('hỗ trợ phân trang với page > 1', () async {
      fakeClient.stubTable('kudos', listData: [_kudosRow]);

      final result = await datasource.fetchKudosHistory(
        userId: '1',
        filter: 'sent',
        page: 2,
        limit: 20,
      );

      expect(result.length, 1);
    });
  });

  // ─── searchUsers ───

  group('searchUsers', () {
    test('trả về List<UserProfile> theo query', () async {
      fakeClient.stubTable('users', listData: _searchUserRows);

      final result = await datasource.searchUsers('Nguyễn');

      expect(result, isA<List<UserProfile>>());
      expect(result.length, 1);
      expect(result.first.name, 'Nguyễn Văn A');
    });

    test('trả về danh sách rỗng khi không tìm thấy', () async {
      fakeClient.stubTable('users', listData: []);

      final result = await datasource.searchUsers('XYZ');

      expect(result, isEmpty);
    });
  });
}
