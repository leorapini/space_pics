import 'package:intl/intl.dart';

import '../data/constants/values.dart';

// Returns a String with the following for farmat YYYY-MM-DD as per Nasa's Api
// Nasa API docs https://github.com/nasa/apod-api
String fromDateTimeToString(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formattedDate = formatter.format(date);
  return formattedDate;
}

DateTime daysAgo(DateTime date) {
  final DateTime daysAgo = date.subtract(const Duration(days: numberOfDays));
  return daysAgo;
}

bool isDateValid(String value) {
  final result = DateTime.tryParse(value) != null;
  return result;
}
