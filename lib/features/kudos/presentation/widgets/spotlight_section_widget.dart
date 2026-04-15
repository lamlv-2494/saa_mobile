import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/spotlight_network.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/widgets/section_header_widget.dart';

class SpotlightSectionWidget extends StatelessWidget {
  const SpotlightSectionWidget({
    super.key,
    required this.network,
    this.onSearchTap,
  });

  final SpotlightNetwork? network;
  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderWidget(
            label: t.kudos.sectionLabel,
            title: t.kudos.spotlightTitle,
          ),
          const SizedBox(height: 24),
          _SpotlightChart(network: network, onSearchTap: onSearchTap),
        ],
      ),
    );
  }
}

class _SpotlightChart extends StatelessWidget {
  const _SpotlightChart({required this.network, this.onSearchTap});

  final SpotlightNetwork? network;
  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    if (network == null || network!.nodes.isEmpty) {
      return Container(
        height: 159,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.outlineBtnBorder, width: 0.29),
        ),
        child: Center(
          child: Text(
            t.kudos.emptySpotlight,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }
    return Image.asset(Assets.images.kudosSpotlight.path, fit: BoxFit.cover);
  }
}
