import 'package:mockito/annotations.dart';
import 'package:space_pics/data/datasources/local_json_datasource.dart';
import 'package:space_pics/data/datasources/nasa_datasource.dart';
import 'package:space_pics/data/datasources/offline_datasource.dart';
import 'package:space_pics/domain/repositories/pictures_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  PicturesRepository,
  NasaDataSource,
  LocalJsonDataSource,
  OfflineDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
