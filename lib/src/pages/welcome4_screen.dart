import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/controllers/welcome_screen_controller.dart';
import 'package:ezfastnow/src/helpers/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_picker/flutter_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> colors = const <String>[
  'Red',
  'Yellow',
  'Amber',
  'Blue',
  'Black',
  'Pink',
  'Purple',
  'White',
  'Grey',
  'Green',
];

const List<String> hours24 = const <String>[
  '00:00',
  '01:00',
  '02:00',
  '03:00',
  '04:00',
  '05:00',
  '06:00',
  '07:00',
  '08:00',
  '09:00',
  '10:00',
  '11:00',
  '12:00',
  '13:00',
  '14:00',
  '15:00',
  '16:00',
  '17:00',
  '18:00',
  '19:00',
  '20:00',
  '21:00',
  '22:00',
  '23:00',
];

const List<String> hours12 = const <String>[
  '12:00 AM',
  '01:00 AM',
  '02:00 AM',
  '03:00 AM',
  '04:00 AM',
  '05:00 AM',
  '06:00 AM',
  '07:00 AM',
  '08:00 AM',
  '09:00 AM',
  '10:00 AM',
  '11:00 AM',
  '12:00 PM',
  '01:00 PM',
  '02:00 PM',
  '03:00 PM',
  '04:00 PM',
  '05:00 PM',
  '06:00 PM',
  '07:00 PM',
  '08:00 PM',
  '09:00 PM',
  '10:00 PM',
  '11:00 PM',
];

class Welcome4Widget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  Welcome4Widget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _Welcome4WidgetState createState() => _Welcome4WidgetState();
}

class _Welcome4WidgetState extends StateMVC<Welcome4Widget> {
  WelcomeScreenController _con;

  SharedPreferences prefs;

  String fastStart = "";
  String fastEnd = "";

  bool is24Hours = true;

  bool isSelectionView = false;
  String selectedType = S.current.too_loose_weight;

  int _selectedStartIndex = 5;
  int _selectedEndIndex = 19;

  _Welcome4WidgetState() : super(WelcomeScreenController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    setUpPrefs();
  }

  setUpPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.containsKey("fast_start"))
        fastStart = prefs.getString("fast_start");
      else
        fastStart = "";

      if (prefs.containsKey("fast_end"))
        fastEnd = prefs.getString("fast_end");
      else
        fastEnd = "";

      // if (fastStart.isNotEmpty) {
      //   if (fastStart.contains("AM") || fastStart.contains("PM")) {
      //     for (int i = 0; i < hours12.length; i++) {
      //       if (fastStart == hours12.elementAt(i)) {
      //         _selectedStartIndex = i;
      //       }
      //     }
      //   } else {
      //     for (int i = 0; i < hours24.length; i++) {
      //       if (fastStart == hours24.elementAt(i)) {
      //         _selectedStartIndex = i;
      //       }
      //     }
      //   }
      // } else {
      //   _selectedStartIndex = 5;
      // }
      //
      // if (fastEnd.isNotEmpty) {
      //   if (fastEnd.contains("AM") || fastEnd.contains("PM")) {
      //     for (int i = 0; i < hours12.length; i++) {
      //       if (fastEnd == hours12.elementAt(i)) {
      //         _selectedEndIndex = i;
      //       }
      //     }
      //   } else {
      //     for (int i = 0; i < hours24.length; i++) {
      //       if (fastEnd == hours24.elementAt(i)) {
      //         _selectedEndIndex = i;
      //       }
      //     }
      //   }
      // } else {
      //   _selectedEndIndex = 19;
      // }
    });
  }

  setFastStart(String start) async {
    prefs.setString("fast_start", start);
  }

  setFastEnd(String end) async {
    prefs.setString("fast_end", end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        color: Colors.white,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.current.w4_txt1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3.merge(
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w800)),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              S.current.w4_txt2,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .merge(TextStyle(color: Colors.black87)),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          S.current.w4_txt3,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3.merge(
                              TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                        ),
                        Expanded(
                          child: Container(
                            // height: 160.0,
                            child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                    initialItem: _selectedStartIndex),
                                itemExtent: 40.0,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    _selectedStartIndex = index;
                                    String st = "";
                                    if (is24Hours)
                                      st = hours24[index];
                                    else
                                      st = hours12[index];
                                    setFastStart(st);
                                  });
                                },
                                children: new List<Widget>.generate(
                                    (is24Hours)
                                        ? hours24.length
                                        : hours12.length, (int index) {
                                  return new Center(
                                    child: new Text(
                                      (is24Hours)
                                          ? hours24[index]
                                          : hours12[index],
                                      style: (index == _selectedStartIndex)
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline2
                                              .merge(
                                                TextStyle(
                                                    fontSize: 24,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              )
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .merge(
                                                TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black87),
                                              ),
                                    ),
                                  );
                                })),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          S.current.w4_txt3,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3.merge(
                              TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800)),
                        ),
                        Expanded(
                            child: Container(
                          // height: 160.0,
                          child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem: _selectedEndIndex),
                              itemExtent: 40.0,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  _selectedEndIndex = index;
                                  String et = "";
                                  if (is24Hours)
                                    et = hours24[index];
                                  else
                                    et = hours12[index];
                                  setFastEnd(et);
                                });
                              },
                              children: new List<Widget>.generate(
                                  (is24Hours) ? hours24.length : hours12.length,
                                  (int index) {
                                return new Center(
                                  child: new Text(
                                    (is24Hours)
                                        ? hours24[index]
                                        : hours12[index],
                                    style: (index == _selectedEndIndex)
                                        ? Theme.of(context)
                                            .textTheme
                                            .headline2
                                            .merge(
                                              TextStyle(
                                                  fontSize: 24,
                                                  color: Theme.of(context)
                                                      .accentColor),
                                            )
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(
                                              TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black87),
                                            ),
                                  ),
                                );
                              })),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 20,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    S.current.w4_txt5,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline3.merge(
                        TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
                Switch(
                  value: is24Hours,
                  onChanged: (value) {
                    setState(() {
                      is24Hours = value;
                    });
                  },
                  activeTrackColor:
                      Theme.of(context).accentColor.withOpacity(0.2),
                  activeColor: Theme.of(context).accentColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
