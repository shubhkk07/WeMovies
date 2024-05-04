import 'package:intl/intl.dart';
import 'package:movieapp/extensions/int.dart';

extension FormatDate on DateTime {
  String convertDateTime() {
    String date = day.toOrdinal();
    DateFormat dateFormat = DateFormat('MMM, yyyy');
    return "$date ${dateFormat.format(this)}".toUpperCase();
  }
}
