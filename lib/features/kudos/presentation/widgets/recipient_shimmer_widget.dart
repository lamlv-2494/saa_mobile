import 'package:flutter/material.dart';

/// Shimmer loading placeholder for recipient search results (3 items).
class RecipientShimmerWidget extends StatefulWidget {
  const RecipientShimmerWidget({super.key});

  @override
  State<RecipientShimmerWidget> createState() => _RecipientShimmerWidgetState();
}

class _RecipientShimmerWidgetState extends State<RecipientShimmerWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) => Column(
        children: List.generate(3, (i) {
          return Column(
            children: [
              _ShimmerItem(progress: _controller.value),
              if (i < 2)
                const Divider(
                  color: Color(0xFF2E3940),
                  height: 1,
                  indent: 12,
                  endIndent: 12,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _ShimmerItem extends StatelessWidget {
  const _ShimmerItem({required this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            _shimmerBox(width: 36, height: 36, circular: true),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerBox(width: 140, height: 14),
                  const SizedBox(height: 6),
                  _shimmerBox(width: 90, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    bool circular = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius:
            circular ? BorderRadius.circular(width / 2) : BorderRadius.circular(4),
        gradient: LinearGradient(
          begin: Alignment(-1.0 + 2.0 * progress, 0),
          end: Alignment(-1.0 + 2.0 * progress + 1.0, 0),
          colors: const [
            Color(0xFF1A2A36),
            Color(0xFF2A3A46),
            Color(0xFF1A2A36),
          ],
        ),
      ),
    );
  }
}
