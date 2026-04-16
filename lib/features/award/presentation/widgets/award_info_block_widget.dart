import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/core/extensions/currency_format_extension.dart';
import 'package:saa_mobile/features/award/presentation/widgets/award_badge_image_widget.dart';
import 'package:saa_mobile/features/award/presentation/widgets/award_stat_row_widget.dart';
import 'package:saa_mobile/features/home/data/models/award_category.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class AwardInfoBlock extends StatelessWidget {
  const AwardInfoBlock({
    super.key,
    required this.category,
    required this.locale,
  });

  final AwardCategory category;
  final String locale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Badge image
        AwardBadgeImage(
          slug: category.slug,
          semanticLabel: '${t.accessibility.awardBadge} ${category.name}',
        ),
        const SizedBox(height: 16),
        // Title row: icon + name
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.icons.icAward.svg(
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.textAccent,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                category.name,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 20 / 14,
                  color: AppColors.textAccent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Description
        Text(
          category.description,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            height: 20 / 14,
            letterSpacing: 0.25,
            color: AppColors.textWhite,
          ),
        ),
        const SizedBox(height: 16),
        // Divider
        Container(height: 1, color: AppColors.divider),
        const SizedBox(height: 16),
        // Quantity stat
        AwardStatRow(
          icon: Assets.icons.icDiamond.svg(
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.textAccent,
              BlendMode.srcIn,
            ),
          ),
          label: t.award.awardQuantityLabel,
          value: category.quantity.toString().padLeft(2, '0'),
          unit: category.unit,
          valueUnitGap: 4,
        ),
        const SizedBox(height: 16),
        // Divider
        Container(height: 1, color: AppColors.divider),
        const SizedBox(height: 16),
        // Prize stat(s) — Signature has multiple full blocks with dividers
        ..._buildPrizeSections(),
      ],
    );
  }

  /// Builds prize section(s).
  /// - Single prize (most awards): 1 AwardStatRow
  /// - Multiple prizes (Signature): each prize is a full AwardStatRow
  ///   separated by dividers — matching Figma layout exactly.
  List<Widget> _buildPrizeSections() {
    Widget prizeIcon() => Assets.icons.icAwardFlag.svg(
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.textAccent,
            BlendMode.srcIn,
          ),
        );

    // Single prize (prizeValue on category directly)
    if (category.prizeValue != null) {
      return [
        AwardStatRow(
          icon: prizeIcon(),
          label: t.award.awardValueLabel,
          value: category.prizeValue!.formatCurrency(locale),
          unit: category.prizeNote ?? '',
          valueUnitGap: 8,
        ),
      ];
    }

    // Multiple prizes (Signature case) — each prize gets its own
    // full AwardStatRow with icon + label, separated by dividers
    final widgets = <Widget>[];
    for (var i = 0; i < category.awardPrizes.length; i++) {
      final prize = category.awardPrizes[i];
      final note = locale == 'en' ? prize.noteEn : prize.noteVi;
      widgets.add(
        AwardStatRow(
          icon: prizeIcon(),
          label: t.award.awardValueLabel,
          value: prize.valueAmount.formatCurrency(locale),
          unit: note,
          valueUnitGap: 8,
        ),
      );
      // Add divider between prize blocks (not after the last one)
      if (i < category.awardPrizes.length - 1) {
        widgets.addAll([
          const SizedBox(height: 16),
          Container(height: 1, color: AppColors.divider),
          const SizedBox(height: 16),
        ]);
      }
    }
    return widgets;
  }
}
