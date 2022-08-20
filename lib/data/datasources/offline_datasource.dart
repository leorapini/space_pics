import 'dart:convert';

import 'package:flutter/services.dart';

import '../constants/urls_and_paths.dart';
import '../models/pic_of_day_model.dart';
import 'helpers/is_word_in_string.dart';

abstract class OfflineDataSource {
  Future<List<PicOfDayModel>> getOfflineData({String? keyword});
}

// Local data source (json + pictures) shipped with the app in order to offer
// a good offline experience for the user.
class OfflineDataSourceImpl implements OfflineDataSource {
  @override
  Future<List<PicOfDayModel>> getOfflineData({String? keyword}) async {
    List<PicOfDayModel> result = [];
    final String response =
        await rootBundle.loadString(OfflineDataSourcePath.jsonPath);
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
