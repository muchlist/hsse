import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import 'package:provider/single_child_widget.dart';

import 'api/services/truck_service.dart';
import 'api/services/viol_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print("Handling a background message: ${message.messageId}");
}

// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init SharedPrefs
  await SharedPrefs().init();

  // init firebase
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'risa2', // id
      'risa notification', // title
      'channel untuk menampilkan notif risa', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // add font licensi
  LicenseRegistry.addLicense(() async* {
    final String license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(<String>['google_fonts'], license);
  });

  // Set notification bar tot transfarent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'HSSE';
  final AuthService _authService = const AuthService();
  final ViolService _violService = const ViolService();
  final RulesService _rulesService = const RulesService();
  final TruckService _truckService = const TruckService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<ViolProvider>(
            create: (BuildContext context) => ViolProvider(_violService)),
        ChangeNotifierProvider<AuthProvider>(
            create: (BuildContext context) => AuthProvider(_authService)),
        ChangeNotifierProvider<RulesProvider>(
            create: (BuildContext context) => RulesProvider(_rulesService)),
        ChangeNotifierProvider<TruckProvider>(
            create: (BuildContext context) => TruckProvider(_truckService)),
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
