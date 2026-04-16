import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/profile/data/models/icon_badge.dart';
import 'package:saa_mobile/features/profile/data/models/kudos_filter_type.dart';
import 'package:saa_mobile/features/profile/data/models/user_profile.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    UserProfile? profile,
    PersonalStats? personalStats,
    @Default([]) List<IconBadge> iconBadges,
    @Default([]) List<Kudos> kudosList,
    @Default(KudosFilterType.sent) KudosFilterType kudosFilter,
    @Default(true) bool hasMoreKudos,
    @Default(false) bool isLoadingMoreKudos,
  }) = _ProfileState;
}
