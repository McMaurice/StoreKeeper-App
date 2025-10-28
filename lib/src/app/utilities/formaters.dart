import 'package:intl/intl.dart';

class AppFormatter {
  //---FORMATS THE AMOUNT TO CURRENCY VALUES---
  static String currency(num amount) {
    final doubleAmount = amount.toDouble();
    final rounded = (doubleAmount * 100).ceilToDouble() / 100;
    final formatter = NumberFormat('#,##0.00', 'en_US'); // always 2 decimals
    return formatter.format(rounded);
  }

  //---FORMATS A WORD TO IT PLURAL---
  static String pluralFormatter(String word, {int count = 1}) {
    if (word.isEmpty) return word;

    if (count == 1) return word;
    final lower = word.toLowerCase();

    if (lower.endsWith('s') ||
        lower.endsWith('x') ||
        lower.endsWith('z') ||
        lower.endsWith('ch') ||
        lower.endsWith('sh')) {
      return '${word}es';
    }
    if (lower.endsWith('y') && !'aeiou'.contains(lower[lower.length - 2])) {
      return '${word.substring(0, word.length - 1)}ies';
    }
    return '${word}s';
  }
}
