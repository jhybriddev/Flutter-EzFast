import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezfastnow/src/helpers/custom_trace.dart';
import 'package:ezfastnow/src/helpers/notification_manager.dart';
import 'package:ezfastnow/src/models/User.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../helpers/app_config.dart' as config;

class SplashScreenController extends ControllerMVC with ChangeNotifier {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState> scaffoldKey;
  // final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  SharedPreferences prefs;

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // Should define these variables before the app loaded
    // progress.value = {"Setting": 0, "User": 0};
    progress.value = {"Setting": 0, "User": 59};
  }

  @override
  void initState() {
    super.initState();
    // firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    // configureFirebase(firebaseMessaging);

    // NotificationManger.init(context: context);
    // if (Platform.isIOS) _iosPermission();
    // firebaseMessaging.requestNotificationPermissions();
    // firebaseMessaging.autoInitEnabled();
    // configureFirebase(firebaseMessaging);

    // initSharedPref();
    // settingRepo.setting.addListener(() {
    //   if (settingRepo.setting.value.appName != null &&
    //       settingRepo.setting.value.appName != '' &&
    //       settingRepo.setting.value.mainColor != null) {
    //     progress.value["Setting"] = 41;
    //     progress?.notifyListeners();
    //   }
    // });

    // userRepo.currentUser.addListener(() {
    //   if (userRepo.currentUser.value.auth != null) {
    //     progress.value["User"] = 59;
    //     progress?.notifyListeners();
    //   }
    // });
    // Timer(Duration(seconds: 30), () {
    //   scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //     content: Text(S.of(context).verify_your_internet_connection),
    //   ));
    // });
  }

  _iosPermission() {
    // firebaseMessaging.requestNotificationPermissions(
    //     IosNotificationSettings(sound: true, badge: true, alert: true));
    // firebaseMessaging.onIosSettingsRegistered.listen((
    //     IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
  }

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  // void configureFirebase(FirebaseMessaging _firebaseMessaging) {
  //   try {
  //     _firebaseMessaging.configure(
  //       onMessage: notificationOnMessage,
  //       onLaunch: notificationOnLaunch,
  //       onResume: notificationOnResume,
  //         // onBackgroundMessage: notificationOnBackground,
  //     );
  //
  //     // _firebaseMessaging.configure(
  //     //     onMessage: (Map<String, dynamic> message) async =>
  //     //         NotificationManger.handleNotificationMsg(message),
  //     //     onLaunch: (Map<String, dynamic> message) async =>
  //     //         NotificationManger.handleDataMsg(message['data']),
  //     //     onResume: (Map<String, dynamic> message) async =>
  //     //         NotificationManger.handleDataMsg(message['data']),
  //     //     onBackgroundMessage: (Map<String, dynamic> message) async =>
  //     //         NotificationManger.handleDataMsg(message['data'])
  //     // );
  //   } catch (e) {
  //     print(CustomTrace(StackTrace.current,
  //         message: "-----FCM_configureFirebase1----" + e));
  //     print(CustomTrace(StackTrace.current,
  //         message:
  //         "-----FCM_configureFirebase1----" + 'Error Config Firebase'));
  //   }
  // }

  Future notificationOnResume(Map<String, dynamic> message) async {
    print(CustomTrace(StackTrace.current,
        message: "-----FCM_notificationOnResume1----" + message.toString()));
    print(CustomTrace(StackTrace.current,
        message: "-----FCM_notificationOnResume2----" + message['data']['id']));
    try {
      // if (message['data']['id'] == "orders") {
      settingRepo.navigatorKey.currentState
          .pushReplacementNamed('/Pages', arguments: 0);
      // }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Future notificationOnBackground(Map<String, dynamic> message) async {
    print(CustomTrace(StackTrace.current,
        message: "-----FCM_notificationOnBackground1----" + message.toString()));
    print(CustomTrace(StackTrace.current,
        message: "-----FCM_notificationOnBackground2----" + message['data']['id']));
    try {
      // if (message['data']['id'] == "orders") {
      settingRepo.navigatorKey.currentState
          .pushReplacementNamed('/Pages', arguments: 0);
      // }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Future notificationOnLaunch(Map<String, dynamic> message) async {
    String messageId = await settingRepo.getMessageId();
    print(CustomTrace(StackTrace.current,
        message: "-----FCM_notificationOnLaunch1----" + message.toString()));

    try {
      if (messageId != message['google.message_id']) {
        // if (message['data']['id'] == "orders") {
        await settingRepo.saveMessageId(message['google.message_id']);
        settingRepo.navigatorKey.currentState
            .pushReplacementNamed('/Pages', arguments: 0);
        // }
      }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Future notificationOnMessage(Map<String, dynamic> message) async {
    print(CustomTrace(StackTrace.current,
        message: "-----FCM_notificationOnMessage1----" + message.toString()));

    List<String> savedNotifications;
    int notiCount = 0;
    prefs = await SharedPreferences.getInstance();
    print('--------1---------------');
    savedNotifications = <String>[];
    if (prefs.containsKey('notiList') &&
        prefs.getStringList('notiList') != null)
      savedNotifications = prefs.getStringList('notiList');
    print('--------2---------------' + savedNotifications.length.toString());
    savedNotifications.add(message['notification']['title'] +
        ":\n" +
        message['notification']['body']);
    print('--------3---------------' + savedNotifications.length.toString());
    await prefs.setStringList('notiList', savedNotifications);
    if (prefs.containsKey('notiCount')) notiCount = prefs.getInt('notiCount');
    notiCount++;
    // settingRepo.setting.value.notifyNotiCount.value = notiCount.toString();
    settingRepo.setting.notifyListeners();
    settingRepo.setNotificationsCount(notiCount);

    // showFCMNotificaitonDialog(message);
    // Fluttertoast.showToast(
    //   msg: message['notification']['title'],
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.BOTTOM,
    //   // backgroundColor: Theme
    //   //     .of(context)
    //   //     .backgroundColor,
    //   // textColor: Theme
    //   //     .of(context)
    //   //     .hintColor,
    //   timeInSecForIosWeb: 5,
    // );
  }

  void showFCMNotificaitonDialog(Map<String, dynamic> message) {
    print('--------x---------------');
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 180,
            child: SizedBox.expand(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      message['notification']['title'],
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .merge(TextStyle(fontSize: 16.0)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      message['notification']['body'],
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .merge(TextStyle(fontSize: 16.0)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ButtonTheme(
                          minWidth: 100,
                          child: RaisedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                            padding: EdgeInsets.symmetric(vertical: 14),
                            color: config.Colors().secondColor(1),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0)),
                            child: Text(
                              "S.current.got_it",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}
