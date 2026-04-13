import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/home/data/models/award_category.dart';
import 'package:saa_mobile/features/home/presentation/widgets/award_card_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/widgets/section_header_widget.dart';

class AwardsSectionWidget extends StatelessWidget {
  const AwardsSectionWidget({
    super.key,
    required this.awards,
    required this.onAwardTap,
  });

  final List<AwardCategory> awards;
  final void Function(int awardId) onAwardTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionHeaderWidget(
            label: t.home.awardSectionLabel,
            title: t.home.awardSystem,
          ),
        ),
        const SizedBox(height: 24),
        if (awards.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              t.home.awardsEmpty,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: AppColors.textWhite,
              ),
            ),
          )
        else
          SizedBox(
            height: 298,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, right: 20),
              itemCount: awards.length,
              separatorBuilder: (_, _) => const SizedBox(width: 16),
              itemBuilder: (_, index) => AwardCardWidget(
                award: awards[index],
                onDetailsTap: () => onAwardTap(awards[index].id),
              ),
            ),
          ),
      ],
    );
  }
}
