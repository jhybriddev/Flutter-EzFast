import 'package:ezfastnow/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_config.dart' as config;
import '../repository/settings_repository.dart' as settingRepo;

class NotificationManger {
  static BuildContext _context;

  static init({@required BuildContext context}) {
    _context = context;
  }

  //this method used when notification come and app is closed or in background and
  // user click on it, i will left it empty for you
  static handleDataMsg(Map<String, dynamic> message) {
    print("-------handleDataMsg-------" + message.toString());
  }

  //this our method called when notification come and app is foreground
  static handleNotificationMsg(Map<String, dynamic> message) async {
    SharedPreferences prefs;
    List<String> savedNotifications;
    int notiCount = 0;
    prefs = await SharedPreferences.getInstance();
    print('--------1---------------');
    savedNotifications = <String>[];
    if (prefs.containsKey('notiList') &&
        prefs.getStringList('notiList') != null)
      savedNotifications = prefs.getStringList('notiList');
    print('--------2---------------' + savedNotifications.length.toString());
    savedNotifications.add(message['notification']['title'] +
        ":\n\n" +
        message['notification']['body']);
    print('--------3---------------' + savedNotifications.length.toString());
    await prefs.setStringList('notiList', savedNotifications);
    if (prefs.containsKey('notiCount')) notiCount = prefs.getInt('notiCount');
    notiCount++;
    // settingRepo.setting.value.notifyNotiCount.value = notiCount.toString();
    settingRepo.setting.notifyListeners();
    settingRepo.setNotificationsCount(notiCount);

    _showDialog(message);
  }

  static _showDialog(Map<String, dynamic> message) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: _context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 180,
            child: SizedBox.expand(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      message['notification']['title'],
                      textAlign: TextAlign.center,
                      style: Theme.of(_context)
                          .textTheme
                          .bodyText1
                          .merge(TextStyle(fontSize: 16.0)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      message['notification']['body'],
                      textAlign: TextAlign.center,
                      style: Theme.of(_context)
                          .textTheme
                          .bodyText1
                          .merge(TextStyle(fontSize: 16.0)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ButtonTheme(
                          minWidth: 100,
                          child: RaisedButton(
                            onPressed: () async {
                              Navigator.of(_context).pop();
                            },
                            padding: EdgeInsets.symmetric(vertical: 14),
                            color: config.Colors().secondColor(1),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0)),
                            child: Text(
                              "S.current.got_it",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}
