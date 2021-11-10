import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/settings_repository.dart';
import '../helpers/app_config.dart' as config;

class DarkModeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  DarkModeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _DarkModeWidgetState createState() => _DarkModeWidgetState();
}

class _DarkModeWidgetState extends StateMVC<DarkModeWidget> {
  HomeController _con;

  // bool enableSw = false;

  _DarkModeWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
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
                      'Dark Mode',
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.headline4.merge(
                          TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.keyboard_backspace_outlined,
                            size: 28,
                            color: config.Colors().textColor(),
                          ),
                        ),
                      ),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 6, bottom: 6),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 0.0, left: 0.0),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _con.isDarkMode
                                                          ? 'Disable'
                                                          : 'Enable',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                            color: config.Colors().textColor(),
                                                            fontSize: 14,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Switch(
                                                value: _con.isDarkMode,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _con.isDarkMode = value;
                                                  });
                                                  if (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark) {
                                                    setBrightness(
                                                        Brightness.light);
                                                    setting.value.brightness
                                                            .value =
                                                        Brightness.light;
                                                  } else {
                                                    setting.value.brightness
                                                            .value =
                                                        Brightness.dark;
                                                    setBrightness(
                                                        Brightness.dark);
                                                  }
                                                  setting.notifyListeners();
                                                  _con.prefs.setBool(
                                                      'isDarkMode', value);
                                                },
                                                activeTrackColor:
                                                    Theme.of(context)
                                                        .focusColor
                                                        .withOpacity(0.5),
                                                activeColor: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'MODE',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(
                                    color: config.Colors().textColor(),
                                    fontSize: 16,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 0.0, left: 0.0),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Manual',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                            color: config.Colors().textColor(),
                                                            fontSize: 14,
                                                          )),
                                                    ),
                                                    Text(
                                                      'Switch on and off when you want',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 10,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 0.5,
                                          color: Colors.grey[300],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Scheduled',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                            color: config.Colors().textColor(),
                                                            fontSize: 14,
                                                          )),
                                                    ),
                                                    Text(
                                                      'Switch daily at a set time',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 10,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 0.5,
                                          color: Colors.grey[300],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Auto',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                            color: config.Colors().textColor(),
                                                            fontSize: 14,
                                                          )),
                                                    ),
                                                    Text(
                                                      'Switches based on screen brightness',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 10,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
