import 'package:flutter/material.dart' hide Badge;
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/profile/data/models/badge.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class BadgeCollectionWidget extends StatelessWidget {
  const BadgeCollectionWidget({super.key, required this.badges});

  final List<Badge> badges;

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.profile.badgeCollection,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 20 / 14,
              color: AppColors.textAccent,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: badges.map(_buildBadgeItem).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem(Badge badge) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.iconDark,
          ),
          child: ClipOval(
            child: badge.imageUrl.isNotEmpty
                ? Image.network(
                    badge.imageUrl,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, _) => const SizedBox.shrink(),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          badge.name,
          style: GoogleFonts.montserrat(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            height: 16 / 10,
            color: AppColors.textWhite,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
