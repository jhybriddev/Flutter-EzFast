import 'package:intl/intl.dart'; // for date format

class Weight {
  String id;
  String userId;
  String userEmail;
  String dateTime = "";
  String weight = "";

  Weight(
      {this.id,
        this.userId,
        this.userEmail,
        this.dateTime,
        this.weight});

  Weight.fromData(Map<String, dynamic> data)
      : id = data['id'],
        userId = data['userId'],
        userEmail = data['userEmail'],
        dateTime = data['dateTime'],
        weight = data['weight'];

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'userId': userId,
      'userEmail': userEmail,
      'dateTime': dateTime,
      'weight': weight
    };
  }

  String getWeightDateTimeInFormat(String _format) {
    DateTime savedDate = DateTime.parse(dateTime);
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
