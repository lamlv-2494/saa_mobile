import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/icon_collection_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/kudos_section_header_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_kudos_filter_dropdown.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_kudos_list_widget.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/shared/widgets/personal_stats_card.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';
import 'package:saa_mobile/shared/widgets/home_header_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(profileViewModelProvider.notifier).loadMoreKudos();
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(profileViewModelProvider);
    final locale = ref.watch(localeNotifierProvider);
    final topPadding = MediaQuery.of(context).padding.top;
    // Header height = status bar + app bar content (60px)
    final headerHeight = topPadding + 60.0;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Stack(
        children: [
          // Background: keyvisual — full viewport height per Figma (bg group: 812px)
          Positioned.fill(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Assets.images.keyVisualBg.image(
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  errorBuilder: (_, _, _) =>
                      const ColoredBox(color: AppColors.bgDark),
                ),
                // Shadow Left gradient (Figma: 6885:10336)
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
                // Shadow Bottom gradient (Figma: 6885:10337, rotate -90deg)
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

          // Main content
          async.when(
            loading: () => Center(
              child: Padding(
                padding: EdgeInsets.only(top: headerHeight),
                child: const CircularProgressIndicator(
                  color: AppColors.textAccent,
                ),
              ),
            ),
            error: (err, _) => Center(
              child: Padding(
                padding: EdgeInsets.only(top: headerHeight),
                child: GestureDetector(
                  onTap: () =>
                      ref.read(profileViewModelProvider.notifier).refresh(),
                  child: Text(
                    t.profile.loadError,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            data: (state) {
              final profile = state.profile;
              if (profile == null) return const SizedBox.shrink();

              return RefreshIndicator(
                color: AppColors.textAccent,
                onRefresh: () =>
                    ref.read(profileViewModelProvider.notifier).refresh(),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Space for fixed header
                      SizedBox(height: headerHeight),
                      ProfileInfoWidget(profile: profile),
                      const SizedBox(height: 24),
                      if (state.iconBadges.isNotEmpty) ...[
                        IconCollectionWidget(iconBadges: state.iconBadges),
                        const SizedBox(height: 24),
                      ],
                      if (state.personalStats != null) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: PersonalStatsCard(
                            stats: state.personalStats!,
                            onOpenSecretBox: () => context.push('/secret-box'),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      // Kudos section header banner (mms_4_header)
                      const KudosSectionHeaderWidget(),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ProfileKudosFilterDropdown(
                          currentFilter: state.kudosFilter,
                          sentCount: state.personalStats?.kudosSent ?? 0,
                          receivedCount:
                              state.personalStats?.kudosReceived ?? 0,
                          onChanged: (filter) => ref
                              .read(profileViewModelProvider.notifier)
                              .changeFilter(filter),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ProfileKudosListWidget(
                          kudosList: state.kudosList,
                          isLoadingMore: state.isLoadingMoreKudos,
                          onHeartTap: (kudosId) => ref
                              .read(profileViewModelProvider.notifier)
                              .toggleHeart(kudosId),
                          onAvatarTap: (userId) =>
                              context.push('/profile/$userId'),
                          onViewDetail: (kudosId) =>
                              context.push('/kudos/$kudosId'),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
          ),

          // App Header fixed on top (mms_1_header)
          HomeHeaderWidget(
            opacity: 1.0,
            hasUnreadNotifications: false,
            currentLocaleCode: locale.languageCode,
            onLocaleChanged: (code) {
              ref.read(localeNotifierProvider.notifier).changeLocale(code);
            },
            onSearchTap: () => context.push('/search'),
            onNotificationTap: () {},
          ),
        ],
      ),
    );
  }
}
