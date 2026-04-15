import 'package:saa_mobile/features/profile/data/models/badge.dart';
import 'package:saa_mobile/features/profile/data/models/icon_badge.dart';
import 'package:saa_mobile/features/profile/data/models/user_profile.dart';

UserProfile createUserProfile({
  String id = '1',
  String name = 'Nguyễn Văn A',
  String email = 'a@sun-asterisk.com',
  String? avatarUrl = 'https://example.com/avatar.png',
  String? teamCode = 'CECV1',
  String? departmentName = 'Division A',
  String heroTier = 'new_hero',
  String? heroTierUrl = 'https://example.com/hero.png',
}) =>
    UserProfile(
      id: id,
      name: name,
      email: email,
      avatarUrl: avatarUrl,
      teamCode: teamCode,
      departmentName: departmentName,
      heroTier: heroTier,
      heroTierUrl: heroTierUrl,
    );

IconBadge createIconBadge({
  int badgeId = 1,
  String badgeName = 'Top Talent',
  String badgeImageUrl = 'https://example.com/badge.png',
  DateTime? earnedAt,
}) =>
    IconBadge(
      badgeId: badgeId,
      badgeName: badgeName,
      badgeImageUrl: badgeImageUrl,
      earnedAt: earnedAt ?? DateTime(2025, 12, 1),
    );

Badge createBadge({
  int id = 1,
  String name = 'Rising Hero',
  String imageUrl = 'https://example.com/badge.png',
  String? description = 'Huy hiệu dành cho hero',
}) =>
    Badge(
      id: id,
      name: name,
      imageUrl: imageUrl,
      description: description,
    );

List<IconBadge> createIconBadgeList({int count = 3}) => List.generate(
      count,
      (i) => createIconBadge(
        badgeId: i + 1,
        badgeName: 'Badge ${i + 1}',
      ),
    );

List<Badge> createBadgeList({int count = 3}) => List.generate(
      count,
      (i) => createBadge(
        id: i + 1,
        name: 'Badge ${i + 1}',
      ),
    );
