import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/gift_recipient_ranking.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class TopGiftRecipientsCard extends StatelessWidget {
  const TopGiftRecipientsCard({super.key, required this.recipients});

  final List<GiftRecipientRanking> recipients;

  @override
  Widget build(BuildContext context) {
    if (recipients.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            t.kudos.emptyTop10,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        border: Border.all(
          color: AppColors.outlineBtnBorder,
          width: 0.794,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.kudos.top10Title,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 20 / 14,
              color: AppColors.textAccent,
            ),
          ),
          const SizedBox(height: 12),
          ...recipients.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _RecipientRow(ranking: r),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipientRow extends StatelessWidget {
  const _RecipientRow({required this.ranking});

  final GiftRecipientRanking ranking;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: AppColors.textSecondary.withAlpha(77),
          backgroundImage: ranking.user.avatar.isNotEmpty
              ? NetworkImage(ranking.user.avatar)
              : null,
          child: ranking.user.avatar.isEmpty
              ? Text(
                  ranking.user.name.isNotEmpty
                      ? ranking.user.name[0].toUpperCase()
                      : '?',
                  style: const TextStyle(fontSize: 10, color: AppColors.bgDark),
                )
              : null,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ranking.user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textWhite,
                ),
              ),
              if (ranking.rewardName.isNotEmpty)
                Text(
                  ranking.rewardName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
