import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phicore/core/theme/app_colors.dart';

/// Önbellekli network image widget.
/// Placeholder, error state ve fade animasyonu içerir.
///
/// Kullanım:
/// ```dart
/// AppCachedImage(
///   imageUrl: 'https://example.com/photo.jpg',
///   width: 120,
///   height: 120,
/// )
///
/// AppCachedImage.avatar(
///   imageUrl: user.avatarUrl,
///   size: 48,
/// )
///
/// AppCachedImage.cover(
///   imageUrl: article.coverUrl,
///   height: 200,
/// )
/// ```
class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  /// Yuvarlak avatar.
  factory AppCachedImage.avatar({
    Key? key,
    required String imageUrl,
    double size = 48,
  }) {
    return AppCachedImage(
      key: key,
      imageUrl: imageUrl,
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(999),
    );
  }

  /// Tam genişlik kapak görseli.
  factory AppCachedImage.cover({
    Key? key,
    required String imageUrl,
    double? height = 200,
    BorderRadius? borderRadius,
  }) {
    return AppCachedImage(
      key: key,
      imageUrl: imageUrl,
      width: double.infinity,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(12),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 200),
      fadeOutDuration: const Duration(milliseconds: 200),
      placeholder: (context, url) =>
          placeholder ?? _DefaultPlaceholder(width: width, height: height),
      errorWidget: (context, url, error) =>
          errorWidget ?? _DefaultError(width: width, height: height),
    );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }
}

class _DefaultPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;

  const _DefaultPlaceholder({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.surfaceLight,
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.grey50,
          ),
        ),
      ),
    );
  }
}

class _DefaultError extends StatelessWidget {
  final double? width;
  final double? height;

  const _DefaultError({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.surfaceLight,
      child: const Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: AppColors.grey50,
          size: 24,
        ),
      ),
    );
  }
}
