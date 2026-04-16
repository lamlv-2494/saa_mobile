import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

/// Common language dropdown widget using PopupMenuButton.
/// Reusable across Auth, Home, and other screens.
class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({
    super.key,
    required this.currentLocaleCode,
    required this.onLocaleChanged,
  });

  final String currentLocaleCode;
  final ValueChanged<String> onLocaleChanged;

  static final _localeOptions = [
    ('vi', 'VN', Assets.icons.flags.vn),
    ('en', 'EN', Assets.icons.flags.en),
  ];

  @override
  Widget build(BuildContext context) {
    final currentOption = _localeOptions.firstWhere(
      (o) => o.$1 == currentLocaleCode,
      orElse: () => _localeOptions.first,
    );

    return Semantics(
      button: true,
      label: t.accessibility.languageSelector,
      child: SizedBox(
        height: 48,
        child: PopupMenuButton<String>(
          onSelected: onLocaleChanged,
          offset: const Offset(0, 48),
          color: const Color(0xFF00070C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFF998C5F)),
          ),
          itemBuilder: (_) => _localeOptions.map((option) {
            final (code, label, flagIcon) = option;
            final isSelected = code == currentLocaleCode;
            return PopupMenuItem<String>(
              value: code,
              padding: EdgeInsets.zero,
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFFFEA9E).withValues(alpha: 0.20)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(isSelected ? 2 : 0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    flagIcon.svg(width: 24, height: 24),
                    const SizedBox(width: 4),
                    Text(
                      label,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.1,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              currentOption.$3.svg(width: 24, height: 24),
              const SizedBox(width: 4),
              Text(
                currentOption.$2,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(width: 4),
              Assets.icons.icArrowDown.svg(width: 24, height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
