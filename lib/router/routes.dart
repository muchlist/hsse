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
  RouteGenerator._();

  static const String homeHsse = '/home';
  static const String login = '/login';
  static const String detail = '/detail';
  static const String addViol = '/add-viol';
  static const String editViol = '/edit-viol';
  static const String history = '/history';
  static const String rules = '/rules';
  static const String addRules = '/add-rules';
  static const String editRules = '/edit-rules';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute<LoginScreen>(builder: (_) => LoginScreen());
      case homeHsse:
        return MaterialPageRoute<HomeHsseScreen>(
            builder: (_) => const HomeHsseScreen());
      case history:
        return MaterialPageRoute<HistoryScreen>(
            builder: (_) => const HistoryScreen());
      case detail:
        return MaterialPageRoute<ViolDetailScreen>(
            builder: (_) => const ViolDetailScreen());
      case addViol:
        return MaterialPageRoute<AddViolScreen>(
            builder: (_) => AddViolScreen());
      case editViol:
        return MaterialPageRoute<EditViolScreen>(
            builder: (_) => EditViolScreen());
      case rules:
        return MaterialPageRoute<RulesScreen>(
            builder: (_) => const RulesScreen());
      case addRules:
        return MaterialPageRoute<AddRulesScreen>(
            builder: (_) => AddRulesScreen());
      case editRules:
        return MaterialPageRoute<EditRulesScreen>(
            builder: (_) => EditRulesScreen());
      default:
        return MaterialPageRoute<LoginScreen>(builder: (_) => LoginScreen());
    }
  }
}

class RouteException implements Exception {
  const RouteException(this.message);
  final String message;
}
