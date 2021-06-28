import 'package:flutter/material.dart';
import 'package:hsse/singleton/shared_pref.dart';

import '../../router/routes.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _token = "";

  _loadToken() async {
    _token = SharedPrefs().getToken() ?? "";
    if (_token == "") {
      await Future(() {
        Navigator.pushReplacementNamed(context, RouteGenerator.login);
      });
    } else {
      await Future(() {
        Navigator.pushReplacementNamed(context, RouteGenerator.homeHsse);
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
    return Scaffold(
      body: const Center(child: Text(". . .")),
    );
  }
}