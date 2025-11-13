import 'package:intl/intl.dart';

class DateConverter{

  static String formatDate({DateTime? dateTime, String format = 'MMM dd, yyyy'}) {
    try {
      final dt = dateTime ?? DateTime.now();
      return DateFormat(format).format(dt);
    } catch (e) {
      return dateTime?.toString() ?? '';
    }
  }


  static String formatDateTime({
    DateTime? dateTime,
    String format = 'dd MMM yyyy h:mm a',
  }) {
    try {
      final dt = dateTime ?? DateTime.now();
      return DateFormat(format).format(dt);
    } catch (e) {
      return dateTime?.toString() ?? '';
    }
  }

  static String formatDateRange({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    final start = startDate ?? DateTime.now();
    final end = endDate ?? start;

    final sameMonth = start.month == end.month;
    final sameYear = start.year == end.year;

    // Case 1: Same month and year → "June 15–17, 2025"
    if (sameMonth && sameYear) {
      final month = DateFormat('MMMM').format(start);
      final startDay = DateFormat('d').format(start);
      final endDay = DateFormat('d').format(end);
      // final year = DateFormat('y').format(start);
      // return '$month $startDay–$endDay, $year';
      return '$month $startDay–$endDay';
    }

    // Case 2: Different months, same year → "June 28 – July 2, 2025"
    if (!sameMonth && sameYear) {
      final startText = DateFormat('MMMM d').format(start);
      final endText = DateFormat('MMMM d').format(end);
      return '$startText – $endText';
    }

    // Case 3: Different years → "Dec 30, 2024 – Jan 2, 2025"
    final startText = DateFormat('MMMM d, y').format(start);
    final endText = DateFormat('MMMM d, y').format(end);
    return '$startText – $endText';
  }

}
