import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';

class AwardStatRow extends StatelessWidget {
  const AwardStatRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    this.valueUnitGap = 4,
  });

  final Widget icon;
  final String label;
  final String value;
  final String unit;

  /// Gap between value and unit text. 4px for quantity, 8px for prize.
  final double valueUnitGap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label row: icon + label
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 20 / 14,
                color: AppColors.textAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Value row: value + unit
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 24 / 18,
                letterSpacing: 0.5,
                color: AppColors.textWhite,
              ),
            ),
            SizedBox(width: valueUnitGap),
            Text(
              unit,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                height: 20 / 14,
                letterSpacing: 0.25,
                color: AppColors.textWhite,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
