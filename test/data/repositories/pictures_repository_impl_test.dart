import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:space_pics/data/repositories/pictures_repository_impl.dart';

import '../../helpers/sample_data.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockNasaDataSource mockNasaDataSource;
  late MockLocalJsonDataSource mockLocalJsonDataSource;
  late MockOfflineDataSource mockOfflineDataSource;
  late PicturesRepositoryImpl repo;

  setUp(() {
    mockNasaDataSource = MockNasaDataSource();
    mockLocalJsonDataSource = MockLocalJsonDataSource();
    mockOfflineDataSource = MockOfflineDataSource();
    repo = PicturesRepositoryImpl(
        nasaDataSource: mockNasaDataSource,
        localJsonDataSource: mockLocalJsonDataSource,
        offlineDataSource: mockOfflineDataSource);
  });

  const testPicOfDayModel = samplePicOfDayModel;
  const testPicOfDay = samplePicOfDay;
  const testStartDate = sampleStartDate;
  const testEndDate = sampleEndDate;
  const testKeyword = 'metheor';

  test(
      'should return correct PicOfDay entity when call to NasaDataSource is successful',
      () async {
    when(mockNasaDataSource.getNasaPictures(
            startDate: testStartDate, endDate: testEndDate))
        .thenAnswer((_) async => [testPicOfDayModel]);

    final result = await repo.getPictures(
        startDate: testStartDate, endDate: testEndDate, offline: false);

    verify(mockNasaDataSource.getNasaPictures(
        startDate: testStartDate, endDate: testEndDate));
    expect(result, [testPicOfDay]);
  });

  test(
      'should return correct PicOfDay entity when call to OfflineDataSource is successful',
      () async {
    when(mockOfflineDataSource.getOfflineData())
        .thenAnswer((_) async => [testPicOfDayModel]);

    final result = await repo.getPictures(offline: true);

    verify(mockOfflineDataSource.getOfflineData());
    expect(result, [testPicOfDay]);
  });

  test(
      'should return correct PicOfDay entity when call to LocalDataSource is successful',
      () async {
    when(mockLocalJsonDataSource.getLocalData(keyword: testKeyword))
        .thenAnswer((_) async => [testPicOfDayModel]);

    final result = await repo.getPictures(keyword: testKeyword, offline: false);

    verify(mockLocalJsonDataSource.getLocalData(keyword: testKeyword));
    expect(result, [testPicOfDay]);
  });
}
