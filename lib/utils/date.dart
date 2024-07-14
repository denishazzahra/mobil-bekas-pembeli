import 'package:intl/intl.dart';

String formattedFlightDate(DateTime date) {
  return DateFormat('E, MMM d yyyy').format(date);
}

String formattedSearchDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

DateTime parseDate(String date) {
  return DateFormat('yyyy-MM-dd').parse(date);
}
