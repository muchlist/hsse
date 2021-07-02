import 'package:flutter/material.dart';
import 'package:hsse/screen/home_hsse/home_screen.dart';
import 'package:hsse/screen/login/login_screen.dart';
import 'package:hsse/screen/rule/add_rule_screen.dart';
import 'package:hsse/screen/rule/edit_rule_screen.dart';
import 'package:hsse/screen/rule/rules_screen.dart';
import 'package:hsse/screen/violation/add_viol_screen.dart';
import 'package:hsse/screen/violation/edit_viol_screen.dart';
import 'package:hsse/screen/violation/history_screen.dart';
import 'package:hsse/screen/violation/detail_viol_screen.dart';

class RouteGenerator {
  static const String homeHsse = '/home';
  static const String login = '/login';
  static const String detail = '/detail';
  static const String addViol = '/add-viol';
  static const String editViol = '/edit-viol';
  static const String history = '/history';
  static const String rules = '/rules';
  static const String addRules = '/add-rules';
  static const String editRules = '/edit-rules';

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
      case addViol:
        return MaterialPageRoute(builder: (_) => AddViolScreen());
      case editViol:
        return MaterialPageRoute(builder: (_) => EditViolScreen());
      case rules:
        return MaterialPageRoute(builder: (_) => RulesScreen());
      case addRules:
        return MaterialPageRoute(builder: (_) => AddRulesScreen());
      case editRules:
        return MaterialPageRoute(builder: (_) => EditRulesScreen());
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
