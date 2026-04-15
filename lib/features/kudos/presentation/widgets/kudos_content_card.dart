import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/heart_button.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class KudosContentCard extends StatelessWidget {
  const KudosContentCard({
    super.key,
    required this.content,
    required this.hashtags,
    required this.heartCount,
    required this.isLikedByMe,
    required this.canLike,
    required this.timeText,
    this.awardTitle,
    this.shareUrl,
    this.onHeartTap,
    this.onViewDetail,
  });

  final String content;
  final List<Hashtag> hashtags;
  final int heartCount;
  final bool isLikedByMe;
  final bool canLike;
  final String timeText;
  final String? awardTitle;
  final String? shareUrl;
  final VoidCallback? onHeartTap;
  final VoidCallback? onViewDetail;

  void _copyLink(BuildContext context) {
    if (shareUrl == null || shareUrl!.isEmpty) return;
    Clipboard.setData(ClipboardData(text: shareUrl!));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.kudos.linkCopied),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.surfaceDark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          timeText,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 16 / 12,
            color: AppColors.textSecondary,
          ),
        ),
        if (awardTitle != null && awardTitle!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.center,
            child: Text(
              awardTitle!,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 20 / 14,
                color: AppColors.bgDark,
              ),
            ),
          ),
        ],
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.awardMessageContent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 20 / 14,
              color: AppColors.bgDark,
            ),
          ),
        ),
        if (hashtags.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: hashtags
                .map(
                  (h) => Text(
                    h.name,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 16 / 12,
                      color: AppColors.textRed,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
        const SizedBox(height: 8),
        Container(height: 1, color: AppColors.awardImgBorder),
        const SizedBox(height: 8),
        Row(
          children: [
            HeartButton(
              heartCount: heartCount,
              isLiked: isLikedByMe,
              canLike: canLike,
              onToggle: onHeartTap,
            ),
            const Spacer(),
            
            GestureDetector(
              onTap: () => _copyLink(context),
              child: Row(
                children: [
                  Semantics(
                    button: true,
                    label: t.kudos.copyLinkAccessibility,
                    child: Text(
                      t.kudos.copyLink,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.bgDark.withAlpha(178),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Assets.icons.icLink.svg(
                    width: 12,
                    height: 12,
                    color: AppColors.bgDark.withAlpha(178),
                  ),],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onViewDetail,
              child: Row(
                children: [
                  Semantics(
                    link: true,
                    label: t.kudos.viewDetailAccessibility,
                    child: Text(
                      t.kudos.viewDetail,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.bgDark.withAlpha(178),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Assets.icons.icArrowOpen.svg(
                    width: 16,
                    height: 16,
                    color: AppColors.bgDark.withAlpha(178),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
