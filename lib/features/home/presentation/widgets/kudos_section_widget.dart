import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/features/home/data/models/kudos_info.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/widgets/primary_button.dart';
import 'package:saa_mobile/shared/widgets/section_header_widget.dart';

class KudosSectionWidget extends StatelessWidget {
  const KudosSectionWidget({
    super.key,
    required this.kudosInfo,
    required this.onDetailsTap,
  });

  final KudosInfo kudosInfo;
  final VoidCallback onDetailsTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SectionHeaderWidget(
            label: t.home.recognitionMovement,
            title: t.home.sunKudos,
          ),
          const SizedBox(height: 24),
          // Kudos banner
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: double.infinity,
              height: 145,
              color: AppColors.bgDark,
              child: Assets.images.home.kudosBanner.image(
                width: double.infinity,
                height: 145,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: double.infinity,
                  height: 145,
                  color: AppColors.bgDark,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 24),
                  child: Text(
                    'KUDOS',
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.kudosBannerText,
                      letterSpacing: -3.6,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // New feature badge
          Text(
            t.home.newFeatureSaa,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 20 / 14,
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            t.home.kudosDescription,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              height: 20 / 14,
              letterSpacing: 0.25,
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 16),
          // Details button
          PrimaryButton(
            label: t.home.details,
            icon: Assets.icons.icArrowOpen.svg(
              width: 24,
              height: 24,
              color: AppColors.bgDark,
            ),
            onPressed: onDetailsTap,
          ),
        ],
      ),
    );
  }
}
