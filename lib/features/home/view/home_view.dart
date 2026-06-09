import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phicore/core/widgets/app_bottom_nav_bar.dart';
import 'package:phicore/features/home/view/tabs/explore_tab_view.dart';
import 'package:phicore/features/home/view/tabs/home_tab_view.dart';
import 'package:phicore/features/home/view/tabs/profile_tab_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _currentIndex = 0;

  static const _pages = [
    HomeTabView(),
    ExploreTabView(),
    ProfileTabView(),
  ];

  static const _navItems = [
    AppBottomNavItem(icon: Icons.home_outlined, activeIcon: Icons.home),
    AppBottomNavItem(icon: Icons.explore_outlined, activeIcon: Icons.explore),
    AppBottomNavItem(icon: Icons.person_outline, activeIcon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: _navItems,
      ),
    );
  }
}
