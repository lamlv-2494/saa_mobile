import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_card.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/widgets/section_header_widget.dart';

class AllKudosPageView extends StatefulWidget {
  const AllKudosPageView({
    super.key,
    required this.kudosList,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onBackToFeed,
    required this.onLoadMore,
    required this.onRefresh,
    required this.onHeartTap,
    required this.onAvatarTap,
    required this.formatTimeAgo,
    this.hasLoadError = false,
    this.onRetry,
    this.onViewDetail,
  });

  final List<Kudos> kudosList;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onBackToFeed;
  final VoidCallback onLoadMore;
  final Future<void> Function() onRefresh;
  final void Function(String kudosId) onHeartTap;
  final void Function(String userId) onAvatarTap;
  final String Function(DateTime) formatTimeAgo;
  final bool hasLoadError;
  final VoidCallback? onRetry;
  final void Function(String kudosId)? onViewDetail;

  @override
  State<AllKudosPageView> createState() => _AllKudosPageViewState();
}

class _AllKudosPageViewState extends State<AllKudosPageView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (widget.hasMore && !widget.isLoadingMore) {
        widget.onLoadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ─── Background Key Visual Layer ───
        Positioned.fill(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Assets.images.keyVisualBg.image(
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (_, _, _) =>
                    const ColoredBox(color: AppColors.bgDark),
              ),
              // Shadow Left gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF00101A),
                      Color(0xFF10181F),
                      Color.fromRGBO(0, 16, 26, 0),
                    ],
                    stops: [0.0007, 0.1861, 0.772],
                  ),
                ),
              ),
              // Shadow Bottom gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFF00101A),
                      Color(0xFF00101A),
                      Color.fromRGBO(0, 16, 26, 0),
                    ],
                    stops: [0.0, 0.2541, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),

        // ─── Scrollable Content Layer ───
        RefreshIndicator(
          color: AppColors.textAccent,
          backgroundColor: AppColors.bgDark,
          onRefresh: widget.onRefresh,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // ─── AppBar ───
              SliverAppBar(
                floating: true,
                pinned: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: Semantics(
                  button: true,
                  label: 'Go back',
                  child: GestureDetector(
                    key: const Key('allKudosBackButton'),
                    onTap: widget.onBackToFeed,
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Assets.icons.icChevronLeft.svg(
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                            AppColors.textWhite,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  t.kudos.allKudosNavbarTitle,
                  style: const TextStyle(
                    fontFamily: 'Helvetica Neue',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    height: 24 / 17,
                    color: AppColors.textWhite,
                  ),
                ),
                centerTitle: true,
                flexibleSpace: Container(
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

              // ─── Section Header ───
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: SectionHeaderWidget(
                    label: t.kudos.sectionLabel,
                    title: t.kudos.allKudosTitle,
                  ),
                ),
              ),

              // ─── Error state (full page, empty list) ───
              if (widget.hasLoadError && widget.kudosList.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t.kudos.allKudosLoadError,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          if (widget.onRetry != null)
                            TextButton(
                              onPressed: widget.onRetry,
                              child: Text(
                                t.kudos.allKudosRetry,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: AppColors.textAccent,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              // ─── Empty state ───
              else if (widget.kudosList.isEmpty && !widget.isLoadingMore)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Semantics(
                      label: t.kudos.allKudosEmpty,
                      child: Text(
                        t.kudos.allKudosEmpty,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                )
              // ─── Kudos list with load-more indicator ───
              else ...[
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList.separated(
                    itemCount: widget.kudosList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final kudos = widget.kudosList[index];
                      return Semantics(
                        label: 'Kudos card',
                        child: KudosCard(
                          variant: KudosCardVariant.feed,
                          kudos: kudos,
                          timeText: widget.formatTimeAgo(kudos.createdAt),
                          onHeartTap: () => widget.onHeartTap(kudos.id),
                          onAvatarTap: widget.onAvatarTap,
                          onViewDetail: widget.onViewDetail != null
                              ? () => widget.onViewDetail!(kudos.id)
                              : null,
                        ),
                      );
                    },
                  ),
                ),

                // ─── Load more: loading indicator or load-more error ───
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: widget.isLoadingMore
                        ? Semantics(
                            label: t.kudos.allKudosLoadingMore,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.textAccent,
                              ),
                            ),
                          )
                        : (widget.hasLoadError
                              ? Center(
                                  child: TextButton(
                                    onPressed: widget.onRetry,
                                    child: Text(
                                      t.kudos.allKudosRetry,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: AppColors.textAccent,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink()),
                  ),
                ),
              ],

              // ─── Bottom spacing for nav bar ───
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ],
    );
  }
}
