import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/department.dart';
import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/filter_dropdown_button.dart';
import 'package:saa_mobile/features/kudos/presentation/widgets/highlight_carousel_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/widgets/section_header_widget.dart';

class HighlightSectionWidget extends StatelessWidget {
  const HighlightSectionWidget({
    super.key,
    required this.kudosList,
    this.availableHashtags = const [],
    this.availableDepartments = const [],
    this.selectedHashtag,
    this.selectedDepartment,
    this.onHashtagSelected,
    this.onDepartmentSelected,
    this.onHeartTap,
    this.onCopyLink,
    this.onViewDetail,
    this.onAvatarTap,
  });

  final List<Kudos> kudosList;
  final List<Hashtag> availableHashtags;
  final List<Department> availableDepartments;
  final Hashtag? selectedHashtag;
  final Department? selectedDepartment;
  final void Function(Hashtag?)? onHashtagSelected;
  final void Function(Department?)? onDepartmentSelected;
  final void Function(String kudosId)? onHeartTap;
  final void Function(String kudosId)? onCopyLink;
  final void Function(String kudosId)? onViewDetail;
  final void Function(String userId)? onAvatarTap;

  void _showHashtagBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _FilterOptionsList<Hashtag>(
        title: t.kudos.selectHashtag,
        items: availableHashtags,
        selectedItem: selectedHashtag,
        getName: (h) => h.name,
        onSelected: (h) {
          Navigator.pop(context);
          onHashtagSelected?.call(h);
        },
        onClear: () {
          Navigator.pop(context);
          onHashtagSelected?.call(null);
        },
      ),
    );
  }

  void _showDepartmentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _FilterOptionsList<Department>(
        title: t.kudos.selectDepartment,
        items: availableDepartments,
        selectedItem: selectedDepartment,
        getName: (d) => d.name,
        onSelected: (d) {
          Navigator.pop(context);
          onDepartmentSelected?.call(d);
        },
        onClear: () {
          Navigator.pop(context);
          onDepartmentSelected?.call(null);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderWidget(
            label: t.kudos.sectionLabel,
            title: t.kudos.highlightTitle,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              FilterDropdownButton(
                label: t.kudos.filterHashtag,
                selectedValue: selectedHashtag?.name,
                width: 129,
                onTap: () => _showHashtagBottomSheet(context),
              ),
              const SizedBox(width: 8),
              FilterDropdownButton(
                label: t.kudos.filterDepartment,
                selectedValue: selectedDepartment?.name,
                onTap: () => _showDepartmentBottomSheet(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          HighlightCarouselWidget(
            kudosList: kudosList,
            onHeartTap: onHeartTap,
            onCopyLink: onCopyLink,
            onViewDetail: onViewDetail,
            onAvatarTap: onAvatarTap,
          ),
        ],
      ),
    );
  }
}

class _FilterOptionsList<T> extends StatelessWidget {
  const _FilterOptionsList({
    super.key,
    required this.title,
    required this.items,
    required this.getName,
    required this.onSelected,
    required this.onClear,
    this.selectedItem,
  });

  final String title;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) getName;
  final void Function(T) onSelected;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textWhite,
                  ),
                ),
                if (selectedItem != null)
                  GestureDetector(
                    onTap: onClear,
                    child: Text(
                      t.kudos.clearFilter,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: AppColors.textAccent,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = item == selectedItem;
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      getName(item),
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w400,
                        color: isSelected
                            ? AppColors.textAccent
                            : AppColors.textWhite,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check,
                            color: AppColors.textAccent,
                            size: 20,
                          )
                        : null,
                    onTap: () => onSelected(item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
