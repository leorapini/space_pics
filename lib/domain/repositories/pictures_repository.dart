import '../entities/pic_of_day.dart';

abstract class PicturesRepository {
  Future<List<PicOfDay>> getPictures({
    String? startDate,
    String? endDate,
    String? keyword,
    required bool offline,
  });
}
