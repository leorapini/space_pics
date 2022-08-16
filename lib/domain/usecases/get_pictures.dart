import 'package:space_pics/domain/entities/pic_of_day.dart';
import 'package:space_pics/domain/repositories/pictures_repository.dart';

class GetPictures {
  final PicturesRepository repo;

  GetPictures({required this.repo});

  Future<List<PicOfDay>> execute(
      {required String startDate, required String endDate}) {
    return repo.getPictures(startDate: startDate, endDate: endDate);
  }
}
