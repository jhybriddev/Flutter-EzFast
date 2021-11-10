import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/setting.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
final navigatorKey = GlobalKey<NavigatorState>();

Future<Setting> initSettings() async {
  Setting _setting = new Setting();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _setting.appName = 'Ez Fast Now';
  _setting.mainColor = "#B22222";
  _setting.mainDarkColor = "#B22222";
  _setting.secondColor = "#04294B";
  _setting.secondDarkColor = "#04294B";
  _setting.accentColor = "#B22222";
  _setting.accentDarkColor = "#B22222";
  _setting.scaffoldDarkColor = "#2c2c2c";
  _setting.scaffoldColor = "#fafafa";
  _setting.mobileLanguage.value = Locale('en', '');
  _setting.timeFormat.value = "12";
  _setting.weightUnit.value = "KG";
  _setting.isTimerUp.value = 0;
  _setting.isDarkMode.value = false;
  _setting.fcmKey = '';

  if (prefs.containsKey('weightUnit')) {
    _setting.weightUnit.value = prefs.getString('weightUnit');
  }
  if (prefs.containsKey('isDarkMode')) {
    _setting.isDarkMode.value = prefs.getBool('isDarkMode');
  }
  if (prefs.containsKey('isTimerUp')) {
    _setting.isTimerUp.value = prefs.getInt('isTimerUp');
  }
  if (prefs.containsKey('timeFormat')) {
    _setting.timeFormat.value = prefs.getString('timeFormat');
  }
  if (prefs.containsKey('language')) {
    _setting.mobileLanguage.value = Locale(prefs.get('language'), '');
  }
  _setting.brightness.value =
      prefs.getBool('isDark') ?? false ? Brightness.dark : Brightness.light;
  setting.value = _setting;
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  setting.notifyListeners();
  return setting.value;
}

void setBrightness(Brightness brightness) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (brightness == Brightness.dark) {
    prefs.setBool("isDark", true);
    brightness = Brightness.dark;
  } else {
    prefs.setBool("isDark", false);
    brightness = Brightness.light;
  }
}

Future<void> setDefaultLanguage(String language) async {
  if (language != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }
}

Future<void> setNotificationsCount(int count) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('notiCount', count);
}

Future<String> getDefaultLanguage(String defaultLanguage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('language')) {
    defaultLanguage = await prefs.get('language');
  }
  return defaultLanguage;
}

Future<void> saveMessageId(String messageId) async {
  if (messageId != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('google.message_id', messageId);
  }
}

Future<String> getMessageId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.get('google.message_id');
}
