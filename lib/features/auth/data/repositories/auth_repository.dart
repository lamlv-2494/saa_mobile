import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:saa_mobile/features/auth/data/datasources/auth_remote_datasource.dart';

abstract class AuthRepository {
  Future<bool> signInWithGoogle();
  Future<void> signOut();
  User? get currentUser;
  Session? get currentSession;
  Stream<AuthState> get onAuthStateChange;
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDataSource dataSource})
    : _dataSource = dataSource;

  final AuthRemoteDataSource _dataSource;

  @override
  Future<bool> signInWithGoogle() async {
    return _dataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
  }

  @override
  User? get currentUser => _dataSource.currentUser;

  @override
  Session? get currentSession => _dataSource.currentSession;

  @override
  Stream<AuthState> get onAuthStateChange => _dataSource.onAuthStateChange;
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(client: Supabase.instance.client);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    dataSource: ref.watch(authRemoteDataSourceProvider),
  );
});
