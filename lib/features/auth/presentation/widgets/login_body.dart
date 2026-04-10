import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/root_further.png',
          width: 247,
          height: 109,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            t.login.description,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              height: 20 / 14,
              letterSpacing: 0.25,
              color: AppColors.textWhite,
            ),
          ),
        ),
      ],
    );
  }
}
