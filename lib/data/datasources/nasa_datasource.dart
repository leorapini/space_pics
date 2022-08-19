import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/urls_and_paths.dart';
import '../../helpers/errors.dart';
import '../models/pic_of_day_model.dart';

abstract class NasaDataSource {
  Future<List<PicOfDayModel>> getNasaPictures(
      {required String startDate, required String endDate});
}

class NasaDataSourceImpl implements NasaDataSource {
  final http.Client httpClient;

  NasaDataSourceImpl({required this.httpClient});

  @override
  Future<List<PicOfDayModel>> getNasaPictures({required String startDate, required String endDate}) async {
    final nasaRequestUrl = NasaUrl.getUrlByDate(startDate: startDate, endDate: endDate);
    final response = await httpClient.get(Uri.parse(nasaRequestUrl));

    if (response.statusCode == 200) {
      final Iterable result = jsonDecode(response.body);
      final List<PicOfDayModel> listOfPictures = List<PicOfDayModel>.from(result.map((model) => PicOfDayModel.fromJson(model)));
      return listOfPictures;
    } else {
      throw ServerError();
    }
  }
}
