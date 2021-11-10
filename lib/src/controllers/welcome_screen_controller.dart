import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class WelcomeScreenController extends ControllerMVC {

  GlobalKey<ScaffoldState> scaffoldKey;

  WelcomeScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
}
