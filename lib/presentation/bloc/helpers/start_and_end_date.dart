// Helper class with function that returns the start and end date
// for searches on the API. The value of the end date is based on the
// current date and the start date is based on the value defined at
// data/constants/values.dart .
// Start date must always be earlier/smaller then end date.
import 'package:space_pics/helpers/format_functions.dart';

class StartAndEndDate {
  final String endDate;
  final String startDate;

  StartAndEndDate({required this.startDate, required this.endDate});

  factory StartAndEndDate.fromNow() {
    final DateTime now = DateTime.now();
    final DateTime daysAgoDate =
        daysAgo(now); // Number days is define in constants/values
    final String endDate = fromDateTimeToString(now);
    final String startDate = fromDateTimeToString(
        daysAgoDate); // Number of prior to today's date (aka endDate)

    return StartAndEndDate(startDate: startDate, endDate: endDate);
  }
}
