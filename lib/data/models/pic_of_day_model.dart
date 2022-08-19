import 'package:equatable/equatable.dart';

import '../../domain/entities/pic_of_day.dart';

class PicOfDayModel extends Equatable {
  final String imgUrl;
  final String title;
  final String date;
  final String explanation;

  const PicOfDayModel({
    required this.imgUrl,
    required this.title,
    required this.date,
    required this.explanation,
  });

  // NASA API Docs https://github.com/nasa/apod-api
  factory PicOfDayModel.fromJson(Map<String, dynamic> json) => PicOfDayModel(
        imgUrl: json['url'],
        title: json['title'],
        date: json['date'],
        explanation: json['explanation'],
      );

  PicOfDay toEntity() => PicOfDay(
        imgUrl: imgUrl,
        title: title,
        date: date,
        explanation: explanation,
      );

  @override
  List<Object?> get props => [
        imgUrl,
        title,
        date,
        explanation,
      ];
}
