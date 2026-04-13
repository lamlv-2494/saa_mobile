import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/home/data/models/home_state.dart';
import 'package:saa_mobile/features/home/data/repositories/home_repository.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';

class HomeViewModel extends AsyncNotifier<HomeState> {
  @override
  FutureOr<HomeState> build() => _fetchAll();

  Future<HomeState> _fetchAll() async {
    final repo = ref.read(homeRepositoryProvider);
    final locale = ref.watch(localeNotifierProvider).languageCode;

    final (eventInfo, awards, kudosInfo, unreadCount) = await (
      repo.getEventInfo(locale: locale),
      repo.getAwardCategories(locale: locale),
      repo.getKudosInfo(),
      repo.getUnreadNotificationCount(),
    ).wait;

    return HomeState(
      eventInfo: eventInfo,
      awards: awards,
      kudosInfo: kudosInfo,
      unreadNotificationCount: unreadCount,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchAll);
  }
}

final homeViewModelProvider =
    AsyncNotifierProvider<HomeViewModel, HomeState>(HomeViewModel.new);
