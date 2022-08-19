import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/local_json_datasource.dart';
import 'data/datasources/nasa_datasource.dart';
import 'data/datasources/offline_datasource.dart';
import 'data/repositories/pictures_repository_impl.dart';
import 'domain/repositories/pictures_repository.dart';
import 'domain/usecases/get_pictures.dart';
import 'presentation/bloc/pic_of_day_list_bloc.dart';

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
      localJsonDataSource: locator(),
      offlineDataSource: locator(),
    ),
  );

  // Data Sources
  locator.registerLazySingleton<NasaDataSource>(
    () => NasaDataSourceImpl(
      httpClient: locator(),
    ),
  );
  locator.registerLazySingleton<LocalJsonDataSource>(
    () => LocalJsonDataSourceImpl(),
  );
  locator.registerLazySingleton<OfflineDataSource>(
    () => OfflineDataSourceImpl(),
  );

  // Http
  locator.registerLazySingleton(() => http.Client());
}
