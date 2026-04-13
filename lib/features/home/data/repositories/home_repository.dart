import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:saa_mobile/features/home/data/datasources/home_remote_datasource.dart';
import 'package:saa_mobile/features/home/data/models/award_category.dart';
import 'package:saa_mobile/features/home/data/models/event_info.dart';
import 'package:saa_mobile/features/home/data/models/kudos_info.dart';

abstract class HomeRepository {
  Future<EventInfo> getEventInfo({required String locale});
  Future<List<AwardCategory>> getAwardCategories({required String locale});
  Future<KudosInfo> getKudosInfo();
  Future<int> getUnreadNotificationCount();
}

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._datasource);

  final HomeRemoteDatasource _datasource;

  @override
  Future<EventInfo> getEventInfo({required String locale}) =>
      _datasource.getEventInfo(locale: locale);

  @override
  Future<List<AwardCategory>> getAwardCategories({required String locale}) =>
      _datasource.getAwardCategories(locale: locale);

  @override
  Future<KudosInfo> getKudosInfo() => _datasource.getKudosInfo();

  @override
  Future<int> getUnreadNotificationCount() =>
      _datasource.getUnreadNotificationCount();
}

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final client = Supabase.instance.client;
  final datasource = HomeRemoteDatasourceImpl(client);
  return HomeRepositoryImpl(datasource);
});
