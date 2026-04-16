import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_card.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class ProfileKudosListWidget extends StatelessWidget {
  const ProfileKudosListWidget({
    super.key,
    required this.kudosList,
    required this.isLoadingMore,
    this.onHeartTap,
    this.onCopyLink,
    this.onViewDetail,
    this.onAvatarTap,
  });

  final List<Kudos> kudosList;
  final bool isLoadingMore;
  final void Function(String kudosId)? onHeartTap;
  final void Function(String kudosId)? onCopyLink;
  final void Function(String kudosId)? onViewDetail;
  final void Function(String userId)? onAvatarTap;

  String _formatTime(DateTime createdAt) {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 1) return t.kudos.justNow;
    if (diff.inHours < 1) {
      return t.kudos.minutesAgo.replaceAll('{count}', '${diff.inMinutes}');
    }
    if (diff.inDays < 1) {
      return t.kudos.hoursAgo.replaceAll('{count}', '${diff.inHours}');
    }
    return t.kudos.daysAgo.replaceAll('{count}', '${diff.inDays}');
  }

  @override
  Widget build(BuildContext context) {
    if (kudosList.isEmpty && !isLoadingMore) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: Text(
            t.profile.noKudosHistory,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        ...kudosList.map(
          (kudos) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Stack(
              children: [
                KudosCard(
                  variant: KudosCardVariant.feed,
                  kudos: kudos,
                  timeText: _formatTime(kudos.createdAt),
                  onHeartTap: onHeartTap != null
                      ? () => onHeartTap!(kudos.id)
                      : null,
                  onCopyLink: onCopyLink != null
                      ? () => onCopyLink!(kudos.id)
                      : null,
                  onViewDetail: onViewDetail != null
                      ? () => onViewDetail!(kudos.id)
                      : null,
                  onAvatarTap: onAvatarTap,
                ),
                if (kudos.isSpam)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF8C00),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        t.profile.spam,
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (isLoadingMore)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: CircularProgressIndicator(
              color: AppColors.textAccent,
              strokeWidth: 2,
            ),
          ),
      ],
    );
  }
}
