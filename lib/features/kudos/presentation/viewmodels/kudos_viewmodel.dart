import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/kudos/data/models/department.dart';
import 'package:saa_mobile/features/kudos/data/models/gift_recipient_ranking.dart';
import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos_state.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/kudos/data/models/spotlight_network.dart';
import 'package:saa_mobile/features/kudos/data/repositories/kudos_repository.dart';

class KudosViewModel extends AsyncNotifier<KudosState> {
  late KudosRepository _repository;
  int _currentPage = 1;
  static const int _pageLimit = 20;

  @override
  FutureOr<KudosState> build() async {
    _repository = ref.read(kudosRepositoryProvider);
    _currentPage = 1;

    // Fetch song song nhưng mỗi call fail independently
    // — nếu 1 API lỗi, các sections khác vẫn hiển thị data
    final results = await Future.wait([
      _safeFetch(() => _repository.getHighlightKudos()),
      _safeFetch(() => _repository.getKudos(page: 1, limit: _pageLimit)),
      _safeFetch(() => _repository.getPersonalStats()),
      _safeFetch(() => _repository.getTopRecipients()),
      _safeFetch(() => _repository.getSpotlight()),
      _safeFetch(() => _repository.getHashtags()),
      _safeFetch(() => _repository.getDepartments()),
    ]);

    final allKudos = results[1] as List<Kudos>? ?? [];

    return KudosState(
      highlightKudos: results[0] as List<Kudos>? ?? [],
      allKudos: allKudos,
      personalStats: results[2] as PersonalStats?,
      topGiftRecipients: results[3] as List<GiftRecipientRanking>? ?? [],
      spotlightData: results[4] as SpotlightNetwork?,
      availableHashtags: results[5] as List<Hashtag>? ?? [],
      availableDepartments: results[6] as List<Department>? ?? [],
      hasMoreKudos: allKudos.length >= _pageLimit,
    );
  }

  /// Gọi API và trả null nếu lỗi thay vì throw exception.
  /// Cho phép các section khác vẫn hiển thị khi 1 API fail.
  Future<T?> _safeFetch<T>(Future<T> Function() fetch) async {
    try {
      return await fetch();
    } catch (_) {
      return null;
    }
  }

  Future<void> refresh() async {
    _currentPage = 1;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await build());
  }

  Future<void> loadMoreKudos() async {
    final currentState = state.valueOrNull;
    if (currentState == null || !currentState.hasMoreKudos) return;

    _currentPage++;
    try {
      final newKudos = await _repository.getKudos(
        page: _currentPage,
        limit: _pageLimit,
        hashtagId: currentState.selectedHashtag?.id,
        departmentName: currentState.selectedDepartment?.name,
      );
      state = AsyncValue.data(
        currentState.copyWith(
          allKudos: [...currentState.allKudos, ...newKudos],
          hasMoreKudos: newKudos.length >= _pageLimit,
        ),
      );
    } catch (e) {
      _currentPage--;
    }
  }

  Future<void> toggleHeart(String kudosId) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final kudosIndex = currentState.allKudos.indexWhere((k) => k.id == kudosId);
    final highlightIndex = currentState.highlightKudos.indexWhere(
      (k) => k.id == kudosId,
    );

    Kudos? targetKudos;
    if (kudosIndex >= 0) {
      targetKudos = currentState.allKudos[kudosIndex];
    } else if (highlightIndex >= 0) {
      targetKudos = currentState.highlightKudos[highlightIndex];
    }
    if (targetKudos == null || !targetKudos.canLike) return;

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
      _updateKudosInState(currentState, kudosId, updatedKudos),
    );

    try {
      if (isLiked) {
        await _repository.unlikeKudos(kudosId);
      } else {
        await _repository.likeKudos(kudosId);
      }
    } catch (_) {
      // Rollback on error
      state = AsyncValue.data(
        _updateKudosInState(
          state.valueOrNull ?? currentState,
          kudosId,
          targetKudos,
        ),
      );
    }
  }

  Future<void> setHashtagFilter(Hashtag? hashtag) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    state = AsyncValue.data(
      currentState.copyWith(selectedHashtag: hashtag, currentHighlightPage: 0),
    );

    try {
      final highlights = await _repository.getHighlightKudos(
        hashtagId: hashtag?.id,
        departmentName: currentState.selectedDepartment?.name,
      );
      state = AsyncValue.data(
        state.valueOrNull!.copyWith(highlightKudos: highlights),
      );
    } catch (_) {}
  }

  Future<void> setDepartmentFilter(Department? department) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    state = AsyncValue.data(
      currentState.copyWith(
        selectedDepartment: department,
        currentHighlightPage: 0,
      ),
    );

    try {
      final highlights = await _repository.getHighlightKudos(
        hashtagId: currentState.selectedHashtag?.id,
        departmentName: department?.name,
      );
      state = AsyncValue.data(
        state.valueOrNull!.copyWith(highlightKudos: highlights),
      );
    } catch (_) {}
  }

  Future<void> clearFilters() async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    state = AsyncValue.data(
      currentState.copyWith(
        selectedHashtag: null,
        selectedDepartment: null,
        currentHighlightPage: 0,
      ),
    );

    try {
      final highlights = await _repository.getHighlightKudos();
      state = AsyncValue.data(
        state.valueOrNull!.copyWith(highlightKudos: highlights),
      );
    } catch (_) {}
  }

  KudosState _updateKudosInState(
    KudosState currentState,
    String kudosId,
    Kudos updatedKudos,
  ) {
    final updatedAllKudos = currentState.allKudos.map((k) {
      return k.id == kudosId ? updatedKudos : k;
    }).toList();

    final updatedHighlightKudos = currentState.highlightKudos.map((k) {
      return k.id == kudosId ? updatedKudos : k;
    }).toList();

    return currentState.copyWith(
      allKudos: updatedAllKudos,
      highlightKudos: updatedHighlightKudos,
    );
  }
}

final kudosViewModelProvider =
    AsyncNotifierProvider<KudosViewModel, KudosState>(KudosViewModel.new);
