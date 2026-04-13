import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_content_card.dart';

class HighlightKudosCard extends StatelessWidget {
  const HighlightKudosCard({
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
    return Container(
      width: 274,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        border: Border.all(color: AppColors.textAccent),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _SenderReceiverRow(kudos: kudos, onAvatarTap: onAvatarTap),
          const SizedBox(height: 8),
          Container(height: 1, color: AppColors.textAccent),
          const SizedBox(height: 8),
          Expanded(
            child: KudosContentCard(
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
          ),
        ],
      ),
    );
  }
}

class _SenderReceiverRow extends StatelessWidget {
  const _SenderReceiverRow({required this.kudos, this.onAvatarTap});

  final Kudos kudos;
  final void Function(String userId)? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _UserAvatar(
          avatar: kudos.sender.avatar,
          name: kudos.sender.name,
          onTap: () => onAvatarTap?.call(kudos.sender.id),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            kudos.sender.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.bgDark,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.arrow_forward, size: 12, color: AppColors.bgDark),
        ),
        _UserAvatar(
          avatar: kudos.receiver.avatar,
          name: kudos.receiver.name,
          onTap: () => onAvatarTap?.call(kudos.receiver.id),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            kudos.receiver.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.bgDark,
            ),
          ),
        ),
      ],
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({required this.avatar, required this.name, this.onTap});

  final String avatar;
  final String name;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 14,
        backgroundColor: AppColors.textSecondary.withAlpha(77),
        backgroundImage: avatar.isNotEmpty ? NetworkImage(avatar) : null,
        child: avatar.isEmpty
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(fontSize: 10, color: AppColors.bgDark),
              )
            : null,
      ),
    );
  }
}
