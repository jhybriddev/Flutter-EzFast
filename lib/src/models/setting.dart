import 'package:flutter/material.dart';

class Setting {
  String appName = '';
  String mainColor;
  String mainDarkColor;
  String secondColor;
  String secondDarkColor;
  String accentColor;
  String accentDarkColor;
  String scaffoldDarkColor;
  String scaffoldColor;
  String fcmKey;

  ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('en', ''));
  ValueNotifier<Brightness> brightness = new ValueNotifier(Brightness.light);
  ValueNotifier<String> timeFormat = new ValueNotifier("12");
  ValueNotifier<String> weightUnit = new ValueNotifier("KG");
  ValueNotifier<int> isTimerUp = new ValueNotifier(0);
  ValueNotifier<bool> isDarkMode = new ValueNotifier(false);
  Setting();
}
