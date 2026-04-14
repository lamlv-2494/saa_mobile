import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/main_scaffold.dart';
import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/award/data/models/award_state.dart';
import 'package:saa_mobile/features/award/presentation/viewmodels/award_viewmodel.dart';
import 'package:saa_mobile/features/award/presentation/widgets/award_dropdown_filter.dart';
import 'package:saa_mobile/features/award/presentation/widgets/award_info_block_widget.dart';
import 'package:saa_mobile/features/award/presentation/widgets/kv_kudos_banner_widget.dart';
import 'package:saa_mobile/features/award/presentation/widgets/sun_kudos_block_widget.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';
import 'package:saa_mobile/shared/widgets/home_header_widget.dart';
import 'package:saa_mobile/shared/widgets/section_header_widget.dart';

/// Provider chứa slug giải thưởng ban đầu khi navigate từ Home.
/// Null = mặc định Top Talent (index 0).
final initialAwardSlugProvider = StateProvider<String?>((ref) => null);

class AwardScreen extends ConsumerStatefulWidget {
  const AwardScreen({super.key});

  @override
  ConsumerState<AwardScreen> createState() => _AwardScreenState();
}

class _AwardScreenState extends ConsumerState<AwardScreen> {
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

  @override
  Widget build(BuildContext context) {
    final awardAsync = ref.watch(awardViewModelProvider);
    final locale = ref.watch(localeNotifierProvider);
    final localeCode = locale.languageCode;

    // Listen for slug navigation from Home
    ref.listen<String?>(initialAwardSlugProvider, (_, slug) {
      if (slug != null) {
        ref.read(awardViewModelProvider.notifier).selectBySlug(slug);
        ref.read(initialAwardSlugProvider.notifier).state = null;
        // Reset scroll
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      }
    });

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: awardAsync.when(
        data: (awardState) => _buildContent(awardState, localeCode),
        loading: () => _buildLoading(),
        error: (e, _) => _buildError(),
      ),
    );
  }

  Widget _buildContent(AwardState awardState, String localeCode) {
    final categories = awardState.categories;
    final selectedIndex = awardState.selectedIndex;
    final selectedCategory = awardState.selectedCategory;

    return Stack(
      children: [
        // Background
        Positioned.fill(
          child: Assets.images.keyVisualBg.image(
            fit: BoxFit.cover,
            alignment: Alignment.topRight,
          ),
        ),
        // Left shadow gradient
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF00101A),
                  Color(0xFF10181F),
                  Colors.transparent,
                ],
                stops: [0.0007, 0.1861, 0.772],
              ),
            ),
          ),
        ),
        // Bottom shadow gradient
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFF00101A),
                  Color(0xFF00101A),
                  Colors.transparent,
                ],
                stops: [0.0, 0.2541, 1.0],
              ),
            ),
          ),
        ),
        // Scrollable content
        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.only(
            top: 144,
            left: 20,
            right: 20,
            bottom: 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // KV Kudos Banner
              const KvKudosBanner(),
              const SizedBox(height: 40),
              // Section Header + Dropdown
              SectionHeaderWidget(
                label: t.home.awardSectionLabel,
                title: t.award.awardSystemTitle,
              ),
              const SizedBox(height: 16),
              AwardDropdownFilter(
                items: categories.map<String>((c) => c.name).toList(),
                selectedIndex: selectedIndex,
                onChanged: (index) {
                  ref
                      .read(awardViewModelProvider.notifier)
                      .selectCategory(index);
                  // Scroll reset on award switch
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                },
              ),
              const SizedBox(height: 40),
              // Award Detail Block
              if (selectedCategory != null)
                AwardInfoBlock(category: selectedCategory, locale: localeCode),
              const SizedBox(height: 40),
              // Sun* Kudos Block
              SunKudosBlock(
                onDetailsTap: () {
                  // Navigate to Kudos tab (T036)
                  ref.read(currentTabIndexProvider.notifier).state = 2;
                },
              ),
            ],
          ),
        ),
        // Fixed header
        HomeHeaderWidget(
          opacity: _headerOpacity,
          hasUnreadNotifications: false,
          currentLocaleCode: localeCode,
          onLocaleChanged: (code) {
            ref.read(localeNotifierProvider.notifier).changeLocale(code);
          },
          onSearchTap: () {},
          onNotificationTap: () {},
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Stack(
      children: [
        // Background
        Container(color: AppColors.bgDark),
        // Shimmer skeleton
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 144,
            left: 20,
            right: 20,
            bottom: 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // KV Banner placeholder
              _shimmerBox(width: 221, height: 67),
              const SizedBox(height: 40),
              // Section header placeholder
              _shimmerBox(width: 200, height: 16),
              const SizedBox(height: 8),
              _shimmerBox(width: double.infinity, height: 1),
              const SizedBox(height: 8),
              _shimmerBox(width: 280, height: 28),
              const SizedBox(height: 16),
              // Dropdown placeholder
              _shimmerBox(width: 160, height: 40),
              const SizedBox(height: 40),
              // Badge placeholder
              Center(child: _shimmerBox(width: 160, height: 160)),
              const SizedBox(height: 16),
              _shimmerBox(width: 200, height: 20),
              const SizedBox(height: 12),
              _shimmerBox(width: double.infinity, height: 60),
              const SizedBox(height: 16),
              _shimmerBox(width: double.infinity, height: 1),
              const SizedBox(height: 16),
              _shimmerBox(width: 200, height: 20),
              const SizedBox(height: 12),
              _shimmerBox(width: 120, height: 24),
            ],
          ),
        ),
        // Fixed header
        HomeHeaderWidget(
          opacity: 0.9,
          hasUnreadNotifications: false,
          currentLocaleCode: ref.read(localeNotifierProvider).languageCode,
          onLocaleChanged: (code) {
            ref.read(localeNotifierProvider.notifier).changeLocale(code);
          },
          onSearchTap: () {},
          onNotificationTap: () {},
        ),
      ],
    );
  }

  Widget _shimmerBox({required double height, double? width}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.textWhite.withAlpha(13),
        borderRadius: BorderRadius.circular(4),
      ),
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
              onTap: () => ref.read(awardViewModelProvider.notifier).refresh(),
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
