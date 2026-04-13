import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class EnvConfig {
  static String get _rawSupabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';

  /// Trên Android emulator (debug), tự động đổi 127.0.0.1 → 10.0.2.2
  /// để app có thể reach host machine mà không cần adb reverse.
  /// OAuth vẫn cần adb reverse vì Google chỉ accept 127.0.0.1.
  static String get supabaseUrl {
    final url = _rawSupabaseUrl;
    if (kDebugMode && Platform.isAndroid) {
      return url.replaceFirst('://127.0.0.1', '://10.0.2.2');
    }
    return url;
  }

  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  static bool get isConfigured =>
      _rawSupabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
