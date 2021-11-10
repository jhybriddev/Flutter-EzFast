import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../helpers/app_config.dart' as config;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart'; // for date format

class AllWeightsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  AllWeightsWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _AllWeightsWidgetState createState() => _AllWeightsWidgetState();
}

class _AllWeightsWidgetState extends StateMVC<AllWeightsWidget> {
  HomeController _con;

  int weightToggleIndex = 0;
  int touchedIndex;
  final Color barBackgroundColor = Colors.grey[300];

  _AllWeightsWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForWeights();
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
                      'Weight',
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
                      ToggleSwitch(
                        // minWidth: 50,
                        minHeight: 30.0,
                        initialLabelIndex: weightToggleIndex,
                        cornerRadius: 30.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey[300],
                        inactiveFgColor: Theme.of(context).accentColor,
                        labels: ['WEEK', 'MONTH', 'YEAR'],
                        // icons: [Icons.stacked_bar_chart, Icons.calendar_today_sharp],
                        iconSize: 12.0,
                        fontSize: 12,
                        activeBgColors: [
                          Theme.of(context).focusColor.withOpacity(0.8),
                          Theme.of(context).focusColor.withOpacity(0.8),
                          Theme.of(context).focusColor.withOpacity(0.8)
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
                            style: Theme.of(context).textTheme.bodyText2.merge(
                                TextStyle(
                                    color: config.Colors().textColor(),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          )),
                          Text(
                            _con.weightGraphDatesTxt,
                            style: Theme.of(context).textTheme.bodyText2.merge(
                                TextStyle(
                                    color: config.Colors().textColor(),
                                    fontSize: 12)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        // Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                        child: (_con.graphWeightsList != null &&
                                _con.graphWeightsList.length > 0)
                            ? BarChart(
                                recentWeightBarData(),
                                swapAnimationDuration:
                                    const Duration(milliseconds: 250),
                              )
                            : Center(
                                child: Text('Log weights to build your graph'),
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
                                        color: Theme.of(context).accentColor)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Container(
                                  height: 30,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(24.0),
                                        bottomRight: Radius.circular(24.0),
                                        topLeft: Radius.circular(24.0),
                                        bottomLeft: Radius.circular(23.0),
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
                                        color: Theme.of(context).accentColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.of(context).pushNamed('/AllWeightsList')
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: new BorderRadius.circular(8.0),
                              border: Border.all(
                                  color: Theme.of(context).accentColor),
                              color: Theme.of(context).accentColor),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Container()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              Center(
                                child: Text(
                                  'SEE ALL DATA',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .merge(TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
