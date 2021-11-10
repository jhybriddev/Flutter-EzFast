import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../helpers/app_config.dart' as config;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart'; // for date format

class EditProfileWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  EditProfileWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends StateMVC<EditProfileWidget> {
  HomeController _con;

  int isMale = 0;

  _EditProfileWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForUser();
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
                      'Edit Profile',
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
                  child: Form(
                    key: _con.formKey,
                    child: Container(
                      // margin: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (input) => _con.user.name = input,
                            // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .merge(TextStyle(color: config.Colors().textColor())),
                              contentPadding: EdgeInsets.all(12),
                              hintText: 'Adam',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .merge(TextStyle(
                                  color:
                                  config.Colors().textColor().withOpacity(0.7))),
                              prefixIcon: Icon(Icons.person,
                                  color: config.Colors().textColor()),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                      config.Colors().textColor().withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                      config.Colors().textColor().withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                      config.Colors().textColor().withOpacity(0.2))),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .merge(TextStyle(color: config.Colors().textColor())),
                          ),
                          SizedBox(height: 20,),
                          ToggleSwitch(
                            minWidth: MediaQuery.of(context).size.width/2.5,
                            minHeight: 40.0,
                            initialLabelIndex: isMale,
                            cornerRadius: 30.0,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey[300],
                            inactiveFgColor:
                            Theme.of(context).accentColor,
                            labels: ['Male', 'Female'],
                            // icons: [Icons.stacked_bar_chart, Icons.calendar_today_sharp],
                            iconSize: 10.0,
                            fontSize: 14,
                            activeBgColors: [
                              Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.8),
                              Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.8)
                            ],
                            onToggle: (index) {
                              isMale = index;
                              if (index==0) _con.user.gender = "Male";
                              _con.user.gender = "Female";
                              setState(() { });
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width - 100,
                            child: RaisedButton(
                              onPressed: () {
                                if (isMale==0) _con.user.gender = "Male";
                                _con.user.gender = "Female";
                                _con.formKey.currentState.save();
                                _con.updateUser();
                                Navigator.of(context).pop();
                              },
                              padding: EdgeInsets.symmetric(vertical: 14),
                              color: Colors.grey,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(24.0)),
                              child: Text(
                                'Update',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         SizedBox(height: 20,),
                  //         TextFormField(
                  //           keyboardType: TextInputType.text,
                  //           onSaved: (input) => _con.user.name = input,
                  //           // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
                  //           decoration: InputDecoration(
                  //             labelText: 'Name',
                  //             labelStyle: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText1
                  //                 .merge(TextStyle(color: config.Colors().textColor())),
                  //             contentPadding: EdgeInsets.all(12),
                  //             hintText: 'Adam',
                  //             hintStyle: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText1
                  //                 .merge(TextStyle(
                  //                 color:
                  //                 config.Colors().textColor().withOpacity(0.7))),
                  //             prefixIcon: Icon(Icons.person,
                  //                 color: config.Colors().textColor()),
                  //             border: OutlineInputBorder(
                  //                 borderSide: BorderSide(
                  //                     color:
                  //                     config.Colors().textColor().withOpacity(0.2))),
                  //             focusedBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(
                  //                     color:
                  //                     config.Colors().textColor().withOpacity(0.5))),
                  //             enabledBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(
                  //                     color:
                  //                     config.Colors().textColor().withOpacity(0.2))),
                  //           ),
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .bodyText1
                  //               .merge(TextStyle(color: config.Colors().textColor())),
                  //         ),
                  //         SizedBox(height: 20,),
                  //         ToggleSwitch(
                  //           minWidth: MediaQuery.of(context).size.width/2.5,
                  //           minHeight: 40.0,
                  //           initialLabelIndex: isMale,
                  //           cornerRadius: 30.0,
                  //           activeFgColor: Colors.white,
                  //           inactiveBgColor: Colors.grey[300],
                  //           inactiveFgColor:
                  //           Theme.of(context).accentColor,
                  //           labels: ['Male', 'Female'],
                  //           // icons: [Icons.stacked_bar_chart, Icons.calendar_today_sharp],
                  //           iconSize: 10.0,
                  //           fontSize: 14,
                  //           activeBgColors: [
                  //             Theme.of(context)
                  //                 .focusColor
                  //                 .withOpacity(0.8),
                  //             Theme.of(context)
                  //                 .focusColor
                  //                 .withOpacity(0.8)
                  //           ],
                  //           onToggle: (index) {
                  //             isMale = index;
                  //             if (index==0) _con.user.gender = "Male";
                  //             _con.user.gender = "Female";
                  //             setState(() { });
                  //           },
                  //         ),
                  //         SizedBox(
                  //           height: 40,
                  //         ),
                  //         ButtonTheme(
                  //           minWidth: MediaQuery.of(context).size.width - 100,
                  //           child: RaisedButton(
                  //             onPressed: () {
                  //               _con.updateUser();
                  //             },
                  //             padding: EdgeInsets.symmetric(vertical: 14),
                  //             color: Colors.grey,
                  //             shape: new RoundedRectangleBorder(
                  //                 borderRadius: new BorderRadius.circular(24.0)),
                  //             child: Text(
                  //               S.current.sign_in,
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     )
                  //   ],
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
