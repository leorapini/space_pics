import '../../domain/entities/pic_of_day.dart';
import '../../domain/repositories/pictures_repository.dart';
import '../../helpers/errors.dart';
import '../datasources/nasa_datasource.dart';

class PicturesRepositoryImpl implements PicturesRepository {
  final NasaDataSource nasaDataSource;

  PicturesRepositoryImpl({required this.nasaDataSource});

  @override
  Future<List<PicOfDay>> getPictures(
      {String? startDate, String? endDate, String? keyword}) async {
    try {
      List result;
      if (keyword != null) {
        result = [];
      } else if (startDate != null && endDate != null) {
        result = await nasaDataSource.getNasaPictures(
            startDate: startDate, endDate: endDate);
      } else {
        result = [];
      }
      final List<PicOfDay> entityList =
          List<PicOfDay>.from(result.map((model) => model.toEntity()));
      return entityList;
    } catch (e) {
      throw ServerError();
    }
  }
}
