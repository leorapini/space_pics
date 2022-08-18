// Nasa API docs https://github.com/nasa/apod-api
class NasaUrl {
  static const String apiUrl = 'https://api.nasa.gov/planetary/apod';
  static const String apiKey = 'vwEGRVVekBVT8GXSzPpBHdG3GeTJ0DwRdZDcXLec';
  static String getUrlByDate(
          {required String startDate, required String endDate}) =>
      '$apiUrl?api_key=$apiKey&start_date=$startDate&end_date=$endDate';
}
