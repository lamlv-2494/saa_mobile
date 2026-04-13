import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';

class ThemeDescriptionWidget extends StatelessWidget {
  const ThemeDescriptionWidget({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    if (description.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        description,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          height: 20 / 14,
          letterSpacing: 0.25,
          color: AppColors.textWhite,
        ),
      ),
    );
  }
}
