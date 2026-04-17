import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/main_scaffold.dart';
import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:saa_mobile/features/profile/presentation/viewmodels/other_profile_viewmodel.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/badge_collection_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/kudos_section_header_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_kudos_filter_dropdown.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_kudos_list_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/send_kudos_button_widget.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';
import 'package:saa_mobile/shared/widgets/home_header_widget.dart';

class OtherProfileScreen extends ConsumerStatefulWidget {
  const OtherProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  ConsumerState<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends ConsumerState<OtherProfileScreen> {
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
      ref
          .read(otherProfileViewModelProvider(widget.userId).notifier)
          .loadMoreKudos();
    }
  }

  void _handleSendKudos(String userId, String userName) {
    context.push(
      '/send-kudos',
      extra: {'recipientId': userId, 'recipientName': userName},
    );
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(otherProfileViewModelProvider(widget.userId));
    final locale = ref.watch(localeNotifierProvider);
    final topPadding = MediaQuery.of(context).padding.top;
    final headerHeight = topPadding + 60.0;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Stack(
        children: [
          // Background: keyvisual — full viewport per Figma
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

          // Content
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.profile.userNotFound,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: Text(
                        t.profile.retry,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            data: (state) {
              final profile = state.profile;
              if (profile == null) return const SizedBox.shrink();

              // Self-redirect: if viewing own profile, switch to profile tab
              final authState = ref.read(authViewModelProvider).valueOrNull;
              final currentUserId = authState?.whenOrNull(
                authenticated: (user) => user.id,
              );
              if (currentUserId != null && currentUserId == widget.userId) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(currentTabIndexProvider.notifier).state = 3;
                  if (context.canPop()) context.pop();
                });
              }

              return RefreshIndicator(
                color: AppColors.textAccent,
                onRefresh: () => ref
                    .read(otherProfileViewModelProvider(widget.userId).notifier)
                    .refresh(),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Space for fixed header
                      SizedBox(height: headerHeight),
                      ProfileInfoWidget(profile: profile),
                      const SizedBox(height: 16),
                      if (state.badges.isNotEmpty) ...[
                        BadgeCollectionWidget(badges: state.badges),
                        const SizedBox(height: 16),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SendKudosButtonWidget(
                          userId: profile.id,
                          userName: profile.name,
                          onTap: () =>
                              _handleSendKudos(profile.id, profile.name),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const KudosSectionHeaderWidget(),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ProfileKudosFilterDropdown(
                          currentFilter: state.kudosFilter,
                          sentCount: state.kudosSentCount,
                          receivedCount: state.kudosReceivedCount,
                          onChanged: (filter) => ref
                              .read(
                                otherProfileViewModelProvider(
                                  widget.userId,
                                ).notifier,
                              )
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
                              .read(
                                otherProfileViewModelProvider(
                                  widget.userId,
                                ).notifier,
                              )
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

          // App Header fixed on top (same as Profile screen)
          HomeHeaderWidget(
            opacity: 1.0,
            hasUnreadNotifications: false,
            currentLocaleCode: locale.languageCode,
            onLocaleChanged: (code) {
              ref.read(localeNotifierProvider.notifier).changeLocale(code);
            },
            onSearchTap: () {},
            onNotificationTap: () {},
          ),
        ],
      ),
    );
  }
}
