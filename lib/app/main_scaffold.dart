import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:saa_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:saa_mobile/features/kudos/presentation/screens/kudos_screen.dart';
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
          _PlaceholderTab(title: 'Awards'),
          KudosScreen(),
          _PlaceholderTab(title: 'Profile'),
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

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00101A),
      body: Center(
        child: Text(
          '$title — coming soon',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
