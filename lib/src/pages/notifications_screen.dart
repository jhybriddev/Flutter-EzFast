import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;

class NotificationWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  NotificationWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends StateMVC<NotificationWidget> {
  HomeController _con;

  bool newLearnSw = false;
  bool ezFastUpdateSw = false;
  bool goalSw = false;
  bool halfwaySw = false;
  bool lastHrSw = false;
  bool surpassSw = false;
  bool reachedGoalSw = false;

  _NotificationWidgetState() : super(HomeController()) {
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
                      'Notification',
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
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'REMINDERS',
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
                                                      'Weight In',
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
                                              Text(
                                                'Off',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                )),
                                              ),
                                              SizedBox(width: 10,),
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
                                                      'Start Fasting',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                        color: config.Colors().textColor(),
                                                        fontSize: 14,
                                                      )),
                                                    ),
                                                    Text(
                                                      'Deactivated during a fast',
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
                                              Text(
                                                '1 Set',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                )),
                                              ),
                                              SizedBox(width: 10,),
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
                                                      'Fast Journal',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                        color: config.Colors().textColor(),
                                                        fontSize: 14,
                                                      )),
                                                    ),
                                                    Text(
                                                      'Activated during a fast',
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
                                              Text(
                                                '2 Sets',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                )),
                                              ),
                                              SizedBox(width: 10,),
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
                                                      'New Learn Content',
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
                                                value: newLearnSw,
                                                onChanged: (value) {
                                                  setState(() {
                                                    newLearnSw =
                                                        value;
                                                    print(
                                                        newLearnSw);
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
                                                  ],
                                                ),
                                              ),
                                              Switch(
                                                value: ezFastUpdateSw,
                                                onChanged: (value) {
                                                  setState(() {
                                                    ezFastUpdateSw =
                                                        value;
                                                    print(
                                                        ezFastUpdateSw);
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
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'MILESTONES',
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
                                                      'Goal Reached',
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
                                                value: goalSw,
                                                onChanged: (value) {
                                                  setState(() {
                                                    goalSw =
                                                        value;
                                                    print(
                                                        goalSw);
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
                                                      'Halfway Through',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                        color: config.Colors().textColor(),
                                                        fontSize: 14,
                                                      )),
                                                    ),
                                                    Text(
                                                      'Only for 4 hours or longer fasts',
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
                                                value: halfwaySw,
                                                onChanged: (value) {
                                                  setState(() {
                                                    halfwaySw =
                                                        value;
                                                    print(
                                                        halfwaySw);
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
                                                      'Last Hour',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                        color: config.Colors().textColor(),
                                                        fontSize: 14,
                                                      )),
                                                    ),
                                                    Text(
                                                      'Only for 4 hours or longer fasts',
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
                                                value: lastHrSw,
                                                onChanged: (value) {
                                                  setState(() {
                                                    lastHrSw =
                                                        value;
                                                    print(
                                                        lastHrSw);
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
                                                      'Surpasses Goal (Continuous)',
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
                                                value: surpassSw,
                                                onChanged: (value) {
                                                  setState(() {
                                                    surpassSw =
                                                        value;
                                                    print(
                                                        surpassSw);
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
                                                      'Reached Goal Weight',
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
                                                value: reachedGoalSw,
                                                onChanged: (value) {
                                                  setState(() {
                                                    reachedGoalSw =
                                                        value;
                                                    print(
                                                        reachedGoalSw);
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
