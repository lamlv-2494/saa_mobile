import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import 'package:saa_mobile/features/auth/data/models/auth_state.dart';
import 'package:saa_mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:saa_mobile/features/auth/presentation/viewmodels/auth_viewmodel.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockAuthRepository();
    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(mockRepository)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthViewModel', () {
    test(
      'initial state should check session and be unauthenticated when no session',
      () async {
        when(() => mockRepository.currentSession).thenReturn(null);
        when(() => mockRepository.currentUser).thenReturn(null);

        final state = await container.read(authViewModelProvider.future);

        expect(state, const AuthState.unauthenticated());
      },
    );

    test('initial state should be authenticated when session exists', () async {
      final mockUser = MockUser();
      when(() => mockUser.email).thenReturn('test@sun-asterisk.com');
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
      'signInWithGoogle should transition to authenticated on success',
      () async {
        final mockUser = MockUser();
        when(() => mockUser.email).thenReturn('test@sun-asterisk.com');
        when(() => mockRepository.currentSession).thenReturn(null);
        when(() => mockRepository.currentUser).thenReturn(null);
        when(
          () => mockRepository.signInWithGoogle(),
        ).thenAnswer((_) async => mockUser);

        // Wait for initial state
        await container.read(authViewModelProvider.future);

        // Trigger sign in
        await container.read(authViewModelProvider.notifier).signInWithGoogle();

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

    test(
      'signInWithGoogle should transition to error on generic exception',
      () async {
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
      },
    );
  });
}

class _MockSession extends Mock implements Session {}
