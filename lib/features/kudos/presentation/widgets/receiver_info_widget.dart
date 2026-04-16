import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/core/env/env_config.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

/// Widget hiển thị thông tin receiver — luôn hiển thị đầy đủ.
class ReceiverInfoWidget extends StatelessWidget {
  const ReceiverInfoWidget({
    super.key,
    required this.receiver,
    this.onTapProfile,
  });

  final UserSummary receiver;
  final VoidCallback? onTapProfile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapProfile,
      child: Column(
        children: [
          Semantics(
            label: t.kudos.avatarAccessibility,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 0.865),
              ),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.textSecondary.withAlpha(77),
                backgroundImage: receiver.avatar.isNotEmpty
                    ? NetworkImage(receiver.avatar)
                    : null,
                child: receiver.avatar.isEmpty
                    ? Text(
                        receiver.name.isNotEmpty
                            ? receiver.name[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.bgDark,
                        ),
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            receiver.name,
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
              if (receiver.department.isNotEmpty)
                Flexible(
                  child: Text(
                    receiver.department,
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
              if (receiver.heroTierUrl.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Assets.icons.icDot.svg(width: 2, height: 2),
                ),
                Flexible(
                  child: Image.network(
                    '${EnvConfig.supabaseUrl}${receiver.heroTierUrl}',
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
}
