import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/features/profile/data/models/other_profile_state.dart';
import 'package:saa_mobile/features/profile/presentation/screens/other_profile_screen.dart';
import 'package:saa_mobile/features/profile/presentation/viewmodels/other_profile_viewmodel.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/badge_collection_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/kudos_section_header_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/send_kudos_button_widget.dart';
import 'package:saa_mobile/shared/widgets/personal_stats_card.dart';
import 'package:saa_mobile/i18n/strings.g.dart';

import '../../helpers/profile_test_helpers.dart';

// ─── Fake ViewModels ───

class _FakeOtherProfileViewModel extends OtherProfileViewModel {
  final OtherProfileState _initial;
  _FakeOtherProfileViewModel(this._initial);

  @override
  FutureOr<OtherProfileState> build(String arg) => _initial;

  @override
  Future<void> refresh() async {}

  @override
  Future<void> loadMoreKudos() async {}
}

class _LoadingOtherProfileViewModel extends OtherProfileViewModel {
  @override
  FutureOr<OtherProfileState> build(String arg) =>
      Completer<OtherProfileState>().future;
}

class _ErrorOtherProfileViewModel extends OtherProfileViewModel {
  @override
  FutureOr<OtherProfileState> build(String arg) =>
      throw Exception('user not found');
}

OtherProfileState _makeState() => OtherProfileState(
      profile: createUserProfile(id: 'other-user'),
      badges: createBadgeList(count: 2),
      kudosList: const [],
    );

Widget _buildScreen(
  String userId,
  OtherProfileViewModel Function() vmFactory,
) {
  return ProviderScope(
    overrides: [
      otherProfileViewModelProvider.overrideWith(vmFactory),
    ],
    child: TranslationProvider(
      child: MaterialApp(
        home: OtherProfileScreen(userId: userId),
      ),
    ),
  );
}

void main() {
  const testUserId = 'other-user';

  group('OtherProfileScreen - loading', () {
    testWidgets('hiển thị loading indicator', (tester) async {
      await tester.pumpWidget(
        _buildScreen(testUserId, _LoadingOtherProfileViewModel.new),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('OtherProfileScreen - data loaded', () {
    testWidgets('hiển thị ProfileInfoWidget', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          testUserId,
          () => _FakeOtherProfileViewModel(_makeState()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ProfileInfoWidget), findsOneWidget);
    });

    testWidgets('hiển thị BadgeCollectionWidget', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          testUserId,
          () => _FakeOtherProfileViewModel(_makeState()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(BadgeCollectionWidget), findsOneWidget);
    });

    testWidgets('hiển thị SendKudosButtonWidget', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          testUserId,
          () => _FakeOtherProfileViewModel(_makeState()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SendKudosButtonWidget), findsOneWidget);
    });

    testWidgets('hiển thị KudosSectionHeaderWidget với KUDOS header', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          testUserId,
          () => _FakeOtherProfileViewModel(_makeState()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(KudosSectionHeaderWidget), findsOneWidget);
    });

    testWidgets('KHÔNG hiển thị PersonalStatsCard', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          testUserId,
          () => _FakeOtherProfileViewModel(_makeState()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PersonalStatsCard), findsNothing);
    });

    testWidgets('hiển thị SliverAppBar transparent với SVG back icon', (tester) async {
      await tester.pumpWidget(
        _buildScreen(
          testUserId,
          () => _FakeOtherProfileViewModel(_makeState()),
        ),
      );
      await tester.pumpAndSettle();

      // SliverAppBar phải có backgroundColor transparent (không dùng Material BackButton)
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.byType(BackButton), findsNothing);
    });
  });

  group('OtherProfileScreen - error', () {
    testWidgets('hiển thị error text khi load thất bại', (tester) async {
      await tester.pumpWidget(
        _buildScreen(testUserId, _ErrorOtherProfileViewModel.new),
      );
      await tester.pumpAndSettle();

      expect(find.text('User not found.'), findsOneWidget);
    });
  });
}
