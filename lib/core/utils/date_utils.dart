import 'package:intl/intl.dart';

String formatToMsgTimestamp(DateTime timestamp) {
  return DateFormat('h:mm a').format(timestamp).toString();
}

String getChatDayLabel(DateTime timestamp) {
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
