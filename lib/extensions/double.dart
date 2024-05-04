import 'dart:ffi';

import 'package:intl/intl.dart';

extension ConvertNumber on int {
  String covertInKM() {
    final formatter = NumberFormat.compact(locale: "en_US", explicitSign: false);
    return formatter.format(this);
  }
}
