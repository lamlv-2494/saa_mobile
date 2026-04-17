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

class HighlightSectionWidget extends StatefulWidget {
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

  @override
  State<HighlightSectionWidget> createState() => _HighlightSectionWidgetState();
}

class _HighlightSectionWidgetState extends State<HighlightSectionWidget> {
  final MenuController _hashtagMenuController = MenuController();
  final MenuController _departmentMenuController = MenuController();

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
              // ── Hashtag DropdownMenu ──
              MenuAnchor(
                controller: _hashtagMenuController,
                style: _menuStyle,
                menuChildren: _buildHashtagMenuItems(),
                child: FilterDropdownButton(
                  label: t.kudos.filterHashtag,
                  selectedValue: widget.selectedHashtag?.name,
                  width: 129,
                  onTap: () => _hashtagMenuController.isOpen
                      ? _hashtagMenuController.close()
                      : _hashtagMenuController.open(),
                ),
              ),
              const SizedBox(width: 8),
              // ── Department DropdownMenu ──
              MenuAnchor(
                controller: _departmentMenuController,
                style: _menuStyle,
                menuChildren: _buildDepartmentMenuItems(),
                child: FilterDropdownButton(
                  label: t.kudos.filterDepartment,
                  selectedValue: widget.selectedDepartment?.name,
                  onTap: () => _departmentMenuController.isOpen
                      ? _departmentMenuController.close()
                      : _departmentMenuController.open(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          HighlightCarouselWidget(
            kudosList: widget.kudosList,
            onHeartTap: widget.onHeartTap,
            onCopyLink: widget.onCopyLink,
            onViewDetail: widget.onViewDetail,
            onAvatarTap: widget.onAvatarTap,
          ),
        ],
      ),
    );
  }

  MenuStyle get _menuStyle => MenuStyle(
    backgroundColor: const WidgetStatePropertyAll(AppColors.bgDark),
    surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFF998C5F)),
      ),
    ),
    maximumSize: const WidgetStatePropertyAll(Size(double.infinity, 300)),
    padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8)),
  );

  List<Widget> _buildHashtagMenuItems() {
    final items = <Widget>[];

    // Clear filter option when a filter is active
    if (widget.selectedHashtag != null) {
      items.add(
        MenuItemButton(
          onPressed: () {
            widget.onHashtagSelected?.call(null);
            _hashtagMenuController.close();
          },
          style: _clearItemStyle,
          child: Text(
            t.kudos.clearFilter,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textAccent,
            ),
          ),
        ),
      );
    }

    for (final tag in widget.availableHashtags) {
      final isSelected = tag == widget.selectedHashtag;
      items.add(
        MenuItemButton(
          onPressed: () {
            widget.onHashtagSelected?.call(tag);
            _hashtagMenuController.close();
          },
          style: _itemStyle(isSelected),
          trailingIcon: isSelected
              ? const Icon(Icons.check, color: AppColors.textAccent, size: 20)
              : null,
          child: Text(
            tag.name,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              color: isSelected ? AppColors.textAccent : AppColors.textWhite,
            ),
          ),
        ),
      );
    }

    return items;
  }

  List<Widget> _buildDepartmentMenuItems() {
    final items = <Widget>[];

    // Clear filter option when a filter is active
    if (widget.selectedDepartment != null) {
      items.add(
        MenuItemButton(
          onPressed: () {
            widget.onDepartmentSelected?.call(null);
            _departmentMenuController.close();
          },
          style: _clearItemStyle,
          child: Text(
            t.kudos.clearFilter,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textAccent,
            ),
          ),
        ),
      );
    }

    for (final dept in widget.availableDepartments) {
      final isSelected = dept == widget.selectedDepartment;
      items.add(
        MenuItemButton(
          onPressed: () {
            widget.onDepartmentSelected?.call(dept);
            _departmentMenuController.close();
          },
          style: _itemStyle(isSelected),
          trailingIcon: isSelected
              ? const Icon(Icons.check, color: AppColors.textAccent, size: 20)
              : null,
          child: Text(
            dept.name,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              color: isSelected ? AppColors.textAccent : AppColors.textWhite,
            ),
          ),
        ),
      );
    }

    return items;
  }

  ButtonStyle _itemStyle(bool isSelected) => ButtonStyle(
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    foregroundColor: WidgetStatePropertyAll(
      isSelected ? AppColors.textAccent : AppColors.textWhite,
    ),
  );

  ButtonStyle get _clearItemStyle => const ButtonStyle(
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    foregroundColor: WidgetStatePropertyAll(AppColors.textAccent),
  );
}
