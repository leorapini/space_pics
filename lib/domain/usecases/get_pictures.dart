import '../entities/pic_of_day.dart';
import '../repositories/pictures_repository.dart';

class GetPictures {
  final PicturesRepository repo;

  GetPictures({required this.repo});

  Future<List<PicOfDay>> execute(
      {String? startDate, String? endDate, String? keyword, bool? offline}) {
    return repo.getPictures(startDate: startDate, endDate: endDate, keyword: keyword, offline: offline);
  }
}
