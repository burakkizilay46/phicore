/// String yardımcı extension'ları.
extension StringExtensions on String {
  bool get isEmail => RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(this);

  bool get isPhone => RegExp(r'^\+?[0-9]{10,15}$').hasMatch(this);

  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  String get capitalize =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';

  String get capitalizeWords =>
      split(' ').map((w) => w.capitalize).join(' ');

  String truncate(int maxLength, {String suffix = '...'}) =>
      length <= maxLength ? this : '${substring(0, maxLength)}$suffix';

  String? get nullIfEmpty => isEmpty ? null : this;
}

/// Nullable string extension'ları.
extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
