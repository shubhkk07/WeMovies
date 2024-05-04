import 'package:intl/intl.dart';

extension ConvertNumber on int {
  String covertInKM() {
    final formatter = NumberFormat.compact(locale: "en_US", explicitSign: false);
    return formatter.format(this);
  }

  String toOrdinal() {
    if (this < 0) throw Exception('Invalid Number');

    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }
}
