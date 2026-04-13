import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/widgets/language_dropdown.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
    required this.opacity,
    required this.hasUnreadNotifications,
    required this.currentLocaleCode,
    required this.onLocaleChanged,
    this.onSearchTap,
    this.onNotificationTap,
  });

  final double opacity;
  final bool hasUnreadNotifications;
  final String currentLocaleCode;
  final ValueChanged<String> onLocaleChanged;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: topPadding + 60,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.headerGradientColors,
              stops: AppColors.headerGradientStops,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: topPadding, left: 20, right: 20),
            child: Row(
              children: [
                // Logo
                Assets.images.home.logoSaa.image(
                  width: 48,
                  height: 44,
                  errorBuilder: (_, _, _) => Text(
                    'SAA',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                ),
                const Spacer(),
                // Language selector
                LanguageDropdown(
                  currentLocaleCode: currentLocaleCode,
                  onLocaleChanged: onLocaleChanged,
                ),
                const SizedBox(width: 10),
                // Search
                Semantics(
                  button: true,
                  label: t.accessibility.searchButton,
                  child: GestureDetector(
                    onTap: onSearchTap,
                    child: Assets.icons.icSearch.svg(
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Notification bell
                Semantics(
                  button: true,
                  label: t.accessibility.notificationButton,
                  child: GestureDetector(
                    onTap: onNotificationTap,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Assets.icons.icNotification.svg(
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                              AppColors.textWhite,
                              BlendMode.srcIn,
                            ),
                          ),
                          if (hasUnreadNotifications)
                            Positioned(
                              top: -1,
                              right: -1,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.notificationBadge,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.bgDark,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
