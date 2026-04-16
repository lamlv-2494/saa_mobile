import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PersonalStatRow(
            label: t.kudos.statsKudosReceived,
            value: stats.kudosReceived,
          ),
          const SizedBox(height: 12),
          _PersonalStatRow(
            label: t.kudos.statsKudosSent,
            value: stats.kudosSent,
          ),
          const SizedBox(height: 12),
          _PersonalStatRow(
            label: t.kudos.statsHeartsReceived,
            value: stats.heartsReceived,
            showBonusBadge: stats.isBonusActive,
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFF2E3940)),
          const SizedBox(height: 12),
          _PersonalStatRow(
            label: t.kudos.statsBoxesOpened,
            value: stats.secretBoxesOpened,
          ),
          const SizedBox(height: 12),
          _PersonalStatRow(
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

class _PersonalStatRow extends StatelessWidget {
  const _PersonalStatRow({
    required this.label,
    required this.value,
    this.showBonusBadge = false,
  });

  final String label;
  final int value;
  final bool showBonusBadge;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label: $value',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 16 / 12,
                  color: AppColors.textWhite,
                ),
              ),
              if (showBonusBadge) ...[
                const SizedBox(width: 8),
                Assets.images.kudosFire.image(width: 20, height: 20),
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
      ),
    );
  }
}
