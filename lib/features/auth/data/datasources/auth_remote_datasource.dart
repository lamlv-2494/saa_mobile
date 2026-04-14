import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<bool> signInWithGoogle();
  Future<void> signOut();
  Future<void> ensureUserProfile();
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
  Future<void> ensureUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;

    // Kiểm tra user đã có profile chưa
    final existing = await _client
        .from('users')
        .select('id')
        .eq('auth_id', user.id)
        .maybeSingle();

    if (existing != null) return; // Đã có → không cần tạo

    // Lấy thông tin từ Google OAuth metadata
    final metadata = user.userMetadata ?? {};
    final name = metadata['full_name'] as String? ??
        metadata['name'] as String? ??
        user.email?.split('@').first ??
        'Sunner';
    final avatar = metadata['avatar_url'] as String? ??
        metadata['picture'] as String? ??
        '';

    await _client.from('users').insert({
      'auth_id': user.id,
      'email': user.email ?? '',
      'name': name,
      'avatar_url': avatar,
    });
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
