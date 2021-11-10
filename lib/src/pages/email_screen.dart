import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;


class EmailWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  EmailWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _EmailWidgetState createState() => _EmailWidgetState();
}

class _EmailWidgetState extends StateMVC<EmailWidget> {
  HomeController _con;

  bool isFastReminderSwitched = false;
  bool statsSwitched = false;
  bool updatesSwitched = false;
  bool newsSwitched = false;

  _EmailWidgetState() : super(HomeController()) {
    _con = controller;
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
                      'Email',
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
                                color: Colors.black,
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
                                                      'Fasting Reminders',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                            color: config.Colors().textColor(),
                                                            fontSize: 14,
                                                          )),
                                                    ),
                                                    Text(
                                                      'Stay on top of your logging fasts',
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
                                              Switch(
                                                value: isFastReminderSwitched,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isFastReminderSwitched =
                                                        value;
                                                    print(
                                                        isFastReminderSwitched);
                                                  });
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
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 0.5,
                                          color: Colors.grey[300],
                                        ),
                                        SizedBox(
                                          height: 6,
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
                                                      'Stats & Milestones',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                            color: config.Colors().textColor(),
                                                            fontSize: 14,
                                                          )),
                                                    ),
                                                    Text(
                                                      'Keep track of your progress',
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
                                              Switch(
                                                value: statsSwitched,
                                                onChanged: (value) {
                                                  setState(() {
                                                    statsSwitched =
                                                        value;
                                                    print(
                                                        statsSwitched);
                                                  });
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
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 0.5,
                                          color: Colors.grey[300],
                                        ),
                                        SizedBox(
                                          height: 6,
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
                                                      'Ez Fast Now Updates',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                            color: config.Colors().textColor(),
                                                            fontSize: 14,
                                                          )),
                                                    ),
                                                    Text(
                                                      'Get the latest updates from Ez Fast Now',
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
                                              Switch(
                                                value: updatesSwitched,
                                                onChanged: (value) {
                                                  setState(() {
                                                    updatesSwitched =
                                                        value;
                                                    print(
                                                        updatesSwitched);
                                                  });
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
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 0.5,
                                          color: Colors.grey[300],
                                        ),
                                        SizedBox(
                                          height: 6,
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
                                                      'Ez Fast Now Group',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                            color: config.Colors().textColor(),
                                                            fontSize: 14,
                                                          )),
                                                    ),
                                                    Text(
                                                      'Get the latest news from Ez Fast Now',
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
                                              Switch(
                                                value: newsSwitched,
                                                onChanged: (value) {
                                                  setState(() {
                                                    newsSwitched =
                                                        value;
                                                    print(
                                                        newsSwitched);
                                                  });
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
