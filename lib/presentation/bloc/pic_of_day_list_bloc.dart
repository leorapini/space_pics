import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_pictures.dart';
import '../../helpers/errors.dart';
import '../../helpers/format_functions.dart';
import 'pic_of_day_list_event.dart';
import 'pic_of_day_list_state.dart';

class PicOfDayListBloc extends Bloc<PicOfDayListEvent, PicOfDayListState> {
  final GetPictures _getPictures;

  PicOfDayListBloc(this._getPictures) : super(PicOfDayListInitial()) {
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

// Start date must always be earlier/smaller then end date
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
