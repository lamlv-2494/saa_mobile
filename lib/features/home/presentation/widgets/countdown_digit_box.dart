import 'package:flutter/material.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';

class CountdownDigitBox extends StatelessWidget {
  const CountdownDigitBox({super.key, required this.digit});

  final String digit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.countdownBorder.withAlpha(128),
          width: 0.5,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(255, 255, 255, 0.5),
            Color.fromRGBO(255, 255, 255, 0.05),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        digit,
        style: const TextStyle(
          fontFamily: 'DigitalNumbers',
          fontSize: 32,
          fontWeight: FontWeight.w400,
          color: AppColors.textWhite,
        ),
      ),
    );
  }
}
