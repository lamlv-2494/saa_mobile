import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/kudos/data/models/department.dart';
import 'package:saa_mobile/features/kudos/data/models/gift_recipient_ranking.dart';
import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos_state.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/kudos/data/models/spotlight_data.dart';
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
      spotlightData: results[4] as SpotlightData?,
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
    final delta = currentState.personalStats?.isBonusActive == true ? 2 : 1;
    final newHeartCount = isLiked
        ? targetKudos.heartCount - delta
        : targetKudos.heartCount + delta;
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

  /// Tìm kudos theo ID: kiểm tra cache (allKudos + highlightKudos + allKudosPageList) trước,
  /// nếu không có thì gọi API. Trả về null nếu không tìm thấy (404).
  Future<Kudos?> getKudosById(String kudosId) async {
    final currentState = state.valueOrNull;
    if (currentState != null) {
      // Cache hit: tìm trong allKudos
      final fromAll = currentState.allKudos
          .where((k) => k.id == kudosId)
          .firstOrNull;
      if (fromAll != null) return fromAll;

      // Cache hit: tìm trong highlightKudos
      final fromHighlight = currentState.highlightKudos
          .where((k) => k.id == kudosId)
          .firstOrNull;
      if (fromHighlight != null) return fromHighlight;

      // Cache hit: tìm trong allKudosPageList
      final fromPageList = currentState.allKudosPageList
          .where((k) => k.id == kudosId)
          .firstOrNull;
      if (fromPageList != null) return fromPageList;
    }

    // Cache miss: gọi API
    try {
      return await _repository.getKudosDetail(kudosId);
    } catch (_) {
      return null;
    }
  }

  // === All Kudos Page (page index 1 trong PageView) ===

  int _allKudosPage = 1;

  Future<void> loadAllKudosPage() async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    _allKudosPage = 1;
    try {
      final kudos = await _repository.getKudos(page: 1, limit: _pageLimit);
      state = AsyncValue.data(
        currentState.copyWith(
          allKudosPageList: kudos,
          hasMoreAllKudosPage: kudos.length >= _pageLimit,
        ),
      );
    } catch (_) {}
  }

  Future<void> loadMoreAllKudos() async {
    final currentState = state.valueOrNull;
    if (currentState == null ||
        !currentState.hasMoreAllKudosPage ||
        currentState.isLoadingMoreAllKudos) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMoreAllKudos: true));

    _allKudosPage++;
    try {
      final newKudos = await _repository.getKudos(
        page: _allKudosPage,
        limit: _pageLimit,
      );
      state = AsyncValue.data(
        state.valueOrNull!.copyWith(
          allKudosPageList: [
            ...state.valueOrNull!.allKudosPageList,
            ...newKudos,
          ],
          hasMoreAllKudosPage: newKudos.length >= _pageLimit,
          isLoadingMoreAllKudos: false,
        ),
      );
    } catch (_) {
      _allKudosPage--;
      state = AsyncValue.data(
        state.valueOrNull!.copyWith(isLoadingMoreAllKudos: false),
      );
    }
  }

  Future<void> refreshAllKudos() async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    _allKudosPage = 1;
    try {
      final kudos = await _repository.getKudos(page: 1, limit: _pageLimit);
      state = AsyncValue.data(
        currentState.copyWith(
          allKudosPageList: kudos,
          hasMoreAllKudosPage: kudos.length >= _pageLimit,
        ),
      );
    } catch (_) {}
  }

  // === Secret Box Flow ===

  bool _isOpeningBox = false;

  /// Mở hộp bí mật tiếp theo của user hiện tại.
  /// Guard chống double-tap (_isOpeningBox).
  /// Trả về [SecretBox] đã mở để caller navigate, hoặc null nếu không còn hộp.
  Future<void> openNextSecretBox() async {
    if (_isOpeningBox) return;
    _isOpeningBox = true;
    try {
      // Step 1: lấy hộp chưa mở tiếp theo
      final nextBox = await _repository.getNextSecretBox();
      if (nextBox == null) return;

      // Step 2: mở hộp
      await _repository.openSecretBox(nextBox.id);

      // Step 3: cập nhật stats cục bộ (optimistic)
      final current = state.valueOrNull;
      if (current?.personalStats != null) {
        final stats = current!.personalStats!;
        state = AsyncValue.data(
          current.copyWith(
            personalStats: stats.copyWith(
              secretBoxesOpened: stats.secretBoxesOpened + 1,
              secretBoxesUnopened: (stats.secretBoxesUnopened - 1).clamp(
                0,
                9999,
              ),
            ),
          ),
        );
      }
    } catch (_) {
      // Không update state khi lỗi — giữ nguyên để user thấy trạng thái đúng
    } finally {
      _isOpeningBox = false;
    }
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

    final updatedAllKudosPageList = currentState.allKudosPageList.map((k) {
      return k.id == kudosId ? updatedKudos : k;
    }).toList();

    return currentState.copyWith(
      allKudos: updatedAllKudos,
      highlightKudos: updatedHighlightKudos,
      allKudosPageList: updatedAllKudosPageList,
    );
  }
}

final kudosViewModelProvider =
    AsyncNotifierProvider<KudosViewModel, KudosState>(KudosViewModel.new);
