import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/spotlight_data.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/widgets/section_header_widget.dart';

class SpotlightSectionWidget extends StatelessWidget {
  const SpotlightSectionWidget({
    super.key,
    required this.data,
    this.onSearchTap,
  });

  final SpotlightData? data;
  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderWidget(
            label: t.kudos.sectionLabel,
            title: t.kudos.spotlightTitle,
          ),
          const SizedBox(height: 24),
          _SpotlightCanvas(data: data, onSearchTap: onSearchTap),
        ],
      ),
    );
  }
}

class _SpotlightCanvas extends StatefulWidget {
  const _SpotlightCanvas({required this.data, this.onSearchTap});

  final SpotlightData? data;
  final VoidCallback? onSearchTap;

  @override
  State<_SpotlightCanvas> createState() => _SpotlightCanvasState();
}

class _SpotlightCanvasState extends State<_SpotlightCanvas> {
  static const double _canvasW = 700;
  static const double _canvasH = 130;
  static const double _fontSize = 8;

  String? _highlightedUserId;
  List<Offset> _positions = [];

  @override
  void initState() {
    super.initState();
    _positions = _layoutEntries(widget.data?.entries ?? []);
  }

  @override
  void didUpdateWidget(covariant _SpotlightCanvas old) {
    super.didUpdateWidget(old);
    if (old.data?.entries != widget.data?.entries) {
      _positions = _layoutEntries(widget.data?.entries ?? []);
    }
  }

  // Viewport visible ban đầu ~ 335x130, center ở ~167x55.
  // Labels tập trung ở giữa viewport rồi dần tỏa ra toàn canvas.
  static const double _viewCenterX = 167;
  static const double _viewCenterY = 55;

  List<Offset> _layoutEntries(List<SpotlightEntry> entries) {
    if (entries.isEmpty) return [];

    final rng = math.Random(42);
    final offsets = <Offset>[];
    final count = entries.length;

    for (var i = 0; i < count; i++) {
      final ratio = count <= 1 ? 0.0 : i / (count - 1);
      // Spread 40% → 100%: rải rộng hơn để các tên không dồn vào nhau
      final spreadX = 0.4 + ratio * 0.6;
      final spreadY = 0.4 + ratio * 0.6;
      final dx = (rng.nextDouble() - 0.5) * 500 * spreadX;
      final dy = (rng.nextDouble() - 0.5) * 120 * spreadY;
      final x = (_viewCenterX + dx).clamp(4.0, _canvasW - 80);
      final y = (_viewCenterY + dy).clamp(4.0, _canvasH - 16);
      offsets.add(Offset(x, y));
    }
    return offsets;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    if (data == null || data.entries.isEmpty) {
      return Container(
        height: 159,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.outlineBtnBorder, width: 0.29),
        ),
        child: Center(
          child: Text(
            t.kudos.emptySpotlight,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    final entries = data.entries;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 159,
        decoration: BoxDecoration(
          color: const Color(0xFF00101A),
          border: Border.all(color: AppColors.outlineBtnBorder, width: 0.29),
        ),
        child: Stack(
          children: [
            // [Layer 1] Interactive floating names canvas
            InteractiveViewer(
              panEnabled: true,
              scaleEnabled: false,
              child: SizedBox(
                width: _canvasW,
                height: _canvasH,
                child: Stack(
                  children: [
                    for (var i = 0; i < entries.length; i++)
                      if (i < _positions.length)
                        _buildLabel(entries[i], _positions[i]),
                  ],
                ),
              ),
            ),
            // [Layer 2] KUDOS count label (center top, fixed overlay)
            Positioned(
              top: 11,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Center(
                  child: Text(
                    t.kudos.totalKudos.replaceAll(
                      '{count}',
                      data.totalKudos.toString(),
                    ),
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textWhite,
                    ),
                  ),
                ),
              ),
            ),
            // [Layer 3] Search button (fixed overlay, on top for hit testing)
            Positioned(
              top: 8,
              left: 7,
              child: _SearchButton(onTap: widget.onSearchTap),
            ),
            // [Layer 4] Live feed (fixed overlay)
            if (data.recentActivity.isNotEmpty)
              Positioned(
                top: 124,
                left: 14,
                child: _LiveFeedEntry(activity: data.recentActivity.first),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(SpotlightEntry entry, Offset pos) {
    final isHighlighted = _highlightedUserId == entry.userId;
    return Positioned(
      left: pos.dx,
      top: pos.dy,
      child: GestureDetector(
        onTap: () => setState(() {
          _highlightedUserId = isHighlighted ? null : entry.userId;
        }),
        child: Text(
          entry.name,
          style: GoogleFonts.montserrat(
            fontSize: isHighlighted ? 10 : _fontSize,
            fontWeight: FontWeight.w700,
            color: isHighlighted
                ? const Color(0xFFFFEA9E)
                : Colors.white.withAlpha(179),
          ),
        ),
      ),
    );
  }
}

class _LiveFeedEntry extends StatelessWidget {
  const _LiveFeedEntry({required this.activity});

  final SpotlightActivity activity;

  @override
  Widget build(BuildContext context) {
    final text = t.kudos.liveFeedEntry
        .replaceAll('{timestamp}', activity.timestamp)
        .replaceAll('{name}', activity.receiverName);
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 8,
        fontWeight: FontWeight.w400,
        color: Colors.white.withAlpha(153),
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key('spotlight_search_button'),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.outlineBtnBg,
          border: Border.all(color: AppColors.outlineBtnBorder, width: 0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search, color: AppColors.textAccent, size: 12),
            const SizedBox(width: 4),
            Text(
              t.kudos.searchSunner,
              style: GoogleFonts.montserrat(
                fontSize: 9,
                fontWeight: FontWeight.w400,
                color: AppColors.textAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
