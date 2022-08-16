import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:space_pics/data/models/pic_of_day_model.dart';
import 'package:space_pics/domain/entities/pic_of_day.dart';

void main() {
  final testPicOfDayModel = PicOfDayModel(
    imgUrl: "https://apod.nasa.gov/apod/image/2208/MeteorWind_Larnaout_960.jpg",
    title: "A Meteor Wind over Tunisia",
    date: "2022-08-16",
    explanation:
        "Does the Earth ever pass through a wind of meteors? Yes, and they are frequently visible as meteor showers. Almost all meteors are sand-sized debris that escaped from a Sun-orbiting comet or asteroid, debris that continues in an elongated orbit around the Sun. Circling the same Sun, our Earth can move through an orbiting debris stream, where it can appear, over time, as a meteor wind. Their streaks, though, can all be traced back to a single point on the sky called the radiant.  The featured image composite was taken over two days in late July near the ancient Berber village Zriba El Alia in Tunisia, during the peak of the Southern Delta Aquariids meteor shower. The radiant is to the right of the image. A few days ago our Earth experienced the peak of a more famous meteor wind -- the Perseids.",
  );

  final testPicOfDay = PicOfDay(
    imgUrl: "https://apod.nasa.gov/apod/image/2208/MeteorWind_Larnaout_960.jpg",
    title: "A Meteor Wind over Tunisia",
    date: "2022-08-16",
    explanation:
        "Does the Earth ever pass through a wind of meteors? Yes, and they are frequently visible as meteor showers. Almost all meteors are sand-sized debris that escaped from a Sun-orbiting comet or asteroid, debris that continues in an elongated orbit around the Sun. Circling the same Sun, our Earth can move through an orbiting debris stream, where it can appear, over time, as a meteor wind. Their streaks, though, can all be traced back to a single point on the sky called the radiant.  The featured image composite was taken over two days in late July near the ancient Berber village Zriba El Alia in Tunisia, during the peak of the Southern Delta Aquariids meteor shower. The radiant is to the right of the image. A few days ago our Earth experienced the peak of a more famous meteor wind -- the Perseids.",
  );

  const jsonData =
      '{ "copyright": "Makrem Larnaout", "date": "2022-08-16", "explanation": "Does the Earth ever pass through a wind of meteors? Yes, and they are frequently visible as meteor showers. Almost all meteors are sand-sized debris that escaped from a Sun-orbiting comet or asteroid, debris that continues in an elongated orbit around the Sun. Circling the same Sun, our Earth can move through an orbiting debris stream, where it can appear, over time, as a meteor wind. Their streaks, though, can all be traced back to a single point on the sky called the radiant.  The featured image composite was taken over two days in late July near the ancient Berber village Zriba El Alia in Tunisia, during the peak of the Southern Delta Aquariids meteor shower. The radiant is to the right of the image. A few days ago our Earth experienced the peak of a more famous meteor wind -- the Perseids.", "hdurl": "https://apod.nasa.gov/apod/image/2208/MeteorWind_Larnaout_2048.jpg","media_type": "image","service_version": "v1","title": "A Meteor Wind over Tunisia","url": "https://apod.nasa.gov/apod/image/2208/MeteorWind_Larnaout_960.jpg"}';

  test('should return PicOfDayModel from json', () {
    final Map<String, dynamic> mapFromJson = jsonDecode(jsonData);

    final result = PicOfDayModel.fromJson(mapFromJson);

    expect(result.date, equals(testPicOfDayModel.date));
    expect(result.explanation, equals(testPicOfDayModel.explanation));
    expect(result.imgUrl, equals(testPicOfDayModel.imgUrl));
    expect(result.title, equals(testPicOfDayModel.title));
    expect(result.toString(), equals(testPicOfDayModel.toString()));
  });

  test('should return PicOfDay entity from Model', () {
    final result = testPicOfDayModel.toEntity();

    expect(result.date, equals(testPicOfDay.date));
    expect(result.explanation, equals(testPicOfDay.explanation));
    expect(result.imgUrl, equals(testPicOfDay.imgUrl));
    expect(result.title, equals(testPicOfDay.title));
    expect(result.toString(), equals(testPicOfDay.toString()));
  });
}
