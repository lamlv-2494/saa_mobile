import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/widgets/primary_button.dart';
import 'package:saa_mobile/shared/widgets/section_header_widget.dart';

class SunKudosBlock extends StatelessWidget {
  const SunKudosBlock({super.key, required this.onDetailsTap});

  final VoidCallback onDetailsTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Section header
        SectionHeaderWidget(
          label: t.home.recognitionMovement,
          title: t.home.sunKudos,
        ),
        const SizedBox(height: 24),
        // Kudos banner image
        Container(
          width: double.infinity,
          height: 145,
          decoration: BoxDecoration(
            color: AppColors.kudosBannerBg,
            borderRadius: BorderRadius.circular(4.653),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.653),
            child: Assets.images.kudosBanner.image(
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Center(
                child: Text(
                  'KUDOS',
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: AppColors.kudosBannerText,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Note text
        RichText(
          text: TextSpan(
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              height: 20 / 14,
              letterSpacing: 0.25,
              color: AppColors.textWhite,
            ),
            children: [
              TextSpan(
                text: '${t.home.newFeatureSaa}\n',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(text: t.home.kudosDescription),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // "Chi tiết" button
        Semantics(
          button: true,
          hint: t.accessibility.kudosDetailButton,
          child: PrimaryButton(
            label: t.home.details,
            width: 160,
            icon: Assets.icons.icArrowOpen.svg(
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.buttonText,
                BlendMode.srcIn,
              ),
            ),
            onPressed: onDetailsTap,
          ),
        ),
      ],
    );
  }
}
