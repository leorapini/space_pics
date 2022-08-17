import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_pics/domain/usecases/get_pictures.dart';
import 'package:space_pics/helpers/errors.dart';
import 'package:space_pics/presentation/bloc/pic_of_day_list_event.dart';
import 'package:space_pics/presentation/bloc/pic_of_day_list_state.dart';

class PicOfDayListBloc extends Bloc<PicOfDayListEvent, PicOfDayListState> {
  final GetPictures _getPictures;

  PicOfDayListBloc(this._getPictures) : super(PicOfDayListInitial()) {
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
