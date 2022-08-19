import 'package:flutter/material.dart';

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
      required bool offline}) async {
    List result = [];

    // Get offline pictures (stored locally)
    if (offline == true) {
      try {
        if (keyword != null) {
          result = await offlineDataSource.getOfflineData(keyword: keyword);
        } else {
          result = await offlineDataSource.getOfflineData();
        }
      } catch (e) {
        debugPrint('error: $e');
        throw ServerError();
      }
      // Get pictures from NASA if searched by date or from local json if searched by keyword
    } else {
      try {
        if (keyword != null) {
          result = await localDataSource.getLocalData(keyword: keyword);
        } else if (startDate != null && endDate != null) {
          result = await nasaDataSource.getNasaPictures(
              startDate: startDate, endDate: endDate);
        }
      } catch (e) {
        debugPrint('error: $e');
        throw ServerError();
      }
    }

    final List<PicOfDay> entityList =
        List<PicOfDay>.from(result.map((model) => model.toEntity()));

    return entityList;
  }
}
