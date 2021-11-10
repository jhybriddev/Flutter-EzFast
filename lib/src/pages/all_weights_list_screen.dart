import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../helpers/app_config.dart' as config;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart'; // for date format

class AllWeightsListWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  AllWeightsListWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _AllWeightsListWidgetState createState() => _AllWeightsListWidgetState();
}

class _AllWeightsListWidgetState extends StateMVC<AllWeightsListWidget> {
  HomeController _con;

  _AllWeightsListWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForWeights();
  }

  Widget weightsList() {
    return ListView.separated(
        itemCount: _con.weightsList.length,
        separatorBuilder: (context, index) {
          return SizedBox(height: 0);
        },
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.1),
                      blurRadius: 15,
                      offset: Offset(0, 5)),
                ],
              ),
              margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    DateFormat('dd MMM, yyyy ' + _con.CURRENT_DATE_TIME_FORMAT)
                        .format(DateTime.parse(_con.weightsList.elementAt(index).dateTime)),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .merge(TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(child:  Text(
                        'From Zero',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .merge(TextStyle(fontSize: 16, color: Colors.black)),
                      ),),
                      Text( _con.weightsList.elementAt(index).weight + 'Kg',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .merge(TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // Icon(
                      //   Icons.arrow_forward_ios_rounded,
                      //   size: 16,
                      //   color: Colors.grey[200],
                      // ),

                    ],
                  )
                ],
              ),
            ),
          );
        });
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
              child: _con.weightsList != null && _con.weightsList.length > 0
                  ? ListView(
                      primary: false,
                      children: <Widget>[
                        weightsList(),
                      ],
                    )
                  : Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.line_weight,
                            size: 60,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'No data available',
                            style: Theme.of(context).textTheme.bodyText2.merge(
                                TextStyle(fontSize: 14, color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
