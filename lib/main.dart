
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/helpers/app_config.dart' as config;
import 'src/repository/settings_repository.dart' as settingRepo;
import 'generated/l10n.dart';
import 'route_generator.dart';
import 'src/models/setting.dart';

import 'dart:async';


// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // initFirebase();
    settingRepo.initSettings();
    super.initState();
  }

  initFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ValueListenableBuilder(
        valueListenable: settingRepo.setting,
        builder: (context, Setting _setting, _) {
          return MaterialApp(
              navigatorKey: settingRepo.navigatorKey,
              title: _setting.appName,
              initialRoute: '/Splash',
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
              locale: _setting.mobileLanguage.value,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: _setting.brightness.value == Brightness.light
                  ? ThemeData(
                      fontFamily: 'Rubik',
                      primaryColor: Colors.white,
                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                          elevation: 0, foregroundColor: Colors.white),
                      brightness: Brightness.light,
                      accentColor: config.Colors().mainColor(1),
                      dividerColor: config.Colors().accentColor(0.1),
                      focusColor: config.Colors().accentColor(1),
                      hintColor: config.Colors().secondColor(1),
                      textTheme: TextTheme(
                        headline5: TextStyle(
                            fontSize: 22.0,
                            color: config.Colors().secondColor(1),
                            height: 1.3),
                        headline4: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: config.Colors().secondColor(1),
                            height: 1.1),
                        headline3: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            color: config.Colors().secondColor(1),
                            height: 1.3),
                        headline2: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            color: config.Colors().mainColor(1),
                            height: 1.3),
                        headline1: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.w300,
                            color: config.Colors().secondColor(1),
                            height: 1.4),
                        subtitle1: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: config.Colors().secondColor(1),
                            height: 1.3),
                        headline6: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w700,
                            color: config.Colors().mainColor(1),
                            height: 1.2),
                        bodyText2: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: config.Colors().secondColor(1),
                            height: 1.2),
                        bodyText1: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: config.Colors().secondColor(1),
                            height: 1.2),
                        caption: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            color: config.Colors().accentColor(1),
                            height: 1.2),
                      ),
                    )
                  : ThemeData(
                      fontFamily: 'Rubik',
                      primaryColor: Color(0xFF252525),
                      brightness: Brightness.dark,
                      scaffoldBackgroundColor: Color(0xFF2C2C2C),
                      accentColor: config.Colors().mainDarkColor(1),
                      dividerColor: config.Colors().accentColor(0.1),
                      hintColor: config.Colors().secondDarkColor(1),
                      focusColor: config.Colors().accentDarkColor(1),
                      textTheme: TextTheme(
                        headline5: TextStyle(
                            fontSize: 22.0,
                            color: config.Colors().secondDarkColor(1),
                            height: 1.3),
                        headline4: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: config.Colors().secondDarkColor(1),
                            height: 1.1),
                        headline3: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            color: config.Colors().secondDarkColor(1),
                            height: 1.3),
                        headline2: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            color: config.Colors().mainDarkColor(1),
                            height: 1.3),
                        headline1: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.w300,
                            color: config.Colors().secondDarkColor(1),
                            height: 1.4),
                        subtitle1: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: config.Colors().secondDarkColor(1),
                            height: 1.2),
                        headline6: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w700,
                            color: config.Colors().mainDarkColor(1),
                            height: 1.2),
                        bodyText2: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: config.Colors().secondDarkColor(1),
                            height: 1.2),
                        bodyText1: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: config.Colors().secondDarkColor(1),
                            height: 1.2),
                        caption: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            color: config.Colors().secondDarkColor(0.6),
                            height: 1.2),
                      ),
                    ));
        });
  }
}
