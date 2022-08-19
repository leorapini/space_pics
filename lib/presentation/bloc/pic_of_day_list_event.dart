import 'package:equatable/equatable.dart';

abstract class PicOfDayListEvent extends Equatable {
  const PicOfDayListEvent();

  @override
  List<Object?> get props => [];
}

class OnInitialState extends PicOfDayListEvent {

  OnInitialState();

  @override
  List<Object?> get props => [];
}

class OnInitialStateOffline extends PicOfDayListEvent {
  OnInitialStateOffline();

  @override
  List<Object?> get props => [];
}

class OnSearchSubmitted extends PicOfDayListEvent {
  final String value;

  OnSearchSubmitted({
    required this.value,
  });

  @override
  List<Object?> get props => [value];
}

class OnSearchSubmittedOffline extends PicOfDayListEvent {
  final String value;

  OnSearchSubmittedOffline({
    required this.value,
  });

  @override
  List<Object?> get props => [value];
}
