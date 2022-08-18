import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:space_pics/data/datasources/nasa_datasource.dart';
import 'package:space_pics/data/repositories/pictures_repository_impl.dart';
import 'package:space_pics/domain/repositories/pictures_repository.dart';
import 'package:space_pics/domain/usecases/get_pictures.dart';
import 'package:space_pics/presentation/bloc/pic_of_day_list_bloc.dart';
import 'presentation/screens/pic_of_day_screen.dart';
import 'locator.dart' as locator;

void main() {
  locator.start();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator.locator<PicOfDayListBloc>()),
        ],
        child: MaterialApp(
          title: 'SpacePics',
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          home: PicOfDayScreen(),
        ));
  }
}
