import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class KudosSectionHeaderWidget extends StatelessWidget {
  const KudosSectionHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.profile.saaAwards,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 16 / 12,
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            t.profile.kudosTitle,
            style: GoogleFonts.montserrat(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              height: 28 / 22,
              color: AppColors.textAccent,
            ),
          ),
        ],
      ),
    );
  }
}
