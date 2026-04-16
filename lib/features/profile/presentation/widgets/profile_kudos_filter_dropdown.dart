import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/profile/data/models/kudos_filter_type.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class ProfileKudosFilterDropdown extends StatefulWidget {
  const ProfileKudosFilterDropdown({
    super.key,
    required this.currentFilter,
    required this.sentCount,
    required this.receivedCount,
    required this.onChanged,
  });

  final KudosFilterType currentFilter;
  final int sentCount;
  final int receivedCount;
  final ValueChanged<KudosFilterType> onChanged;

  @override
  State<ProfileKudosFilterDropdown> createState() =>
      _ProfileKudosFilterDropdownState();
}

class _ProfileKudosFilterDropdownState
    extends State<ProfileKudosFilterDropdown> {
  bool _isOpen = false;

  String _labelFor(KudosFilterType filter) {
    if (filter == KudosFilterType.sent) {
      return '${t.profile.filterSent} (${widget.sentCount})';
    }
    return '${t.profile.filterReceived} (${widget.receivedCount})';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [_buildButton(), if (_isOpen) _buildOverlay()],
    );
  }

  Widget _buildButton() {
    return GestureDetector(
      onTap: () => setState(() => _isOpen = !_isOpen),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.outlineBtnBg,
          border: Border.all(color: AppColors.outlineBtnBorder),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _labelFor(widget.currentFilter),
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 20 / 14,
                color: AppColors.textAccent,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 16,
              color: AppColors.textAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: AppColors.bgDark,
        border: Border.all(color: AppColors.outlineBtnBorder),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: KudosFilterType.values.map((filter) {
          final isSelected = filter == widget.currentFilter;
          return GestureDetector(
            onTap: () {
              setState(() => _isOpen = false);
              widget.onChanged(filter);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.outlineBtnBg : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                filter == KudosFilterType.sent
                    ? '${t.profile.filterSent} (${widget.sentCount})'
                    : '${t.profile.filterReceived} (${widget.receivedCount})',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textAccent,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
