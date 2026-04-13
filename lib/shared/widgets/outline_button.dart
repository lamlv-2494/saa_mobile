import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';

class OutlineButtonWidget extends StatelessWidget {
  const OutlineButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.width,
    this.height = 40,
    this.enabled = true,
  });

  final String label;
  final VoidCallback onPressed;
  final SvgPicture? icon;
  final double? width;
  final double height;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.outlineBtnBg,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: enabled
                ? AppColors.outlineBtnBorder
                : AppColors.outlineBtnBorder.withAlpha(102),
          ),
        ),
        child: Row(
          mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: FittedBox(
                child: Text(
                  label,
                  maxLines: 1,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 20 / 14,
                    color: enabled
                        ? AppColors.textWhite
                        : AppColors.textWhite.withAlpha(102),
                  ),
                ),
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              icon!,
            ],
          ],
        ),
      ),
    );
  }
}
