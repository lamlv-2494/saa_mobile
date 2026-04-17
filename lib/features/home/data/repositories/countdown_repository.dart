import 'package:shared_preferences/shared_preferences.dart';

abstract class CountdownRepository {
  Future<DateTime> getOrInitEndTime();
  Future<DateTime> resetEndTime();
  Future<void> clear();
}

class CountdownRepositoryImpl implements CountdownRepository {
  CountdownRepositoryImpl(this._prefs, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  static const String storageKey = 'home_countdown_end_time';
  static const Duration period = Duration(days: 20);

  final SharedPreferences _prefs;
  final DateTime Function() _now;

  @override
  Future<DateTime> getOrInitEndTime() async {
    final stored = _prefs.getString(storageKey);
    if (stored != null) {
      final parsed = DateTime.tryParse(stored);
      if (parsed != null) return parsed;
    }
    return resetEndTime();
  }

  @override
  Future<DateTime> resetEndTime() async {
    final end = _now().add(period);
    await _prefs.setString(storageKey, end.toIso8601String());
    return end;
  }

  @override
  Future<void> clear() async {
    await _prefs.remove(storageKey);
  }
}
