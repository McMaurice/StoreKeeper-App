import 'package:intl/intl.dart';

class AppFormatter {
  //---FORMATS THE AMOUNT TO CURRENCY VALUES---
  static String currency(num amount) {
    final formatter = NumberFormat('#,##0.##', 'en_US');
    return formatter.format(amount);
  }
}
