import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:space_pics/data/models/pic_of_day_model.dart';

import '../../helpers/sample_data.dart';

void main() {
  const testPicOfDayModel = samplePicOfDayModel;

  const testPicOfDay = samplePicOfDay;

  const jsonData = sampleJsonData;

  

  test('should return PicOfDayModel from json', () {
    final Map<String, dynamic> mapFromJson = jsonDecode(jsonData);

    final result = PicOfDayModel.fromJson(mapFromJson);

    expect(result, equals(testPicOfDayModel));
  });

  test('should return PicOfDay entity from Model', () {
    final result = testPicOfDayModel.toEntity();

    expect(result, equals(testPicOfDay));
  });
}
