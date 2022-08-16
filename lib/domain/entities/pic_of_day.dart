import 'package:equatable/equatable.dart';

class PicOfDay extends Equatable {
  final String imgUrl;
  final String title;
  final String date;
  final String explanation;

  const PicOfDay({
    required this.imgUrl,
    required this.title,
    required this.date,
    required this.explanation,
  });

  @override
  List<Object?> get props => [
        imgUrl,
        title,
        date,
        explanation,
      ];
}
