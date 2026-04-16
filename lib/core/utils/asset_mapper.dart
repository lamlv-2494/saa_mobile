import 'package:saa_mobile/gen/assets.gen.dart';

/// Maps award category slug → local Flutter asset.
class AssetMapper {
  AssetMapper._();

  /// Returns local [AssetGenImage] for a hero tier value.
  /// Returns null if the tier is 'none' or unrecognized.
  static AssetGenImage? heroTierImage(String heroTier) {
    return switch (heroTier) {
      'new_hero' => Assets.awards.heroTier.newHero,
      'rising_hero' => Assets.awards.heroTier.risingHero,
      'super_hero' => Assets.awards.heroTier.superHero,
      'legend_hero' => Assets.awards.heroTier.legendHero,
      _ => null,
    };
  }

  /// Returns local [AssetGenImage] for an award category slug.
  /// Returns null if the slug is unrecognized.
  static AssetGenImage? awardImage(String slug) {
    return switch (slug) {
      'top-talent' => Assets.awards.awards.topTalent,
      'top-project' => Assets.awards.awards.topProject,
      'top-project-leader' => Assets.awards.awards.topProjectLeader,
      'best-manager' => Assets.awards.awards.bestManager,
      'mvp' => Assets.awards.awards.mvp,
      'signature-2025-creator' => Assets.awards.awards.signatureCreator,
      _ => null,
    };
  }
}
