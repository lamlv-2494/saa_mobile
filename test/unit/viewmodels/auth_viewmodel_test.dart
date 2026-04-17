import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import 'package:saa_mobile/features/auth/data/models/auth_state.dart';
import 'package:saa_mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:saa_mobile/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:saa_mobile/features/home/data/repositories/countdown_repository.dart';
import 'package:saa_mobile/features/home/presentation/providers/countdown_repository_provider.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUser extends Mock implements User {}

class _MockSession extends Mock implements Session {}

class MockCountdownRepository extends Mock implements CountdownRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late MockCountdownRepository mockCountdownRepository;
  late ProviderContainer container;
  late StreamController<sb.AuthState> authStreamController;

  setUp(() {
    mockRepository = MockAuthRepository();
    mockCountdownRepository = MockCountdownRepository();
    authStreamController = StreamController<sb.AuthState>.broadcast();
    when(
      () => mockRepository.onAuthStateChange,
    ).thenAnswer((_) => authStreamController.stream);
    when(() => mockCountdownRepository.clear()).thenAnswer((_) async {});
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockRepository),
        countdownRepositoryProvider.overrideWithValue(mockCountdownRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
    authStreamController.close();
  });

  group('AuthViewModel', () {
    test('initial state should be unauthenticated when no session', () async {
      when(() => mockRepository.currentSession).thenReturn(null);
      when(() => mockRepository.currentUser).thenReturn(null);

      final state = await container.read(authViewModelProvider.future);

      expect(state, const AuthState.unauthenticated());
    });

    test('initial state should be authenticated when session exists', () async {
      final mockUser = MockUser();
      when(() => mockRepository.currentSession).thenReturn(_MockSession());
      when(() => mockRepository.currentUser).thenReturn(mockUser);

      final state = await container.read(authViewModelProvider.future);

      expect(
        state,
        isA<AuthState>().having(
          (s) => s.whenOrNull(authenticated: (user) => user),
          'user',
          equals(mockUser),
        ),
      );
    });

    test(
      'signInWithGoogle should set loading then wait for auth stream',
      () async {
        when(() => mockRepository.currentSession).thenReturn(null);
        when(() => mockRepository.currentUser).thenReturn(null);
        when(
          () => mockRepository.signInWithGoogle(),
        ).thenAnswer((_) async => true);

        await container.read(authViewModelProvider.future);

        await container.read(authViewModelProvider.notifier).signInWithGoogle();

        // State remains loading (waiting for OAuth callback via stream)
        verify(() => mockRepository.signInWithGoogle()).called(1);
      },
    );

    test('signInWithGoogle should set error when launch fails', () async {
      when(() => mockRepository.currentSession).thenReturn(null);
      when(() => mockRepository.currentUser).thenReturn(null);
      when(
        () => mockRepository.signInWithGoogle(),
      ).thenAnswer((_) async => false);

      await container.read(authViewModelProvider.future);

      await container.read(authViewModelProvider.notifier).signInWithGoogle();

      final state = container.read(authViewModelProvider).value;
      expect(
        state,
        isA<AuthState>().having(
          (s) => s.whenOrNull(error: (msg) => msg),
          'message',
          isNotNull,
        ),
      );
    });

    test('signInWithGoogle should set error on exception', () async {
      when(() => mockRepository.currentSession).thenReturn(null);
      when(() => mockRepository.currentUser).thenReturn(null);
      when(
        () => mockRepository.signInWithGoogle(),
      ).thenThrow(Exception('Network error'));

      await container.read(authViewModelProvider.future);

      await container.read(authViewModelProvider.notifier).signInWithGoogle();

      final state = container.read(authViewModelProvider).value;
      expect(
        state,
        isA<AuthState>().having(
          (s) => s.whenOrNull(error: (msg) => msg),
          'message',
          isNotNull,
        ),
      );
    });

    test(
      'FR-011: should reset loading to unauthenticated on app resume after OAuth cancel',
      () async {
        when(() => mockRepository.currentSession).thenReturn(null);
        when(() => mockRepository.currentUser).thenReturn(null);
        when(
          () => mockRepository.signInWithGoogle(),
        ).thenAnswer((_) async => true);

        await container.read(authViewModelProvider.future);

        // Trigger sign in → sets loading
        await container.read(authViewModelProvider.notifier).signInWithGoogle();

        // Verify state is loading
        final loadingState = container.read(authViewModelProvider).value;
        expect(
          loadingState,
          isA<AuthState>().having(
            (s) => s.whenOrNull(loading: () => true),
            'isLoading',
            isTrue,
          ),
        );

        // Simulate app resume (user cancelled OAuth in browser)
        container.read(authViewModelProvider.notifier).handleAppResumed();

        // Wait for the delayed reset (1.5s in impl)
        await Future<void>.delayed(const Duration(seconds: 2));

        final resumedState = container.read(authViewModelProvider).value;
        expect(resumedState, const AuthState.unauthenticated());
      },
    );

    test(
      'signOut clears countdown storage before calling authRepository.signOut '
      'and transitions state to unauthenticated',
      () async {
        when(() => mockRepository.currentSession).thenReturn(null);
        when(() => mockRepository.currentUser).thenReturn(null);
        when(() => mockRepository.signOut()).thenAnswer((_) async {});

        await container.read(authViewModelProvider.future);

        await container.read(authViewModelProvider.notifier).signOut();

        verifyInOrder([
          () => mockCountdownRepository.clear(),
          () => mockRepository.signOut(),
        ]);

        final state = container.read(authViewModelProvider).value;
        expect(state, const AuthState.unauthenticated());
      },
    );

    test(
      'FR-011: should NOT reset state on app resume if already authenticated',
      () async {
        final mockUser = MockUser();
        when(() => mockRepository.currentSession).thenReturn(null);
        when(() => mockRepository.currentUser).thenReturn(null);
        when(
          () => mockRepository.signInWithGoogle(),
        ).thenAnswer((_) async => true);

        await container.read(authViewModelProvider.future);

        // Trigger sign in → loading
        await container.read(authViewModelProvider.notifier).signInWithGoogle();

        // Simulate auth callback arriving (user completed OAuth)
        authStreamController.add(
          sb.AuthState(
            sb.AuthChangeEvent.signedIn,
            _MockSessionWithUser(mockUser),
          ),
        );

        // Wait for stream to propagate
        await Future<void>.delayed(const Duration(milliseconds: 100));

        // Now simulate app resume
        container.read(authViewModelProvider.notifier).handleAppResumed();

        // Wait past the delay
        await Future<void>.delayed(const Duration(seconds: 2));

        // State should still be authenticated, not reset
        final state = container.read(authViewModelProvider).value;
        expect(
          state,
          isA<AuthState>().having(
            (s) => s.whenOrNull(authenticated: (user) => user),
            'user',
            equals(mockUser),
          ),
        );
      },
    );
  });
}

class _MockSessionWithUser extends Mock implements Session {
  _MockSessionWithUser(this._user);
  final User _user;

  @override
  User get user => _user;
}
