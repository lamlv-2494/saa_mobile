import 'package:flutter/material.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/keyvisual_bg.png', fit: BoxFit.cover),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 104,
          child: Opacity(
            opacity: 0.9,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.headerGradientColors,
                  stops: AppColors.headerGradientStops,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
