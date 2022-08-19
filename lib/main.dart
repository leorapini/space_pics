import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locator.dart' as locator;
import 'presentation/bloc/pic_of_day_list_bloc.dart';
import 'presentation/screens/home/home_screen.dart';
import 'route_generator.dart';

void main() {
  locator.start();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          onGenerateRoute: RouteGenerator.generateRoute,
          home: const HomeScreen(),
        ));
  }
}
