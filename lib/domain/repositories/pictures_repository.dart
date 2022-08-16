import 'package:space_pics/domain/entities/pic_of_day.dart';

abstract class PicturesRepository {
  Future<List<PicOfDay>> getPictures({
    required String startDate,
    required String endDate,
  });
}
