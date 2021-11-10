import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SettingsController extends ControllerMVC {
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  SettingsController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
}
