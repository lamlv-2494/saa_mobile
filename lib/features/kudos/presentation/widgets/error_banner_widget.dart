import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';

class ErrorBannerWidget extends StatefulWidget {
  const ErrorBannerWidget({
    super.key,
    required this.message,
    this.onDismiss,
    this.shakeKey = 0,
  });

  final String message;
  final VoidCallback? onDismiss;
  final int shakeKey;

  @override
  State<ErrorBannerWidget> createState() => _ErrorBannerWidgetState();
}

class _ErrorBannerWidgetState extends State<ErrorBannerWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;
  int _lastShakeKey = 0;

  @override
  void initState() {
    super.initState();
    _lastShakeKey = widget.shakeKey;
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -5), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -5, end: 5), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 5, end: 0), weight: 25),
    ]).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(covariant ErrorBannerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shakeKey != _lastShakeKey && widget.shakeKey > 0) {
      _lastShakeKey = widget.shakeKey;
      _shakeController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => SizeTransition(
        sizeFactor: animation,
        child: FadeTransition(opacity: animation, child: child),
      ),
      child: widget.message.isEmpty
          ? const SizedBox.shrink()
          : AnimatedBuilder(
              animation: _shakeAnimation,
              builder: (_, child) => Transform.translate(
                offset: Offset(_shakeAnimation.value, 0),
                child: child,
              ),
              child: Container(
                key: const ValueKey('error_banner'),
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0x26D4271D),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.errorRed),
                ),
                child: Text(
                  widget.message,
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.38,
                  ),
                ),
              ),
            ),
    );
  }
}
