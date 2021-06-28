import 'package:flutter/material.dart';
import 'package:hsse/screen/home_hsse/home_screen.dart';
import 'package:hsse/screen/login/login_screen.dart';
import 'package:hsse/screen/violation/history_screen.dart';
import 'package:hsse/screen/violation/viol_detail.dart';

class RouteGenerator {
  static const String homeHsse = '/home';
  static const String login = '/login';
  static const String detail = '/detail';
  static const String history = '/history';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case homeHsse:
        return MaterialPageRoute(builder: (_) => HomeHsseScreen());
      case history:
        return MaterialPageRoute(builder: (_) => HistoryScreen());
      case detail:
        return MaterialPageRoute(builder: (_) => ViolDetailScreen());
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
