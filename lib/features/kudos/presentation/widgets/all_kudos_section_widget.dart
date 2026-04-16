import 'package:flutter/material.dart';

import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/widgets/section_header_widget.dart';

class AllKudosSectionHeader extends StatelessWidget {
  const AllKudosSectionHeader({super.key, this.onViewAll});

  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SectionHeaderWidget(
        label: t.kudos.sectionLabel,
        title: t.kudos.allKudosTitle,
      ),
    );
  }
}
