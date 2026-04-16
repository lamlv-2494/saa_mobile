import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/profile/data/models/badge.dart';
import 'package:saa_mobile/features/profile/data/models/kudos_filter_type.dart';
import 'package:saa_mobile/features/profile/data/models/user_profile.dart';

part 'other_profile_state.freezed.dart';

@freezed
class OtherProfileState with _$OtherProfileState {
  const factory OtherProfileState({
    UserProfile? profile,
    PersonalStats? personalStats,
    @Default([]) List<Badge> badges,
    @Default([]) List<Kudos> kudosList,
    @Default(KudosFilterType.received) KudosFilterType kudosFilter,
    @Default(true) bool hasMoreKudos,
    @Default(false) bool isLoadingMoreKudos,
  }) = _OtherProfileState;
}
