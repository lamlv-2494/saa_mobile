import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

/// Chỉ chứa content (tagline + logo).
/// Background image nằm ở level KudosScreen (Stack) để bao phủ cả AppBar.
class KudosHeroBannerWidget extends StatelessWidget {
  const KudosHeroBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 40, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.kudos.tagline,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 20 / 14,
              color: AppColors.textAccent,
            ),
          ),
          const SizedBox(height: 8),
          Assets.images.kudosLogo.image(
            width: 221,
            height: 39,
          ),
        ],
      ),
    );
  }
}
