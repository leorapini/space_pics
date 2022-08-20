import 'package:equatable/equatable.dart';

abstract class PicOfDayListEvent extends Equatable {
  const PicOfDayListEvent();

  @override
  List<Object?> get props => [];
}

class OnInitialState extends PicOfDayListEvent {
  const OnInitialState();

  @override
  List<Object?> get props => [];
}

class OnSearchSubmitted extends PicOfDayListEvent {
  final String value;
  const OnSearchSubmitted({
    required this.value,
  });

  @override
  List<Object?> get props => [value];
}

class OnInitialStateOffline extends PicOfDayListEvent {
  const OnInitialStateOffline();

  @override
  List<Object?> get props => [];
}

class OnSearchSubmittedOffline extends PicOfDayListEvent {
  final String value;
  const OnSearchSubmittedOffline({
    required this.value,
  });

  @override
  List<Object?> get props => [value];
}
