import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:saa_mobile/features/kudos/data/models/department.dart';
import 'package:saa_mobile/features/kudos/data/models/gift_recipient_ranking.dart';
import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/kudos/data/models/spotlight_network.dart';

part 'kudos_state.freezed.dart';

@freezed
class KudosState with _$KudosState {
  const factory KudosState({
    @Default([]) List<Kudos> highlightKudos,
    @Default([]) List<Kudos> allKudos,
    PersonalStats? personalStats,
    @Default([]) List<GiftRecipientRanking> topGiftRecipients,
    SpotlightNetwork? spotlightData,
    Hashtag? selectedHashtag,
    Department? selectedDepartment,
    @Default(0) int currentHighlightPage,
    @Default(true) bool hasMoreKudos,
    @Default([]) List<Hashtag> availableHashtags,
    @Default([]) List<Department> availableDepartments,
  }) = _KudosState;
}
