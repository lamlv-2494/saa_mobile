import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class RecipientPopupMenuWidget extends ConsumerWidget {
  const RecipientPopupMenuWidget({
    super.key,
    required this.hasError,
  });

  final bool hasError;

  String _getInitials(String name) {
    if (name.isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final state = ref.watch(sendKudosViewModelProvider).value;
    final hasRecipient = state?.recipientId != null;
    final displayText = state?.recipientName ?? '';
    final allUsers = state?.allUsers ?? [];
    final selectedId = state?.recipientId;

    final borderColor =
        hasError ? AppColors.errorRed : const Color(0xFF998C5F);

    return PopupMenuButton<UserSummary>(
      onSelected: (user) {
        ref.read(sendKudosViewModelProvider.notifier).selectRecipient(
              id: user.id,
              name: user.name,
              avatar: user.avatar,
            );
      },
      constraints: const BoxConstraints(maxHeight: 300, maxWidth: 335),
      color: const Color(0xFF0A1A24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(color: Color(0xFF998C5F)),
      ),
      position: PopupMenuPosition.under,
      itemBuilder: (_) {
        if (allUsers.isEmpty) {
          return [
            PopupMenuItem<UserSummary>(
              enabled: false,
              child: Center(
                child: Text(
                  t.sendKudos.usersLoadError,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ];
        }
        return allUsers.map((user) {
          final isSelected = user.id == selectedId;
          return PopupMenuItem<UserSummary>(
            value: user,
            child: Container(
              color: isSelected ? const Color(0x14FFEA9E) : null,
              child: Row(
                children: [
                  _buildAvatar(user),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          user.name,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (user.department.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            user.department,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF999999),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList();
      },
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0x1AFFEA9E),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hasRecipient
                    ? displayText
                    : t.sendKudos.recipientPlaceholder,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color:
                      hasRecipient ? Colors.white : AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(UserSummary user) {
    if (user.avatar.isNotEmpty) {
      return CircleAvatar(
        radius: 18,
        backgroundImage: NetworkImage(user.avatar),
        backgroundColor: const Color(0x33FFEA9E),
        onBackgroundImageError: (_, _) {},
      );
    }
    return CircleAvatar(
      radius: 18,
      backgroundColor: const Color(0x33FFEA9E),
      child: Text(
        _getInitials(user.name),
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFFFEA9E),
        ),
      ),
    );
  }
}
