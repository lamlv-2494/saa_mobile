import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/core/env/env_config.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

/// Widget hiển thị thông tin sender.
/// Conditional rendering: anonymous → avatar mặc định, alias, no badge, no tap.
class SenderInfoWidget extends StatelessWidget {
  const SenderInfoWidget({
    super.key,
    required this.kudos,
    this.onTapProfile,
  });

  final Kudos kudos;
  final VoidCallback? onTapProfile;

  @override
  Widget build(BuildContext context) {
    if (kudos.isAnonymous) {
      return _buildAnonymous();
    }
    // Sender bị xóa tài khoản: không phải ẩn danh nhưng name rỗng
    if (kudos.sender.name.isEmpty) {
      return _buildDeletedSender();
    }
    return _buildNormal();
  }

  Widget _buildDeletedSender() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 0.865),
          ),
          child: CircleAvatar(
            radius: 12,
            backgroundColor: AppColors.textSecondary.withAlpha(77),
            child: const Text(
              '?',
              style: TextStyle(fontSize: 10, color: AppColors.bgDark),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          t.profile.userNotFound,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            height: 16 / 10,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildNormal() {
    final sender = kudos.sender;
    return GestureDetector(
      onTap: onTapProfile,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 0.865),
            ),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.textSecondary.withAlpha(77),
              backgroundImage:
                  sender.avatar.isNotEmpty ? NetworkImage(sender.avatar) : null,
              child: sender.avatar.isEmpty
                  ? Text(
                      sender.name.isNotEmpty
                          ? sender.name[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.bgDark,
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sender.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              height: 16 / 10,
              color: AppColors.buttonText,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (sender.department.isNotEmpty)
                Flexible(
                  child: Text(
                    sender.department,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      height: 9.26 / 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              if (sender.heroTierUrl.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Assets.icons.icDot.svg(width: 2, height: 2),
                ),
                Flexible(
                  child: Image.network(
                    '${EnvConfig.supabaseUrl}${sender.heroTierUrl}',
                    height: 9,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const SizedBox.shrink(),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnonymous() {
    final displayName =
        kudos.senderAlias ?? t.kudos.anonymousSender;
    final departmentText = t.kudos.anonymousSender;

    return Semantics(
      label: t.kudos.anonymousAvatarAccessibility,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.869),
            ),
            child: ClipOval(
              child: Assets.images.anonymousAvatar.image(
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            displayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              height: 16 / 10,
              color: AppColors.buttonText,
            ),
          ),
          Text(
            departmentText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              height: 9.26 / 10,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
