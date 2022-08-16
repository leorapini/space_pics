import 'dart:convert';

import 'package:space_pics/constants/urls.dart';
import 'package:space_pics/data/models/pic_of_day_model.dart';
import 'package:http/http.dart' as http;

abstract class NasaDataSource {
  Future<List<PicOfDayModel>> getNasaPictures(
      {required String startDate, required String endDate});
}

class NasaDataSourceImpl implements NasaDataSource {
  final http.Client httpClient;

  NasaDataSourceImpl({required this.httpClient});

  @override
  Future<List<PicOfDayModel>> getNasaPictures({required String startDate, required String endDate}) async {
    final response = await httpClient.get(Uri.parse(NasaUrl.getUrlByDate(startDate: startDate, endDate: endDate)));

    if (response.statusCode == 200) {
      final Iterable result = jsonDecode(response.body);
      final List<PicOfDayModel> listOfPictures = List<PicOfDayModel>.from(result.map((model) => PicOfDayModel.fromJson(model)));
      return listOfPictures;
    } else {
      throw Error();
    }
  }
}
