import 'package:intl/intl.dart';

// Returns a String with the following for farmat YYYY-MM-DD as per Nasa's Api
String fromDateTimeToString(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formattedDate = formatter.format(date);
  return formattedDate;
}

DateTime tenDaysAgo(DateTime date) {
  final DateTime tenDaysAgo = date.subtract(const Duration(days: 10));
  return tenDaysAgo;
}

bool isDateValid(String value) {
  // add check date after 1995-06-16 and before DateTime.now()
  final result = DateTime.tryParse(value) != null;
  return result;
}
