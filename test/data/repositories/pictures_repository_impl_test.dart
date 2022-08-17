import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:space_pics/data/repositories/pictures_repository_impl.dart';

import '../../helpers/sample_data.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockNasaDataSource mockNasaDataSource;
  late PicturesRepositoryImpl repo;

  setUp(() {
    mockNasaDataSource = MockNasaDataSource();
    repo = PicturesRepositoryImpl(nasaDataSource: mockNasaDataSource);
  });

  const testPicOfDayModel = samplePicOfDayModel;
  const testPicOfDay = samplePicOfDay;
  const testStartDate = sampleStartDate;
  const testEndDate = sampleEndDate;

  test('should return correct PicOfDay entity when call to NasaDataSource is successful', () async {
    when(mockNasaDataSource.getNasaPictures(startDate: testStartDate, endDate: testEndDate)).thenAnswer((_) async => [testPicOfDayModel]);

    final result = await repo.getPictures(startDate: testStartDate, endDate: testEndDate);

    verify(mockNasaDataSource.getNasaPictures(startDate: testStartDate, endDate: testEndDate));
    expect(result, [testPicOfDay]);
  });


}