import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:space_pics/domain/usecases/get_pictures.dart';
import 'package:space_pics/presentation/bloc/pic_of_day_list_bloc.dart';
import 'package:space_pics/presentation/bloc/pic_of_day_list_event.dart';
import 'package:space_pics/presentation/bloc/pic_of_day_list_state.dart';

import '../../helpers/sample_data.dart';
import 'pic_of_day_list_bloc_test.mocks.dart';

@GenerateMocks([GetPictures])
void main() {
  late MockGetPictures mockGetPictures;
  late PicOfDayListBloc picOfDayListBloc;

  setUp(() {
    mockGetPictures = MockGetPictures();
    picOfDayListBloc = PicOfDayListBloc(mockGetPictures);
  });

  const testPicOfDay = samplePicOfDay;
  const testStartDate = sampleStartDate;
  const testEndDate = sampleEndDate;
  const testKeyword = sampleKeyword;

  test('initial state should be empty', () {
    expect(picOfDayListBloc.state, PicOfDayListInitial());
  });

  blocTest<PicOfDayListBloc, PicOfDayListState>(
      '(ONLINE) should emit loading and has data when successful search by date',
      build: () {
        when(mockGetPictures.execute(
                startDate: testStartDate, endDate: testEndDate, offline: false))
            .thenAnswer((_) async => [testPicOfDay]);
        return picOfDayListBloc;
      },
      act: (bloc) => bloc.add(OnSearchSubmitted(value: testStartDate)),
      wait: const Duration(microseconds: 100),
      expect: () => [
            PicOfDayListLoading(),
            PicOfDayListHasData(picOfDayList: [testPicOfDay]),
          ],
      verify: (bloc) {
        verify(mockGetPictures.execute(
            startDate: testStartDate, endDate: testStartDate, offline: false));
      });

  blocTest<PicOfDayListBloc, PicOfDayListState>(
      '(ONLINE) should emit loading and has data when successful search by keyword',
      build: () {
        when(mockGetPictures.execute(keyword: testKeyword, offline: false))
            .thenAnswer((_) async => [testPicOfDay]);
        return picOfDayListBloc;
      },
      act: (bloc) => bloc.add(OnSearchSubmitted(value: testKeyword)),
      wait: const Duration(microseconds: 100),
      expect: () => [
            PicOfDayListLoading(),
            PicOfDayListHasData(picOfDayList: [testPicOfDay]),
          ],
      verify: (bloc) {
        verify(mockGetPictures.execute(keyword: testKeyword, offline: false));
      });

  // Restricted to dates between 2022-06-01 and 2022-08-18
  blocTest<PicOfDayListBloc, PicOfDayListState>(
      '(OFFLINE) should emit loading and has data when successful search by date',
      build: () {
        when(mockGetPictures.execute(
                startDate: testStartDate, endDate: testEndDate, offline: true))
            .thenAnswer((_) async => [testPicOfDay]);
        return picOfDayListBloc;
      },
      act: (bloc) => bloc.add(OnSearchSubmittedOffline(value: testStartDate)),
      wait: const Duration(microseconds: 100),
      expect: () => [
            PicOfDayListLoading(),
            PicOfDayListHasDataOffline(picOfDayList: [testPicOfDay]),
          ],
      verify: (bloc) {
        verify(mockGetPictures.execute(
            startDate: testStartDate, endDate: testStartDate, offline: true));
      });

  blocTest<PicOfDayListBloc, PicOfDayListState>(
      '(OFFLINE) should emit loading and has data when successful search by keyword',
      build: () {
        when(mockGetPictures.execute(keyword: testKeyword, offline: true))
            .thenAnswer((_) async => [testPicOfDay]);
        return picOfDayListBloc;
      },
      act: (bloc) => bloc.add(OnSearchSubmittedOffline(value: testKeyword)),
      wait: const Duration(microseconds: 100),
      expect: () => [
            PicOfDayListLoading(),
            PicOfDayListHasDataOffline(picOfDayList: [testPicOfDay]),
          ],
      verify: (bloc) {
        verify(mockGetPictures.execute(keyword: testKeyword, offline: true));
      });
}
