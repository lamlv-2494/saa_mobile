import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:saa_mobile/app/main_scaffold.dart';
import 'package:saa_mobile/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:saa_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:saa_mobile/features/kudos/presentation/screens/kudos_detail_screen.dart';
import 'package:saa_mobile/features/kudos/presentation/screens/send_kudos_screen.dart';
import 'package:saa_mobile/features/profile/presentation/screens/other_profile_screen.dart';

GoRouter createRouter(Ref ref) {
  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: _AuthRefreshListenable(ref, authViewModelProvider),
    redirect: (_, state) {
      final isAuthenticated =
          authState.whenOrNull(
            data: (s) => s.whenOrNull(authenticated: (_) => true),
          ) ??
          false;

      final isLoginRoute = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoginRoute) return '/login';
      if (isAuthenticated && isLoginRoute) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/home', builder: (_, _) => const MainScaffold()),
      GoRoute(path: '/send-kudos', builder: (_, _) => const SendKudosScreen()),
      GoRoute(
        path: '/kudos/:kudosId',
        builder: (_, state) =>
            KudosDetailScreen(kudosId: state.pathParameters['kudosId']!),
      ),
      GoRoute(
        path: '/profile/:userId',
        builder: (_, state) =>
            OtherProfileScreen(userId: state.pathParameters['userId']!),
      ),
      // Placeholder: Open Secret Box screen (screenId: kQk65hSYF2 — pending)
      GoRoute(
        path: '/secret-box',
        builder: (_, _) => const Scaffold(
          body: Center(child: Text('Secret Box — Coming Soon')),
        ),
      ),
    ],
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  return createRouter(ref);
});

class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable(Ref ref, ProviderListenable<dynamic> provider) {
    _subscription = ref.listen(provider, (_, _) {
      notifyListeners();
    });
  }

  late final ProviderSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
