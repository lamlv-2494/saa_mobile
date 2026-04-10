import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<bool> signInWithGoogle();
  Future<void> signOut();
  User? get currentUser;
  Session? get currentSession;
  Stream<AuthState> get onAuthStateChange;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required SupabaseClient client})
    : _client = client;

  final SupabaseClient _client;

  GoTrueClient get _auth => _client.auth;

  @override
  Future<bool> signInWithGoogle() async {
    try {
      final success = await _auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.saamobile://login-callback/',
      );
      return success;
    } on AuthException catch (e) {
      debugPrint('Google sign-in error: ${e.message}');
      throw Exception(e.message);
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Session? get currentSession => _auth.currentSession;

  @override
  Stream<AuthState> get onAuthStateChange =>
      _auth.onAuthStateChange.map((event) => event);
}
