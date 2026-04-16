import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:saa_mobile/app/theme/app_colors.dart';
import 'package:saa_mobile/features/profile/data/models/user_profile.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key, required this.profile});

  final UserProfile profile;

  String _getInitial(String name) {
    if (name.isEmpty) return '?';
    return name.trim()[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(),
          const SizedBox(height: 8),
          Text(
            profile.name,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 22 / 16,
              color: AppColors.textWhite,
            ),
            textAlign: TextAlign.center,
          ),
          if (profile.teamCode != null && profile.teamCode!.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              profile.teamCode!,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 16 / 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
          if (profile.heroTier.isNotEmpty && profile.heroTier != 'none') ...[
            const SizedBox(height: 2),
            Text(
              profile.heroTier,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 16 / 12,
                color: AppColors.textAccent,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final hasAvatar =
        profile.avatarUrl != null && profile.avatarUrl!.isNotEmpty;

    return Semantics(
      image: true,
      label: 'Ảnh đại diện của ${profile.name}',
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 0.865),
        ),
        child: ClipOval(
          child: hasAvatar
              ? Image.network(
                  profile.avatarUrl!,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, _) => _buildInitial(),
                )
              : _buildInitial(),
        ),
      ),
    );
  }

  Widget _buildInitial() {
    return CircleAvatar(
      radius: 32,
      backgroundColor: const Color(0x33FFEA9E),
      child: Text(
        _getInitial(profile.name),
        style: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textAccent,
        ),
      ),
    );
  }
}
