import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hsse/api/services/auth_service.dart';
import 'package:hsse/providers/auth.dart';
import 'package:hsse/screen/landing/landing.dart';
import 'package:hsse/singleton/shared_pref.dart';
import 'package:provider/provider.dart';

import 'package:hsse/config/theme_color.dart';
import 'package:hsse/providers/violation.dart';
import 'package:hsse/router/routes.dart';

// API V
// Shared Preference V
// provider login v
// Login Page v
// Provider
// Firebase
// ...

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
  // final ViolService _violService = ViolService();
  // final RulesService _rulesService = RulesService();
  // final TruckService _truckService = TruckService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ViolationProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider(_authService)),
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
