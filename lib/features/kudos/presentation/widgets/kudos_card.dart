import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/core/utils/asset_mapper.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_content_card.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

enum KudosCardVariant { highlight, feed }

class KudosCard extends StatelessWidget {
  const KudosCard({
    super.key,
    required this.variant,
    required this.kudos,
    required this.timeText,
    this.onHeartTap,
    this.onCopyLink,
    this.onViewDetail,
    this.onAvatarTap,
  });

  final KudosCardVariant variant;
  final Kudos kudos;
  final String timeText;
  final VoidCallback? onHeartTap;
  final VoidCallback? onCopyLink;
  final VoidCallback? onViewDetail;
  final void Function(String userId)? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final content = variant == KudosCardVariant.highlight
        ? _buildHighlight()
        : _buildFeed();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: variant == KudosCardVariant.highlight
              ? AppColors.awardImgBorder
              : Colors.transparent,
        ),
      ),
      child: content,
    );
  }

  Widget _buildHighlight() {
    return Container(
      width: 274,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _SenderReceiverRow(
            kudos: kudos,
            onAvatarTap: onAvatarTap,
            compact: true,
          ),
          const SizedBox(height: 8),
          Container(height: 1, color: AppColors.awardImgBorder),
          const SizedBox(height: 8),
          Expanded(child: SingleChildScrollView(child: _buildContentCard())),
        ],
      ),
    );
  }

  Widget _buildFeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SenderReceiverRow(
          kudos: kudos,
          onAvatarTap: onAvatarTap,
          compact: true,
        ),
        const SizedBox(height: 8),
        Container(height: 1, color: AppColors.awardImgBorder),
        const SizedBox(height: 8),
        _buildContentCard(),
      ],
    );
  }

  Widget _buildContentCard() {
    return KudosContentCard(
      content: kudos.content,
      hashtags: kudos.hashtags,
      heartCount: kudos.heartCount,
      isLikedByMe: kudos.isLikedByMe,
      canLike: kudos.canLike,
      timeText: timeText,
      awardTitle: kudos.awardTitle,
      shareUrl: kudos.shareUrl,
      onHeartTap: onHeartTap,
      onViewDetail: onViewDetail,
    );
  }
}

class _SenderReceiverRow extends StatelessWidget {
  const _SenderReceiverRow({
    required this.kudos,
    required this.compact,
    this.onAvatarTap,
  });

  final Kudos kudos;
  final bool compact;
  final void Function(String userId)? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    if (compact) return _buildCompact();
    return _buildFull();
  }

  Widget _buildCompact() {
    final isAnon = kudos.isAnonymous;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: isAnon
              ? _AnonymousAvatar(
                  name: kudos.senderAlias ?? t.kudos.anonymousSender,
                  radius: 14,
                )
              : _UserAvatar(
                  avatar: kudos.sender.avatar,
                  name: kudos.sender.name,
                  department: kudos.sender.department,
                  heroTier: kudos.sender.heroTier,
                  radius: 14,
                  onTap: () => onAvatarTap?.call(kudos.sender.id),
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Assets.icons.icMedia.svg(width: 16, height: 16),
        ),
        Expanded(
          child: _UserAvatar(
            avatar: kudos.receiver.avatar,
            name: kudos.receiver.name,
            department: kudos.receiver.department,
            heroTier: kudos.receiver.heroTier,
            radius: 14,
            onTap: () => onAvatarTap?.call(kudos.receiver.id),
          ),
        ),
      ],
    );
  }

  Widget _buildFull() {
    final isAnon = kudos.isAnonymous;
    final senderDisplayName = isAnon
        ? (kudos.senderAlias ?? t.kudos.anonymousSender)
        : kudos.sender.name;

    return Row(
      children: [
        Column(
          children: [
            if (isAnon)
              _AnonymousAvatar(
                name: senderDisplayName,
                radius: 16,
              )
            else
              GestureDetector(
                onTap: () => onAvatarTap?.call(kudos.sender.id),
                child: _UserAvatar(
                  avatar: kudos.sender.avatar,
                  name: kudos.sender.name,
                  department: kudos.sender.department,
                  heroTier: kudos.sender.heroTier,
                  radius: 16,
                ),
              ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                senderDisplayName,
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
          child: _UserAvatar(
            avatar: kudos.receiver.avatar,
            name: kudos.receiver.name,
            department: kudos.receiver.department,
            heroTier: kudos.receiver.heroTier,
            radius: 16,
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

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({
    required this.avatar,
    required this.name,
    required this.department,
    required this.radius,
    this.heroTier = 'none',
    this.onTap,
  });

  final String avatar;
  final String name;
  final String department;
  final double radius;
  final String heroTier;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.textSecondary.withAlpha(77),
            backgroundImage: avatar.isNotEmpty ? NetworkImage(avatar) : null,
            child: avatar.isEmpty
                ? Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: TextStyle(
                      fontSize: radius > 14 ? 12 : 10,
                      color: AppColors.bgDark,
                    ),
                  )
                : null,
          ),
        ),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.buttonText,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (department.isNotEmpty)
              FittedBox(
                child: Text(
                  department,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            if (AssetMapper.heroTierImage(heroTier) != null) ...[
              if (department.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Assets.icons.icDot.svg(width: 2, height: 2),
                ),
              AssetMapper.heroTierImage(heroTier)!.image(width: 45, height: 9),
            ],
          ],
        ),
      ],
    );
  }
}

/// Avatar ẩn danh — dùng asset riêng, border dày hơn, không badge, không tap.
class _AnonymousAvatar extends StatelessWidget {
  const _AnonymousAvatar({
    required this.name,
    required this.radius,
  });

  final String name;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.869),
          ),
          child: ClipOval(
            child: Assets.images.anonymousAvatar.image(
              width: radius * 2,
              height: radius * 2,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.buttonText,
          ),
        ),
        Text(
          t.kudos.anonymousSender,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
