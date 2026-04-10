import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:saa_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:saa_mobile/features/auth/data/repositories/auth_repository.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthRemoteDataSource mockDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(dataSource: mockDataSource);
  });

  group('signInWithGoogle', () {
    test('should call dataSource.signInWithGoogle and return true', () async {
      when(
        () => mockDataSource.signInWithGoogle(),
      ).thenAnswer((_) async => true);

      final result = await repository.signInWithGoogle();

      verify(() => mockDataSource.signInWithGoogle()).called(1);
      expect(result, isTrue);
    });

    test('should return false when browser launch fails', () async {
      when(
        () => mockDataSource.signInWithGoogle(),
      ).thenAnswer((_) async => false);

      final result = await repository.signInWithGoogle();

      expect(result, isFalse);
    });

    test('should propagate exception from dataSource', () async {
      when(
        () => mockDataSource.signInWithGoogle(),
      ).thenThrow(Exception('Auth error'));

      expect(() => repository.signInWithGoogle(), throwsA(isA<Exception>()));
    });
  });

  group('getSession', () {
    test('should return session from dataSource', () {
      final mockSession = _MockSession();
      when(() => mockDataSource.currentSession).thenReturn(mockSession);

      final result = repository.currentSession;

      expect(result, equals(mockSession));
    });

    test('should return null when no session', () {
      when(() => mockDataSource.currentSession).thenReturn(null);

      final result = repository.currentSession;

      expect(result, isNull);
    });
  });

  group('signOut', () {
    test('should call dataSource.signOut', () async {
      when(() => mockDataSource.signOut()).thenAnswer((_) async {});

      await repository.signOut();

      verify(() => mockDataSource.signOut()).called(1);
    });
  });
}

class _MockSession extends Mock implements Session {}
