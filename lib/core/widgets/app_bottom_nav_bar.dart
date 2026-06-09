import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phicore/core/constants/app_constants.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_spacing.dart';

/// Bottom navigation bar item modeli.
class AppBottomNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String? badge;

  const AppBottomNavItem({
    required this.icon,
    required this.activeIcon,
    this.badge,
  });
}

/// Floating glassmorphic bottom navigation bar.
///
/// Kullanım:
/// ```dart
/// Scaffold(
///   extendBody: true,
///   bottomNavigationBar: AppBottomNavBar(
///     currentIndex: _currentIndex,
///     onTap: (i) => setState(() => _currentIndex = i),
///     items: [
///       AppBottomNavItem(icon: Icons.home_outlined, activeIcon: Icons.home),
///       AppBottomNavItem(icon: Icons.explore_outlined, activeIcon: Icons.explore),
///       AppBottomNavItem(icon: Icons.person_outline, activeIcon: Icons.person),
///     ],
///   ),
/// )
/// ```
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppBottomNavItem> items;
  final double height;
  final EdgeInsets padding;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.height = 64,
    this.padding = const EdgeInsets.only(
      left: AppSpacing.xl,
      right: AppSpacing.xl,
      bottom: AppSpacing.xl,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: AppColors.glassBorder,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(items.length, _buildItem),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    final isActive = currentIndex == index;
    final item = items[index];

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppConstants.animNormal,
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 24 : 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              isActive ? item.activeIcon : item.icon,
              size: 26,
              color: isActive ? AppColors.primary : AppColors.grey50,
            ),
            if (item.badge != null)
              Positioned(
                top: -4,
                right: -6,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
