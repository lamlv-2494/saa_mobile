import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_content_card.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class KudosFeedCard extends StatelessWidget {
  const KudosFeedCard({
    super.key,
    required this.kudos,
    required this.timeText,
    this.onHeartTap,
    this.onCopyLink,
    this.onViewDetail,
    this.onAvatarTap,
  });

  final Kudos kudos;
  final String timeText;
  final VoidCallback? onHeartTap;
  final VoidCallback? onCopyLink;
  final VoidCallback? onViewDetail;
  final void Function(String userId)? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SenderReceiverHeader(kudos: kudos, onAvatarTap: onAvatarTap),
        const SizedBox(height: 8),
        KudosContentCard(
          content: kudos.content,
          hashtags: kudos.hashtags,
          heartCount: kudos.heartCount,
          isLikedByMe: kudos.isLikedByMe,
          canLike: kudos.canLike,
          timeText: timeText,
          shareUrl: kudos.shareUrl,
          onHeartTap: onHeartTap,
          onViewDetail: onViewDetail,
        ),
      ],
    );
  }
}

class _SenderReceiverHeader extends StatelessWidget {
  const _SenderReceiverHeader({required this.kudos, this.onAvatarTap});

  final Kudos kudos;
  final void Function(String userId)? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onAvatarTap?.call(kudos.sender.id),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.textSecondary.withAlpha(77),
            backgroundImage: kudos.sender.avatar.isNotEmpty
                ? NetworkImage(kudos.sender.avatar)
                : null,
            child: kudos.sender.avatar.isEmpty
                ? Text(
                    kudos.sender.name.isNotEmpty
                        ? kudos.sender.name[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.bgDark,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            kudos.isAnonymous ? t.kudos.anonymous : kudos.sender.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textWhite,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(
            Icons.arrow_forward,
            size: 14,
            color: AppColors.textAccent,
          ),
        ),
        GestureDetector(
          onTap: () => onAvatarTap?.call(kudos.receiver.id),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.textSecondary.withAlpha(77),
            backgroundImage: kudos.receiver.avatar.isNotEmpty
                ? NetworkImage(kudos.receiver.avatar)
                : null,
            child: kudos.receiver.avatar.isEmpty
                ? Text(
                    kudos.receiver.name.isNotEmpty
                        ? kudos.receiver.name[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.bgDark,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            kudos.receiver.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textWhite,
            ),
          ),
        ),
      ],
    );
  }
}
