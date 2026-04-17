import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/features/home/data/models/event_info.dart';
import 'package:saa_mobile/features/home/data/repositories/countdown_repository.dart';
import 'package:saa_mobile/features/home/presentation/widgets/countdown_timer_widget.dart';
import 'package:saa_mobile/features/home/presentation/widgets/event_info_row.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/widgets/outline_button.dart';
import 'package:saa_mobile/shared/widgets/primary_button.dart';

class HeroContentWidget extends StatelessWidget {
  const HeroContentWidget({
    super.key,
    required this.eventInfo,
    required this.countdownRepository,
    required this.onAboutAwardTap,
    required this.onAboutKudosTap,
  });

  final EventInfo eventInfo;
  final CountdownRepository countdownRepository;
  final VoidCallback onAboutAwardTap;
  final VoidCallback onAboutKudosTap;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        // Background hero image + gradient overlays
        Positioned.fill(child: _HeroBackground()),
        // Content
        Padding(
          padding: EdgeInsets.only(
            top: topPadding + 70, // below header
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Root Further logo
              Assets.images.rootFurtherLogo.image(
                width: 247,
                height: 109,
                errorBuilder: (_, _, _) => Text(
                  'ROOT\nFURTHER',
                  style: GoogleFonts.montserrat(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                    color: AppColors.textWhite,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Coming soon
              Text(
                t.home.comingSoon,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  height: 20 / 14,
                  letterSpacing: 0.25,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(height: 8),
              // Countdown timer
              CountdownTimerWidget(repository: countdownRepository),
              const SizedBox(height: 24),
              // Event info rows
              EventInfoRow(
                label: t.home.eventTime,
                value: _formatDate(eventInfo.eventDate),
              ),
              const SizedBox(height: 8),
              EventInfoRow(label: t.home.eventVenue, value: eventInfo.venue),
              const SizedBox(height: 8),
              // Livestream note
              Text(
                eventInfo.livestreamNote,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 20 / 14,
                  letterSpacing: 0.25,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(height: 24),
              // CTA buttons
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: t.home.aboutAward,
                      icon: Assets.icons.icArrowOpen.svg(
                        width: 24,
                        height: 24,
                        color: AppColors.bgDark,
                      ),
                      onPressed: onAboutAwardTap,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlineButtonWidget(
                      label: t.home.aboutKudos,
                      icon: Assets.icons.icArrowOpen.svg(
                        width: 24,
                        height: 24,
                        color: AppColors.textWhite,
                      ),
                      onPressed: onAboutKudosTap,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

class _HeroBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Key Visual BG
        Assets.images.keyVisualBg.image(
          width: double.infinity,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          errorBuilder: (_, _, _) => const ColoredBox(color: AppColors.bgDark),
        ),
        // Shadow Left gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF00101A),
                Color(0xFF10181F),
                Color.fromRGBO(0, 16, 26, 0),
              ],
              stops: [0.0007, 0.1861, 0.772],
            ),
          ),
        ),
        // Shadow Bottom gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFF00101A),
                Color(0xFF00101A),
                Color.fromRGBO(0, 16, 26, 0),
              ],
              stops: [0.0, 0.2541, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
