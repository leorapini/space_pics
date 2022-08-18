import 'package:equatable/equatable.dart';

abstract class PicOfDayListEvent extends Equatable {
  const PicOfDayListEvent();

  @override
  List<Object?> get props => [];
}

class OnInitialState extends PicOfDayListEvent {
  final String startDate;
  final String endDate;

  OnInitialState({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}

class OnDateChanged extends PicOfDayListEvent {
  final String startDate;
  final String endDate;

  OnDateChanged({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}
