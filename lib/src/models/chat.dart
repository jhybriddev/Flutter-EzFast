import 'package:flutter/material.dart';

import 'User.dart';

class Chat {
  String id = UniqueKey().toString();
  // message text
  String text;
  // time of the message
  int time;
  // user id who send the message
  String userId;
  String fromUserId;
  String toUserId;

  User user;
  String fromUserName;
  String toUserName;

  Chat(this.text, this.time, this.userId, this.fromUserId, this.fromUserName, this.toUserId, this.toUserName);

  Chat.fromJSON(Map<String, dynamic> jsonMap) {
    print('------fromJSON---'+jsonMap.toString());
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : null;
      text = jsonMap['text'] != null ? jsonMap['text'].toString() : '';
      time = jsonMap['time'] != null ? jsonMap['time'] : 0;
      fromUserName = jsonMap['fromUserName'] != '' ? jsonMap['fromUserName'].toString() : '';
      toUserName = jsonMap['toUserName'] != '' ? jsonMap['toUserName'].toString() : '';
      fromUserId = jsonMap['fromUser'] != '' ? jsonMap['fromUser'].toString() : '';
      toUserId = jsonMap['toUser'] != '' ? jsonMap['toUser'].toString() : '';
      userId = jsonMap['user'] != '' ? jsonMap['user'].toString() : '';
    } catch (e) {
      id = null;
      text = '';
      time = 0;
      user = null;
      userId = '';
      fromUserId = '';
      toUserId = '';
      toUserName = '';
      fromUserName = '';
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["text"] = text;
    map["time"] = time;
    map["user"] = userId;
    map["fromUser"] = fromUserId;
    map["toUser"] = toUserId;
    map["fromUserName"] = fromUserName;
    map["toUserName"] = toUserName;
    return map;
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'time': time,
      'user': userId,
      'fromUser': fromUserId,
      'toUser': toUserId,
      'fromUserName': fromUserName,
      'toUserName': toUserName
    };
  }
}
