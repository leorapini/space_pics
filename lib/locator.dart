import 'package:get_it/get_it.dart';
import 'package:space_pics/data/datasources/nasa_datasource.dart';
import 'package:space_pics/data/repositories/pictures_repository_impl.dart';
import 'package:space_pics/domain/repositories/pictures_repository.dart';
import 'package:space_pics/domain/usecases/get_pictures.dart';
import 'package:space_pics/presentation/bloc/pic_of_day_list_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void start() {
  // BLOC
  locator.registerFactory(() => PicOfDayListBloc(locator()));

  // Usecase
  locator.registerLazySingleton(() => GetPictures(repo: locator()));

  // Repository
  locator.registerLazySingleton<PicturesRepository>(
    () => PicturesRepositoryImpl(
      nasaDataSource: locator(),
    ),
  );

  // Data Source
  locator.registerLazySingleton<NasaDataSource>(
    () => NasaDataSourceImpl(
      httpClient: locator(),
    ),
  );

  // Http
  locator.registerLazySingleton(() => http.Client());
}
