import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/repositories/kudos_repository.dart';

class KudosDetailViewModel extends FamilyAsyncNotifier<Kudos?, String> {
  late KudosRepository _repository;

  @override
  FutureOr<Kudos?> build(String arg) async {
    _repository = ref.read(kudosRepositoryProvider);
    return _repository.getKudosDetail(arg);
  }

  Future<void> toggleHeart() async {
    final currentKudos = state.valueOrNull;
    if (currentKudos == null) return;

    final isLiked = currentKudos.isLikedByMe;
    final newHeartCount = isLiked
        ? currentKudos.heartCount - 1
        : currentKudos.heartCount + 1;

    // Optimistic update
    state = AsyncValue.data(
      currentKudos.copyWith(isLikedByMe: !isLiked, heartCount: newHeartCount),
    );

    try {
      if (isLiked) {
        await _repository.unlikeKudos(currentKudos.id);
      } else {
        await _repository.likeKudos(currentKudos.id);
      }
    } catch (_) {
      // Rollback on error
      state = AsyncValue.data(currentKudos);
    }
  }

  void copyShareLink() {
    final currentKudos = state.valueOrNull;
    if (currentKudos == null) return;
    Clipboard.setData(ClipboardData(text: currentKudos.shareUrl));
  }
}

final kudosDetailViewModelProvider =
    AsyncNotifierProvider.family<KudosDetailViewModel, Kudos?, String>(
      KudosDetailViewModel.new,
    );
