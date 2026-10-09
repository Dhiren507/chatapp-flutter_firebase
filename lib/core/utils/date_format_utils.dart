import 'package:intl/intl.dart';

class DateFormatUtils {
  static String formatToMsgTimestamp(DateTime timestamp) {
    return DateFormat('h:mm a').format(timestamp).toString();
  }

  static String getChatDayLabel(DateTime timestamp) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final chatDate = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (chatDate == today) {
      return 'Today';
    } else if (chatDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d, yyyy').format(timestamp);
    }
  }

  static String calculateTimeAgo(DateTime dateTime) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      if (difference.inMinutes <= 0) {
        return 'just now';
      }
      return difference.inMinutes == 1 ? '1 minute ago' : '${difference.inMinutes} minutes ago';
    }

    if (difference.inHours < 24) {
      final today = DateTime(now.year, now.month, now.day);
      final messageDay = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (messageDay == today) {
        return difference.inHours == 1 ? '1 hour ago' : '${difference.inHours} hours ago';
      }
    }

    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final messageDay = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (messageDay == yesterday) {
      return 'yesterday';
    }

    final String day = dateTime.day.toString().padLeft(2, '0');
    final String month = dateTime.month.toString().padLeft(2, '0');
    final String year = dateTime.year.toString();

    return '$day/$month/$year';
  }
}
