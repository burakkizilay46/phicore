import 'package:intl/intl.dart';

/// DateTime yardımcı extension'ları.
extension DateTimeExtensions on DateTime {
  /// "14 Haziran 2025"
  String get formatted => DateFormat('d MMMM yyyy', 'tr_TR').format(this);

  /// "14.06.2025"
  String get shortFormatted => DateFormat('dd.MM.yyyy').format(this);

  /// "14:30"
  String get timeFormatted => DateFormat('HH:mm').format(this);

  /// "14 Haz 2025, 14:30"
  String get fullFormatted =>
      DateFormat('d MMM yyyy, HH:mm', 'tr_TR').format(this);

  /// Bugün mü?
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Dün mü?
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// "3 dakika önce", "2 saat önce" gibi relative zaman.
  String get timeAgo {
    final diff = DateTime.now().difference(this);

    if (diff.inSeconds < 60) return 'Az önce';
    if (diff.inMinutes < 60) return '${diff.inMinutes} dakika önce';
    if (diff.inHours < 24) return '${diff.inHours} saat önce';
    if (diff.inDays < 7) return '${diff.inDays} gün önce';
    return shortFormatted;
  }
}
