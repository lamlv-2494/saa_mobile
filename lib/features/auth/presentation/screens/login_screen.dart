import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/auth/data/models/auth_state.dart' as auth;
import 'package:saa_mobile/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:saa_mobile/features/auth/presentation/widgets/google_login_button.dart';
import 'package:saa_mobile/features/auth/presentation/widgets/login_background.dart';
import 'package:saa_mobile/features/auth/presentation/widgets/login_body.dart';
import 'package:saa_mobile/features/auth/presentation/widgets/login_footer.dart';
import 'package:saa_mobile/features/auth/presentation/widgets/login_header.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        ref.read(authViewModelProvider.notifier).handleAppResumed();
      },
    );
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    // Watch locale to trigger rebuild when language changes
    ref.watch(localeNotifierProvider);

    ref.listen<AsyncValue<auth.AuthState>>(authViewModelProvider, (_, next) {
      next.whenData((state) {
        state.whenOrNull(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textWhite,
                  ),
                ),
                backgroundColor: AppColors.errorBg.withValues(alpha: 0.9),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                duration: const Duration(seconds: 4),
              ),
            );
          },
        );
      });
    });

    final isLoading =
        authState.whenOrNull(
          data: (state) => state.whenOrNull(loading: () => true),
        ) ??
        false;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const LoginBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const LoginHeader(),
                  const Spacer(flex: 2),
                  const LoginBody(),
                  const Spacer(flex: 3),
                  Center(
                    child: GoogleLoginButton(
                      isLoading: isLoading,
                      onPressed: () {
                        ref
                            .read(authViewModelProvider.notifier)
                            .signInWithGoogle();
                      },
                    ),
                  ),
                  const Spacer(),
                  const LoginFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
