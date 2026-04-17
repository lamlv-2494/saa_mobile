import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

/// Inline dropdown menu for selecting hashtags (multi-select).
/// Uses [MenuAnchor] to show overlay below the trigger button.
class HashtagDropdownWidget extends ConsumerStatefulWidget {
  const HashtagDropdownWidget({super.key});

  @override
  ConsumerState<HashtagDropdownWidget> createState() =>
      HashtagDropdownWidgetState();
}

class HashtagDropdownWidgetState extends ConsumerState<HashtagDropdownWidget> {
  final MenuController _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final state = ref.watch(sendKudosViewModelProvider).value;
    final available = state?.availableHashtags ?? [];
    final selected = state?.hashtags ?? [];

    return MenuAnchor(
      controller: _menuController,
      style: MenuStyle(
        backgroundColor: const WidgetStatePropertyAll(Color(0xFF0A1520)),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFF998C5F)),
          ),
        ),
        maximumSize: const WidgetStatePropertyAll(Size(double.infinity, 300)),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 8),
        ),
      ),
      menuChildren: available.isEmpty
          ? [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Text(
                  t.sendKudos.hashtagEmpty,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ]
          : available.map((tag) {
              final isSelected = selected.any((s) => s.id == tag.id);
              final isDisabled =
                  !isSelected &&
                  selected.length >= SendKudosViewModel.maxHashtags;

              return MenuItemButton(
                onPressed: isDisabled
                    ? null
                    : () {
                        ref
                            .read(sendKudosViewModelProvider.notifier)
                            .toggleHashtag(tag);
                        // Keep menu open for multi-select
                        if (!_menuController.isOpen) {
                          _menuController.open();
                        }
                      },
                style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    isDisabled
                        ? AppColors.textSecondary.withValues(alpha: 0.4)
                        : isSelected
                        ? AppColors.textAccent
                        : Colors.white,
                  ),
                ),
                trailingIcon: isSelected
                    ? const Icon(
                        Icons.check,
                        color: AppColors.textAccent,
                        size: 20,
                      )
                    : null,
                child: Text(
                  tag.name,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDisabled
                        ? AppColors.textSecondary.withValues(alpha: 0.4)
                        : isSelected
                        ? AppColors.textAccent
                        : Colors.white,
                  ),
                ),
              );
            }).toList(),
      child: const SizedBox.shrink(),
    );
  }

  /// Opens the hashtag dropdown menu.
  void open() {
    _menuController.open();
  }
}
