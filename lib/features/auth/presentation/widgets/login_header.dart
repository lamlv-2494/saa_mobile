import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';

class LoginHeader extends ConsumerWidget {
  const LoginHeader({super.key});

  static const _localeOptions = [
    ('vi', 'VN', 'assets/icons/flags/vn.svg'),
    ('en', 'EN', 'assets/icons/flags/en.svg'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);
    final currentCode = locale.languageCode;
    final currentOption = _localeOptions.firstWhere(
      (o) => o.$1 == currentCode,
      orElse: () => _localeOptions.first,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/saa_logo.png',
          width: 48,
          height: 44,
          fit: BoxFit.cover,
        ),
        Semantics(
          button: true,
          label: t.accessibility.languageSelector,
          child: SizedBox(
            height: 48,
            child: PopupMenuButton<String>(
              onSelected: (code) {
                ref.read(localeNotifierProvider.notifier).changeLocale(code);
              },
              offset: const Offset(0, 48),
              color: const Color(0xFF001A2E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              itemBuilder: (_) => _localeOptions.map((option) {
                final (code, label, flagPath) = option;
                return PopupMenuItem<String>(
                  value: code,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(flagPath, width: 24, height: 24),
                      const SizedBox(width: 8),
                      Text(
                        label,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textWhite,
                        ),
                      ),
                      if (code == currentCode) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.check,
                          size: 16,
                          color: AppColors.textWhite,
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    currentOption.$3,
                    width: 24,
                    height: 24,
                  ),
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
      ],
    );
  }
}
