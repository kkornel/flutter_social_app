import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime dt) {
    Duration diff = DateTime.now().difference(dt);
    int s = diff.inSeconds;

    if (diff.inDays > 30 || diff.inDays < 0) {
      var formatter = new DateFormat('Y-m-d H:j');
      String formatted = formatter.format(dt);
      return formatted;
    } else if (diff.inDays == 1) {
      return 'One day ago';
    } else if (diff.inDays > 1) {
      return '${diff.inDays} days ago';
    } else if (s <= 1) {
      return 'just now';
    } else if (s < 60) {
      return '$s seconds ago';
    } else if (s < 60) {
      return '$s seconds ago';
    } else if (s < 120) {
      return 'one minute ago';
    } else if (s < 3600) {
      return '${diff.inMinutes} minutes ago';
    } else if (s < 7200) {
      return 'one hour ago';
    } else {
      return '${diff.inHours} hours ago';
    }
  }
}
