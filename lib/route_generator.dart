import 'package:flutter/material.dart';

import 'presentation/screens/detail/details_screen.dart';
import 'presentation/screens/home/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case DetailScreen.routeName:
        if (args is DetailScreenParams) {
          return MaterialPageRoute(builder: (_) => DetailScreen(params: args));
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
