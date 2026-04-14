import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';

class PageIndicatorWidget extends StatelessWidget {
  const PageIndicatorWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.onPrevious,
    this.onNext,
  });

  final int currentPage;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  bool get _isFirst => currentPage <= 1;
  bool get _isLast => currentPage >= totalPages;

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 0) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _isFirst ? null : onPrevious,
          child: Opacity(
            opacity: _isFirst ? 0.3 : 1.0,
            child: SvgPicture.asset(
              Assets.icons.icPrev.path,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.textWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$currentPage',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 20 / 14,
                  letterSpacing: 0.25,
                  color: AppColors.textAccent,
                ),
              ),
              TextSpan(
                text: '/$totalPages',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 20 / 14,
                  letterSpacing: 0.25,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 32),
        GestureDetector(
          onTap: _isLast ? null : onNext,
          child: Opacity(
            opacity: _isLast ? 0.3 : 1.0,
            child: SvgPicture.asset(
              Assets.icons.icNext.path,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.textWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
