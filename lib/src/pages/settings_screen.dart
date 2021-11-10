import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:ezfastnow/src/helpers/helper.dart';
import 'package:ezfastnow/src/models/route_argument.dart';
import 'package:ezfastnow/src/pages/common_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../helpers/app_config.dart' as config;
// import '../helpers/app_config.dart' as app_colors;

class SettingsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  SettingsWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends StateMVC<SettingsWidget> {
  HomeController _con;

  _SettingsWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Preferences',
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
                              // height: 150,
                              padding:
                                  const EdgeInsets.only(right: 0.0, left: 0.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Timer Direction',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                      color: config.Colors()
                                                          .textColor(),
                                                      fontSize: 14,
                                                    )),
                                              ),
                                              Text(
                                                (_con.timerToggleIndex == 0)
                                                    ? 'Counting up from 00:00'
                                                    : 'Counting down to 00:00',
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
                                        ToggleSwitch(
                                          minWidth: 50,
                                          minHeight: 25.0,
                                          initialLabelIndex:
                                              _con.timerToggleIndex,
                                          cornerRadius: 30.0,
                                          activeFgColor: Colors.white,
                                          inactiveBgColor: Colors.grey[300],
                                          inactiveFgColor:
                                              Theme.of(context).accentColor,
                                          labels: ['UP', 'DOWN'],
                                          // icons: [Icons.stacked_bar_chart, Icons.calendar_today_sharp],
                                          iconSize: 10.0,
                                          fontSize: 10,
                                          activeBgColors: [
                                            Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.8),
                                            Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.8)
                                          ],
                                          onToggle: (index) {
                                            _con.timerToggleIndex = index;
                                            setState(() {});
                                            _con.prefs
                                                .setInt('isTimerUp', index);
                                            settingRepo.setting.value.isTimerUp
                                                .value = index;
                                            settingRepo.setting.value.isTimerUp
                                                .notifyListeners();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Weight Units',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                      color: config.Colors()
                                                          .textColor(),
                                                      fontSize: 14,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ToggleSwitch(
                                          minWidth: 50,
                                          minHeight: 25.0,
                                          initialLabelIndex:
                                              _con.weightToggleIndex,
                                          cornerRadius: 30.0,
                                          activeFgColor: Colors.white,
                                          inactiveBgColor: Colors.grey[300],
                                          inactiveFgColor:
                                              Theme.of(context).accentColor,
                                          labels: ['KG', 'LBS'],
                                          // icons: [Icons.stacked_bar_chart, Icons.calendar_today_sharp],
                                          iconSize: 10.0,
                                          fontSize: 10,
                                          activeBgColors: [
                                            Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.8),
                                            Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.8)
                                          ],
                                          onToggle: (index) {
                                            _con.weightToggleIndex = index;
                                            setState(() {});

                                            if (index == 0) {
                                              _con.prefs.setString(
                                                  'weightUnit', 'KG');
                                              settingRepo.setting.value
                                                  .weightUnit.value = 'KG';
                                            } else {
                                              _con.prefs.setString(
                                                  'weightUnit', 'LBS');
                                              settingRepo.setting.value
                                                  .weightUnit.value = 'LBS';
                                            }
                                            settingRepo.setting.value.weightUnit
                                                .notifyListeners();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Time Format',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                      color: config.Colors()
                                                          .textColor(),
                                                      fontSize: 14,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ToggleSwitch(
                                          minWidth: 50,
                                          minHeight: 25.0,
                                          initialLabelIndex:
                                              _con.timeToggleIndex,
                                          cornerRadius: 30.0,
                                          activeFgColor: Colors.white,
                                          inactiveBgColor: Colors.grey[300],
                                          inactiveFgColor:
                                              Theme.of(context).accentColor,
                                          labels: ['12h', '24h'],
                                          // icons: [Icons.stacked_bar_chart, Icons.calendar_today_sharp],
                                          iconSize: 10.0,
                                          fontSize: 10,
                                          activeBgColors: [
                                            Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.8),
                                            Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.8)
                                          ],
                                          onToggle: (index) {
                                            _con.timeToggleIndex = index;
                                            setState(() {});
                                            if (index == 0) {
                                              _con.prefs.setString(
                                                  'timeFormat', '12');
                                              settingRepo.setting.value
                                                  .timeFormat.value = '12';
                                            } else {
                                              _con.prefs.setString(
                                                  'timeFormat', '24');
                                              settingRepo.setting.value
                                                  .timeFormat.value = '24';
                                            }
                                            settingRepo.setting.value
                                                .timeFormat
                                                .notifyListeners();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  InkWell(
                                    // onTap: () {
                                    //   // Navigator.of(context)
                                    //   //     .pushNamed('/DarkMode');
                                    // },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 1, bottom: 1),
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
                                                  'Dark Mode',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Text(
                                          //   _con.isDarkMode ? 'Enabled' : 'Disabled',
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .bodyText2
                                          //       .merge(TextStyle(
                                          //         color: Colors.grey,
                                          //         fontSize: 12,
                                          //       )),
                                          // ),
                                          SizedBox(
                                            width: 10,
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
                                                settingRepo.setBrightness(
                                                    Brightness.light);
                                                settingRepo
                                                    .setting
                                                    .value
                                                    .brightness
                                                    .value = Brightness.light;
                                              } else {
                                                settingRepo
                                                    .setting
                                                    .value
                                                    .brightness
                                                    .value = Brightness.dark;
                                                settingRepo.setBrightness(
                                                    Brightness.dark);
                                              }
                                              settingRepo.setting
                                                  .notifyListeners();
                                              _con.prefs
                                                  .setBool('isDarkMode', value);
                                            },
                                            activeTrackColor: Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.5),
                                            activeColor:
                                                Theme.of(context).accentColor,
                                          ),
                                          // Icon(
                                          //   Icons.arrow_forward_ios_rounded,
                                          //   size: 10,
                                          //   color: Colors.grey,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed('/Notification');
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
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
                                                  'Notifications',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed('/EmailWidget');
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 10),
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
                                                  'Emails',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
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
                        'Account',
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
                              // height: 150,
                              padding:
                                  const EdgeInsets.only(right: 0.0, left: 0.0),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed('/MyProfile');
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 15),
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
                                                  'My Profile',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            _con.user != null
                                                ? _con.user.name
                                                : '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                )),
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
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed('/MyData');
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
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
                                                  'My Data',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      _showDialogLogout(context,
                                          'Are you sure to logout this user from device?');
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 10),
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
                                                  'Logout',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
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
                        'Community',
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
                              // height: 150,
                              padding:
                                  const EdgeInsets.only(right: 0.0, left: 0.0),
                              child: Column(
                                children: [
                                  InkWell(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 15),
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
                                                  'Rate us on App Store',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                                Text(
                                                  'Your app store rating help us a lot',
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
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed('/FindEzFast');
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
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
                                                  'Find Ez Fast Now online',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                                Text(
                                                  'Instagram, Youtube, Facebook, Twitter',
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
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  InkWell(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
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
                                                  'Download Less',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                                Text(
                                                  'If you drink, drink mindfully',
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
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  InkWell(
                                      child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Download Oak',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                      color: config.Colors()
                                                          .textColor(),
                                                      fontSize: 14,
                                                    )),
                                              ),
                                              Text(
                                                'Mediate, Breathe, Sleep',
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
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 10,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  )),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
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
                        'App',
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
                              // height: 150,
                              padding:
                                  const EdgeInsets.only(right: 0.0, left: 0.0),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).pushNamed('/Chat', arguments: RouteArgument(param: _con.message));
                                      Navigator.of(context).pushNamed('/Chat');
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 15),
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
                                                  'Contact Support',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) =>
                                                CommonInfoWidget(
                                                    title: 'Help Center',
                                                    value: Helper.help_text),
                                            transitionsBuilder:
                                                (c, anim, a2, child) =>
                                                    FadeTransition(
                                                        opacity: anim,
                                                        child: child),
                                            transitionDuration:
                                                Duration(milliseconds: 300),
                                          ));
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
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
                                                  'Help Center',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) =>
                                                CommonInfoWidget(
                                                    title: 'Terms of Use',
                                                    value: Helper.terms_text),
                                            transitionsBuilder:
                                                (c, anim, a2, child) =>
                                                    FadeTransition(
                                                        opacity: anim,
                                                        child: child),
                                            transitionDuration:
                                                Duration(milliseconds: 300),
                                          ));
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
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
                                                  'Terms of Use',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) =>
                                                CommonInfoWidget(
                                                    title: 'Privacy',
                                                    value: Helper.privacy_text),
                                            transitionsBuilder:
                                                (c, anim, a2, child) =>
                                                    FadeTransition(
                                                        opacity: anim,
                                                        child: child),
                                            transitionDuration:
                                                Duration(milliseconds: 300),
                                          ));
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
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
                                                  'Privacy',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 0.5,
                                    color: Colors.grey[300],
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) =>
                                                CommonInfoWidget(
                                                    title:
                                                        'Open Source Libraries',
                                                    value: Helper
                                                        .open_source_text),
                                            transitionsBuilder:
                                                (c, anim, a2, child) =>
                                                    FadeTransition(
                                                        opacity: anim,
                                                        child: child),
                                            transitionDuration:
                                                Duration(milliseconds: 300),
                                          ));
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 10),
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
                                                  'Open Source Libraries',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
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
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialogLogout(BuildContext ctx, String msg) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: ctx,
        builder: (ctx) => Container(
              width: 300,
              height: 250,
              child: Stack(
                children: [
                  Container(
                    color: config.Colors().bgColor(),
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          'Alert!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3.merge(
                              TextStyle(
                                  color: config.Colors().textColor(),
                                  fontWeight: FontWeight.w800)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          msg,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption.merge(
                              TextStyle(color: config.Colors().textColor())),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonTheme(
                          minWidth: 250,
                          child: RaisedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              _con.signOut();
                            },
                            padding: EdgeInsets.symmetric(vertical: 14),
                            color: config.Colors().textColor(),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(24.0)),
                            child: Text(
                              'Confirm',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: config.Colors().bgColor(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Dismiss',
                              style:
                                  Theme.of(context).textTheme.bodyText2.merge(
                                        TextStyle(
                                            color: config.Colors().textColor(),
                                            fontWeight: FontWeight.w600),
                                      ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Image.asset(
                      //   Helper.IMAGE_SPLASH,
                      //   // width: 40,
                      //   height: 40,
                      //   fit: BoxFit.contain,
                      // ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: config.Colors().textColor(),
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.close_rounded,
                            color: config.Colors().bgColor(),
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}
