import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:saa_mobile/features/home/data/models/award_category.dart';
import 'package:saa_mobile/features/home/data/models/event_info.dart';
import 'package:saa_mobile/features/home/data/models/kudos_info.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required EventInfo eventInfo,
    @Default([]) List<AwardCategory> awards,
    @Default(KudosInfo(title: '', description: '', isEnabled: false))
    KudosInfo kudosInfo,
    @Default(0) int unreadNotificationCount,
  }) = _HomeState;
}
