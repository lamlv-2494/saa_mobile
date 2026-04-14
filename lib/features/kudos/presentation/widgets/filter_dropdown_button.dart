import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';

class FilterDropdownButton extends StatelessWidget {
  const FilterDropdownButton({
    super.key,
    required this.label,
    this.selectedValue,
    required this.onTap,
    this.width,
  });

  final String label;
  final String? selectedValue;
  final VoidCallback onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.outlineBtnBg,
          border: Border.all(color: AppColors.outlineBtnBorder),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
          children: [
            Flexible(
              child: Text(
                selectedValue ?? label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  color: AppColors.textWhite,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              Assets.icons.icArrowDown.path,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.textWhite,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
