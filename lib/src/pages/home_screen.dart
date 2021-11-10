import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/pages/hsitory_screen.dart';
import 'package:ezfastnow/src/pages/products_screen.dart';
import 'package:ezfastnow/src/pages/settings_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helpers/app_config.dart' as config;

import '../helpers/helper.dart';
import '../models/route_argument.dart';
import 'timer_screen.dart';

import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;

  Widget currentPage;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  HomeScreen({
    Key key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String tabName = "Timer";

  // initState() {
  //   super.initState();
  //   _selectTab(widget.currentTab);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectTab(widget.currentTab);

    // FirebaseMessaging.instance
    //     .getToken()
    //     .then((value) => {print('===tokennn====' + value)});
    //
    // FirebaseMessaging.instance.setAutoInitEnabled(true);
    //
    // FirebaseMessaging.instance.requestPermission(alert: true);
    // FirebaseMessaging.instance.app.setAutomaticDataCollectionEnabled(true);
    //
    // FirebaseMessaging.instance
    //     .getInitialMessage()
    //     .then((RemoteMessage message) {
    //   if (message != null) {
    //     print('===========fcm=====' + message.toString());
    //   }
    // });
    //
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     // flutterLocalNotificationsPlugin.show(
    //     //     notification.hashCode,
    //     //     notification.title,
    //     //     notification.body,
    //     //     NotificationDetails(
    //     //       android: AndroidNotificationDetails(
    //     //         channel.id,
    //     //         channel.name,
    //     //         channel.description,
    //     //         // TODO add a proper drawable resource to android, for now using
    //     //         //      one that already exists in example app.
    //     //         icon: 'launch_background',
    //     //       ),
    //     //     ));
    //   }
    // });
    //
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('===========fcm=====A new onMessageOpenedApp event was published!');
    // });
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage =
              TimerWidget(parentScaffoldKey: widget.scaffoldKey);
          setState(() {
            tabName = S.current.timer;
          });
          break;
        case 1:
          widget.currentPage =
              ProductsWidget(parentScaffoldKey: widget.scaffoldKey);
          setState(() {
            tabName = 'SlimScents';
          });
          break;
        case 2:
          // widget.currentPage =
          //     PresentWidget(parentScaffoldKey: widget.scaffoldKey);
          // setState(() {
          //   tabName = 'Gift';
          // });
          _launchURL('https://flutter.io');
          break;
        case 3:
          widget.currentPage =
              HistoryWidget(parentScaffoldKey: widget.scaffoldKey);
          setState(() {
            tabName = S.current.history;
          });
          break;
        case 4:
          widget.currentPage =
              SettingsWidget(parentScaffoldKey: widget.scaffoldKey);
          setState(() {
            tabName = S.current.settings;
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: widget.scaffoldKey,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 1,
                  left: 2,
                  right: 2,
                  bottom: 1),
              child: Stack(
                children: [
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      tabName,
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.headline4.merge(
                          TextStyle(
                              color: config.Colors().textColor(),
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text(
                        '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.bodyText2.merge(
                            TextStyle(
                                color: config.Colors().textColor(),
                                fontWeight: FontWeight.w600)),
                      )),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.notifications,
                            size: 28,
                            color: config.Colors().textColor(),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 0.5,
              color: config.Colors().textColor(),
            ),
            Expanded(
              flex: 1,
              child: widget.currentPage,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 0.5,
              color: config.Colors().textColor(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          iconSize: 24,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 24),
          unselectedItemColor: Colors.grey,
          // unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            if (i == 2) {
              _launchURL('https://flutter.io');
            } else {
              this._selectTab(i);
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: S.current.timer,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_iridescent),
              label: 'SlimScents',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard_rounded),
              label: 'Gift',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.bar_chart_outlined),
              label: S.current.history,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              label: S.current.settings,
            ),
          ],
        ),
      ),
    );
  }
}
