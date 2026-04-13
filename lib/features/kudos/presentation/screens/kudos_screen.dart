import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/kudos_viewmodel.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/all_kudos_section_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/highlight_section_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_card.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/kudos_hero_banner_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/personal_stats_card.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/spotlight_section_widget.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/top_gift_recipients_card.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';
import 'package:saa_mobile/shared/widgets/language_dropdown.dart';
import 'package:saa_mobile/shared/widgets/outline_button.dart';

class KudosScreen extends ConsumerStatefulWidget {
  const KudosScreen({super.key});

  @override
  ConsumerState<KudosScreen> createState() => _KudosScreenState();
}

class _KudosScreenState extends ConsumerState<KudosScreen> {
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
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(kudosViewModelProvider.notifier).loadMoreKudos();
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

  void _navigateToSendKudos() {
    // Placeholder — sẽ thay bằng go_router push khi màn hình gửi kudos được build
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.kudos.ctaComingSoon),
        duration: Duration(seconds: 1),
      ),
    );
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
          onPressed: _navigateToSendKudos,
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
        data: (state) => Stack(
          children: [
            // ─── Background Image Layer ───
            // Trải dài từ top (behind AppBar) xuống ~500px.
            // Theo design: Hero Banner Background 812px, nhưng
            // phần visible trước khi scroll chỉ khoảng 450-500px.
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 500,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Assets.images.kudos.keyVisualBg.image(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  // Left shadow gradient
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.bgDark,
                          Color(0xFF10181F),
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.18, 0.77],
                      ),
                    ),
                  ),
                  // Bottom shadow gradient
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [AppColors.bgDark, Colors.transparent],
                        stops: [0.0, 0.6],
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      onHashtagSelected: (h) => vm.setHashtagFilter(h),
                      onDepartmentSelected: (d) => vm.setDepartmentFilter(d),
                      onHeartTap: (id) => vm.toggleHeart(id),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),

                  // ─── Spotlight Board ───
                  SliverToBoxAdapter(
                    child: SpotlightSectionWidget(network: state.spotlightData),
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
                          onOpenSecretBox: () {
                            // Placeholder — navigate to open secret box screen
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
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          final kudos = state.allKudos[index];
                          return KudosCard(
                            variant: KudosCardVariant.feed,
                            kudos: kudos,
                            timeText: _formatTimeAgo(kudos.createdAt),
                            onHeartTap: () => vm.toggleHeart(kudos.id),
                            onAvatarTap: (userId) {
                              // Placeholder — navigate to profile
                            },
                          );
                        },
                      ),
                    ),

                  const SliverToBoxAdapter(child: SizedBox(height: 20)),

                  // ─── View all Kudos button ───
                  SliverToBoxAdapter(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Navigate to full kudos feed screen
                        },
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
      ),
    );
  }
}
