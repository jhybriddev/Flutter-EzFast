import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/helpers/helper.dart';
import 'package:ezfastnow/src/models/Fast.dart';
import 'package:ezfastnow/src/models/SlimScent.dart';
import 'package:ezfastnow/src/models/Weight.dart';
import 'package:ezfastnow/src/models/conversation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // for date format
import 'package:ezfastnow/src/models/User.dart' as local_user;

class HomeController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;

  CollectionReference _usersCollectionReference;
  CollectionReference _fastCollectionReference;
  CollectionReference _ssCollectionReference;
  CollectionReference _weightCollectionReference;
  Stream<QuerySnapshot> myCompletedFasts;
  List<Fast> fastsList;
  // List<Fast> fastsListForCalendar = [];
  List<SlimScent> slimScentsList;
  Fast selectedFast;
  Fast selectedSlimScent;
  Fast longestFast;

  List<local_user.User> users = [];

  Conversation message;

  String totalFastGraphDatesTxt = '';
  String totalFastGraphHoursTxt = '';
  List<Fast> totalGraphFastsList = [];

  List<Weight> weightsList;
  String weightGraphDatesTxt = '';
  String aveWeightTxt = '';
  List<Weight> graphWeightsList = [];

  OverlayEntry loader;
  SharedPreferences prefs;

  bool isReverseCountdownTimer = false;
  String _12H_format = 'hh:mm a';
  String _24H_format = 'HH:mm';
  String CURRENT_DATE_TIME_FORMAT = 'hh:mm a';

  int timerToggleIndex = 0;
  int weightToggleIndex = 0;
  int timeToggleIndex = 0;
  bool isDarkMode = false;

  GlobalKey<FormState> formKey;

  local_user.User user;

  HomeController() {
    message = new Conversation(users, name: 'EzFastNow Team');
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    formKey = new GlobalKey<FormState>();
    _usersCollectionReference = FirebaseFirestore.instance.collection("users");

    setPreferenceValues();
  }

  setPreferenceValues() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('isTimerUp')) {
      timerToggleIndex = prefs.getInt('isTimerUp');
    }
    if (timerToggleIndex == 0)
      isReverseCountdownTimer = false;
    else
      isReverseCountdownTimer = true;

    if (prefs.containsKey('isDarkMode')) {
      isDarkMode = prefs.getBool('isDarkMode');
    }

    if (prefs.containsKey('weightUnit')) {
      String w = prefs.getString('weightUnit');
      if (w == 'KG') {
        weightToggleIndex = 0;
      } else {
        weightToggleIndex = 1;
      }
    }

    if (prefs.containsKey('timeFormat')) {
      String w = prefs.getString('timeFormat');
      if (w == '12') {
        timeToggleIndex = 0;
        CURRENT_DATE_TIME_FORMAT = _12H_format;
      } else {
        timeToggleIndex = 1;
        CURRENT_DATE_TIME_FORMAT = _24H_format;
      }
    }
    setState(() {});
  }

  listenForUser() async {
    var u = await FirebaseAuth.instance.currentUser;
    print('----111');
    if (u != null) {
      print('----222');
      getUserData(u.email).then((snapshots) {
        print('----333');
        getUserListFromStream(snapshots).then((value) => {
              print('----444'),
              value.listen((event) {
                List<local_user.User> list = event;
                user = list.elementAt(0);
                setState(() {});
              }),
            });
      });
    }
  }

  listenForFasts() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("====eeeeeeventeeeaefaef=>>>" + user.uid);
      getUserFasts(user.uid).then((snapshots) {
        getListFromStream(snapshots).then((value) => {
              value.listen((event) {
                fastsList = event;
                // fastsListForCalendar = event;
                // fastsListForCalendar = [];

                int hours = 0;
                if (fastsList != null && fastsList.length > 0) {
                  fastsList.sort((a, b) {
                    var adate = DateTime.parse(
                        a.fastStart); //before -> var adate = a.expiry;
                    var bdate = DateTime.parse(b.fastStart);
                    ; //before -> var bdate = b.expiry;
                    return adate.compareTo(
                        bdate); //to get the order other way just switch `adate & bdate`
                  });

                  for (int i = 0; i < fastsList.length; i++) {
                    int fh = int.parse(fastsList.elementAt(i).fastHours);
                    if (fh > hours) {
                      hours = fh;
                      longestFast = fastsList.elementAt(i);
                    }
                  }
                } else {
                  fastsList = [];
                }
                // fastsListForCalendar = fastsList;

                // if (fastsListForCalendar != null && fastsListForCalendar.length > 0) {
                //   fastsListForCalendar.sort((a, b) {
                //     var adate = DateTime.parse(
                //         a.fastStart); //before -> var adate = a.expiry;
                //     var bdate = DateTime.parse(b.fastStart);
                //     ; //before -> var bdate = b.expiry;
                //     return adate.compareTo(
                //         bdate); //to get the order other way just switch `adate & bdate`
                //   });
                // } else {
                //   fastsListForCalendar = [];
                // }
                setSelectedFast(new DateTime.now());
                setTotalFastWeek();
                setState(() {});
                listenForSlimScents();
              }),
            });
      });
    }
  }

  void setTotalFastWeek() {
    if (fastsList != null && fastsList.length > 0) {
      totalGraphFastsList.clear();
      DateTime lastWeek = new DateTime.now();
      lastWeek = lastWeek.subtract(new Duration(days: 7));
      totalFastGraphDatesTxt = DateFormat("MMM dd").format(lastWeek) +
          " - " +
          DateFormat("MMM dd").format(new DateTime.now());
      double totalHrs = 0;
      for (int i = 0; i < fastsList.length; i++) {
        if (!fastsList.elementAt(i).isSlimScent) {
          DateTime dt = DateTime.parse(fastsList
              .elementAt(i)
              .fastStart);
          if (dt.isAfter(lastWeek)) {
            totalGraphFastsList.add(fastsList.elementAt(i));
            totalHrs = totalHrs +
                double.parse(fastsList.elementAt(i).getHoursDifference());
          }
        }
      }
      totalFastGraphHoursTxt = totalHrs.toString();
      print('-----week----' + totalGraphFastsList.length.toString());
    }
  }

  void setTotalFastMonth() {
    if (fastsList != null && fastsList.length > 0) {
      totalGraphFastsList.clear();
      DateTime lastWeek = new DateTime.now();
      lastWeek = lastWeek.subtract(new Duration(days: 30));
      totalFastGraphDatesTxt = DateFormat("MMM dd, yyyy").format(lastWeek) +
          " - " +
          DateFormat("MMM dd, yyyy").format(new DateTime.now());
      double totalHrs = 0;
      for (int i = 0; i < fastsList.length; i++) {
        if (!fastsList.elementAt(i).isSlimScent) {
          DateTime dt = DateTime.parse(fastsList
              .elementAt(i)
              .fastStart);
          if (dt.isAfter(lastWeek)) {
            totalGraphFastsList.add(fastsList.elementAt(i));
            totalHrs = totalHrs +
                double.parse(fastsList.elementAt(i).getHoursDifference());
          }
        }
      }
      totalFastGraphHoursTxt = totalHrs.toString();
      print('-----mon----' + totalGraphFastsList.length.toString());
    }
  }

  void setTotalFastYear() {
    if (fastsList != null && fastsList.length > 0) {
      totalGraphFastsList.clear();
      DateTime lastWeek = new DateTime.now();
      lastWeek = lastWeek.subtract(new Duration(days: 365));
      totalFastGraphDatesTxt = DateFormat("MMM dd, yyyy").format(lastWeek) +
          " - " +
          DateFormat("MMM dd, yyyy").format(new DateTime.now());
      double totalHrs = 0;
      for (int i = 0; i < fastsList.length; i++) {
        if (!fastsList.elementAt(i).isSlimScent) {
          DateTime dt = DateTime.parse(fastsList
              .elementAt(i)
              .fastStart);
          if (dt.isAfter(lastWeek)) {
            totalGraphFastsList.add(fastsList.elementAt(i));
            totalHrs = totalHrs +
                double.parse(fastsList.elementAt(i).getHoursDifference());
          }
        }
      }
      totalFastGraphHoursTxt = totalHrs.toString();
      print('-----year----' + totalGraphFastsList.length.toString());
    }
  }

  void setSelectedFast(DateTime dateTime) {
    bool isFound = false;
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);
    if (fastsList != null && fastsList.length > 0) {
      for (int i = 0; i < fastsList.length; i++) {
        if (!fastsList.elementAt(i).isSlimScent) {
          DateTime st = DateTime.parse(fastsList.elementAt(i).fastStart);
          st = DateTime(st.year, st.month, st.day, 0, 0, 0);
          if (st == dateTime) {
            isFound = true;
            selectedFast = fastsList.elementAt(i);
            // break;
          }
        }
      }
    }

    if (!isFound) selectedFast = null;
    setState(() {});
  }

  Future<Stream<List<Fast>>> getListFromStream(
      Stream<QuerySnapshot> stream) async {
    return stream.map((qShot) => qShot.docs
        .map((doc) => Fast(
            id: doc.id,
            userId: doc.get('userId'),
            userEmail: doc.get('userEmail'),
            fastType: doc.get('fastType'),
            fastHours: doc.get('fastHours'),
            fastStart: doc.get('fastStart'),
            fastEnd: doc.get('fastEnd'),
            from: DateTime.parse(doc.get('fastStart')),
            to: DateTime.parse(doc.get('fastEnd')),
            background: const Color(0x80B22222),
            eventName:
                getFastDurationInHrs(doc.get('fastStart'), doc.get('fastEnd')),
            isSlimScent: false,
            isAllDay: true))
        .toList());
  }

  Future<Stream<List<local_user.User>>> getUserListFromStream(
      Stream<QuerySnapshot> stream) async {
    return stream.map((qShot) => qShot.docs
        .map((doc) => local_user.User(
              id: doc.id,
              email: doc.get('email'),
              name: doc.get('name'),
              dob: doc.get('dob'),
              gender: doc.get('gender'),
              selectedReason: doc.get('selectedReason'),
              selectedType: doc.get('selectedType'),
              fastStart: doc.get('fastStart'),
              fastEnd: doc.get('fastEnd'),
              isSocial: doc.get('isSocial'),
            ))
        .toList());
  }

  String getFastDurationInHrs(String st1, String et1) {
    DateTime st = DateTime.parse(st1);
    DateTime et = DateTime.parse(et1);

    return et.difference(st).inHours.toString() + "Hrs";
  }

  deleteAll() async {
    deleteUserData();
    Overlay.of(context).insert(loader);
    var uu = await FirebaseAuth.instance.currentUser;
    if (uu != null) {
      _usersCollectionReference =
          FirebaseFirestore.instance.collection("users");
      getUserData(uu.email).then((snapshots) {
        getUserListFromStream(snapshots).then((value) => {
              value.listen((event) {
                List<local_user.User> uList = event;
                for (int i = 0; i < uList.length; i++) {
                  _usersCollectionReference.doc(uList.elementAt(i).id).delete();
                }
                uu.delete();
                setState(() {});
              }),
            });
      });
    }
    Helper.hideLoader(loader);
  }

  deleteUserData() async {
    Overlay.of(context).insert(loader);
    var uu = await FirebaseAuth.instance.currentUser;
    if (uu != null) {
      _fastCollectionReference = FirebaseFirestore.instance.collection("fasts");
      getUserFasts(uu.uid).then((snapshots) {
        getListFromStream(snapshots).then((value) => {
              value.listen((event) {
                fastsList = event;
                for (int i = 0; i < fastsList.length; i++) {
                  _fastCollectionReference
                      .doc(fastsList.elementAt(i).id)
                      .delete();
                }
                setState(() {});
              }),
            });
      });
    }
    Helper.hideLoader(loader);
  }

  Future<Stream<QuerySnapshot>> getUserData(String email) async {
    _usersCollectionReference = FirebaseFirestore.instance.collection("users");
    return _usersCollectionReference
        .where('email', isEqualTo: email)
        .snapshots();
  }

  Future<void> updateUser() async {
    Overlay.of(context).insert(loader);
    _usersCollectionReference = FirebaseFirestore.instance.collection("users");
    try {
      await _usersCollectionReference.doc(user.id).update(user.toJson());
    } catch (e) {
      return e.message;
    }
    Helper.hideLoader(loader);
  }

  Future<Stream<QuerySnapshot>> getUserFasts(String userId) async {
    _fastCollectionReference = FirebaseFirestore.instance.collection("fasts");
    return _fastCollectionReference
        .where('userId', isEqualTo: userId)
        // .orderBy('time', descending: true)
        .snapshots();
  }

  // ignore: missing_return
  Future<String> saveFast(DateTime endDate) async {
    Overlay.of(context).insert(loader);

    _fastCollectionReference = FirebaseFirestore.instance.collection("fasts");

    prefs = await SharedPreferences.getInstance();

    int fastingHours = 13;
    DateTime startDate;

    if (prefs.containsKey("fast_start_time"))
      startDate = DateTime.parse(prefs.getString('fast_start_time'));
    else
      startDate = new DateTime.now();
    if (prefs.containsKey("fasting_hours"))
      fastingHours = prefs.getInt("fasting_hours");
    else
      fastingHours = 13;

    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('--fastingHours----' + fastingHours.toString());
      try {
        await createFast(Fast(
          userId: user.uid,
          userEmail: user.email,
          fastHours: fastingHours.toString(),
          fastType: S.current.circadian_trf +
              " " +
              fastingHours.toString() +
              " Hours",
          fastStart: startDate.toIso8601String(),
          fastEnd: endDate.toIso8601String(),
        ));

        String msg = "";
        Helper.hideLoader(loader);
        // scaffoldKey.currentState.showSnackBar(SnackBar(
        //   content: Text(msg),
        // ));
        return msg;
      } catch (e) {
        Helper.hideLoader(loader);
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        return e.toString();
      }
    }
  }

  Future createFast(Fast fast) async {
    try {
      await _fastCollectionReference.add(fast.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    Overlay.of(context).insert(loader);
    await FirebaseAuth.instance.signOut();
    prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", '');
    Helper.hideLoader(loader);
    Navigator.of(context).pushReplacementNamed('/Welcome');
  }

  listenForWeights() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      getUserWeights(user.uid).then((snapshots) {
        getWeightListFromStream(snapshots).then((value) => {
              value.listen((event) {
                weightsList = event;
                if (weightsList != null && weightsList.length > 0) {
                  weightsList.sort((a, b) {
                    var adate = DateTime.parse(
                        a.dateTime); //before -> var adate = a.expiry;
                    var bdate = DateTime.parse(
                        b.dateTime); //before -> var bdate = b.expiry;
                    return adate.compareTo(
                        bdate); //to get the order other way just switch `adate & bdate`
                  });

                  double sum = 0;
                  for (int i = 0; i < weightsList.length; i++) {
                    sum = sum + double.parse(weightsList.elementAt(i).weight);
                  }
                  double average = sum / weightsList.length;
                  aveWeightTxt = average.toStringAsFixed(1);
                }
                setWeightWeek();
                setState(() {});
              }),
            });
      });
    }
  }

  Future<Stream<QuerySnapshot>> getUserWeights(String userId) async {
    _weightCollectionReference =
        FirebaseFirestore.instance.collection("weights");
    return _weightCollectionReference
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  Future<Stream<List<Weight>>> getWeightListFromStream(
      Stream<QuerySnapshot> stream) async {
    return stream.map((qShot) => qShot.docs
        .map((doc) => Weight(
              id: doc.id,
              userId: doc.get('userId'),
              userEmail: doc.get('userEmail'),
              dateTime: doc.get('dateTime'),
              weight: doc.get('weight'),
            ))
        .toList());
  }

  void setWeightWeek() {
    if (weightsList != null && weightsList.length > 0) {
      graphWeightsList.clear();
      DateTime lastWeek = new DateTime.now();
      lastWeek = lastWeek.subtract(new Duration(days: 7));
      weightGraphDatesTxt = DateFormat("MMM dd").format(lastWeek) +
          " - " +
          DateFormat("MMM dd").format(new DateTime.now());
      double sum = 0;
      for (int i = 0; i < weightsList.length; i++) {
        DateTime dt = DateTime.parse(weightsList.elementAt(i).dateTime);
        if (dt.isAfter(lastWeek)) {
          graphWeightsList.add(weightsList.elementAt(i));
          sum = sum + double.parse(weightsList.elementAt(i).weight);
        }
      }
      double average = sum / weightsList.length;
      aveWeightTxt = average.toStringAsFixed(1);
      print('-----weight week----' + graphWeightsList.length.toString());
    }
  }

  void setWeightMonth() {
    if (weightsList != null && weightsList.length > 0) {
      graphWeightsList.clear();
      DateTime lastMon = new DateTime.now();
      lastMon = lastMon.subtract(new Duration(days: 30));
      weightGraphDatesTxt = DateFormat("MMM dd, yyyy").format(lastMon) +
          " - " +
          DateFormat("MMM dd, yyyy").format(new DateTime.now());
      double sum = 0;
      for (int i = 0; i < weightsList.length; i++) {
        DateTime dt = DateTime.parse(weightsList.elementAt(i).dateTime);
        if (dt.isAfter(lastMon)) {
          graphWeightsList.add(weightsList.elementAt(i));
          sum = sum + double.parse(weightsList.elementAt(i).weight);
        }
      }
      double average = sum / weightsList.length;
      aveWeightTxt = average.toStringAsFixed(1);
      print('-----weight mon----' + graphWeightsList.length.toString());
    }
  }

  void setWeightYear() {
    if (weightsList != null && weightsList.length > 0) {
      graphWeightsList.clear();
      DateTime lastYear = new DateTime.now();
      lastYear = lastYear.subtract(new Duration(days: 365));
      weightGraphDatesTxt = DateFormat("MMM dd, yyyy").format(lastYear) +
          " - " +
          DateFormat("MMM dd, yyyy").format(new DateTime.now());
      double sum = 0;
      for (int i = 0; i < weightsList.length; i++) {
        DateTime dt = DateTime.parse(weightsList.elementAt(i).dateTime);
        if (dt.isAfter(lastYear)) {
          graphWeightsList.add(weightsList.elementAt(i));
          sum = sum + double.parse(weightsList.elementAt(i).weight);
        }
      }
      double average = sum / weightsList.length;
      aveWeightTxt = average.toStringAsFixed(1);
      print('-----weight year----' + graphWeightsList.length.toString());
    }
  }

  Future<String> saveWeight(DateTime dateTime, String weight) async {
    Overlay.of(context).insert(loader);

    _weightCollectionReference =
        FirebaseFirestore.instance.collection("weights");

    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await createWeight(Weight(
          userId: user.uid,
          userEmail: user.email,
          weight: weight,
          dateTime: dateTime.toIso8601String(),
        ));

        String msg = "";
        Helper.hideLoader(loader);
        // Fluttertoast.showToast(msg: 'Please enter value for weight!');
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Weight has been logged successfully.'),
        ));
        Navigator.of(context).pop();
        return msg;
      } catch (e) {
        Helper.hideLoader(loader);
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        return e.toString();
      }
    }
  }

  Future createWeight(Weight weight) async {
    try {
      await _weightCollectionReference.add(weight.toJson());
    } catch (e) {
      return e.message;
    }
  }

  // ignore: missing_return
  Future<String> saveSlimScent(DateTime date) async {
    Overlay.of(context).insert(loader);

    _ssCollectionReference =
        FirebaseFirestore.instance.collection("slimscents");

    prefs = await SharedPreferences.getInstance();

    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await createSlimScent(SlimScent(
          userId: user.uid,
          userEmail: user.email,
          date: date.toIso8601String(),
        ));

        String msg = "SlimScent has ben added successfully.";
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(msg),
        ));
        Helper.hideLoader(loader);
        return msg;
      } catch (e) {
        Helper.hideLoader(loader);
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        return e.toString();
      }
    }
  }

  Future createSlimScent(SlimScent slimScent) async {
    try {
      await _ssCollectionReference.add(slimScent.toJson());
    } catch (e) {
      return e.message;
    }
  }

  listenForSlimScents() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      getUserSlimScents(user.uid).then((snapshots) {
        getSlimScentsListFromStream(snapshots).then((value) => {
              value.listen((event) {
                slimScentsList = event;
                if (slimScentsList != null && slimScentsList.length > 0) {
                  slimScentsList.sort((a, b) {
                    var adate = DateTime.parse(a.date);
                    var bdate = DateTime.parse(b.date);
                    return adate.compareTo(bdate);
                  });

                  for (int i = 0; i < fastsList.length; i++) {
                    if (fastsList.elementAt(i).isSlimScent) {
                      fastsList.removeAt(i);
                      i = 0;
                    }
                  }

                  for (int i = 0; i < slimScentsList.length; i++) {
                    Fast fast = Fast(
                        id: slimScentsList.elementAt(i).id,
                        userId: slimScentsList.elementAt(i).userId,
                        userEmail: slimScentsList.elementAt(i).userEmail,
                        fastType: "",
                        fastHours: "0",
                        fastStart: slimScentsList.elementAt(i).date,
                        fastEnd: "",
                        from: DateTime.parse(slimScentsList.elementAt(i).date),
                        to: DateTime.parse(slimScentsList.elementAt(i).date),
                        background: Colors.lightGreen,
                        eventName: 'SlimScent',
                        isSlimScent: true,
                        isAllDay: true);
                    fastsList.add(fast);
                  }
                }
                setSelectedSlimScent(new DateTime.now());
                setState(() {});
              }),
            });
      });
    }
  }

  Future<Stream<QuerySnapshot>> getUserSlimScents(String userId) async {
    _ssCollectionReference =
        FirebaseFirestore.instance.collection("slimscents");
    return _ssCollectionReference
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  Future<Stream<List<SlimScent>>> getSlimScentsListFromStream(
      Stream<QuerySnapshot> stream) async {
    return stream.map((qShot) => qShot.docs
        .map((doc) => SlimScent(
            id: doc.id,
            userId: doc.get('userId'),
            userEmail: doc.get('userEmail'),
            date: doc.get('date'),
            dateTime: DateTime.parse(doc.get('date')),
            background: Colors.lightGreen,
            eventName: 'SlimScent',
            isAllDay: true))
        .toList());
  }

  void setSelectedSlimScent(DateTime dateTime) {
    // bool isFound = false;
    // dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);
    // if (slimScentsList != null && slimScentsList.length > 0) {
    //   for (int i = 0; i < slimScentsList.length; i++) {
    //     DateTime st = DateTime.parse(slimScentsList.elementAt(i).date);
    //     st = DateTime(st.year, st.month, st.day, 0, 0, 0);
    //     if (st == dateTime) {
    //       isFound = true;
    //       selectedSlimScent = slimScentsList.elementAt(i);
    //     }
    //   }
    // }
    // if (!isFound) selectedSlimScent = null;
    // setState(() {});

    bool isFound = false;
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);
    if (fastsList != null && fastsList.length > 0) {
      for (int i = 0; i < fastsList.length; i++) {
        if (fastsList.elementAt(i).isSlimScent) {
          DateTime st = DateTime.parse(fastsList.elementAt(i).fastStart);
          st = DateTime(st.year, st.month, st.day, 0, 0, 0);
          if (st == dateTime) {
            isFound = true;
            selectedSlimScent = fastsList.elementAt(i);
          }
        }
      }
    }

    if (!isFound) selectedSlimScent = null;
    setState(() {});
  }
}
