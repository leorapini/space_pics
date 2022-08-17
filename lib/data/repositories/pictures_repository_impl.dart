import 'package:space_pics/data/datasources/nasa_datasource.dart';
import 'package:space_pics/data/models/pic_of_day_model.dart';
import 'package:space_pics/domain/entities/pic_of_day.dart';
import 'package:space_pics/domain/repositories/pictures_repository.dart';
import 'package:space_pics/helpers/errors.dart';

class PicturesRepositoryImpl implements PicturesRepository {
  final NasaDataSource nasaDataSource;

  PicturesRepositoryImpl({required this.nasaDataSource});

  @override
  Future<List<PicOfDay>> getPictures(
      {required String startDate, required String endDate}) async {
    try {
      final result = await nasaDataSource.getNasaPictures(
          startDate: startDate, endDate: endDate);
      final List<PicOfDay> entityList =
          List<PicOfDay>.from(result.map((model) => model.toEntity()));
      return entityList;
    } on ServerError {
      throw ServerError();
    }
  }
}
