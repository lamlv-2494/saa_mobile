import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/core/utils/time_utils.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/kudos_detail_viewmodel.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/receiver_info_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/sender_info_widget.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class KudosDetailScreen extends ConsumerWidget {
  const KudosDetailScreen({super.key, required this.kudosId});

  final String kudosId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncKudos = ref.watch(kudosDetailViewModelProvider(kudosId));

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: AppColors.bgDark,
        leading: IconButton(
          icon: Assets.icons.icChevronLeft.svg(
            width: 24,
            height: 24,
            colorFilter:
                const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          t.kudos.detailTitle,
          style: GoogleFonts.montserrat(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: AppColors.textWhite,
          ),
        ),
        centerTitle: true,
      ),
      body: asyncKudos.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.textAccent),
        ),
        error: (_, _) => _buildError(context, ref),
        data: (kudos) {
          if (kudos == null) return _buildNotFound(context);
          return _buildContent(context, ref, kudos);
        },
      ),
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            t.kudos.errorRetry,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () =>
                ref.invalidate(kudosDetailViewModelProvider(kudosId)),
            child: Text(
              t.kudos.retry,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            t.kudos.kudosNotFound,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              t.kudos.goBack,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, Kudos kudos) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Center(
        child: Container(
          width: 335,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.awardImgBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSenderReceiverRow(context, kudos),
              const SizedBox(height: 8),
              Container(height: 1, color: AppColors.awardImgBorder),
              const SizedBox(height: 8),
              _buildTimestamp(kudos),
              if (kudos.awardTitle != null &&
                  kudos.awardTitle!.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildAwardTitle(kudos),
              ],
              const SizedBox(height: 8),
              _buildContentFrame(kudos),
              if (kudos.imageUrls.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildImageGallery(kudos),
              ],
              if (kudos.hashtags.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildHashtags(kudos),
              ],
              const SizedBox(height: 8),
              Container(height: 1, color: AppColors.awardImgBorder),
              const SizedBox(height: 8),
              _buildActions(context, ref, kudos),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSenderReceiverRow(BuildContext context, Kudos kudos) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SenderInfoWidget(
            kudos: kudos,
            onTapProfile: kudos.isAnonymous
                ? null
                : () => context.push('/profile/${kudos.sender.id}'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Assets.icons.icSent.svg(width: 16, height: 16),
        ),
        Expanded(
          child: ReceiverInfoWidget(
            receiver: kudos.receiver,
            onTapProfile: () =>
                context.push('/profile/${kudos.receiver.id}'),
          ),
        ),
      ],
    );
  }

  Widget _buildTimestamp(Kudos kudos) {
    return Text(
      formatKudosTimeAgo(kudos.createdAt),
      style: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 11.1 / 10,
        letterSpacing: 0.23,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildAwardTitle(Kudos kudos) {
    return Center(
      child: Text(
        kudos.awardTitle!,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          height: 11.1 / 10,
          letterSpacing: 0.23,
          color: AppColors.buttonText,
        ),
      ),
    );
  }

  Widget _buildContentFrame(Kudos kudos) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 234, 158, 0.40),
        borderRadius: BorderRadius.circular(5.554),
        border: Border.all(
          color: AppColors.awardImgBorder,
          width: 0.463,
        ),
      ),
      child: Text(
        kudos.content.isNotEmpty ? kudos.content : t.kudos.noContent,
        style: GoogleFonts.montserrat(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          height: 14 / 10,
          color: AppColors.buttonText,
        ),
      ),
    );
  }

  Widget _buildImageGallery(Kudos kudos) {
    return Row(
      children: kudos.imageUrls
          .take(5)
          .map(
            (url) => Padding(
              padding: const EdgeInsets.only(right: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.043),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.outlineBtnBorder,
                      width: 0.447,
                    ),
                    borderRadius: BorderRadius.circular(8.043),
                  ),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildHashtags(Kudos kudos) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: kudos.hashtags
          .map(
            (h) => Text(
              h.name,
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                height: 11.1 / 10,
                letterSpacing: 0.23,
                color: AppColors.textRed,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref, Kudos kudos) {
    final notifier =
        ref.read(kudosDetailViewModelProvider(kudosId).notifier);

    return Row(
      children: [
        // Heart button
        GestureDetector(
          onTap: () => notifier.toggleHeart(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                kudos.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                size: 16,
                color: kudos.isLikedByMe
                    ? AppColors.heart
                    : AppColors.buttonText,
              ),
              const SizedBox(width: 4),
              Text(
                '${kudos.heartCount}',
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  height: 14.8 / 10,
                  color: AppColors.buttonText,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        // Copy Link
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: kudos.shareUrl));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(t.kudos.linkCopied),
                duration: const Duration(seconds: 2),
                backgroundColor: AppColors.surfaceDark,
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.kudos.copyLink,
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  height: 11.1 / 10,
                  color: AppColors.buttonText.withAlpha(178),
                ),
              ),
              const SizedBox(width: 4),
              Assets.icons.icLink.svg(
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  AppColors.buttonText.withAlpha(178),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
