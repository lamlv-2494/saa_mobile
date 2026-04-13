import 'package:flutter/material.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/spotlight_network.dart';

class SpotlightChartPainter extends CustomPainter {
  SpotlightChartPainter({required this.network, this.highlightUserId});

  final SpotlightNetwork network;
  final String? highlightUserId;

  @override
  void paint(Canvas canvas, Size size) {
    if (network.nodes.isEmpty) return;

    // Draw edges
    for (final edge in network.edges) {
      final fromNode = network.nodes.where((n) => n.userId == edge.fromUserId);
      final toNode = network.nodes.where((n) => n.userId == edge.toUserId);
      if (fromNode.isEmpty || toNode.isEmpty) continue;

      final from = fromNode.first;
      final to = toNode.first;

      final weightedPaint = Paint()
        ..color = AppColors.textAccent.withAlpha(
          30 + (edge.weight * 15).clamp(0, 225).toInt(),
        )
        ..strokeWidth = (0.5 + edge.weight * 0.3).clamp(0.5, 3.0)
        ..style = PaintingStyle.stroke;

      canvas.drawLine(
        Offset(from.x, from.y),
        Offset(to.x, to.y),
        weightedPaint,
      );
    }

    // Draw nodes
    for (final node in network.nodes) {
      final isHighlighted = node.userId == highlightUserId;
      final radius = isHighlighted ? 6.0 : 4.0;

      final nodePaint = Paint()
        ..color = isHighlighted
            ? AppColors.textAccent
            : AppColors.textWhite.withAlpha(178)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(node.x, node.y), radius, nodePaint);

      if (isHighlighted) {
        final highlightRing = Paint()
          ..color = AppColors.textAccent.withAlpha(102)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
        canvas.drawCircle(Offset(node.x, node.y), radius + 3, highlightRing);
      }

      // Draw name label for highlighted nodes
      if (isHighlighted) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: node.name,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w700,
              color: AppColors.textWhite,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(
          canvas,
          Offset(node.x - textPainter.width / 2, node.y + radius + 2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant SpotlightChartPainter oldDelegate) {
    return oldDelegate.network != network ||
        oldDelegate.highlightUserId != highlightUserId;
  }
}
