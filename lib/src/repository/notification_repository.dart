import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../helpers/helper.dart';
import '../models/notification.dart';
import '../models/User.dart';
import '../repository/user_repository.dart' as userRepo;
import 'settings_repository.dart';

Future<void> sendNotification(String body, String title, User user) async {
  final data = {
    "notification": {"body": "$body", "title": "$title"},
    "priority": "high",
    "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "messages", "status": "done"},
    "to": "${user.name}"
    // "to": "${user.deviceToken}"
  };
  final String url = 'https://fcm.googleapis.com/fcm/send';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "key=${setting.value.fcmKey}",
    },
    body: json.encode(data),
  );
  if (response.statusCode != 200) {
    print('notification sending failed');
  }
}
