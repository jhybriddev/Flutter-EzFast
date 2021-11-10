import 'dart:ffi';

import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:ezfastnow/src/models/FastDataSource.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart'; // for date format
import '../helpers/app_config.dart' as config;

class HistoryWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HistoryWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends StateMVC<HistoryWidget> {
  HomeController _con;

  int toggleIndex = 1;
  int totalFastToggleIndex = 0;
  int weightToggleIndex = 0;
  int sleepToggleIndex = 0;
  int heartRateToggleIndex = 0;
  CalendarController _calendarController;

  int touchedIndex;
  final Color barBackgroundColor = Colors.grey[300];

  _HistoryWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    _calendarController = CalendarController();
    super.initState();
    _con.listenForFasts();
    _con.listenForSlimScents();
    _con.listenForWeights();
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
                ToggleSwitch(
                  minWidth: 150,
                  minHeight: 40.0,
                  initialLabelIndex: toggleIndex,
                  cornerRadius: 30.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey[300],
                  inactiveFgColor: Theme.of(context).accentColor,
                  labels: ['Statistics', 'Calendar'],
                  // icons: [Icons.stacked_bar_chart, Icons.calendar_today_sharp],
                  iconSize: 16.0,
                  fontSize: 15,
                  activeBgColors: [
                    Theme.of(context).focusColor.withOpacity(0.8),
                    Theme.of(context).focusColor.withOpacity(0.8)
                  ],
                  onToggle: (index) {
                    toggleIndex = index;
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                (toggleIndex == 1)
                    ? Column(
                        children: [
                          SfCalendar(
                            view: CalendarView.month,
                            onViewChanged: (ViewChangedDetails visibleDates) {},
                            onTap: (CalendarTapDetails c) {
                              _con.setSelectedFast(c.date);
                              _con.setSelectedSlimScent(c.date);
                            },
                            // controller: _calendarController,
                            dataSource: FastDataSource(_con.fastsList),
                            // // by default the month appointment display mode set as Indicator, we can
                            // // change the display mode as appointment using the appointment display
                            // // mode property
                            // monthCellBuilder: (BuildContext buildContext,
                            //     MonthCellDetails details) {
                            //   final Color backgroundColor = Colors.transparent;
                            //   // _getMonthCellBackgroundColor(details.date);
                            //   Color defaultColor =
                            //       // model.themeData != null &&
                            //       //     model.themeData.brightness == Brightness.dark
                            //       //     ?
                            //       Colors.grey[200];
                            //   // : Colors.white;
                            //   return Container(
                            //     decoration: BoxDecoration(
                            //         color: backgroundColor,
                            //         border: Border.all(
                            //             color: defaultColor, width: 0.5)),
                            //     child: Center(
                            //       child: Column(
                            //         children: [
                            //           Text(
                            //             details.date.day.toString(),
                            //             style: TextStyle(color: Colors.black),
                            //           ),
                            //           // Text(
                            //           //   details.appointments.first.subject.toString(),
                            //           //   style: TextStyle(color: Colors.black),
                            //           // ),
                            //         ],
                            //       )
                            //     ),
                            //   );
                            // },

                            // scheduleViewMonthHeaderBuilder:
                            //     (BuildContext buildContext,
                            //         ScheduleViewMonthHeaderDetails details) {
                            //   final String monthName =
                            //       '_getMonthDate(details.date.month)';
                            //   return Stack(
                            //     children: [
                            //       Image(
                            //           image: ExactAssetImage(
                            //               'images/' + monthName + '.png'),
                            //           fit: BoxFit.cover,
                            //           width: details.bounds.width,
                            //           height: details.bounds.height),
                            //       Positioned(
                            //         left: 55,
                            //         right: 0,
                            //         top: 20,
                            //         bottom: 0,
                            //         child: Text(
                            //           monthName +
                            //               ' ' +
                            //               details.date.year.toString(),
                            //           style: TextStyle(fontSize: 18),
                            //         ),
                            //       )
                            //     ],
                            //   );
                            // },
                            // appointmentBuilder: (BuildContext context,
                            //     CalendarAppointmentDetails details) {
                            //   final Appointment meeting =
                            //       details.appointments.first;
                            //   return Container(
                            //     child: Text(
                            //       meeting.subject,
                            //       style: TextStyle(
                            //         color: Colors.redAccent,
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //       maxLines: 3,
                            //       softWrap: false,
                            //       overflow: TextOverflow.ellipsis,
                            //     ),
                            //   );
                            // },

                            monthViewSettings: MonthViewSettings(
                              appointmentDisplayMode:
                                  MonthAppointmentDisplayMode.indicator,
                              // agendaItemHeight: 50,
                              // appointmentDisplayCount: 1,
                              // showAgenda: false,
                              // agendaViewHeight: 100,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          _con.selectedFast != null
                              ?
                              // Card(
                              //         margin: EdgeInsets.all(0),
                              //         color: Colors.white,
                              //         elevation: 4,
                              //         shadowColor: Theme.of(context).focusColor,
                              //         child:
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text(
                                        // S.current.circadian_trf + ' '+ _con.selectedFast.fastHours + ' Hours',
                                        _con.selectedFast.fastType,
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .merge(TextStyle(
                                                color:
                                                    config.Colors().textColor(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      LinearPercentIndicator(
                                        // width: MediaQuery.of(context).size.width - 50,
                                        animation: true,
                                        lineHeight: 30.0,
                                        animationDuration: 1000,
                                        percent:
                                            _con.selectedFast.getFastPercent(),
                                        center: Text(
                                          _con.selectedFast.getFastPercentage(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .merge(TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor:
                                            Theme.of(context).accentColor,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Started At",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(
                                                      TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                              ),
                                              Text(
                                                _con.selectedFast
                                                    .getFastStartTimeInFormat(_con
                                                        .CURRENT_DATE_TIME_FORMAT),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Ended At",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(
                                                      TextStyle(
                                                          color: config.Colors()
                                                              .textColor(),
                                                          fontSize: 12),
                                                    ),
                                              ),
                                              Text(
                                                _con.selectedFast
                                                    .getFastEndTimeInFormat(_con
                                                        .CURRENT_DATE_TIME_FORMAT),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Duration",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(
                                                      TextStyle(
                                                          color: config.Colors()
                                                              .textColor(),
                                                          fontSize: 12),
                                                    ),
                                              ),
                                              Text(
                                                _con.selectedFast
                                                    .getFastDurationInHrs(),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              // )
                              : Container(),
                          // SizedBox(height: 20,),
                          _con.selectedSlimScent != null
                              ? Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text(
                                        '',
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .merge(TextStyle(
                                                color:
                                                    config.Colors().textColor(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      // SizedBox(
                                      //   height: 4,
                                      // ),
                                      LinearPercentIndicator(
                                        animation: true,
                                        lineHeight: 30.0,
                                        animationDuration: 1000,
                                        percent: 1,
                                        center: Text(
                                          'SlimScent Used',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .merge(TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "SlimScent At",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(
                                                      TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                              ),
                                              Text(
                                                _con.selectedSlimScent
                                                    .getFastStartTimeInFormat(_con
                                                        .CURRENT_DATE_TIME_FORMAT),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Summary
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total Fasts",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(
                                                    TextStyle(
                                                      color: config.Colors()
                                                          .textColor(),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                            ),
                                            Text(
                                              _con.fastsList != null
                                                  ? _con.fastsList.length
                                                      .toString()
                                                  : '0',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      color: config.Colors()
                                                          .textColor(),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "7-Fast Avg",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(
                                                    TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 12),
                                                  ),
                                            ),
                                            Text(
                                              '0h',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      color: config.Colors()
                                                          .textColor(),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Longest Fast",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(
                                                    TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 12),
                                                  ),
                                            ),
                                            Text(
                                              _con.longestFast != null
                                                  ? _con.longestFast
                                                      .getFastDurationInHrs()
                                                  : '0h',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      color: config.Colors()
                                                          .textColor(),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Longest Streak",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(
                                                    TextStyle(
                                                      color: config.Colors()
                                                          .textColor(),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                            ),
                                            Text(
                                              '0',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      color: config.Colors()
                                                          .textColor(),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Current Streak",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(
                                                    TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 12),
                                                  ),
                                            ),
                                            Text(
                                              '0',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      color: config.Colors()
                                                          .textColor(),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Weight",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(
                                                    TextStyle(
                                                        color: config.Colors()
                                                            .textColor(),
                                                        fontSize: 12),
                                                  ),
                                            ),
                                            Text(
                                              '0',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(TextStyle(
                                                      color: config.Colors()
                                                          .textColor(),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //Recent Fasts
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Recent Fasts',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .merge(TextStyle(
                                      color: config.Colors().textColor(),
                                      fontSize: 16,
                                    ))),
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
                                    height: 150,
                                    // Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16.0, left: 6.0),
                                    child: (_con.fastsList != null &&
                                            _con.fastsList.length > 0)
                                        ? BarChart(
                                            recentBarData(),
                                            swapAnimationDuration:
                                                const Duration(
                                                    milliseconds: 250),
                                          )
                                        : Center(
                                            child: Text(
                                                'Log fasts to build your graph'),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Total Fast Hours
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Total Fasting Hours',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(
                                        color: config.Colors().textColor(),
                                        fontSize: 16,
                                      )),
                                )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/AllFastsHours');
                                    },
                                    child: Text(
                                      'See More',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .accentColor)),
                                    ))
                              ],
                            ),
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ToggleSwitch(
                                    // minWidth: 50,
                                    minHeight: 30.0,
                                    initialLabelIndex: totalFastToggleIndex,
                                    cornerRadius: 30.0,
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: Colors.grey[300],
                                    inactiveFgColor:
                                        Theme.of(context).accentColor,
                                    labels: ['WEEK', 'MONTH', 'YEAR'],
                                    // icons: [Icons.stacked_bar_chart, Icons.calendar_today_sharp],
                                    iconSize: 12.0,
                                    fontSize: 12,
                                    activeBgColors: [
                                      Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.8),
                                      Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.8),
                                      Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.8)
                                    ],
                                    onToggle: (index) {
                                      totalFastToggleIndex = index;
                                      if (index == 0) _con.setTotalFastWeek();
                                      if (index == 1) _con.setTotalFastMonth();
                                      if (index == 2) _con.setTotalFastYear();
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Total Hours',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(TextStyle(
                                            color: config.Colors().textColor(),
                                            fontSize: 14,
                                          )),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        _con.totalFastGraphHoursTxt.length > 0
                                            ? _con.totalFastGraphHoursTxt
                                            : '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .merge(TextStyle(
                                                color:
                                                    config.Colors().textColor(),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      )),
                                      Text(
                                        _con.totalFastGraphDatesTxt,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .merge(TextStyle(
                                                color:
                                                    config.Colors().textColor(),
                                                fontSize: 12)),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 150,
                                    // Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16.0, left: 6.0),
                                    child: (_con.totalGraphFastsList != null &&
                                            _con.totalGraphFastsList.length > 0)
                                        ? BarChart(
                                            recentBarData(),
                                            swapAnimationDuration:
                                                const Duration(
                                                    milliseconds: 250),
                                          )
                                        : Center(
                                            child: Text(
                                                'Log fasts to build your graph'),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Weight
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Weight',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(
                                        color: config.Colors().textColor(),
                                        fontSize: 16,
                                      )),
                                )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/AllWeights');
                                    },
                                    child: Text(
                                      'See More',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .accentColor)),
                                    ))
                              ],
                            ),
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ToggleSwitch(
                                    // minWidth: 50,
                                    minHeight: 30.0,
                                    initialLabelIndex: weightToggleIndex,
                                    cornerRadius: 30.0,
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: Colors.grey[300],
                                    inactiveFgColor:
                                        Theme.of(context).accentColor,
                                    labels: ['WEEK', 'MONTH', 'YEAR'],
                                    // icons: [Icons.stacked_bar_chart, Icons.calendar_today_sharp],
                                    iconSize: 12.0,
                                    fontSize: 12,
                                    activeBgColors: [
                                      Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.8),
                                      Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.8),
                                      Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.8)
                                    ],
                                    onToggle: (index) {
                                      weightToggleIndex = index;
                                      if (index == 0) _con.setWeightWeek();
                                      if (index == 1) _con.setWeightMonth();
                                      if (index == 2) _con.setWeightYear();
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Average',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(TextStyle(
                                            color: config.Colors().textColor(),
                                            fontSize: 14,
                                          )),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        _con.aveWeightTxt.length > 0
                                            ? (_con.aveWeightTxt + 'Kg')
                                            : '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .merge(TextStyle(
                                                color:
                                                    config.Colors().textColor(),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      )),
                                      Text(
                                        _con.weightGraphDatesTxt,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .merge(TextStyle(
                                                color:
                                                    config.Colors().textColor(),
                                                fontSize: 12)),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 150,
                                    // Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16.0, left: 6.0),
                                    child: (_con.graphWeightsList != null &&
                                            _con.graphWeightsList.length > 0)
                                        ? BarChart(
                                            recentWeightBarData(),
                                            swapAnimationDuration:
                                                const Duration(
                                                    milliseconds: 250),
                                          )
                                        : Center(
                                            child: Text(
                                                'Log weights to build your graph'),
                                          ),
                                  ),
                                  // SizedBox(height: 20,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 0, right: 0),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Set Goal',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                    fontSize: 10,
                                                    color: Theme.of(context)
                                                        .accentColor)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(24.0),
                                                    bottomRight:
                                                        Radius.circular(24.0),
                                                    topLeft:
                                                        Radius.circular(24.0),
                                                    bottomLeft:
                                                        Radius.circular(23.0),
                                                  ),
                                                  color: Colors.green),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed('/SaveWeight');
                                                },
                                                child: Text(
                                                  'Log Weight',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // child: ButtonTheme(
                                          //   minWidth: 100,
                                          //   child: RaisedButton(
                                          //     onPressed: () {
                                          //
                                          //     },
                                          //     padding: EdgeInsets.symmetric(vertical: 6),
                                          //     color: Colors.green,
                                          //     shape: new RoundedRectangleBorder(
                                          //         borderRadius: new BorderRadius.circular(24.0)),
                                          //     child: Text(
                                          //       'Log Weight',
                                          //       textAlign: TextAlign.start,
                                          //         style: Theme.of(context)
                                          //             .textTheme
                                          //             .bodyText2
                                          //             .merge(TextStyle(
                                          //             fontSize: 10,
                                          //             color: Colors.white))
                                          //     ),
                                          //   ),
                                          // ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Set Reminder',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                    fontSize: 10,
                                                    color: Theme.of(context)
                                                        .accentColor)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // //Sleep
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 10),
                          //   child: Row(
                          //     children: [
                          //       Expanded(child: Text('Total Fasting Hours',
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .bodyText2
                          //             .merge(TextStyle(
                          //           color: config.Colors().textColor(),
                          //           fontSize: 16,)),)),
                          //       TextButton(
                          //           onPressed: () {},
                          //           child: Text('See More', style: Theme.of(context).textTheme.bodyText2.merge(TextStyle( fontSize: 14,color: Theme.of(context).accentColor)),)
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Card(
                          //   elevation: 2,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0),
                          //   ),
                          //   child: Padding(
                          //     padding: EdgeInsets.all(15),
                          //     child: Column(
                          //       // crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         ToggleSwitch(
                          //           // minWidth: 50,
                          //           minHeight: 30.0,
                          //           initialLabelIndex: totalFastToggleIndex,
                          //           cornerRadius: 30.0,
                          //           activeFgColor: Colors.white,
                          //           inactiveBgColor: Colors.grey[300],
                          //           inactiveFgColor: Theme.of(context).accentColor,
                          //           labels: ['WEEK', 'MONTH', 'YEAR'],
                          //           // icons: [Icons.stacked_bar_chart, Icons.calendar_today_sharp],
                          //           iconSize: 12.0,
                          //           fontSize: 12,
                          //           activeBgColors: [
                          //             Theme.of(context).focusColor.withOpacity(0.8),
                          //             Theme.of(context).focusColor.withOpacity(0.8),
                          //             Theme.of(context).focusColor.withOpacity(0.8)
                          //           ],
                          //           onToggle: (index) {
                          //             totalFastToggleIndex = index;
                          //             if (index==0) _con.setTotalFastWeek();
                          //             if (index==1) _con.setTotalFastMonth();
                          //             if (index==2) _con.setTotalFastYear();
                          //             setState(() {});
                          //           },
                          //         ),
                          //         SizedBox(
                          //           height: 20,
                          //         ),
                          //         Container(
                          //           alignment: Alignment.centerLeft,
                          //           child: Text('Total Hours',style: Theme.of(context)
                          //               .textTheme
                          //               .bodyText2
                          //               .merge(TextStyle(
                          //             color: config.Colors().textColor(),
                          //             fontSize: 14,)),),
                          //         ),
                          //         Row(
                          //           children: [
                          //             Expanded(
                          //                 child: Text(_con.totalFastGraphHoursTxt,
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .bodyText2
                          //                       .merge(TextStyle(
                          //                       color: config.Colors().textColor(),
                          //                       fontSize: 16,
                          //                       fontWeight:
                          //                       FontWeight.w500)),)
                          //             ),
                          //             Text(_con.totalFastGraphDatesTxt,
                          //               style: Theme.of(context)
                          //                   .textTheme
                          //                   .bodyText2
                          //                   .merge(TextStyle(
                          //                   color: config.Colors().textColor(),
                          //                   fontSize: 12)),)
                          //           ],),
                          //         SizedBox(height: 20,),
                          //         Container(
                          //           height: 150,
                          //           // Padding(
                          //           padding: const EdgeInsets.only(
                          //               right: 16.0, left: 6.0),
                          //           child: (_con.totalGraphFastsList!=null)
                          //               ? BarChart(
                          //             recentBarData(),
                          //             swapAnimationDuration:
                          //             const Duration(milliseconds: 250),
                          //           )
                          //               : Center(
                          //             child: Text('Log fasts to build your graph'),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          //
                          // // Hear Rate
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 10),
                          //   child: Row(
                          //     children: [
                          //       Expanded(child: Text('Total Fasting Hours',
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .bodyText2
                          //             .merge(TextStyle(
                          //           color: config.Colors().textColor(),
                          //           fontSize: 16,)),)),
                          //       TextButton(
                          //           onPressed: () {},
                          //           child: Text('See More', style: Theme.of(context).textTheme.bodyText2.merge(TextStyle( fontSize: 14,color: Theme.of(context).accentColor)),)
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Card(
                          //   elevation: 2,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0),
                          //   ),
                          //   child: Padding(
                          //     padding: EdgeInsets.all(15),
                          //     child: Column(
                          //       // crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         ToggleSwitch(
                          //           // minWidth: 50,
                          //           minHeight: 30.0,
                          //           initialLabelIndex: totalFastToggleIndex,
                          //           cornerRadius: 30.0,
                          //           activeFgColor: Colors.white,
                          //           inactiveBgColor: Colors.grey[300],
                          //           inactiveFgColor: Theme.of(context).accentColor,
                          //           labels: ['WEEK', 'MONTH', 'YEAR'],
                          //           // icons: [Icons.stacked_bar_chart, Icons.calendar_today_sharp],
                          //           iconSize: 12.0,
                          //           fontSize: 12,
                          //           activeBgColors: [
                          //             Theme.of(context).focusColor.withOpacity(0.8),
                          //             Theme.of(context).focusColor.withOpacity(0.8),
                          //             Theme.of(context).focusColor.withOpacity(0.8)
                          //           ],
                          //           onToggle: (index) {
                          //             totalFastToggleIndex = index;
                          //             if (index==0) _con.setTotalFastWeek();
                          //             if (index==1) _con.setTotalFastMonth();
                          //             if (index==2) _con.setTotalFastYear();
                          //             setState(() {});
                          //           },
                          //         ),
                          //         SizedBox(
                          //           height: 20,
                          //         ),
                          //         Container(
                          //           alignment: Alignment.centerLeft,
                          //           child: Text('Total Hours',style: Theme.of(context)
                          //               .textTheme
                          //               .bodyText2
                          //               .merge(TextStyle(
                          //             color: config.Colors().textColor(),
                          //             fontSize: 14,)),),
                          //         ),
                          //         Row(
                          //           children: [
                          //             Expanded(
                          //                 child: Text(_con.totalFastGraphHoursTxt,
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .bodyText2
                          //                       .merge(TextStyle(
                          //                       color: config.Colors().textColor(),
                          //                       fontSize: 16,
                          //                       fontWeight:
                          //                       FontWeight.w500)),)
                          //             ),
                          //             Text(_con.totalFastGraphDatesTxt,
                          //               style: Theme.of(context)
                          //                   .textTheme
                          //                   .bodyText2
                          //                   .merge(TextStyle(
                          //                   color: config.Colors().textColor(),
                          //                   fontSize: 12)),)
                          //           ],),
                          //         SizedBox(height: 20,),
                          //         Container(
                          //           height: 150,
                          //           // Padding(
                          //           padding: const EdgeInsets.only(
                          //               right: 16.0, left: 6.0),
                          //           child: (_con.totalGraphFastsList!=null)
                          //               ? BarChart(
                          //             recentBarData(),
                          //             swapAnimationDuration:
                          //             const Duration(milliseconds: 250),
                          //           )
                          //               : Center(
                          //             child: Text('Log fasts to build your graph'),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  BarChartData recentBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Theme.of(context).accentColor,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              // String weekDay;
              // switch (group.x.toInt()) {
              //   case 0:
              //     weekDay = 'Monday';
              //     break;
              //   case 1:
              //     weekDay = 'Tuesday';
              //     break;
              //   case 2:
              //     weekDay = 'Wednesday';
              //     break;
              //   case 3:
              //     weekDay = 'Thursday';
              //     break;
              //   case 4:
              //     weekDay = 'Friday';
              //     break;
              //   case 5:
              //     weekDay = 'Saturday';
              //     break;
              //   case 6:
              //     weekDay = 'Sunday';
              //     break;
              // }
              // return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(), TextStyle(color: Colors.yellow));
              String txt = '';
              txt = _con.fastsList
                      .elementAt(group.x.toInt())
                      .getFastDurationInHrs() +
                  "\n" +
                  _con.fastsList.elementAt(group.x.toInt()).getFastPercentage();
              return BarTooltipItem(
                  // (rod.y - 1).toString() + ' Hrs',
                  txt,
                  Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: Colors.white)));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => Theme.of(context).textTheme.caption.merge(
              TextStyle(color: config.Colors().textColor(), fontSize: 12)),
          margin: 16,
          getTitles: (double value) {
            DateTime dt = DateTime.parse(
                _con.fastsList.elementAt(value.toInt()).fastStart);
            dt = DateTime(dt.year, dt.month, dt.day, 0, 0, 0);
            DateTime now = DateTime.now();
            now = DateTime(now.year, now.month, now.day, 0, 0, 0);

            if (dt == now) {
              return 'Today';
            } else
              return DateFormat("EEE").format(dt);
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  List<BarChartGroupData> showingGroups22() =>
      List.generate(_con.fastsList.length, (i) {
        double y = 0;
        // y = double.parse(_con.fastsList.elementAt(i).getHoursDifference());
        y = _con.fastsList.elementAt(i).getFastPercent() * 100;
        return makeGroupData(i, y, isTouched: i == touchedIndex);
      });

  List<BarChartGroupData> showingGroups() {
    List<BarChartGroupData> list = [];
    for (int i = 0; i < _con.fastsList.length; i++) {
      if (!_con.fastsList.elementAt(i).isSlimScent) {
        double y = 0;
        y = _con.fastsList.elementAt(i).getFastPercent() * 100;
        list.add(makeGroupData(i, y, isTouched: i == touchedIndex));
      }
    }
    return list;
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = const Color(0xffB22222),
    double width = 12,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.black87] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 100,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  //Weight///////////////////////////
  BarChartData recentWeightBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Theme.of(context).accentColor,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String txt = '';
              txt = _con.weightsList.elementAt(group.x.toInt()).weight + 'Kg';
              return BarTooltipItem(
                  txt,
                  Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: Colors.white)));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => Theme.of(context).textTheme.caption.merge(
              TextStyle(color: config.Colors().textColor(), fontSize: 12)),
          margin: 16,
          getTitles: (double value) {
            DateTime dt = DateTime.parse(
                _con.weightsList.elementAt(value.toInt()).dateTime);
            dt = DateTime(dt.year, dt.month, dt.day, 0, 0, 0);
            DateTime now = DateTime.now();
            now = DateTime(now.year, now.month, now.day, 0, 0, 0);

            if (dt == now) {
              return 'Today';
            } else
              return DateFormat("EEE").format(dt);
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingWeightsGroups(),
    );
  }

  List<BarChartGroupData> showingWeightsGroups() =>
      List.generate(_con.weightsList.length, (i) {
        double y = 0;
        y = double.parse(_con.weightsList.elementAt(i).weight);
        return makeWeightsGroupData(i, y, isTouched: i == touchedIndex);
      });

  BarChartGroupData makeWeightsGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = const Color(0xffB22222),
    double width = 12,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.black87] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 100,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
//////////////////////////////////
}
