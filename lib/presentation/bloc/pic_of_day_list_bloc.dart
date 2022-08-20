import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_pictures.dart';
import '../../helpers/errors.dart';
import '../../helpers/format_functions.dart';
import 'helpers/start_and_end_date.dart';
import 'pic_of_day_list_event.dart';
import 'pic_of_day_list_state.dart';

class PicOfDayListBloc extends Bloc<PicOfDayListEvent, PicOfDayListState> {
  final GetPictures _getPictures;

  PicOfDayListBloc(this._getPictures) : super(PicOfDayListInitial()) {
    // Initial state getting the last 30 days worth of Pictures of the Day directly from NASA's API
    // The number of days (pictures) is defined at data/constantants/values.dart
    on<OnInitialState>((event, emit) async {
      final StartAndEndDate dates = StartAndEndDate.fromNow();
      emit(PicOfDayListLoading());
      try {
        final result = await _getPictures.execute(
            startDate: dates.startDate, endDate: dates.endDate, offline: false);
        final reversedResult = result.reversed.toList();
        emit(PicOfDayListHasData(picOfDayList: reversedResult));
      } catch (e) {
        emit(const PicOfDayListError());
        throw ServerError();
      }
    });

    // State set once search request is submitted. Arguments can be keywords or a specific date.
    // If argument is a valid date, the request is sent to NASA's API. If the argument is a
    // keyword, the search is done locally from a json file that has been downloaded
    // from NASA's API. The actual image is still downloaded from NASA.
    on<OnSearchSubmitted>((event, emit) async {
      final String value = event.value;
      final bool searchByDate = isDateValid(value);

      emit(PicOfDayListLoading());

      // Search by date from NASA datasource
      if (searchByDate) {
        try {
          final result = await _getPictures.execute(
              startDate: value, endDate: value, offline: false);
          emit(PicOfDayListHasData(picOfDayList: result));
        } catch (e) {
          emit(const PicOfDayListError());
          throw ServerError();
        }
        // Search by keyword from local json
      } else {
        try {
          final result =
              await _getPictures.execute(keyword: value, offline: false);
          final reversedResult = result.reversed.toList();
          emit(PicOfDayListHasData(picOfDayList: reversedResult));
        } catch (e) {
          emit(const PicOfDayListError());
          throw LocalError();
        }
      }
    });

    // Offline state that loads pre-loaded images and data (title, date and explation)
    // from a local json file.
    on<OnInitialStateOffline>((event, emit) async {
      emit(PicOfDayListLoading());
      try {
        final result = await _getPictures.execute(offline: true);
        final reversedResult = result.reversed.toList();
        emit(PicOfDayListHasDataOffline(picOfDayList: reversedResult));
      } catch (e) {
        emit(const PicOfDayListError());
        throw LocalError();
      }
    });

    // Offline search state that searches by keyword and date.
    on<OnSearchSubmittedOffline>((event, emit) async {
      final value = event.value;
      final bool searchByDate = isDateValid(value);

      emit(PicOfDayListLoading());

      // Searching by date (offline mode)
      if (searchByDate) {
        try {
          final result = await _getPictures.execute(
              startDate: value, endDate: value, offline: true);
          emit(PicOfDayListHasData(picOfDayList: result));
        } catch (e) {
          emit(const PicOfDayListError());
          throw LocalError();
        }
        // Searching by keyword (offline mode)
      } else {
        try {
          final result =
              await _getPictures.execute(keyword: value, offline: true);
          final reversedResult = result.reversed.toList();
          emit(PicOfDayListHasDataOffline(picOfDayList: reversedResult));
        } catch (e) {
          emit(const PicOfDayListError());
          throw LocalError();
        }
      }
    });
  }
}
