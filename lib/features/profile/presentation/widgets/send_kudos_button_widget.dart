import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class SendKudosButtonWidget extends StatelessWidget {
  const SendKudosButtonWidget({
    super.key,
    required this.userId,
    required this.userName,
    required this.onTap,
  });

  final String userId;
  final String userName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${t.profile.sendThanks} $userName',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.outlineBtnBg,
            border: Border.all(color: AppColors.outlineBtnBorder),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.icons.icPen.path,
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.textAccent,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                t.profile.sendThanks,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  color: AppColors.textAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
