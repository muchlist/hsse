import 'package:flutter/material.dart';
import 'package:hsse/singleton/shared_pref.dart';

import '../../router/routes.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _token = "";

  Future<void> _loadToken() async {
    _token = SharedPrefs().getToken() ?? "";
    if (_token == "") {
      await Future<void>(() {
        Navigator.pushReplacementNamed(context, RouteGenerator.login);
      });
    } else {
      await Future<void>(() {
        if (SharedPrefs().getRoles().contains("HSSE")) {
          Navigator.pushReplacementNamed(context, RouteGenerator.homeHsse);
        } else {
          Navigator.pushReplacementNamed(context, RouteGenerator.homeSec);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text(". . .")),
    );
  }
}
