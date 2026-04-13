import 'package:flutter/material.dart';

abstract final class AppColors {
  // Background
  static const Color bgDark = Color(0xFF00101A);

  // Text
  static const Color textWhite = Color(0xFFFFFFFF);

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
  static const Color awardImgBorder = Color(0xFFFFEA9E);

  // Error
  static const Color errorBg = Color(0xFFEF4444);

  // Loading
  static const Color loadingSpinner = Color(0xFF00101A);

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
