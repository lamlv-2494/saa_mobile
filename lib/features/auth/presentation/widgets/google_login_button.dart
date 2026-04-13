import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: !isLoading && onPressed != null,
      label: t.accessibility.loginButton,
      child: SizedBox(
        height: 48,
        child: GestureDetector(
          onTap: isLoading ? null : onPressed,
          child: Center(
            child: AnimatedScale(
              scale: 1.0,
              duration: const Duration(milliseconds: 150),
              child: Container(
                width: 246,
                height: 40,
                decoration: BoxDecoration(
                  color: isLoading
                      ? AppColors.buttonBg.withValues(alpha: 0.7)
                      : AppColors.buttonBg,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: isLoading ? _buildLoader() : _buildContent(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: AppColors.loadingSpinner,
      ),
    );
  }

  Widget _buildContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            t.login.button,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 20 / 14,
              color: AppColors.buttonText,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Assets.icons.icGoogle.svg(width: 24, height: 24),
      ],
    );
  }
}
