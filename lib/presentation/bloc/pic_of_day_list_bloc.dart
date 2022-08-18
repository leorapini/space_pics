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
      final String endDate = fromDateTimeToString(now);
      final DateTime tenDaysAgoDate = tenDaysAgo(now);
      final String startDate = fromDateTimeToString(tenDaysAgoDate); // 10 days prior to today's date (aka endDate)

      emit(PicOfDayListLoading());

      try {
        final result =
            await _getPictures.execute(startDate: startDate, endDate: endDate);
        final reversedResult = result.reversed.toList();
        emit(PicOfDayListHasData(picOfDayList: reversedResult));
      } catch (e) {
        throw ServerError();
      }
    });

    on<OnDateChanged>((event, emit) async {
      final startDate = event.startDate;
      final endDate = event.endDate;

      emit(PicOfDayListLoading());

      try {
        final result =
            await _getPictures.execute(startDate: startDate, endDate: endDate);
        emit(PicOfDayListHasData(picOfDayList: result));
      } catch (e) {
        throw ServerError();
      }
    });
  }
}
