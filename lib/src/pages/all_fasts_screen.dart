import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../helpers/app_config.dart' as config;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart'; // for date format

class AllFastsHoursWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  AllFastsHoursWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _AllFastsHoursWidgetState createState() => _AllFastsHoursWidgetState();
}

class _AllFastsHoursWidgetState extends StateMVC<AllFastsHoursWidget> {
  HomeController _con;

  int toggleIndex = 1;
  int totalFastToggleIndex = 0;

  int touchedIndex;
  final Color barBackgroundColor = Colors.grey[300];

  _AllFastsHoursWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForFasts();
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
                      'Total Fasting Hours',
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
                        height: MediaQuery.of(context).size.height/2,
                        alignment: Alignment.center,
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
            ),
          ],
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

  List<BarChartGroupData> showingGroups() =>
      List.generate(_con.fastsList.length, (i) {
        double y = 0;
        // y = double.parse(_con.fastsList.elementAt(i).getHoursDifference());
        y = _con.fastsList.elementAt(i).getFastPercent() * 100;
        return makeGroupData(i, y, isTouched: i == touchedIndex);
      });

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
}
