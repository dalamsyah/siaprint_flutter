
import 'package:intl/intl.dart';

class FormatDate {
  static String convert() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(now);
  }
}