import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/core/utils/time_utils.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/kudos_viewmodel.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/all_kudos_page_view.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/all_kudos_section_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/highlight_section_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_card.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_hero_banner_widget.dart';
import 'package:saa_mobile/shared/widgets/personal_stats_card.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/spotlight_section_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/top_gift_recipients_card.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';
import 'package:go_router/go_router.dart';

import 'package:saa_mobile/shared/widgets/language_dropdown.dart';
import 'package:saa_mobile/shared/widgets/outline_button.dart';

class KudosScreen extends ConsumerStatefulWidget {
  const KudosScreen({super.key});

  @override
  ConsumerState<KudosScreen> createState() => _KudosScreenState();
}

class _KudosScreenState extends ConsumerState<KudosScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToAllKudos() {
    final vm = ref.read(kudosViewModelProvider.notifier);
    vm.loadAllKudosPage();
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _navigateBackToFeed() {
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(kudosViewModelProvider.notifier).loadMoreKudos();
    }
  }

  Future<void> _navigateToSendKudos() async {
    final result = await context.push<bool>('/send-kudos');
    if (result == true && mounted) {
      unawaited(ref.read(kudosViewModelProvider.notifier).refresh());
    }
  }

  Widget _buildCtaButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Semantics(
        button: true,
        label: t.kudos.ctaAccessibilityLabel,
        child: OutlineButtonWidget(
          label: t.kudos.ctaText,
          icon: SvgPicture.asset(
            Assets.icons.icPen.path,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.textWhite,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => _navigateToSendKudos(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(kudosViewModelProvider);
    final vm = ref.read(kudosViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: asyncState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.textAccent),
        ),
        error: (error, _) {
          debugPrint('Error loading KudosScreen data: $error');
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(error.toString()),
                Text(
                  t.kudos.errorRetry,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 8),
                OutlineButtonWidget(
                  label: t.kudos.retry,
                  onPressed: () => vm.refresh(),
                ),
              ],
            ),
          );
        },
        data: (state) => PageView(
          key: const Key('kudosScreenPageView'),
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // ─── Page 0: Kudos Feed ───
            Stack(
              children: [
                // ─── Background Image Layer ───
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
                  onRefresh: () => vm.refresh(),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      // ─── App Bar (transparent — bg image shows through) ───
                      SliverAppBar(
                        floating: true,
                        backgroundColor: Colors.transparent,
                        expandedHeight: 104,
                        flexibleSpace: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: AppColors.headerGradientColors,
                              stops: AppColors.headerGradientStops,
                            ),
                          ),
                          child: SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                children: [
                                  Assets.images.saaLogo.image(
                                    width: 48,
                                    height: 44,
                                  ),
                                  const Spacer(),
                                  LanguageDropdown(
                                    currentLocaleCode: ref
                                        .watch(localeNotifierProvider)
                                        .languageCode,
                                    onLocaleChanged: (code) {
                                      ref
                                          .read(localeNotifierProvider.notifier)
                                          .changeLocale(code);
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  SvgPicture.asset(
                                    Assets.icons.icSearch.path,
                                    width: 24,
                                    height: 24,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.textWhite,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Stack(
                                    children: [
                                      SvgPicture.asset(
                                        Assets.icons.icNotification.path,
                                        width: 24,
                                        height: 24,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.textWhite,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: AppColors.notificationBadge,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ─── Hero Banner (content only — bg is in Stack above) ───
                      const SliverToBoxAdapter(child: KudosHeroBannerWidget()),

                      // ─── CTA Button (top) ───
                      SliverToBoxAdapter(child: _buildCtaButton()),

                      // ─── Highlight Section (with filters) ───
                      SliverToBoxAdapter(
                        child: HighlightSectionWidget(
                          kudosList: state.highlightKudos,
                          availableHashtags: state.availableHashtags,
                          availableDepartments: state.availableDepartments,
                          selectedHashtag: state.selectedHashtag,
                          selectedDepartment: state.selectedDepartment,
                          onViewDetail: (id) => context.push('/kudos/$id'),
                          onHashtagSelected: (h) => vm.setHashtagFilter(h),
                          onDepartmentSelected: (d) =>
                              vm.setDepartmentFilter(d),
                          onHeartTap: (id) => vm.toggleHeart(id),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 24)),

                      // ─── Spotlight Board ───
                      SliverToBoxAdapter(
                        child: SpotlightSectionWidget(
                          data: state.spotlightData,
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 24)),

                      // ─── All Kudos Header ───
                      const SliverToBoxAdapter(child: AllKudosSectionHeader()),

                      const SliverToBoxAdapter(child: SizedBox(height: 20)),

                      // ─── 1. Personal Stats Card ───
                      if (state.personalStats != null)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: PersonalStatsCard(
                              stats: state.personalStats!,
                              onOpenSecretBox: () async {
                                await ref
                                    .read(kudosViewModelProvider.notifier)
                                    .openNextSecretBox();
                                if (context.mounted) {
                                  await context.push('/secret-box');
                                }
                              },
                            ),
                          ),
                        ),

                      if (state.personalStats != null)
                        const SliverToBoxAdapter(child: SizedBox(height: 20)),

                      // ─── 2. Top 10 Gift Recipients ───
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TopGiftRecipientsCard(
                            recipients: state.topGiftRecipients,
                            onUserTap: (userId) =>
                                context.push('/profile/$userId'),
                          ),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 20)),

                      // ─── 3. Kudos Feed List (max 10 items) ───
                      if (state.allKudos.isEmpty)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Center(
                              child: Text(
                                t.kudos.emptyFeed,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          sliver: SliverList.separated(
                            itemCount: state.allKudos.length > 10
                                ? 10
                                : state.allKudos.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final kudos = state.allKudos[index];
                              return KudosCard(
                                variant: KudosCardVariant.feed,
                                kudos: kudos,
                                timeText: formatKudosTimeAgo(kudos.createdAt),
                                onHeartTap: () => vm.toggleHeart(kudos.id),
                                onAvatarTap: (userId) =>
                                    context.push('/profile/$userId'),
                                onViewDetail: () =>
                                    context.push('/kudos/${kudos.id}'),
                              );
                            },
                          ),
                        ),

                      const SliverToBoxAdapter(child: SizedBox(height: 20)),

                      // ─── View all Kudos button ───
                      SliverToBoxAdapter(
                        child: Center(
                          child: GestureDetector(
                            onTap: _navigateToAllKudos,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    t.kudos.viewAllKudos,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textWhite,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Assets.icons.icArrowOpen.svg(
                                    width: 24,
                                    height: 24,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.textWhite,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ─── Bottom spacing for nav bar ───
                      const SliverToBoxAdapter(child: SizedBox(height: 100)),
                    ],
                  ),
                ),
              ], // Stack children
            ),
            // ─── Page 1: All Kudos ───
            AllKudosPageView(
              kudosList: state.allKudosPageList,
              hasMore: state.hasMoreAllKudosPage,
              isLoadingMore: state.isLoadingMoreAllKudos,
              onBackToFeed: _navigateBackToFeed,
              onLoadMore: () => vm.loadMoreAllKudos(),
              onRefresh: () => vm.refreshAllKudos(),
              onHeartTap: (id) => vm.toggleHeart(id),
              onAvatarTap: (userId) => context.push('/profile/$userId'),
              formatTimeAgo: formatKudosTimeAgo,
              onViewDetail: (id) => context.push('/kudos/$id'),
            ),
          ], // PageView children
        ),
      ),
    );
  }
}
