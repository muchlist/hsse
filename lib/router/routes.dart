import 'package:flutter/material.dart';
import '../screen/detail.dart';
import '../screen/home.dart';

class RouteGenerator {
  static const String home = '/home';
  static const String detail = '/detail';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case detail:
        return MaterialPageRoute(builder: (_) => DetailScreen());

      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
