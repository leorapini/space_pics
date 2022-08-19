import '../../domain/entities/pic_of_day.dart';
import '../../domain/repositories/pictures_repository.dart';
import '../../helpers/errors.dart';
import '../datasources/local_datadource.dart';
import '../datasources/nasa_datasource.dart';
import '../datasources/offline_datasource.dart';

class PicturesRepositoryImpl implements PicturesRepository {
  final NasaDataSource nasaDataSource;
  final LocalDataSource localDataSource;
  final OfflineDataSource offlineDataSource;

  PicturesRepositoryImpl(
      {required this.nasaDataSource,
      required this.localDataSource,
      required this.offlineDataSource});

  @override
  Future<List<PicOfDay>> getPictures(
      {String? startDate,
      String? endDate,
      String? keyword,
      bool? offline}) async {
    try {
      List result;
      if (offline != null || offline == false) {
        if (keyword != null) {
          result = await offlineDataSource.getOfflineData(keyword: keyword);
        } else {
          result = await offlineDataSource.getOfflineData();
        }
        final List<PicOfDay> entityList =
            List<PicOfDay>.from(result.map((model) => model.toEntity()));
        return entityList;
      }
      if (keyword != null) {
        result = await localDataSource.getLocalData(keyword: keyword);
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
