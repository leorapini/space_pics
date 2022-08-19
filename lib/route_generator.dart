import 'package:flutter/material.dart';
import 'package:space_pics/domain/entities/pic_of_day.dart';

import 'presentation/screens/details/details_screen.dart';
import 'presentation/screens/home/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case DetailsScreen.routeName:
        if (args is DetailsScreenParams) {
          return MaterialPageRoute(builder: (_) => DetailsScreen(params: args));
        } else {
          return _errorRoute('DetailsScreen');
        }

      default:
        return _errorRoute('root');
    }
  }

  static Route<dynamic> _errorRoute(String origin) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('Navigation Error from $origin.'),
        ),
      );
    });
  }
}
