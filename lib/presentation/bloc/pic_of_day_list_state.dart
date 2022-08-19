import 'package:equatable/equatable.dart';

import '../../domain/entities/pic_of_day.dart';

abstract class PicOfDayListState extends Equatable {
  const PicOfDayListState();

  @override
  List<Object?> get props => [];
}

class PicOfDayListInitial extends PicOfDayListState {}

class PicOfDayListLoading extends PicOfDayListState {}

class PicOfDayListInitialOffline extends PicOfDayListState {}

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

class PicOfDayListHasDataOffline extends PicOfDayListState {
  final List<PicOfDay> picOfDayList;

  PicOfDayListHasDataOffline({required this.picOfDayList});

  @override
  List<Object?> get props => picOfDayList;
}
