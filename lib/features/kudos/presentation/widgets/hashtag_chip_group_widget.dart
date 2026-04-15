import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class HashtagChipGroupWidget extends StatelessWidget {
  const HashtagChipGroupWidget({
    super.key,
    required this.selectedHashtags,
    required this.onRemove,
    required this.onAddTap,
    this.maxHashtags = 5,
    this.hasError = false,
  });

  final List<Hashtag> selectedHashtags;
  final void Function(Hashtag) onRemove;
  final VoidCallback onAddTap;
  final int maxHashtags;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final canAdd = selectedHashtags.length < maxHashtags;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...selectedHashtags.map(
          (tag) => _HashtagChip(
            label: tag.name,
            onRemove: () => onRemove(tag),
          ),
        ),
        if (canAdd)
          _AddHashtagButton(
            label: t.sendKudos.hashtagPlaceholder,
            hasError: hasError && selectedHashtags.isEmpty,
            onTap: onAddTap,
          ),
        if (!canAdd)
          _HintText(
            text: t.sendKudos.hashtagMaxReached
                .replaceAll('{max}', '$maxHashtags'),
          ),
      ],
    );
  }
}

class _HashtagChip extends StatelessWidget {
  const _HashtagChip({required this.label, required this.onRemove});

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.chipBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.chipBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textAccent,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              Icons.close,
              size: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddHashtagButton extends StatelessWidget {
  const _AddHashtagButton({
    required this.label,
    required this.onTap,
    this.hasError = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final borderColor = hasError ? AppColors.errorRed : AppColors.chipBorder;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, style: BorderStyle.solid),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HintText extends StatelessWidget {
  const _HintText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 12,
        color: AppColors.textSecondary,
      ),
    );
  }
}
