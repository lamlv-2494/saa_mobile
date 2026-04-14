import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:saa_mobile/features/award/data/datasources/award_remote_datasource.dart';
import 'package:saa_mobile/features/home/data/models/award_category.dart';

abstract class AwardRepository {
  Future<List<AwardCategory>> getCategoriesWithPrizes({required String locale});
}

class AwardRepositoryImpl implements AwardRepository {
  AwardRepositoryImpl(this._datasource);

  final AwardRemoteDatasource _datasource;

  @override
  Future<List<AwardCategory>> getCategoriesWithPrizes({
    required String locale,
  }) => _datasource.getCategoriesWithPrizes(locale: locale);
}

final awardRepositoryProvider = Provider<AwardRepository>((ref) {
  final client = Supabase.instance.client;
  final datasource = AwardRemoteDatasourceImpl(client);
  return AwardRepositoryImpl(datasource);
});
