import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import 'package:saa_mobile/features/auth/data/models/auth_state.dart';
import 'package:saa_mobile/features/auth/data/repositories/auth_repository.dart';

class AuthViewModel extends AsyncNotifier<AuthState> {
  StreamSubscription<sb.AuthState>? _authSubscription;

  @override
  FutureOr<AuthState> build() {
    _listenAuthStateChanges();
    ref.onDispose(() => _authSubscription?.cancel());
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

  void _listenAuthStateChanges() {
    final repo = ref.read(authRepositoryProvider);
    _authSubscription = repo.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        state = AsyncValue.data(
          AuthState.authenticated(user: session.user),
        );
      } else if (event.event == sb.AuthChangeEvent.signedOut) {
        state = const AsyncValue.data(AuthState.unauthenticated());
      }
    });
  }

  /// FR-011: Reset loading state when user returns to app
  /// without completing OAuth (cancelled/closed browser).
  void handleAppResumed() {
    final current = state.valueOrNull;
    if (current == null) return;

    current.whenOrNull(
      loading: () {
        // Delay to allow deep link callback to arrive first
        Future<void>.delayed(const Duration(milliseconds: 1500), () {
          final afterDelay = state.valueOrNull;
          afterDelay?.whenOrNull(
            loading: () {
              state = const AsyncValue.data(AuthState.unauthenticated());
            },
          );
        });
      },
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.data(AuthState.loading());

    try {
      final repo = ref.read(authRepositoryProvider);
      final launched = await repo.signInWithGoogle();
      if (!launched) {
        state = const AsyncValue.data(
          AuthState.error(message: 'Could not launch Google sign-in'),
        );
      }
      // Auth state will be updated via _listenAuthStateChanges
      // when the OAuth callback returns
    } on Exception catch (e) {
      state = AsyncValue.data(
        AuthState.error(message: e.toString()),
      );
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
