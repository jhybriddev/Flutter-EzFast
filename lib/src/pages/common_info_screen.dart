import 'dart:math';

import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CommonInfoWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  String title;
  String value;

  CommonInfoWidget(
      {Key key,
      this.parentScaffoldKey,
      @required this.title,
      @required this.value})
      : super(key: key);

  @override
  _CommonInfoWidgetState createState() => _CommonInfoWidgetState();
}

class _CommonInfoWidgetState extends StateMVC<CommonInfoWidget> {
  HomeController _con;

  _CommonInfoWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    var rng = new Random();
    // print("----" + widget.value + '?rand=' + rng.nextInt(9999).toString());
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
                      widget.title,
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
              child: widget.value.startsWith('http')
                  ? WebviewScaffold(
                      hidden: true,
                      url: widget.value,
                      initialChild: Center(
                          child: Container(
                        alignment: FractionalOffset.center,
                        child: CircularProgressIndicator(),
                      )))
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          widget.value,
                          style: Theme.of(context).textTheme.bodyText2.merge(
                                TextStyle(
                                  color: config.Colors().textColor(),
                                  fontSize: 14,
                                ),
                              ),
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
