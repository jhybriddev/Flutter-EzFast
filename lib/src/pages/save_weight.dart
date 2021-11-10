import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart'; // for date format

class SaveWeightWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  SaveWeightWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _SaveWeightWidgetState createState() => _SaveWeightWidgetState();
}

class _SaveWeightWidgetState extends StateMVC<SaveWeightWidget> {
  HomeController _con;

  TextEditingController weightController = TextEditingController();

  DateTime dateTime;
  String dateTimeValue = '';

  _SaveWeightWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    dateTime = DateTime.now();
    dateTimeValue = DateFormat('dd MMM, yyyy ' + _con.CURRENT_DATE_TIME_FORMAT).format(dateTime);
    super.initState();
    weightController = TextEditingController();
    weightController.addListener(() {
      setState(() {});
    });
    setState(() { });
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
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
                      style: Theme.of(context).textTheme.headline4.merge(
                          TextStyle(
                              color: config.Colors().textColor(),
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Row(
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
              color: Colors.black38,
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
                                        InkWell(
                                          onTap: () {
                                            DatePicker.showDateTimePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(2000, 1, 1),
                                                maxTime: DateTime.now(),
                                                onChanged: (date) {},
                                                onConfirm: (date) {
                                                  dateTimeValue = DateFormat('dd MMM, yyyy ' + _con.CURRENT_DATE_TIME_FORMAT).format(date);
                                                  dateTime = date;
                                                  setState(() { });
                                            }, currentTime: DateTime.now(), locale: LocaleType.en);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Date & Time',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            .merge(TextStyle(
                                                              color: config
                                                                      .Colors()
                                                                  .textColor(),
                                                              fontSize: 14,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  dateTimeValue,
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
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: 10,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 0.5,
                                          color: Colors.grey[300],
                                        ),
                                        InkWell(
                                          // onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 15, bottom: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Weight',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            .merge(TextStyle(
                                                              color: config
                                                                      .Colors()
                                                                  .textColor(),
                                                              fontSize: 14,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 70,
                                                  height: 30,
                                                  child: TextFormField(
                                                    controller:
                                                        weightController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(4),
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey[300]
                                                                  .withOpacity(
                                                                      0.2))),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey[300]
                                                                  .withOpacity(
                                                                      0.5))),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey[300]
                                                                  .withOpacity(
                                                                      0.2))),
                                                    ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .merge(TextStyle(
                                                            color: Colors
                                                                .black87)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Kg',
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
            ButtonTheme(
              minWidth: 300,
              child: RaisedButton(
                onPressed: () {
                  if(weightController.text.length>0) {
                    _con.saveWeight(dateTime, weightController.text);
                  } else {
                    Fluttertoast.showToast(msg: 'Please enter value for weight!');
                  }
                },
                padding: EdgeInsets.symmetric(vertical: 14),
                color: Colors.black54,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(24.0)),
                child: Text(
                  'Save Weight',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
