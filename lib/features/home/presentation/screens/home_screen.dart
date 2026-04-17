import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/home/data/models/event_info.dart';
import 'package:saa_mobile/features/home/data/models/home_state.dart';
import 'package:saa_mobile/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:saa_mobile/app/main_scaffold.dart';
import 'package:saa_mobile/features/award/presentation/screens/award_screen.dart';
import 'package:saa_mobile/features/home/presentation/widgets/awards_section_widget.dart';
import 'package:saa_mobile/features/home/presentation/widgets/hero_content_widget.dart';
import 'package:saa_mobile/shared/widgets/home_header_widget.dart';
import 'package:saa_mobile/features/home/presentation/widgets/kudos_fab_widget.dart';
import 'package:saa_mobile/features/home/presentation/widgets/kudos_section_widget.dart';
import 'package:saa_mobile/features/home/presentation/widgets/theme_description_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _scrollController = ScrollController();
  double _headerOpacity = 0.9;

  static const _headerFadeStart = 0.0;
  static const _headerFadeEnd = 150.0;

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
    final offset = _scrollController.offset;
    final newOpacity =
        (1.0 -
                ((offset - _headerFadeStart) /
                    (_headerFadeEnd - _headerFadeStart)))
            .clamp(0.0, 0.9);
    if ((newOpacity - _headerOpacity).abs() > 0.01) {
      setState(() => _headerOpacity = newOpacity);
    }
  }

  static final _fallbackEventInfo = EventInfo(
    themeName: 'Root Further',
    eventDate: DateTime(2025, 12, 26, 18, 0),
    venue: 'Âu Cơ Art Center',
    livestreamNote: '',
    themeDescription: '',
  );

  @override
  Widget build(BuildContext context) {
    // Single ref.watch — constitution v1.2.0
    final homeAsync = ref.watch(homeViewModelProvider);
    final locale = ref.watch(localeNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: homeAsync.when(
        data: (homeState) => _buildContent(homeState, locale.languageCode),
        loading: () => _buildContent(
          HomeState(eventInfo: _fallbackEventInfo),
          locale.languageCode,
        ),
        error: (e, _) => _buildError(),
      ),
    );
  }

  Widget _buildContent(HomeState homeState, String localeCode) {
    return Stack(
      children: [
        // Scrollable content
        RefreshIndicator(
          onRefresh: () => ref.read(homeViewModelProvider.notifier).refresh(),
          color: AppColors.textAccent,
          backgroundColor: AppColors.bgDark,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Hero Content
              SliverToBoxAdapter(
                child: HeroContentWidget(
                  eventInfo: homeState.eventInfo,
                  onAboutAwardTap: () {
                    // TODO: context.push('/awards')
                  },
                  onAboutKudosTap: () {
                    // TODO: context.push('/kudos/about')
                  },
                ),
              ),
              // Theme Description
              SliverToBoxAdapter(
                child: ThemeDescriptionWidget(
                  description: homeState.eventInfo.themeDescription,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              // Awards Section — data passed via constructor
              SliverToBoxAdapter(
                child: AwardsSectionWidget(
                  awards: homeState.awards,
                  onAwardTap: (id) {
                    final award = homeState.awards.firstWhere(
                      (a) => a.id == id,
                      orElse: () => homeState.awards.first,
                    );
                    ref.read(initialAwardSlugProvider.notifier).state =
                        award.slug;
                    ref.read(currentTabIndexProvider.notifier).state = 1;
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              // Kudos Section (conditional)
              if (homeState.kudosInfo.isEnabled)
                SliverToBoxAdapter(
                  child: KudosSectionWidget(
                    kudosInfo: homeState.kudosInfo,
                    onDetailsTap: () {
                      ref.read(currentTabIndexProvider.notifier).state = 2;
                    },
                  ),
                ),
              // Bottom spacing
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
        // Header — data passed via constructor (StatelessWidget)
        HomeHeaderWidget(
          opacity: _headerOpacity,
          hasUnreadNotifications: homeState.unreadNotificationCount > 0,
          currentLocaleCode: localeCode,
          onLocaleChanged: (code) {
            ref.read(localeNotifierProvider.notifier).changeLocale(code);
          },
          onSearchTap: () {
            // TODO: context.push('/search')
          },
          onNotificationTap: () {
            // TODO: context.push('/notifications')
          },
        ),
        // FAB
        Positioned(
          right: 20,
          bottom: 16,
          child: KudosFabWidget(
            onWriteKudosTap: () {
              context.push('/send-kudos');
            },
            onViewKudosTap: () {
              ref.read(currentTabIndexProvider.notifier).state = 2;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.home.errorRetry,
              style: GoogleFonts.montserrat(
                color: AppColors.textWhite,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => ref.read(homeViewModelProvider.notifier).refresh(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.outlineBtnBorder),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  t.home.retry,
                  style: GoogleFonts.montserrat(
                    color: AppColors.textWhite,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
