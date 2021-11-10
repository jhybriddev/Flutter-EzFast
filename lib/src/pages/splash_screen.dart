import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezfastnow/src/helpers/helper.dart';
import 'package:ezfastnow/src/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/splash_screen_controller.dart';
import 'test_picker.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen> {
  SplashScreenController _con;

  final CollectionReference _usersCollectionReference = FirebaseFirestore.instance.collection("users");
  // User _currentUser;

  // User get currentUser => _currentUser;

  // SharedPreferences prefs;

  SplashScreenState() : super(SplashScreenController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => loadData());
  }

  // GoogleSignIn _googleSignIn = GoogleSignIn();
  // FirebaseAuth _auth;
  // bool isUserSignedIn = false;
  // void initApp() async {
  //   FirebaseApp defaultApp = await Firebase.initializeApp();
  //   _auth = FirebaseAuth.instanceFor(app: defaultApp);
  //   // immediately check whether the user is signed in
  //   checkIfUserIsSignedIn();
  // }
  //
  // void checkIfUserIsSignedIn() async {
  //   var userSignedIn = await _googleSignIn.isSignedIn();
  //
  //   setState(() {
  //     isUserSignedIn = userSignedIn;
  //   });
  // }

  Future<bool> isUserLoggedIn() async {
    var user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("==1==:::");
      try {
        print("==2==:::");
        print("==2bb==:::" + user.uid);
        var userData = await _usersCollectionReference.doc(user.uid).get();
        print("==2cc==:::" + userData.data.toString());
        print("==2aa==:::" + userData.toString());
        // _currentUser = User.fromData(userData.data);
      } catch (e) {
        print("==3==:::" + e.toString());
        // return false;
      }
    }
    bool i = user != null;
    print("==4==:::" + i.toString());
    return user != null;
  }

  Future<void> loadData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await isUserLoggedIn()) {
      Navigator.of(context).pushReplacementNamed('/Home');
    } else {
      // Navigator.of(context).pushReplacementNamed('/SignUp');
      // Navigator.of(context).pushReplacementNamed('/Home');
      Navigator.of(context).pushReplacementNamed('/Welcome');
    }



      // Navigator
      //     .of(context)
      //     .push(new CupertinoPageRoute(builder: (context) {
      //   return PickerPage();
      // }));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _con.scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            // color: Theme.of(context).scaffoldBackgroundColor,
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  Helper.IMAGE_SPLASH,
                  width: 200,
                  // color: Colors.grey,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
