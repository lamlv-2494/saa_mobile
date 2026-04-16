import 'package:flutter/material.dart';

abstract final class AppColors {
  // Background
  static const Color bgDark = Color(0xFF00101A);

  // Text
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textRed = Color(0xFFD4271D);

  // Button
  static const Color buttonBg = Color(0xFFFFEA9E);
  static const Color buttonText = Color(0xFF00101A);
  static const Color buttonPressed = Color(0xFFE6D28E);

  // Accent (highlighted text: date, venue, section titles, active tab)
  static const Color textAccent = Color(0xFFFFEA9E);

  // Button — Outline variant
  static const Color outlineBtnBg = Color.fromRGBO(255, 234, 158, 0.10);
  static const Color outlineBtnBorder = Color(0xFF998C5F);
  static const Color outlineBtnPressedBg = Color.fromRGBO(255, 234, 158, 0.20);

  // Notification badge
  static const Color notificationBadge = Color(0xFFD4271D);

  // Countdown
  static const Color countdownBorder = Color(0xFFFFEA9E);

  // Divider (section header separator)
  static const Color divider = Color.fromRGBO(46, 57, 64, 1);

  // Bottom navigation bar
  static const Color navBg = Color.fromRGBO(255, 234, 158, 0.15);

  // Kudos banner text
  static const Color kudosBannerText = Color(0xFFDBD1C1);

  // Award card image border
  static const Color awardMessageContent = Color(0xFFFFEA9E);
  static const Color awardImgBorder = Color(0xFFFFEA9E);

  // Award badge glow shadow
  static const Color awardGlow = Color(0xFFFAE287);

  // Kudos banner background
  static const Color kudosBannerBg = Color(0xFF0F0F0F);

  // Error
  static const Color errorBg = Color(0xFFEF4444);

  // Loading
  static const Color loadingSpinner = Color(0xFF00101A);

  // Kudos feature
  static const Color surfaceCard = Color(0xFFFFF8E1);
  static const Color surfaceDark = Color(0xFF00070C);
  static const Color textSecondary = Color(0xFF999999);
  static const Color heart = Color(0xFFF17676);
  static const Color primary15 = Color.fromRGBO(255, 234, 158, 0.15);

  // Profile feature
  static const Color iconDark = Color(0xFF1A1A2E);
  static const Color spam = Color(0xFFFF8C00);

  // Send Kudos feature
  static const Color errorRed = Color(0xFFD4271D);
  static const Color errorBannerBg = Color.fromRGBO(212, 39, 29, 0.15);
  static const Color sendButtonDisabledBg = Color.fromRGBO(255, 234, 158, 0.40);
  static const Color sendButtonDisabledText = Color.fromRGBO(0, 16, 26, 0.40);
  static const Color toolbarBg = Color(0xFF0A1A24);
  static const Color toolbarActive = Color(0xFFFFEA9E);
  static const Color toolbarInactive = Color(0xFF999999);
  static const Color chipBg = Color.fromRGBO(255, 234, 158, 0.15);
  static const Color chipBorder = Color(0xFF998C5F);
  static const Color cancelButtonBg = Color.fromRGBO(255, 255, 255, 0.10);

  // Gradient header stops (top-to-bottom, 180deg)
  static const List<Color> headerGradientColors = [
    Color.fromRGBO(0, 16, 26, 1),
    Color.fromRGBO(0, 16, 26, 0.30),
    Color.fromRGBO(0, 16, 26, 0.20),
    Color.fromRGBO(0, 16, 26, 0.15),
    Color.fromRGBO(0, 16, 26, 0.10),
    Color.fromRGBO(0, 16, 26, 0.05),
    Color.fromRGBO(0, 16, 26, 0),
  ];

  static const List<double> headerGradientStops = [
    0.0,
    0.7644,
    0.8462,
    0.8870,
    0.9279,
    0.9639,
    1.0,
  ];
}
