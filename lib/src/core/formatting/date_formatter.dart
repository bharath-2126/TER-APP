import 'package:intl/intl.dart';

abstract class AppDateFormatter {
  /// Formats transaction timestamps like "Today • 10:45 AM", "Yesterday • 8:20 PM", or "Oct 28 • 12:00 PM"
  static String formatTransactionTimestamp(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final txDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final timeStr = DateFormat('h:mm a').format(dateTime);

    if (txDate == today) {
      return 'Today • $timeStr';
    } else if (txDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday • $timeStr';
    } else {
      final dateStr = DateFormat('MMM d').format(dateTime);
      return '$dateStr • $timeStr';
    }
  }

  /// Formats date for statistics hero card: "November • 24,Wed • 2025"
  static String formatStatisticsHero(DateTime dateTime) {
    final monthStr = DateFormat('MMMM').format(dateTime);
    final dayOfWeek = DateFormat('d,E').format(dateTime);
    final year = dateTime.year.toString();
    return '$monthStr • $dayOfWeek • $year';
  }
}
