import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/profile/data/models/profile_state.dart';
import 'package:saa_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:saa_mobile/features/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/icon_collection_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/kudos_section_header_widget.dart';
import 'package:saa_mobile/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:saa_mobile/i18n/strings.g.dart';
import 'package:saa_mobile/shared/providers/locale_provider.dart';
import 'package:saa_mobile/shared/widgets/personal_stats_card.dart';

import '../../helpers/profile_test_helpers.dart';

// ─── Fake Providers ───

class _FakeLocaleNotifier extends StateNotifier<Locale>
    implements LocaleNotifier {
  _FakeLocaleNotifier() : super(const Locale('vi'));

  @override
  void changeLocale(String code) => state = Locale(code);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// ─── Fake ViewModels ───

class _FakeProfileViewModel extends ProfileViewModel {
  final ProfileState _initial;

  _FakeProfileViewModel(this._initial);

  @override
  FutureOr<ProfileState> build() => _initial;

  @override
  Future<void> refresh() async {}

  @override
  Future<void> loadMoreKudos() async {}
}

/// Giữ trạng thái loading mãi mãi (Completer không bao giờ complete)
class _LoadingProfileViewModel extends ProfileViewModel {
  @override
  FutureOr<ProfileState> build() => Completer<ProfileState>().future;
}

class _ErrorProfileViewModel extends ProfileViewModel {
  @override
  FutureOr<ProfileState> build() => throw Exception('load error');
}

ProfileState _makeState({
  List<Kudos> kudosList = const [],
  PersonalStats? stats,
}) => ProfileState(
  profile: createUserProfile(),
  personalStats:
      stats ??
      const PersonalStats(kudosReceived: 5, kudosSent: 10, heartsReceived: 3),
  iconBadges: createIconBadgeList(count: 2),
  kudosList: kudosList,
);

Widget _buildScreen(ProfileState state) {
  return ProviderScope(
    overrides: [
      profileViewModelProvider.overrideWith(() => _FakeProfileViewModel(state)),
      localeNotifierProvider.overrideWith((_) => _FakeLocaleNotifier()),
    ],
    child: TranslationProvider(child: const MaterialApp(home: ProfileScreen())),
  );
}

void main() {
  group('ProfileScreen - loading', () {
    testWidgets('hiển thị loading indicator khi chưa có data', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileViewModelProvider.overrideWith(_LoadingProfileViewModel.new),
            localeNotifierProvider.overrideWith((_) => _FakeLocaleNotifier()),
          ],
          child: TranslationProvider(child: const MaterialApp(home: ProfileScreen())),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('ProfileScreen - data loaded', () {
    testWidgets('hiển thị ProfileInfoWidget', (tester) async {
      await tester.pumpWidget(_buildScreen(_makeState()));
      await tester.pumpAndSettle();

      expect(find.byType(ProfileInfoWidget), findsOneWidget);
    });

    testWidgets('hiển thị tên người dùng', (tester) async {
      await tester.pumpWidget(_buildScreen(_makeState()));
      await tester.pumpAndSettle();

      expect(find.text('Nguyễn Văn A'), findsOneWidget);
    });

    testWidgets('hiển thị IconCollectionWidget', (tester) async {
      await tester.pumpWidget(_buildScreen(_makeState()));
      await tester.pumpAndSettle();

      expect(find.byType(IconCollectionWidget), findsOneWidget);
    });

    testWidgets('hiển thị PersonalStatsCard', (tester) async {
      await tester.pumpWidget(_buildScreen(_makeState()));
      await tester.pumpAndSettle();

      expect(find.byType(PersonalStatsCard), findsOneWidget);
    });

    testWidgets('hiển thị KudosSectionHeaderWidget', (tester) async {
      await tester.pumpWidget(_buildScreen(_makeState()));
      await tester.pumpAndSettle();

      expect(find.byType(KudosSectionHeaderWidget), findsOneWidget);
    });

    testWidgets('hiển thị empty kudos text khi không có kudos', (tester) async {
      await tester.pumpWidget(_buildScreen(_makeState(kudosList: [])));
      await tester.pumpAndSettle();

      expect(find.text(t.profile.noKudosHistory), findsOneWidget);
    });
  });

  group('ProfileScreen - error', () {
    testWidgets('hiển thị error text khi load thất bại', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileViewModelProvider.overrideWith(_ErrorProfileViewModel.new),
            localeNotifierProvider.overrideWith((_) => _FakeLocaleNotifier()),
          ],
          child: TranslationProvider(child: const MaterialApp(home: ProfileScreen())),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(t.profile.loadError), findsOneWidget);
    });
  });
}
