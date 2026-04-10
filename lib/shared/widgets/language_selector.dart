import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    super.key,
    required this.currentLocaleCode,
    required this.onTap,
  });

  final String currentLocaleCode;
  final VoidCallback onTap;

  static const _localeData = {
    'vi': ('VN', 'assets/icons/flags/vn.svg'),
    'en': ('EN', 'assets/icons/flags/en.svg'),
  };

  @override
  Widget build(BuildContext context) {
    final data = _localeData[currentLocaleCode] ?? _localeData['vi']!;
    final (label, flagPath) = data;

    return Semantics(
      button: true,
      label: t.accessibility.languageSelector,
      child: SizedBox(
        height: 48,
        child: GestureDetector(
          onTap: onTap,
          child: Center(
            child: Container(
              width: 90,
              height: 32,
              padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  SvgPicture.asset(flagPath, width: 24, height: 24),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 20 / 14,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/icons/ic_arrow_down.svg',
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
