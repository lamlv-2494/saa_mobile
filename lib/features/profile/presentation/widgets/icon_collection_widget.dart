import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/profile/data/models/icon_badge.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class IconCollectionWidget extends StatelessWidget {
  const IconCollectionWidget({super.key, required this.iconBadges});

  final List<IconBadge> iconBadges;

  @override
  Widget build(BuildContext context) {
    if (iconBadges.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.profile.myIconCollection,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 20 / 14,
              color: AppColors.textAccent,
            ),
          ),
          const SizedBox(height: 12),
          Row(children: iconBadges.map(_buildIconSlot).toList()),
        ],
      ),
    );
  }

  Widget _buildIconSlot(IconBadge badge) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.iconDark,
        ),
        child: ClipOval(
          child: badge.badgeImageUrl.isNotEmpty
              ? Image.network(
                  badge.badgeImageUrl,
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, _) => const SizedBox.shrink(),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
