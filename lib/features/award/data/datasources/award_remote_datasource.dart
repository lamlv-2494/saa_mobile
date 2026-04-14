import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:saa_mobile/features/home/data/models/award_category.dart';

abstract class AwardRemoteDatasource {
  Future<List<AwardCategory>> getCategoriesWithPrizes({required String locale});
}

class AwardRemoteDatasourceImpl implements AwardRemoteDatasource {
  AwardRemoteDatasourceImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<List<AwardCategory>> getCategoriesWithPrizes({
    required String locale,
  }) async {
    final response = await _client
        .from('award_categories')
        .select('*, award_prizes(*)')
        .order('sort_order', ascending: true);

    return response
        .map((e) => AwardCategory.fromJson(_localize(e, locale)))
        .toList();
  }

  Map<String, dynamic> _localize(Map<String, dynamic> row, String locale) {
    if (locale != 'en') return row;
    final result = Map<String, dynamic>.from(row);
    _swapIfPresent(result, 'name', 'name_en');
    _swapIfPresent(result, 'description', 'description_en');
    _swapIfPresent(result, 'unit', 'unit_en');
    _swapIfPresent(result, 'prize_note', 'prize_note_en');
    return result;
  }

  void _swapIfPresent(Map<String, dynamic> map, String baseKey, String enKey) {
    final enValue = map[enKey];
    if (enValue != null && enValue.toString().isNotEmpty) {
      map[baseKey] = enValue;
    }
  }
}
