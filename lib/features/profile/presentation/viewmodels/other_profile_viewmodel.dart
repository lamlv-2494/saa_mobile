import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/repositories/kudos_repository.dart';
import 'package:saa_mobile/features/profile/data/models/kudos_filter_type.dart';
import 'package:saa_mobile/features/profile/data/models/other_profile_state.dart';
import 'package:saa_mobile/features/profile/data/repositories/profile_repository.dart';

class OtherProfileViewModel
    extends FamilyAsyncNotifier<OtherProfileState, String> {
  late ProfileRepository _profileRepo;
  late KudosRepository _kudosRepo;
  late String _userId;
  int _currentPage = 1;
  static const int _pageLimit = 20;

  @override
  FutureOr<OtherProfileState> build(String arg) async {
    _profileRepo = ref.read(profileRepositoryProvider);
    _kudosRepo = ref.read(kudosRepositoryProvider);
    _userId = arg;
    _currentPage = 1;

    final profileFuture = _profileRepo.getUserProfile(_userId);
    final badgesFuture = _profileRepo.getUserBadges(_userId);
    final statsFuture = _profileRepo.getUserStats(_userId);
    final kudosFuture = _profileRepo.getKudosHistory(
      userId: _userId,
      filter: 'received',
      page: 1,
      limit: _pageLimit,
    );

    final profile = await profileFuture;
    final badges = await badgesFuture;
    final stats = await statsFuture;
    final kudosList = await kudosFuture;

    return OtherProfileState(
      profile: profile,
      personalStats: stats,
      badges: badges,
      kudosList: kudosList,
      kudosFilter: KudosFilterType.received,
      hasMoreKudos: kudosList.length >= _pageLimit,
    );
  }

  Future<void> changeFilter(KudosFilterType filter) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    _currentPage = 1;
    final filterStr = filter == KudosFilterType.sent ? 'sent' : 'received';

    final kudos = await _profileRepo.getKudosHistory(
      userId: _userId,
      filter: filterStr,
      page: 1,
      limit: _pageLimit,
    );

    state = AsyncValue.data(
      currentState.copyWith(
        kudosFilter: filter,
        kudosList: kudos,
        hasMoreKudos: kudos.length >= _pageLimit,
      ),
    );
  }

  Future<void> loadMoreKudos() async {
    final currentState = state.valueOrNull;
    if (currentState == null || !currentState.hasMoreKudos) return;

    final filterStr = currentState.kudosFilter == KudosFilterType.sent
        ? 'sent'
        : 'received';

    _currentPage++;
    try {
      final newKudos = await _profileRepo.getKudosHistory(
        userId: _userId,
        filter: filterStr,
        page: _currentPage,
        limit: _pageLimit,
      );
      state = AsyncValue.data(
        currentState.copyWith(
          kudosList: [...currentState.kudosList, ...newKudos],
          hasMoreKudos: newKudos.length >= _pageLimit,
        ),
      );
    } catch (_) {
      _currentPage--;
    }
  }

  Future<void> toggleHeart(String kudosId) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final kudosIndex = currentState.kudosList.indexWhere(
      (k) => k.id == kudosId,
    );
    if (kudosIndex < 0) return;

    final targetKudos = currentState.kudosList[kudosIndex];
    if (!targetKudos.canLike) return;

    final isLiked = targetKudos.isLikedByMe;
    final newHeartCount = isLiked
        ? targetKudos.heartCount - 1
        : targetKudos.heartCount + 1;
    final updatedKudos = targetKudos.copyWith(
      isLikedByMe: !isLiked,
      heartCount: newHeartCount,
    );

    // Optimistic update
    state = AsyncValue.data(
      _updateKudosInList(currentState, kudosId, updatedKudos),
    );

    try {
      if (isLiked) {
        await _kudosRepo.unlikeKudos(kudosId);
      } else {
        await _kudosRepo.likeKudos(kudosId);
      }
    } catch (_) {
      // Rollback on error
      state = AsyncValue.data(
        _updateKudosInList(
          state.valueOrNull ?? currentState,
          kudosId,
          targetKudos,
        ),
      );
    }
  }

  Future<void> refresh() async {
    _currentPage = 1;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await build(_userId));
  }

  OtherProfileState _updateKudosInList(
    OtherProfileState currentState,
    String kudosId,
    Kudos updatedKudos,
  ) {
    final updatedList = currentState.kudosList.map((k) {
      return k.id == kudosId ? updatedKudos : k;
    }).toList();

    return currentState.copyWith(kudosList: updatedList);
  }
}

final otherProfileViewModelProvider =
    AsyncNotifierProvider.family<
      OtherProfileViewModel,
      OtherProfileState,
      String
    >(OtherProfileViewModel.new);
