import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/app_config.dart' as config;
import 'package:intl/intl.dart'; // for date format
import 'package:intl/date_symbol_data_local.dart'; // for other locales

class TimerWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  TimerWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends StateMVC<TimerWidget> {
  HomeController _con;

  bool isProgress = true;
  bool havingFast = false;
  bool isFastStarted = false;
  int fastingHours = 13;

  int totalSeconds = 46800;
  int initialTimerPosition = 0;

  bool autoStart = false;

  String fastStartsAt = "";
  String fastEndsAt = "";

  DateTime customDate;
  DateTime customTime;

  var countDownController = CountDownController();

  SharedPreferences prefs;

  _TimerWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isProgress = true;
    });
    setUpPrefs();
  }

  setUpPrefs() async {
    prefs = await SharedPreferences.getInstance();
    // setState(() async {
    isProgress = false;

    if (prefs.containsKey("have_fast"))
      havingFast = prefs.getBool("have_fast");
    else
      havingFast = false;

    if (prefs.containsKey("fast_started"))
      isFastStarted = prefs.getBool("fast_started");
    else
      isFastStarted = false;

    if (prefs.containsKey("fasting_hours"))
      fastingHours = prefs.getInt("fasting_hours");
    else
      fastingHours = 13;

    if (isFastStarted) {
      DateTime savedDate;
      if (prefs.containsKey("fast_start_time")) {
        savedDate = DateTime.parse(prefs.getString('fast_start_time'));
      } else {
        savedDate = new DateTime.now();
      }
      DateTime nowDate = new DateTime.now();
      initialTimerPosition = nowDate.difference(savedDate).inSeconds;
      totalSeconds = fastingHours * 3600;

      if (initialTimerPosition >= totalSeconds) {
        DateTime endDate = savedDate;
        endDate = endDate.add(Duration(hours: fastingHours));

        await _con.saveFast(endDate);
        prefs.setBool("have_fast", false);
        havingFast = false;

        prefs.setBool("fast_started", false);
        isFastStarted = false;

        prefs.setInt("fasting_hours", 13);
        fastingHours = 13;
        totalSeconds = 46800;
        initialTimerPosition = 0;
        autoStart = false;
      } else {
        autoStart = true;

        print('==initialTimerPosition===' + initialTimerPosition.toString());
        print('==totalSeconds===' + totalSeconds.toString());

        fastStartsAt = getFastStartTime();
        fastEndsAt = getFastEndTime();
      }
    }
    // });

    setState(() {});
  }

  String getFastStartTime() {
    DateTime savedDate;
    if (prefs.containsKey("fast_start_time")) {
      savedDate = DateTime.parse(prefs.getString('fast_start_time'));
    } else {
      savedDate = new DateTime.now();
    }

    return getDateString(savedDate) + ' at ' + DateFormat(_con.CURRENT_DATE_TIME_FORMAT).format(savedDate);
  }

  String getFastEndTime() {
    DateTime savedDate;
    if (prefs.containsKey("fast_start_time")) {
      savedDate = DateTime.parse(prefs.getString('fast_start_time'));
    } else {
      savedDate = new DateTime.now();
    }

    if (prefs.containsKey("fasting_hours"))
      fastingHours = prefs.getInt("fasting_hours");
    else
      fastingHours = 13;
    // https://stackoverflow.com/questions/54391477/check-if-datetime-variable-is-today-tomorrow-or-yesterday
    print('-0-0-0-0-' + fastingHours.toString());

    savedDate = savedDate.add(Duration(hours: fastingHours));

    print('------' + savedDate.toIso8601String());

    return getDateString(savedDate) +
        ' at ' +
        DateFormat(_con.CURRENT_DATE_TIME_FORMAT).format(savedDate);
  }

  String getDateString(DateTime tm) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dateToCheck = tm;
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return "Today";
    } else if (aDate == yesterday) {
      return "Yesterday";
    } else if (aDate == tomorrow) {
      return "Tomorrow";
    } else {
      return DateFormat("dd MMM ").format(tm);
    }

    // // tm = DateTime(tm.year, tm.month, tm.day);
    // DateTime today = new DateTime.now();
    // Duration oneDay = new Duration(days: 1);
    // Duration twoDay = new Duration(days: 2);
    // Duration oneWeek = new Duration(days: 7);
    // String month;
    // switch (tm.month) {
    //   case 1:
    //     month = "January";
    //     break;
    //   case 2:
    //     month = "February";
    //     break;
    //   case 3:
    //     month = "March";
    //     break;
    //   case 4:
    //     month = "April";
    //     break;
    //   case 5:
    //     month = "May";
    //     break;
    //   case 6:
    //     month = "June";
    //     break;
    //   case 7:
    //     month = "July";
    //     break;
    //   case 8:
    //     month = "August";
    //     break;
    //   case 9:
    //     month = "September";
    //     break;
    //   case 10:
    //     month = "October";
    //     break;
    //   case 11:
    //     month = "November";
    //     break;
    //   case 12:
    //     month = "December";
    //     break;
    // }
    //
    // Duration difference = today.difference(tm);
    //
    // print('xxxxxxxx' + difference.toString());
    // print('xxxxxxxx' + difference.compareTo(oneDay).toString());
    //
    // if (difference.compareTo(oneDay) < 1) {
    //   return "Today";
    // } else if (difference.compareTo(oneDay) == 1) {
    //   return "Tomorrow";
    // } else if (difference.compareTo(twoDay) < 1) {
    //   return "Yesterday";
    // } else if (difference.compareTo(oneWeek) < 1) {
    //   switch (tm.weekday) {
    //     case 1:
    //       return "Monday";
    //     case 2:
    //       return "Tuesday";
    //     case 3:
    //       return "Wednesday";
    //     case 4:
    //       return "Thursday";
    //     case 5:
    //       return "Friday";
    //     case 6:
    //       return "Saturday";
    //     case 7:
    //       return "Sunday";
    //   }
    // } else if (tm.year == today.year) {
    //   return '${tm.day} $month';
    // } else {
    //   return '${tm.day} $month ${tm.year}';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: isProgress
          ? Container()
          : Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: havingFast
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Get ready to fast",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .merge(TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w800)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "700.2k people are fasting with EZ Fast Now",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .merge(TextStyle(
                                    color: Theme.of(context).accentColor,
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(left: 40, right: 40),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        new BorderRadius.circular(24.0),
                                    color: Colors.grey[300]),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 0, right: 0, top: 6, bottom: 6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.current.circadian_rhythm_trf,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            .merge(
                                              TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.edit_rounded,
                                        size: 16,
                                        color: Colors.black87,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Flexible(
                                flex: 1,
                                child:
                                    // isFastStarted
                                    //     ? Column(
                                    //         children: [],
                                    //       )
                                    //     :
                                    Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        child: CircularCountDownTimer(
                                          duration: totalSeconds,
                                          initialDuration: initialTimerPosition,
                                          controller: countDownController,
                                          width: 180,
                                          height: 180,
                                          ringColor: Colors.grey[300],
                                          ringGradient: null,
                                          fillColor:
                                              Theme.of(context).accentColor,
                                          fillGradient: null,
                                          backgroundColor: Colors.transparent,
                                          backgroundGradient: null,
                                          strokeWidth: 30.0,
                                          strokeCap: StrokeCap.round,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              .merge(
                                                TextStyle(
                                                    fontSize: 22.0,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                          textFormat:
                                              CountdownTextFormat.HH_MM_SS,
                                          isReverse: _con.isReverseCountdownTimer,
                                          isReverseAnimation: _con.isReverseCountdownTimer,
                                          isTimerTextShown: true,
                                          autoStart: autoStart,
                                          onStart: () {
                                            print('Countdown Started');
                                          },
                                          onComplete: () {
                                            print('Countdown Ended');
                                          },
                                        ),
                                        //   ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    isFastStarted
                                        ? Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Started Fasting',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .merge(
                                                              TextStyle(
                                                                  fontSize: 13,
                                                                  color: config.Colors().textColor()),
                                                            ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        fastStartsAt,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .merge(
                                                              TextStyle(
                                                                  color: config.Colors().textColor(),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          DatePicker.showDateTimePicker(
                                                              context,
                                                              showTitleActions:
                                                                  true,
                                                              minTime: DateTime(
                                                                  2000, 1, 1),
                                                              maxTime: DateTime
                                                                  .now(),
                                                              onChanged:
                                                                  (date) {
                                                            print(
                                                                'change $date');
                                                          }, onConfirm: (date) {
                                                            int diffInHours = new DateTime
                                                                .now()
                                                                .difference(
                                                                date)
                                                                .inHours;
                                                            if (date.isBefore(new DateTime.now()) && diffInHours > fastingHours) {
                                                            print(
                                                            'alsjfhasogfoasgfoasfosai');
                                                            _showMessageDialog(
                                                            context,
                                                            'Selected time not allowed, its more than Fasting ' +
                                                            fastingHours
                                                                .toString() +
                                                            " hours.");
                                                            } else if (date.isAfter(new DateTime.now())) {

                                                              print('--hrs--' +
                                                                  diffInHours
                                                                      .toString());
                                                              print('--fastingHours--' +
                                                                  fastingHours
                                                                      .toString());

                                                              _showMessageDialog(
                                                                  context,
                                                                  'Future time is not allowed, please enter current or some past time!');
                                                            } else {
                                                              print(
                                                                  'heheheheheheokkkkkk');

                                                                setState(() {
                                                                  customDate =
                                                                      date;
                                                                  print(
                                                                      'confirm $date');

                                                                  prefs.setString(
                                                                      'fast_start_time',
                                                                      customDate
                                                                          .toIso8601String());

                                                                  DateTime
                                                                      savedDate =
                                                                      customDate;

                                                                  DateTime
                                                                      nowDate =
                                                                      new DateTime
                                                                          .now();
                                                                  initialTimerPosition = nowDate
                                                                      .difference(
                                                                          savedDate)
                                                                      .inSeconds;

                                                                  if (prefs
                                                                      .containsKey(
                                                                          "fasting_hours"))
                                                                    fastingHours =
                                                                        prefs.getInt(
                                                                            "fasting_hours");
                                                                  else
                                                                    fastingHours =
                                                                        13;

                                                                  totalSeconds =
                                                                      fastingHours *
                                                                          3600;
                                                                  autoStart =
                                                                      true;

                                                                  fastStartsAt =
                                                                      getFastStartTime();
                                                                  fastEndsAt =
                                                                      getFastEndTime();

                                                                  print('--iiiii---' +
                                                                      initialTimerPosition
                                                                          .toString());
                                                                });
                                                            }
                                                            countDownController.start();
                                                          },
                                                              currentTime:
                                                                  DateTime
                                                                      .now(),
                                                              locale: LocaleType
                                                                  .en);
                                                        },
                                                        child: Container(
                                                          // margin: EdgeInsets.only(left: 40, right: 40),
                                                          alignment:
                                                              Alignment.center,
                                                          // decoration: BoxDecoration(
                                                          //     borderRadius: new BorderRadius.circular(24.0),
                                                          //     color: Colors.grey[300]),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 0,
                                                                    right: 0,
                                                                    top: 0,
                                                                    bottom: 0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Edit Start",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1
                                                                      .merge(
                                                                        TextStyle(
                                                                            color: Theme.of(context)
                                                                                .accentColor,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .edit_rounded,
                                                                  size: 12,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .accentColor,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'Fast Ending',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .merge(
                                                              TextStyle(
                                                                  fontSize: 13,
                                                                  color: config.Colors().textColor()),
                                                            ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        fastEndsAt,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .merge(
                                                              TextStyle(
                                                                  color: config.Colors().textColor(),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 0,
                                                                    right: 0,
                                                                    top: 0,
                                                                    bottom: 0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1
                                                                      .merge(
                                                                        TextStyle(
                                                                            color: Theme.of(context)
                                                                                .accentColor,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  ButtonTheme(
                                                    minWidth: 50,
                                                    child: RaisedButton(
                                                      onPressed: () {},
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 14),
                                                      color: Colors.white,
                                                      shape: new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  24.0)),
                                                      child: Icon(
                                                        Icons.face,
                                                        size: 18,
                                                          color: Colors.black87
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: ButtonTheme(
                                                      // minWidth: 200,
                                                      child: RaisedButton(
                                                        onPressed: () async {
                                                          _showEndFastDialog(
                                                              context);
                                                        },
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 14),
                                                        color: Colors.white,
                                                        shape: new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    24.0)),
                                                        child: Text(
                                                          'End Fast',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  ButtonTheme(
                                                    minWidth: 50,
                                                    child: RaisedButton(
                                                      onPressed: () {},
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 14),
                                                      color: Colors.white,
                                                      shape: new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  24.0)),
                                                      child: Icon(
                                                        Icons.share,
                                                        size: 18,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              GestureDetector(
                                                onTap: null,
                                                child: Text(
                                                  "Schedule SlimScents Products",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption
                                                      .merge(TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                      )),
                                                ),
                                              )
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    prefs.setBool(
                                                        "fast_started", true);

                                                    isFastStarted = true;

                                                    DateTime _dateTime =
                                                        new DateTime.now();
                                                    prefs.setString(
                                                        'fast_start_time',
                                                        _dateTime
                                                            .toIso8601String());

                                                    DateTime savedDate;
                                                    if (prefs.containsKey(
                                                        "fast_start_time")) {
                                                      savedDate = DateTime.parse(
                                                          prefs.getString(
                                                              'fast_start_time'));
                                                    } else {
                                                      savedDate =
                                                          new DateTime.now();
                                                    }
                                                    DateTime nowDate =
                                                        new DateTime.now();
                                                    initialTimerPosition =
                                                        nowDate
                                                            .difference(
                                                                savedDate)
                                                            .inSeconds;

                                                    if (prefs.containsKey(
                                                        "fasting_hours"))
                                                      fastingHours =
                                                          prefs.getInt(
                                                              "fasting_hours");
                                                    else
                                                      fastingHours = 13;

                                                    totalSeconds =
                                                        fastingHours * 3600;
                                                    // autoStart = true;

                                                    fastStartsAt =
                                                        getFastStartTime();
                                                    fastEndsAt =
                                                        getFastEndTime();
                                                  });
                                                  countDownController.start();
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(24.0),
                                                      color: Theme.of(context)
                                                          .accentColor),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 10,
                                                        bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Start your ' +
                                                              fastingHours
                                                                  .toString() +
                                                              'h fast',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline1
                                                                  .merge(
                                                                    TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w800),
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      prefs.setInt(
                                                          "fasting_hours", 13);
                                                      prefs.setBool(
                                                          "fast_started",
                                                          false);
                                                      prefs.setBool(
                                                          "have_fast", false);
                                                      prefs.setString(
                                                          "fast_start_time",
                                                          "");

                                                      setState(() {
                                                        havingFast = false;
                                                        isFastStarted = false;
                                                        fastingHours = 13;
                                                        totalSeconds = 46800;
                                                        initialTimerPosition =
                                                            0;
                                                        fastStartsAt = "";
                                                        fastEndsAt = "";
                                                        autoStart = false;
                                                      });
                                                    },
                                                    child: Text(
                                                      'Change Fast',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          .merge(
                                                            TextStyle(
                                                                color: config.Colors().textColor(),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              '/Reminder');
                                                    },
                                                    child: Text(
                                                      'Set Reminder',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          .merge(
                                                            TextStyle(
                                                                color: config.Colors().textColor(),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                  ],
                                )),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              S.current.choose_get_started,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .merge(TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w800)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              S.current.lorem_ipsum,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .merge(TextStyle(color: config.Colors().textColor())),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    prefs.setInt("fasting_hours", 13);
                                    prefs.setBool("fast_started", false);
                                    prefs.setBool("have_fast", true);
                                    setState(() {
                                      havingFast = true;
                                      isFastStarted = false;
                                      fastingHours = 13;
                                      totalSeconds = 46800;
                                      initialTimerPosition = 0;
                                    });
                                  },
                                  child: Container(
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      0.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Theme.of(context)
                                                  .accentColor),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.current.circadian_trf,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10)),
                                              ),
                                              Text(
                                                '13',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    .merge(TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 36,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                              ),
                                              Text(
                                                'Hours',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      0.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.current.select,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                    color: Colors.black87,
                                                        fontSize: 10)),
                                              ),
                                              Icon(
                                                Icons.info_outline_rounded,
                                                size: 12,
                                                color: Colors.black87,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    prefs.setInt("fasting_hours", 20);
                                    prefs.setBool("fast_started", false);
                                    prefs.setBool("have_fast", true);
                                    setState(() {
                                      havingFast = true;
                                      isFastStarted = false;
                                      fastingHours = 20;

                                      totalSeconds = 3600 * 20;
                                      initialTimerPosition = 0;
                                    });
                                  },
                                  child: Container(
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      0.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Theme.of(context)
                                                  .accentColor),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.current.circadian_trf,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10)),
                                              ),
                                              Text(
                                                '20',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    .merge(TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 36,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                              ),
                                              Text(
                                                'Hours',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      0.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.current.select,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                    color: Colors.black87,
                                                        fontSize: 10)),
                                              ),
                                              Icon(
                                                Icons.info_outline_rounded,
                                                size: 12,
                                                color: Colors.black87,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    prefs.setInt("fasting_hours", 24);
                                    prefs.setBool("fast_started", false);
                                    prefs.setBool("have_fast", true);
                                    setState(() {
                                      havingFast = true;
                                      isFastStarted = false;
                                      fastingHours = 24;
                                      totalSeconds = 3600 * 24;
                                      initialTimerPosition = 0;
                                    });
                                  },
                                  child: Container(
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      0.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Theme.of(context)
                                                  .accentColor),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.current.circadian_trf,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10)),
                                              ),
                                              Text(
                                                '24',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    .merge(TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 36,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                              ),
                                              Text(
                                                'Hours',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      0.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.current.select,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                    color: Colors.black87,
                                                        fontSize: 10)),
                                              ),
                                              Icon(
                                                Icons.info_outline_rounded,
                                                size: 12,
                                                color: Colors.black87,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    prefs.setInt("fasting_hours", 28);
                                    prefs.setBool("fast_started", false);
                                    prefs.setBool("have_fast", true);
                                    setState(() {
                                      havingFast = true;
                                      isFastStarted = false;
                                      fastingHours = 28;
                                      totalSeconds = 3600 * 28;
                                      initialTimerPosition = 0;
                                    });
                                  },
                                  child: Container(
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      0.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Theme.of(context)
                                                  .accentColor),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.current.circadian_trf,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10)),
                                              ),
                                              Text(
                                                '28',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    .merge(TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 36,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                              ),
                                              Text(
                                                'Hours',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      0.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.current.select,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                    color: Colors.black87,
                                                        fontSize: 10)),
                                              ),
                                              Icon(
                                                Icons.info_outline_rounded,
                                                size: 12,
                                                color: Colors.black87,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    prefs.setInt("fasting_hours", 32);
                                    prefs.setBool("fast_started", false);
                                    prefs.setBool("have_fast", true);
                                    setState(() {
                                      havingFast = true;
                                      isFastStarted = false;
                                      fastingHours = 32;
                                      totalSeconds = 3600 * 32;
                                      initialTimerPosition = 0;
                                    });
                                  },
                                  child: Container(
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      0.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Theme.of(context)
                                                  .accentColor),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.current.circadian_trf,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10)),
                                              ),
                                              Text(
                                                '32',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    .merge(TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 36,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                              ),
                                              Text(
                                                'Hours',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      0.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.current.select,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 10)),
                                              ),
                                              Icon(
                                                Icons.info_outline_rounded,
                                                size: 12,color: Colors.black87,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    prefs.setInt("fasting_hours", 36);
                                    prefs.setBool("fast_started", false);
                                    prefs.setBool("have_fast", true);
                                    setState(() {
                                      havingFast = true;
                                      isFastStarted = false;
                                      fastingHours = 36;
                                      totalSeconds = 3600 * 36;
                                      initialTimerPosition = 0;
                                    });
                                  },
                                  child: Container(
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      0.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Theme.of(context)
                                                  .accentColor),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.current.circadian_trf,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10)),
                                              ),
                                              Text(
                                                '36',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    .merge(TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 36,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                              ),
                                              Text(
                                                'Hours',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      0.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.current.select,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 10)),
                                              ),
                                              Icon(
                                                Icons.info_outline_rounded,
                                                size: 12,
                                                color: Colors.black87,
                                              )
                                            ],
                                          ),
                                        )
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
    );
  }

  void _showEndFastDialog(BuildContext ctx) {
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
                          'End Fast',
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
                          'Are you sure to end fast now?',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .merge(TextStyle(color: config.Colors().textColor())),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonTheme(
                          minWidth: 250,
                          child: RaisedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              DateTime endDate = new DateTime.now();
                              await _con.saveFast(endDate);
                              setState(() {
                                prefs.setBool("have_fast", false);
                                havingFast = false;

                                prefs.setBool("fast_started", false);
                                isFastStarted = false;

                                prefs.setInt("fasting_hours", 13);
                                fastingHours = 13;
                                countDownController.pause();
                                totalSeconds = 46800;
                                initialTimerPosition = 0;
                                autoStart = false;
                              });
                            },
                            padding: EdgeInsets.symmetric(vertical: 14),
                            color: config.Colors().textColor(),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(24.0)),
                            child: Text(
                              'End Fast Now',
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
                              color: config.Colors().textColor(), shape: BoxShape.circle),
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

  void _showMessageDialog(BuildContext ctx, String msg) {
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
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .merge(TextStyle(color: config.Colors().textColor())),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonTheme(
                          minWidth: 250,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            padding: EdgeInsets.symmetric(vertical: 14),
                            color: Colors.black54,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(24.0)),
                            child: Text(
                              'Close',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context).pop();
                        //   },
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       'Dismiss',
                        //       style: Theme.of(context).textTheme.bodyText2.merge(
                        //         TextStyle(
                        //             color: config.Colors().textColor(),
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                              color: config.Colors().bgColor(), shape: BoxShape.circle),
                          child: Icon(
                            Icons.close_rounded,
                            color: config.Colors().textColor(),
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
