import 'dart:convert';

import 'package:flutter/services.dart';

import '../constants/urls_and_paths.dart';
import '../models/pic_of_day_model.dart';

abstract class LocalJsonDataSource {
  Future<List<PicOfDayModel>> getLocalData({String? keyword});
}

// Local json file downloaded from NASA's api compromising the years of 2020 - 2022
// This was done in order to support search by title
class LocalJsonDataSourceImpl implements LocalJsonDataSource {
  @override
  Future<List<PicOfDayModel>> getLocalData({String? keyword}) async {
    List<PicOfDayModel> result = [];

    final String response =
        await rootBundle.loadString(LocalJsonDataSourcePath.jsonPath);
    final Iterable jsonDecoded = jsonDecode(response);
    final List<PicOfDayModel> listOfPictures = List<PicOfDayModel>.from(
        jsonDecoded.map((model) => PicOfDayModel.fromJson(model)));

    if (keyword != null) {
      for (int i = 0; i < listOfPictures.length; i++) {
        if (isWordInString(keyword, listOfPictures[i].title)) {
          result.add(listOfPictures[i]);
        }
      }
    } else {
      result = listOfPictures;
    }

    return result;
  }
}

bool isWordInString(String word, String str) {
  final String lowerCaseWord = word.toLowerCase();
  final String lowerCaseString = str.toLowerCase();
  final bool result = lowerCaseString.contains(lowerCaseWord);
  return result;
}
