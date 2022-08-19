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
      final DateTime now = DateTime.now();
      final DateTime tenDaysAgoDate = tenDaysAgo(now);
      final String endDate = fromDateTimeToString(now);
      final String startDate = fromDateTimeToString(
          tenDaysAgoDate); // 10 days prior to today's date (aka endDate)

      emit(PicOfDayListLoading());

      try {
        final result =
            await _getPictures.execute(startDate: startDate, endDate: endDate);
        final reversedResult = result.reversed.toList();
        emit(PicOfDayListHasData(picOfDayList: reversedResult));
      } catch (e) {
        emit(PicOfDayListError(errorMessage: 'Whoops! Something went wrong'));
        throw ServerError();
      }
    });

    on<OnInitialStateOffline>((event, emit) async {
      emit(PicOfDayListLoading());

      try {
        final result = await _getPictures.execute(offline: true);
        final reversedResult = result.reversed.toList();
        emit(PicOfDayListHasDataOffline(picOfDayList: reversedResult));
      } catch (e) {
        emit(PicOfDayListError(errorMessage: 'Whoops! Something went wrong'));
        throw ServerError();
      }
    });

    on<OnSearchSubmitted>((event, emit) async {
      final value = event.value;
      var result;

      if (isDateValid(value)) {
        emit(PicOfDayListLoading());

        try {
          result = await _getPictures.execute(startDate: value, endDate: value);
          emit(PicOfDayListHasData(picOfDayList: result));
        } catch (e) {
          emit(PicOfDayListError(errorMessage: 'Whoops! Something went wrong'));
          throw ServerError();
        }
      } else {
        emit(PicOfDayListLoading());

        try {
          result = await _getPictures.execute(keyword: value);
          final reversedResult = result.reversed.toList();
          emit(PicOfDayListHasData(picOfDayList: reversedResult));
        } catch (e) {
          emit(PicOfDayListError(errorMessage: 'Whoops! Something went wrong'));
          throw ServerError();
        }
      }
    });

    on<OnSearchSubmittedOffline>((event, emit) async {
      final value = event.value;
      var result;

      // searching by date
      if (isDateValid(value)) {
        emit(PicOfDayListLoading());

        try {
          result = await _getPictures.execute(
              startDate: value, endDate: value, offline: true);
          emit(PicOfDayListHasData(picOfDayList: result));
        } catch (e) {
          emit(PicOfDayListError(errorMessage: 'Whoops! Something went wrong'));
          throw ServerError();
        }
      
      // searching by keyword
      } else {
        emit(PicOfDayListLoading());

        try {
          result = await _getPictures.execute(keyword: value, offline: true);
          final reversedResult = result.reversed.toList();
          emit(PicOfDayListHasDataOffline(picOfDayList: reversedResult));
        } catch (e) {
          emit(PicOfDayListError(errorMessage: 'Whoops! Something went wrong'));
          throw ServerError();
        }
      }
    });
  }
}
