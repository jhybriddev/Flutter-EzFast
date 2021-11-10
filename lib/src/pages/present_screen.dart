import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;

class PresentWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  PresentWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _PresentWidgetState createState() => _PresentWidgetState();
}

class _PresentWidgetState extends StateMVC<PresentWidget> {
  HomeController _con;

  _PresentWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Center(
        child: Text('COMING SOON...', style: TextStyle(fontSize: 25, color: config.Colors().textColor()),),
      ),
    );
  }
}
