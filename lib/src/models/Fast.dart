import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date format

class Fast {
  String id;
  String userId;
  String userEmail;
  String fastType = "";
  String fastHours = "";
  String fastStart = "";
  String fastEnd = "";

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
  bool isSlimScent;

  Fast(
      {this.id,
      this.userId,
      this.userEmail,
      this.fastType,
      this.fastStart,
      this.fastEnd,
      this.fastHours,
      this.eventName,
      this.from,
      this.to,
      this.background,
      this.isSlimScent,
      this.isAllDay});

  Fast.fromData(Map<String, dynamic> data)
      : id = data['id'],
        userId = data['userId'],
        userEmail = data['userEmail'],
        fastType = data['fastType'],
        fastHours = data['fastHours'],
        fastStart = data['fastStart'],
        fastEnd = data['fastEnd'];

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'userId': userId,
      'userEmail': userEmail,
      'fastType': fastType,
      'fastHours': fastHours,
      'fastStart': fastStart,
      'fastEnd': fastEnd
    };
  }

  String getFastStartTimeInFormat(String _format) {
    DateTime savedDate = DateTime.parse(fastStart);
    // return getDateString(savedDate) + ' at ' + DateFormat('hh:mm a').format(savedDate);
    return DateFormat(_format).format(savedDate);
  }

  String getFastEndTimeInFormat(String _format) {
    DateTime savedDate = DateTime.parse(fastEnd);
    // return getDateString(savedDate) +
    //     ' at ' +
    //     DateFormat('hh:mm a').format(savedDate);
    return DateFormat(_format).format(savedDate);
  }

  String getFastDurationInHrs() {
    DateTime st = DateTime.parse(fastStart);
    DateTime et = DateTime.parse(fastEnd);

    return et.difference(st).inHours.toString() + "Hrs";
  }

  double getFastPercent() {
    DateTime st = DateTime.parse(fastStart);
    DateTime et = DateTime.parse(fastEnd);

    int diff = et.difference(st).inHours;
    int total = int.parse(fastHours);

    double d1 = diff/total;
    return d1;
  }

  String getFastPercentage() {
    DateTime st = DateTime.parse(fastStart);
    DateTime et = DateTime.parse(fastEnd);

    int diff = et.difference(st).inHours;
    int total = int.parse(fastHours);

    double d1 = diff/total;
    d1 = d1*100;

    return d1.toStringAsFixed(1) + "%";
  }
  String getHoursDifference() {
    DateTime st = DateTime.parse(fastStart);
    DateTime et = DateTime.parse(fastEnd);

    int diff = et.difference(st).inHours;

    return diff.toString();
  }

  String getDateString(DateTime tm) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dateToCheck = tm;
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return "Today";
    } else if (aDate == yesterday) {
      return "Yesterday";
    } else if (aDate == tomorrow) {
      return "Tomorrow";
    } else {
      return DateFormat("dd MMM ").format(tm);
    }
  }
}
