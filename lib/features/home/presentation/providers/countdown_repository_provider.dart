import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/home/data/repositories/countdown_repository.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';

final countdownRepositoryProvider = Provider<CountdownRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return CountdownRepositoryImpl(prefs);
});
