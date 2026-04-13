import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';
import 'package:saa_mobile/shared/widgets/language_dropdown.dart';

class LoginHeader extends ConsumerWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Assets.images.saaLogo.image(
          width: 48,
          height: 44,
          fit: BoxFit.cover,
        ),
        LanguageDropdown(
          currentLocaleCode: locale.languageCode,
          onLocaleChanged: (code) {
            ref.read(localeNotifierProvider.notifier).changeLocale(code);
          },
        ),
      ],
    );
  }
}
