import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:saa_mobile/core/env/env_config.dart';

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
  );
}
