import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class KudosFabWidget extends StatefulWidget {
  const KudosFabWidget({
    super.key,
    required this.onWriteKudosTap,
    required this.onViewKudosTap,
  });

  final VoidCallback onWriteKudosTap;
  final VoidCallback onViewKudosTap;

  @override
  State<KudosFabWidget> createState() => _KudosFabWidgetState();
}

class _KudosFabWidgetState extends State<KudosFabWidget> {
  bool _isProcessing = false;

  void _handleTap(VoidCallback action) {
    if (_isProcessing) return;
    _isProcessing = true;
    action();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 89,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.buttonBg,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Write kudos
          Semantics(
            button: true,
            label: t.accessibility.fabWriteKudos,
            child: GestureDetector(
              onTap: () => _handleTap(widget.onWriteKudosTap),
              child: Assets.icons.icPen.svg(
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.buttonText,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '/',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                height: 32 / 24,
                color: AppColors.buttonText,
              ),
            ),
          ),
          // View kudos
          Semantics(
            button: true,
            label: t.accessibility.fabViewKudos,
            child: GestureDetector(
              onTap: () => _handleTap(widget.onViewKudosTap),
              child: Assets.icons.icKudosLogo.svg(
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
