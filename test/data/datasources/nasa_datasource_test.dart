import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:space_pics/constants/urls.dart';
import 'package:space_pics/data/datasources/nasa_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:space_pics/helpers/errors.dart';

import '../../helpers/sample_data.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late NasaDataSourceImpl nasaDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    nasaDataSource = NasaDataSourceImpl(httpClient: mockHttpClient);
  });

  test('Should return list of PicOfDayModel if response code is 200', () async {
    const testStartDate = "2017-07-08";
    const testEndDate = "2017-07-12";
    const testPicOfDayModelList = samplePicOfDayModelList;
    const testResponseBody = sampleJsonDataList;

    when(mockHttpClient.get(Uri.parse(NasaUrl.getUrlByDate(
      startDate: testStartDate,
      endDate: testEndDate,
    )))).thenAnswer((_) async => http.Response(testResponseBody, 200));

    final result = await nasaDataSource.getNasaPictures(
        startDate: testStartDate, endDate: testEndDate);

    expect(result, equals(testPicOfDayModelList));
  });

  test('Should throw Error when response code is NOT 200', () {
    const testStartDate = "2017-07-08";
    const testEndDate = "2017-07-12";
    when(mockHttpClient.get(Uri.parse(NasaUrl.getUrlByDate(
            startDate: testStartDate, endDate: testEndDate))))
        .thenAnswer((_) async => http.Response('Not found', 404));

    final result = nasaDataSource.getNasaPictures(
        startDate: testStartDate, endDate: testEndDate);

    expect(() => result, throwsA(isA<ServerError>()));
  });
}
