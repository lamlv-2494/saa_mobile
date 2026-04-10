import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:saa_mobile/features/auth/data/datasources/auth_remote_datasource.dart';

abstract class AuthRepository {
  Future<User> signInWithGoogle();
  Future<void> signOut();
  User? get currentUser;
  Session? get currentSession;
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDataSource dataSource})
    : _dataSource = dataSource;

  final AuthRemoteDataSource _dataSource;

  @override
  Future<User> signInWithGoogle() async {
    await _dataSource.signInWithGoogle();

    final user = _dataSource.currentUser;
    if (user == null) {
      throw Exception('No user returned after sign in');
    }

    return user;
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
  }

  @override
  User? get currentUser => _dataSource.currentUser;

  @override
  Session? get currentSession => _dataSource.currentSession;
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(client: Supabase.instance.client);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    dataSource: ref.watch(authRemoteDataSourceProvider),
  );
});
