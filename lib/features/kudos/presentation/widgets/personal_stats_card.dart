import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/widgets/outline_button.dart';
import 'package:saa_mobile/shared/widgets/primary_button.dart';

class PersonalStatsCard extends StatelessWidget {
  const PersonalStatsCard({
    super.key,
    required this.stats,
    this.onOpenSecretBox,
  });

  final PersonalStats stats;
  final VoidCallback? onOpenSecretBox;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        border: Border.all(color: AppColors.outlineBtnBorder, width: 0.794),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _StatRow(label: t.kudos.statsKudosReceived, value: stats.kudosReceived),
          const SizedBox(height: 8),
          _StatRow(label: t.kudos.statsKudosSent, value: stats.kudosSent),
          const SizedBox(height: 8),
          _StatRow(
            label: t.kudos.statsHeartsReceived,
            value: stats.heartsReceived,
            showBonusBadge: stats.isBonusActive,
          ),
          const SizedBox(height: 8),
          Container(height: 1, color: AppColors.outlineBtnBorder.withAlpha(77)),
          const SizedBox(height: 8),
          _StatRow(
            label: t.kudos.statsBoxesOpened,
            value: stats.secretBoxesOpened,
          ),
          const SizedBox(height: 8),
          _StatRow(
            label: t.kudos.statsBoxesUnopened,
            value: stats.secretBoxesUnopened,
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            width: double.infinity,
            label: t.kudos.openSecretBox,
            icon: SvgPicture.asset(
              Assets.icons.icGiftOpen.path,
              width: 24,
              height: 24,
            ),
            onPressed: onOpenSecretBox ?? () {},
            enabled: stats.secretBoxesUnopened > 0,
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    this.showBonusBadge = false,
  });

  final String label;
  final int value;
  final bool showBonusBadge;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 20 / 14,
                color: AppColors.textWhite,
              ),
            ),
            if (showBonusBadge) ...[
              const SizedBox(width: 4),
              SvgPicture.asset(
                Assets.icons.icFire.path,
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.textAccent,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                'x2',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textAccent,
                ),
              ),
            ],
          ],
        ),
        Text(
          '$value',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 20 / 14,
            color: AppColors.textAccent,
          ),
        ),
      ],
    );
  }
}
