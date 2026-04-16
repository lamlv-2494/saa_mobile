import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/core/utils/asset_mapper.dart';
import 'package:saa_mobile/features/home/data/models/award_category.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class AwardCardWidget extends StatelessWidget {
  const AwardCardWidget({
    super.key,
    required this.award,
    required this.onDetailsTap,
  });

  final AwardCategory award;
  final VoidCallback onDetailsTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Award image — fixed 160x160
          SizedBox(
            width: 160,
            height: 160,
            child: AssetMapper.awardImage(award.slug)?.image(
                  fit: BoxFit.cover,
                  width: 160,
                  height: 160,
                ) ??
                Container(
                  color: AppColors.bgDark,
                  alignment: Alignment.center,
                  child: Text(
                    award.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textAccent,
                    ),
                  ),
                ),
          ),
          const SizedBox(height: 12),
          // Award name
          Text(
            award.name,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 20 / 14,
              color: AppColors.textAccent,
            ),
          ),
          const SizedBox(height: 4),
          // Description — Expanded để fill remaining space đều nhau
          Expanded(
            child: Text(
              award.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                height: 20 / 14,
                letterSpacing: 0.25,
                color: AppColors.textWhite,
              ),
            ),
          ),
          // Details button — luôn nằm ở đáy card
          GestureDetector(
            onTap: onDetailsTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.home.details,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 20 / 14,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Assets.icons.icArrowOpen.svg(
                    width: 24,
                    height: 24,
                    color: AppColors.textWhite,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
