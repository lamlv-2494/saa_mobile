import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';
import 'package:saa_mobile/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

class RecipientDropdownMenuWidget extends ConsumerWidget {
  const RecipientDropdownMenuWidget({super.key, required this.hasError});

  final bool hasError;

  String _getInitials(String name) {
    if (name.isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final state = ref.watch(sendKudosViewModelProvider).value;
    final allUsers = state?.allUsers ?? [];
    final selectedId = state?.recipientId;
    final selectedUser = selectedId != null
        ? allUsers.where((u) => u.id == selectedId).firstOrNull
        : null;

    final borderColor = hasError ? AppColors.errorRed : const Color(0xFF998C5F);

    return DropdownMenu<UserSummary>(
      expandedInsets: EdgeInsets.zero,
      initialSelection: selectedUser,
      requestFocusOnTap: false,
      enableFilter: false,
      enableSearch: false,
      onSelected: (user) {
        if (user != null) {
          ref
              .read(sendKudosViewModelProvider.notifier)
              .selectRecipient(
                id: user.id,
                name: user.name,
                avatar: user.avatar,
              );
        }
      },
      menuStyle: MenuStyle(
        backgroundColor: const WidgetStatePropertyAll(Color(0xFF0A1A24)),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(color: Color(0xFF998C5F)),
          ),
        ),
        maximumSize: const WidgetStatePropertyAll(Size(double.infinity, 300)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0x1AFFEA9E),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        constraints: const BoxConstraints(maxHeight: 44),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: hasError ? AppColors.errorRed : AppColors.textAccent,
          ),
        ),
        hintStyle: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF999999),
        ),
      ),
      textStyle: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: selectedUser != null ? Colors.white : const Color(0xFF999999),
      ),
      hintText: t.sendKudos.recipientPlaceholder,
      trailingIcon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.textSecondary,
        size: 20,
      ),
      selectedTrailingIcon: const Icon(
        Icons.keyboard_arrow_up,
        color: AppColors.textSecondary,
        size: 20,
      ),
      label: null,
      dropdownMenuEntries: allUsers.isEmpty
          ? [
              DropdownMenuEntry<UserSummary>(
                value: const UserSummary(id: '', name: ''),
                label: t.sendKudos.usersLoadError,
                enabled: false,
                style: const ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(
                    AppColors.textSecondary,
                  ),
                ),
              ),
            ]
          : allUsers.map((user) {
              final isSelected = user.id == selectedId;
              return DropdownMenuEntry<UserSummary>(
                value: user,
                label: user.name,
                leadingIcon: _buildAvatar(user),
                trailingIcon: user.department.isNotEmpty
                    ? Text(
                        user.department,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF999999),
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    isSelected ? const Color(0x14FFEA9E) : Colors.transparent,
                  ),
                  foregroundColor: const WidgetStatePropertyAll(Colors.white),
                  textStyle: WidgetStatePropertyAll(
                    GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  minimumSize: const WidgetStatePropertyAll(
                    Size(double.infinity, 56),
                  ),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              );
            }).toList(),
    );
  }

  Widget _buildAvatar(UserSummary user) {
    if (user.avatar.isNotEmpty) {
      return CircleAvatar(
        radius: 18,
        backgroundImage: NetworkImage(user.avatar),
        backgroundColor: const Color(0x33FFEA9E),
        onBackgroundImageError: (_, _) {},
      );
    }
    return CircleAvatar(
      radius: 18,
      backgroundColor: const Color(0x33FFEA9E),
      child: Text(
        _getInitials(user.name),
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFFFEA9E),
        ),
      ),
    );
  }
}
