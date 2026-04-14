import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/award/data/models/award_state.dart';
import 'package:saa_mobile/features/award/data/repositories/award_repository.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';

class AwardViewModel extends AsyncNotifier<AwardState> {
  @override
  FutureOr<AwardState> build() => _fetch();

  Future<AwardState> _fetch() async {
    final repo = ref.read(awardRepositoryProvider);
    final locale = ref.watch(localeNotifierProvider).languageCode;

    final categories = await repo.getCategoriesWithPrizes(locale: locale);

    return AwardState(categories: categories);
  }

  void selectCategory(int index) {
    final current = state.valueOrNull;
    if (current == null) return;
    if (index < 0 || index >= current.categories.length) return;
    state = AsyncData(current.copyWith(selectedIndex: index));
  }

  void selectBySlug(String slug) {
    final current = state.valueOrNull;
    if (current == null) return;
    final index = current.categories.indexWhere((c) => c.slug == slug);
    if (index != -1) {
      state = AsyncData(current.copyWith(selectedIndex: index));
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetch);
  }
}

final awardViewModelProvider =
    AsyncNotifierProvider<AwardViewModel, AwardState>(AwardViewModel.new);
