import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/gen/assets.gen.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class AwardDropdownFilter extends StatelessWidget {
  const AwardDropdownFilter({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: t.award.dropdownHint,
      button: true,
      child: PopupMenuButton<int>(
        onSelected: onChanged,
        offset: const Offset(0, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: AppColors.outlineBtnBorder),
        ),
        color: AppColors.bgDark,
        itemBuilder: (_) => List.generate(
          items.length,
          (index) => PopupMenuItem<int>(
            value: index,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  items[index],
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: index == selectedIndex
                        ? FontWeight.w500
                        : FontWeight.w400,
                    height: 20 / 14,
                    letterSpacing: 0.25,
                    color: index == selectedIndex
                        ? AppColors.textAccent
                        : AppColors.textWhite,
                  ),
                ),
                if (index < items.length - 1)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.divider,
                    ),
                  ),
              ],
            ),
          ),
        ),
        child: Container(
          height: 40,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0x1AFFEA9E),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.outlineBtnBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                items.isNotEmpty ? items[selectedIndex] : '',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 20 / 14,
                  letterSpacing: 0.25,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(width: 8),
              Assets.icons.icArrowDown.svg(
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.textWhite,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
