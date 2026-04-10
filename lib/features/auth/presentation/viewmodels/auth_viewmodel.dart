import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/auth/data/models/auth_state.dart';
import 'package:saa_mobile/features/auth/data/repositories/auth_repository.dart';

class AuthViewModel extends AsyncNotifier<AuthState> {
  @override
  FutureOr<AuthState> build() {
    return _checkSession();
  }

  AuthState _checkSession() {
    final repo = ref.read(authRepositoryProvider);
    final session = repo.currentSession;

    if (session != null) {
      final user = repo.currentUser;
      if (user != null) {
        return AuthState.authenticated(user: user);
      }
    }

    return const AuthState.unauthenticated();
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final repo = ref.read(authRepositoryProvider);
      final user = await repo.signInWithGoogle();
      state = AsyncValue.data(AuthState.authenticated(user: user));
    } on Exception catch (e) {
      state = AsyncValue.data(AuthState.error(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.signOut();
    state = const AsyncValue.data(AuthState.unauthenticated());
  }
}

final authViewModelProvider = AsyncNotifierProvider<AuthViewModel, AuthState>(
  AuthViewModel.new,
);
