import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../helpers/app_config.dart' as config;

class FindEzFastWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  FindEzFastWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _FindEzFastWidgetState createState() => _FindEzFastWidgetState();
}

class _FindEzFastWidgetState extends StateMVC<FindEzFastWidget> {
  HomeController _con;

  String twitterLink = '@ezfastnow';
  String linkedinLink = '@ezfastnow';
  String youtubeLink = '@ezfastnow';
  String facebookLink = '@ezfastnow';
  String instaLink = '@ezfastnow';

  _FindEzFastWidgetState() : super(HomeController()) {
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
                    child:  Text(
                      'Find Ez Fast Now',
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
                                          child: Padding(
                                            padding:
                                            EdgeInsets.only(top: 10, bottom: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Image.asset('assets/img/splash_logo.png', width: 30,height: 30,),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Follow on Twitter',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                        color: config.Colors().textColor(),
                                                        fontSize: 14,
                                                      )),
                                                    ),
                                                    Text(
                                                      twitterLink,
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
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 10,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                              ),
                                        ),
                                        // SizedBox(height: 15,),
                                        Container(width: MediaQuery.of(context).size.width, height: 0.5, color: Colors.grey[300],),
                                        // SizedBox(height: 15,),
                                        InkWell(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.only(top: 15, bottom: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Image.asset('assets/img/splash_logo.png', width: 30,height: 30,),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Follow on Instagram',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                        color: config.Colors().textColor(),
                                                        fontSize: 14,
                                                      )),
                                                    ),
                                                    Text(
                                                      instaLink,
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
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 10,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                        ),
                                        // SizedBox(height: 15,),
                                        Container(width: MediaQuery.of(context).size.width, height: 0.5, color: Colors.grey[300],),
                                        // SizedBox(height: 15,),
                                        InkWell(
                                            child: Padding(
                                              padding:
                                              EdgeInsets.only(top: 15, bottom: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Image.asset('assets/img/splash_logo.png', width: 30,height: 30,),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Follow on Facebook',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                        color: config.Colors().textColor(),
                                                        fontSize: 14,
                                                      )),
                                                    ),
                                                    Text(
                                                      facebookLink,
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
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 10,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        )
                                        ),
                                        // SizedBox(height: 15,),
                                        Container(width: MediaQuery.of(context).size.width, height: 0.5, color: Colors.grey[300],),
                                        // SizedBox(height: 15,),
                                        InkWell(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.only(top: 15, bottom: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Image.asset('assets/img/splash_logo.png', width: 30,height: 30,),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Follow on Youtube',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                        color: config.Colors().textColor(),
                                                        fontSize: 14,
                                                      )),
                                                    ),
                                                    Text(
                                                      youtubeLink,
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
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 10,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                        ),
                                        // SizedBox(height: 15,),
                                        Container(width: MediaQuery.of(context).size.width, height: 0.5, color: Colors.grey[300],),
                                        // SizedBox(height: 15,),
                                        InkWell(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.only(top: 15, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Image.asset('assets/img/splash_logo.png', width: 30,height: 30,),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Follow on LinkedIn',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .merge(TextStyle(
                                                        color: config.Colors().textColor(),
                                                        fontSize: 14,
                                                      )),
                                                    ),
                                                    Text(
                                                      linkedinLink,
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
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
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
}
