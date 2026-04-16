import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';

class HeartButton extends StatefulWidget {
  const HeartButton({
    super.key,
    required this.heartCount,
    required this.isLiked,
    this.canLike = true,
    this.onToggle,
  });

  final int heartCount;
  final bool isLiked;
  final bool canLike;
  final VoidCallback? onToggle;

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!widget.canLike) return;
    _controller.forward(from: 0);
    widget.onToggle?.call();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isLiked ? AppColors.heart : AppColors.textSecondary;
    final opacity = widget.canLike ? 1.0 : 0.5;

    return GestureDetector(
      onTap: _handleTap,
      child: Opacity(
        opacity: opacity,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) =>
              Transform.scale(scale: _scaleAnimation.value, child: child),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.isLiked ? Icons.favorite : Icons.favorite_border,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 4),
              Text(
                '${widget.heartCount}',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
