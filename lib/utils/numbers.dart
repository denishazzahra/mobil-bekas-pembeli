import 'package:intl/intl.dart';

String formatCurrency(int amount) {
  var formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
  return formatter.format(amount);
}

String formatNumberDecimal(double number, String currency, bool showCurrency) {
  String formattedNumber = NumberFormat('#,##0.00').format(number);
  if (showCurrency) {
    return '$currency $formattedNumber';
  }
  return formattedNumber;
}
