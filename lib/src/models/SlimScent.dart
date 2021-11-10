import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date format

class SlimScent {
  String id;
  String userId;
  String userEmail;
  String date = "";
  DateTime dateTime;
  String eventName;
  Color background;
  bool isAllDay;

  SlimScent(
      {this.id,
        this.userId,
        this.userEmail,
        this.date,
        this.dateTime,
        this.eventName,
        this.background,
        this.isAllDay
      });

  SlimScent.fromData(Map<String, dynamic> data)
      : id = data['id'],
        userId = data['userId'],
        userEmail = data['userEmail'],
        date = data['date']
  ;

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'userId': userId,
      'userEmail': userEmail,
      'date': date
    };
  }

  String getSlimScentDateTimeInFormat(String _format) {
    DateTime savedDate = DateTime.parse(date);
    return DateFormat(_format).format(savedDate);
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
