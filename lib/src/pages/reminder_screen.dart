import 'package:ezfastnow/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const List<String> amPm = const <String>['AM', 'PM'];

const List<String> hours = const <String>[
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12'
];

const List<String> mins = const <String>[
  '00',
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31',
  '32',
  '33',
  '34',
  '35',
  '36',
  '37',
  '38',
  '39',
  '40',
  '41',
  '42',
  '43',
  '44',
  '45',
  '46',
  '47',
  '48',
  '49',
  '50',
  '51',
  '52',
  '53',
  '54',
  '55',
  '56',
  '57',
  '58',
  '59',
];

// ignore: must_be_immutable
class ReminderScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  ReminderScreen({Key key});

  @override
  _ReminderScreenState createState() {
    return _ReminderScreenState();
  }
}

class _ReminderScreenState extends State<ReminderScreen> {
  int _selectedHrIndex = 3;
  int _selectedMinIndex = 4;
  int _selectedAMPMIndex = 0;
  int selectedDay = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DateTime now = new DateTime.now();
    int hh = now.hour;
    if (hh >= 12) {
      _selectedHrIndex = hh - 1 - 12;
      _selectedAMPMIndex = 1;
    } else {
      _selectedHrIndex = hh - 1;
      _selectedAMPMIndex = 0;
    }
    _selectedMinIndex = now.minute;

    print('---' + now.hour.toString());
    print('---' + now.minute.toString());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        key: widget.scaffoldKey,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 1,
                  left: 2,
                  right: 2,
                  bottom: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyText2.merge(
                          TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(msg: "Reminder has been set.");
                    },
                    child: Text(
                      "Save",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyText2.merge(
                          TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 0.5,
              color: Colors.black38,
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Add Reminder",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3.merge(
                              TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 180,
                            child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                    initialItem: _selectedHrIndex),
                                itemExtent: 40.0,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    _selectedHrIndex = index;
                                  });
                                },
                                children: new List<Widget>.generate(
                                    hours.length, (int index) {
                                  return new Center(
                                    child: new Text(
                                      hours[index],
                                      style: (index == _selectedHrIndex)
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
                          SizedBox(
                            width: 1,
                          ),
                          Container(
                            width: 80,
                            height: 180,
                            child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                    initialItem: _selectedMinIndex),
                                itemExtent: 40.0,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    _selectedMinIndex = index;
                                  });
                                },
                                children: new List<Widget>.generate(mins.length,
                                    (int index) {
                                  return new Center(
                                    child: new Text(
                                      mins[index],
                                      style: (index == _selectedMinIndex)
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
                          SizedBox(
                            width: 1,
                          ),
                          Container(
                            width: 80,
                            height: 180,
                            child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                    initialItem: _selectedAMPMIndex),
                                itemExtent: 40.0,
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    _selectedAMPMIndex = index;
                                  });
                                },
                                children: new List<Widget>.generate(amPm.length,
                                    (int index) {
                                  return new Center(
                                    child: new Text(
                                      amPm[index],
                                      style: (index == _selectedAMPMIndex)
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
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Repeat",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline3.merge(
                            TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(16.0),
                            border: Border.all(color: Colors.grey[100]),
                            color: Colors.grey[200]),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDay = 1;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Monday",
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .merge(
                                            TextStyle(
                                              color: (selectedDay == 1)
                                                  ? Theme.of(context)
                                                  .accentColor
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      (selectedDay == 1)
                                          ? Icon(
                                        Icons.check_circle,
                                        color:
                                        Theme.of(context).accentColor,
                                      )
                                          : Container()
                                    ],
                                  ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 0.5,
                              color: Colors.grey[300],
                            ),
                        Container(
                          height: 50,
                          child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDay = 2;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Tuesday",
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(
                                          TextStyle(
                                            color: (selectedDay == 2)
                                                ? Theme.of(context)
                                                .accentColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    (selectedDay == 2)
                                        ? Icon(
                                      Icons.check_circle,
                                      color:
                                      Theme.of(context).accentColor,
                                    )
                                        : Container()
                                  ],
                                )),),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 0.5,
                              color: Colors.grey[300],
                            ),
                        Container(
                          height: 50,
                          child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDay = 3;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Wednesday",
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(
                                          TextStyle(
                                            color: (selectedDay == 3)
                                                ? Theme.of(context)
                                                .accentColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    (selectedDay == 3)
                                        ? Icon(
                                      Icons.check_circle,
                                      color:
                                      Theme.of(context).accentColor,
                                    )
                                        : Container()
                                  ],
                                )),),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 0.5,
                              color: Colors.grey[300],
                            ),
                        Container(
                          height: 50,
                          child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDay = 4;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Thursday",
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(
                                          TextStyle(
                                            color: (selectedDay == 4)
                                                ? Theme.of(context)
                                                .accentColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    (selectedDay == 4)
                                        ? Icon(
                                      Icons.check_circle,
                                      color:
                                      Theme.of(context).accentColor,
                                    )
                                        : Container()
                                  ],
                                )),),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 0.5,
                              color: Colors.grey[300],
                            ),
                        Container(
                          height: 50,
                          child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDay = 5;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Friday",
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(
                                          TextStyle(
                                            color: (selectedDay == 5)
                                                ? Theme.of(context)
                                                .accentColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    (selectedDay == 5)
                                        ? Icon(
                                      Icons.check_circle,
                                      color:
                                      Theme.of(context).accentColor,
                                    )
                                        : Container()
                                  ],
                                )),),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 0.5,
                              color: Colors.grey[300],
                            ),
                        Container(
                          height: 50,
                          child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDay = 6;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Saturday",
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(
                                          TextStyle(
                                            color: (selectedDay == 6)
                                                ? Theme.of(context)
                                                .accentColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    (selectedDay == 6)
                                        ? Icon(
                                      Icons.check_circle,
                                      color:
                                      Theme.of(context).accentColor,
                                    )
                                        : Container()
                                  ],
                                )),),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 0.5,
                              color: Colors.grey[300],
                            ),
                        Container(
                          height: 50,
                          child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDay = 7;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Sunday",
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(
                                          TextStyle(
                                            color: (selectedDay == 7)
                                                ? Theme.of(context)
                                                .accentColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    (selectedDay == 7)
                                        ? Icon(
                                      Icons.check_circle,
                                      color:
                                      Theme.of(context).accentColor,
                                    )
                                        : Container()
                                  ],
                                )),),
                          ],
                        ),
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
