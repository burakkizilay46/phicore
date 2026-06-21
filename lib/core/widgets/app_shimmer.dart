import 'package:flutter/material.dart';
import 'package:phicore/core/theme/app_colors.dart';
import 'package:phicore/core/theme/app_radius.dart';
import 'package:phicore/core/theme/app_spacing.dart';

/// Shimmer efektli loading placeholder.
///
/// Kullanım:
/// ```dart
/// // Tek bir shimmer kutu
/// AppShimmer(width: 200, height: 20)
///
/// // Daire (avatar)
/// AppShimmer.circle(size: 48)
///
/// // Kart skeleton
/// AppShimmer.card()
///
/// // Liste skeleton
/// AppShimmer.list(itemCount: 5)
/// ```
class AppShimmer extends StatefulWidget {
  final double? width;
  final double height;
  final BorderRadius borderRadius;

   const AppShimmer({
    super.key,
    this.width,
    required this.height,
    this.borderRadius =  BorderRadius.zero, //Check here!
  });

  /// Daire shimmer (avatar vb.)
  factory AppShimmer.circle({required double size}) {
    return AppShimmer(
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? AppColors.surfaceLight : const Color(0xFFE8E8E8);
    final highlightColor = isDark
        ? AppColors.surfaceElevated
        : const Color(0xFFF5F5F5);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: [baseColor, highlightColor, baseColor],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

/// Kart skeleton — başlık + 2-3 satır text taklidi.
class AppSkeletonCard extends StatelessWidget {
  const AppSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceLight : Colors.white,
        borderRadius: AppRadius.lgBorder,
        border: Border.all(
          color: isDark ? AppColors.grey15 : const Color(0xFFEEEEEE),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Üst: Avatar + başlık
          Row(
            children: [
              AppShimmer.circle(size: 40),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppShimmer(width: 120, height: 14),
                    const SizedBox(height: AppSpacing.xs),
                    const AppShimmer(width: 80, height: 10),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.gapLg,
          // Body satırları
          const AppShimmer(height: 12),
          const SizedBox(height: AppSpacing.sm),
          const AppShimmer(height: 12),
          const SizedBox(height: AppSpacing.sm),
          const AppShimmer(width: 200, height: 12),
        ],
      ),
    );
  }
}

/// Liste skeleton — tekrarlanan kart satırları.
class AppSkeletonList extends StatelessWidget {
  final int itemCount;
  final double spacing;

  const AppSkeletonList({
    super.key,
    this.itemCount = 5,
    this.spacing = AppSpacing.md,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      separatorBuilder: (_, __) => SizedBox(height: spacing),
      itemBuilder: (_, __) => const AppSkeletonCard(),
    );
  }
}

/// Basit satır skeleton — ikon + text satırı.
class AppSkeletonRow extends StatelessWidget {
  const AppSkeletonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppShimmer.circle(size: 44),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppShimmer(height: 14),
              const SizedBox(height: AppSpacing.xs),
              const AppShimmer(width: 140, height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
