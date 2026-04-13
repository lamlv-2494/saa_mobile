import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/highlight_kudos_card.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/page_indicator_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class HighlightCarouselWidget extends StatefulWidget {
  const HighlightCarouselWidget({
    super.key,
    required this.kudosList,
    this.onHeartTap,
    this.onCopyLink,
    this.onViewDetail,
    this.onAvatarTap,
  });

  final List<Kudos> kudosList;
  final void Function(String kudosId)? onHeartTap;
  final void Function(String kudosId)? onCopyLink;
  final void Function(String kudosId)? onViewDetail;
  final void Function(String userId)? onAvatarTap;

  @override
  State<HighlightCarouselWidget> createState() =>
      _HighlightCarouselWidgetState();
}

class _HighlightCarouselWidgetState extends State<HighlightCarouselWidget> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.82);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HighlightCarouselWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.kudosList.length != oldWidget.kudosList.length) {
      _currentPage = 0;
      _pageController.jumpToPage(0);
    }
  }

  String _formatTimeAgo(DateTime createdAt) {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inDays > 0) {
      return t.kudos.daysAgo.replaceAll('{count}', '${diff.inDays}');
    }
    if (diff.inHours > 0) {
      return t.kudos.hoursAgo.replaceAll('{count}', '${diff.inHours}');
    }
    if (diff.inMinutes > 0) {
      return t.kudos.minutesAgo.replaceAll('{count}', '${diff.inMinutes}');
    }
    return t.kudos.justNow;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.kudosList.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            t.kudos.emptyHighlight,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 256,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: widget.kudosList.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final kudos = widget.kudosList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: HighlightKudosCard(
                      kudos: kudos,
                      timeText: _formatTimeAgo(kudos.createdAt),
                      onHeartTap: () => widget.onHeartTap?.call(kudos.id),
                      onCopyLink: () => widget.onCopyLink?.call(kudos.id),
                      onViewDetail: () => widget.onViewDetail?.call(kudos.id),
                      onAvatarTap: widget.onAvatarTap,
                    ),
                  );
                },
              ),
              // Left gradient
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 40,
                child: IgnorePointer(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [AppColors.bgDark, Colors.transparent],
                      ),
                    ),
                  ),
                ),
              ),
              // Right gradient
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: 40,
                child: IgnorePointer(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [AppColors.bgDark, Colors.transparent],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        PageIndicatorWidget(
          currentPage: _currentPage + 1,
          totalPages: widget.kudosList.length,
          onPrevious: () {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          onNext: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }
}
