import 'package:space_pics/domain/entities/pic_of_day.dart';

class PicOfDayModel {
  final String imgUrl;
  final String title;
  final String date;
  final String explanation;

  PicOfDayModel({
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
}
