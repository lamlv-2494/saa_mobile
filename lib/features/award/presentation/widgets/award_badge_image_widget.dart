import 'package:flutter/material.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/core/env/env_config.dart';

class AwardBadgeImage extends StatelessWidget {
  const AwardBadgeImage({
    super.key,
    required this.imageUrl,
    this.semanticLabel,
  });

  final String imageUrl;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        label: semanticLabel,
        image: true,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.429),
            border: Border.all(color: AppColors.awardImgBorder, width: 0.455),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 1.905),
                blurRadius: 1.905,
                color: Color.fromRGBO(0, 0, 0, 0.25),
              ),
              BoxShadow(blurRadius: 2.857, color: AppColors.awardGlow),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11.429),
            child: Image.network(
              '${EnvConfig.supabaseUrl}$imageUrl',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }
}
