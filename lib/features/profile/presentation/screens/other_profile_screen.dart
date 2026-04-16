import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/main_scaffold.dart';
import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:saa_mobile/features/profile/presentation/viewmodels/other_profile_viewmodel.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/badge_collection_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_kudos_filter_dropdown.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_kudos_list_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/send_kudos_button_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

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
    context.push('/send-kudos');
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(otherProfileViewModelProvider(widget.userId));

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: async.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.textAccent),
        ),
        error: (err, _) => Center(
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
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const SliverAppBar(
                  backgroundColor: AppColors.bgDark,
                  elevation: 0,
                  leading: BackButton(color: AppColors.textWhite),
                  floating: true,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ProfileKudosFilterDropdown(
                          currentFilter: state.kudosFilter,
                          sentCount: state.personalStats?.kudosSent ?? 0,
                          receivedCount:
                              state.personalStats?.kudosReceived ?? 0,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
