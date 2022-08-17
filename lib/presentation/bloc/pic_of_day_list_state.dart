import 'package:equatable/equatable.dart';
import 'package:space_pics/domain/entities/pic_of_day.dart';

abstract class PicOfDayListState extends Equatable {
  const PicOfDayListState();

  @override
  List<Object?> get props => [];
}

class PicOfDayListInitial extends PicOfDayListState {}

class PicOfDayListLoading extends PicOfDayListState {}

class PicOfDayListError extends PicOfDayListState {
  final String errorMessage;

  PicOfDayListError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class PicOfDayListHasData extends PicOfDayListState {
  final List<PicOfDay> picOfDayList;

  PicOfDayListHasData({required this.picOfDayList});

  @override
  List<Object?> get props => picOfDayList;
}
