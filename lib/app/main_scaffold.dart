import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/award/presentation/screens/award_screen.dart';
import 'package:saa_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:saa_mobile/features/kudos/presentation/screens/kudos_screen.dart';
import 'package:saa_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:saa_mobile/shared/widgets/bottom_nav_bar.dart';

final currentTabIndexProvider = StateProvider<int>((ref) => 0);

class MainScaffold extends ConsumerWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentTabIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomeScreen(),
          AwardScreen(),
          KudosScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(currentTabIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}

