import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsse/api/services/auth_service.dart';
import 'package:hsse/api/services/rules_service.dart';
import 'package:hsse/providers/auth.dart';
import 'package:hsse/providers/rules.dart';
import 'package:hsse/providers/truck.dart';
import 'package:hsse/providers/viol.dart';
import 'package:hsse/screen/landing/landing.dart';
import 'package:hsse/singleton/shared_pref.dart';
import 'package:provider/provider.dart';

import 'package:hsse/config/theme_color.dart';
import 'package:hsse/router/routes.dart';

import 'api/services/truck_service.dart';
import 'api/services/viol_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init SharedPrefs
  await SharedPrefs().init();

  // add font licensi
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // Set notification bar tot transfarent
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'HSSE';
  final AuthService _authService = AuthService();
  final ViolService _violService = ViolService();
  final RulesService _rulesService = RulesService();
  final TruckService _truckService = TruckService();
  // final TruckService _truckService = TruckService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ViolProvider(_violService)),
        ChangeNotifierProvider(create: (context) => AuthProvider(_authService)),
        ChangeNotifierProvider(
            create: (context) => RulesProvider(_rulesService)),
        ChangeNotifierProvider(
            create: (context) => TruckProvider(_truckService)),
      ],
      child: MaterialApp(
        title: _title,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: TColor.background,
            ),
            scaffoldBackgroundColor: TColor.background,
            primaryColor: Colors.grey,
            accentColor: TColor.primary,
            iconTheme: const IconThemeData(color: Colors.black),
            fontFamily: GoogleFonts.montserrat().fontFamily,
            textTheme: GoogleFonts.montserratTextTheme()),
        onGenerateRoute: RouteGenerator.generateRoute,
        home: LandingPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
