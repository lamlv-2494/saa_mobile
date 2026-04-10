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
