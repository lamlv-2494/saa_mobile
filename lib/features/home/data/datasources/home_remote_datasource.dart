import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:saa_mobile/features/home/data/models/award_category.dart';
import 'package:saa_mobile/features/home/data/models/event_info.dart';
import 'package:saa_mobile/features/home/data/models/kudos_info.dart';

abstract class HomeRemoteDatasource {
  Future<EventInfo> getEventInfo({required String locale});
  Future<List<AwardCategory>> getAwardCategories({required String locale});
  Future<KudosInfo> getKudosInfo();
  Future<int> getUnreadNotificationCount();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  HomeRemoteDatasourceImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<EventInfo> getEventInfo({required String locale}) async {
    final response = await _client
        .from('events')
        .select()
        .eq('is_active', true)
        .single();

    return EventInfo.fromJson(_localizeEvent(response, locale));
  }

  @override
  Future<List<AwardCategory>> getAwardCategories({
    required String locale,
  }) async {
    final response = await _client
        .from('award_categories')
        .select()
        .order('sort_order', ascending: true);

    return response
        .map((e) => AwardCategory.fromJson(_localizeAward(e, locale)))
        .toList();
  }

  @override
  Future<KudosInfo> getKudosInfo() async {
    return const KudosInfo(
      bannerImageUrl: '',
      title: '',
      description: '',
      isEnabled: true,
    );
  }

  @override
  Future<int> getUnreadNotificationCount() async {
    final response = await _client
        .from('notifications')
        .select()
        .eq('is_read', false)
        .count(CountOption.exact);
    return response.count;
  }

  /// Nếu locale = 'en' và cột _en có giá trị, dùng cột _en.
  /// Ngược lại fallback về cột gốc (tiếng Việt).
  Map<String, dynamic> _localizeEvent(
    Map<String, dynamic> row,
    String locale,
  ) {
    if (locale != 'en') return row;
    final result = Map<String, dynamic>.from(row);
    _swapIfPresent(result, 'livestream_note', 'livestream_note_en');
    _swapIfPresent(result, 'theme_description', 'theme_description_en');
    return result;
  }

  Map<String, dynamic> _localizeAward(
    Map<String, dynamic> row,
    String locale,
  ) {
    if (locale != 'en') return row;
    final result = Map<String, dynamic>.from(row);
    _swapIfPresent(result, 'name', 'name_en');
    _swapIfPresent(result, 'description', 'description_en');
    _swapIfPresent(result, 'unit', 'unit_en');
    _swapIfPresent(result, 'prize_note', 'prize_note_en');
    return result;
  }

  void _swapIfPresent(
    Map<String, dynamic> map,
    String baseKey,
    String enKey,
  ) {
    final enValue = map[enKey];
    if (enValue != null && enValue.toString().isNotEmpty) {
      map[baseKey] = enValue;
    }
  }
}
