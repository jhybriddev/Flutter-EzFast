import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;

class MyDataWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  MyDataWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _MyDataWidgetState createState() => _MyDataWidgetState();
}

class _MyDataWidgetState extends StateMVC<MyDataWidget> {
  HomeController _con;

  _MyDataWidgetState() : super(HomeController()) {
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
                      'My Data',
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
                                          onTap: () {},
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
                                                        'Export Data',
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
                                        // SizedBox(height: 15,),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 0.5,
                                          color: Colors.grey[300],
                                        ),
                                        // SizedBox(height: 15,),
                                        InkWell(
                                          onTap: () {
                                            _showDeleteDialog(
                                                context,
                                                "Are you sure to delete all of your data?",
                                                false);
                                          },
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
                                                        'Delete All Data',
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
                                        // SizedBox(height: 15,),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 0.5,
                                          color: Colors.grey[300],
                                        ),
                                        // SizedBox(height: 15,),
                                        InkWell(
                                          onTap: () {
                                            _showDeleteDialog(
                                                context,
                                                "Are you sure to delete this account?",
                                                true);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 15, bottom: 10),
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
                                                        'Delete My Account',
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
                                        // SizedBox(height: 10,),
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

  void _showDeleteDialog(BuildContext ctx, String msg, bool isAccDelete) {
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
                          style: Theme.of(context).textTheme.caption.merge(
                              TextStyle(color: config.Colors().textColor())),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonTheme(
                          minWidth: 250,
                          child: RaisedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();

                              if (isAccDelete) {
                                _con.deleteAll();
                                Navigator.of(context)
                                    .pushReplacementNamed('/Welcome');
                              } else {
                                _con.deleteUserData();
                                Navigator.of(context).pop();
                              }
                            },
                            padding: EdgeInsets.symmetric(vertical: 14),
                            color: config.Colors().textColor(),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(24.0)),
                            child: Text(
                              'Confirm',
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
                              color: config.Colors().textColor(),
                              shape: BoxShape.circle),
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
}
