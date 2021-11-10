import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezfastnow/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/helper.dart';

import 'package:ezfastnow/src/models/User.dart' as local_user;

class UserController extends ControllerMVC {
  local_user.User localUser = new local_user.User();
  bool hidePassword = true;
  bool loading = false;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  // FirebaseMessaging _firebaseMessaging;
  OverlayEntry loader;
  CollectionReference _usersCollectionReference;
  String name = '';
  String surname = '';
  String phoneNumber = '';
  String emailId = '';
  String password = '';
  File image;
  String uploadedFileURL;
  SharedPreferences prefs;

  String selectedReason = "";
  String selectedType = "";
  String fastStart = "";
  String fastEnd = "";

  UserController() {
    loader = Helper.overlayLoader(context);
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // _firebaseMessaging = FirebaseMessaging();
    // _firebaseMessaging.getToken().then((String _deviceToken) {
    //   // user.deviceToken = _deviceToken;
    // }).catchError((e) {
    //   print('Notification not configured');
    // });
  }

  Future<void> updateUser() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      // try {
      //   var user = await FirebaseAuth.instance.currentUser();
      //   _usersCollectionReference = Firestore.instance.collection("users");
      //   if (user != null) {
      //     await createUser(User(
      //         id: user.uid,
      //         name: localUser.name,
      //         surname: localUser.surname,
      //         email: localUser.email,
      //         imageUrl: localUser.imageUrl,
      //         phoneNumber: localUser.phoneNumber));
      //   }
      //   Helper.hideLoader(loader);
      //   scaffoldKey.currentState.showSnackBar(SnackBar(
      //     content: Text("S.current.profile_updated"),
      //   ));
      // } catch (e) {
      //   loader.remove();
      //   scaffoldKey.currentState.showSnackBar(SnackBar(
      //     content: Text(e.toString()),
      //   ));
      // }
    }
  }

  void login() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);

      try {
        var authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailId,
          password: password,
        );
        if (authResult.user != null) {
          prefs = await SharedPreferences.getInstance();
          await prefs.setString("email", emailId);
          Helper.hideLoader(loader);
          Navigator.of(context).pop();
          Navigator.of(scaffoldKey.currentContext)
              .pushReplacementNamed('/Home');
        }
      } catch (e) {
        loader.remove();
        String errMsg = S.current.error_occurred;
        switch (e.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
          case "account-exists-with-different-credential":
          case "email-already-in-use":
            errMsg = S.current.emailalreadyused;
            break;
          case "ERROR_WRONG_PASSWORD":
          case "wrong-password":
            errMsg = S.current.wrongemail;
            break;
          case "ERROR_USER_NOT_FOUND":
          case "user-not-found":
            errMsg = S.current.nouserfound;
            break;
          case "ERROR_USER_DISABLED":
          case "user-disabled":
            errMsg = S.current.userdisabled;
            break;
          case "ERROR_TOO_MANY_REQUESTS":
          case "operation-not-allowed":
            errMsg = S.current.toomanyrequests;
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
          case "operation-not-allowed":
            errMsg = S.current.servererror;
            break;
          case "ERROR_INVALID_EMAIL":
          case "invalid-email":
            errMsg = S.current.emailinvalid;
            break;
          case "ERROR_USER_NOT_FOUND":
          case "user-not-found":
            errMsg = S.current.noaccount;
            break;
          default:
            errMsg = S.current.error_occurred;
            break;
        }

        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(errMsg.toString()),
        ));
      }
    }
  }

  // https://medium.com/flutter-community/firebase-startup-logic-and-custom-user-profiles-6309562ea8b7
  void register() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);

      // try {
      //   UserCredential userCredential = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //       email: "barry.allen@example.com",
      //       password: "SuperSecretPassword!"
      //   ));
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'weak-password') {
      //     print('The password provided is too weak.');
      //   } else if (e.code == 'email-already-in-use') {
      //     print('The account already exists for that email.');
      //   }
      // } catch (e) {
      //   print(e);
      // }

      try {
        User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailId,
          password: password,
        ))
            .user;
        if (user != null) {
          // _usersCollectionReference = Firestore.instance.collection("users");
          _usersCollectionReference =
              FirebaseFirestore.instance.collection("users");
          await createUser(local_user.User(
            id: user.uid,
            selectedReason: selectedReason,
            selectedType: selectedType,
            fastStart: fastStart,
            fastEnd: fastEnd,
            email: emailId,
            isSocial: false,
            name: '',
            dob: '',
            gender: '',
            // surname: localUser.surname,
            // imageUrl: localUser.imageUrl,
            // phoneNumber: localUser.phoneNumber
          ));
          prefs = await SharedPreferences.getInstance();
          await prefs.setString("email", emailId);
          Helper.hideLoader(loader);
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Your account has been registered successfully."),
          ));
          Navigator.of(context).pop();
          Navigator.of(scaffoldKey.currentContext)
              .pushReplacementNamed('/Home');
        }
      } catch (e) {
        loader.remove();
        String errMsg = S.current.error_occurred;
        switch (e.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
          case "account-exists-with-different-credential":
          case "email-already-in-use":
            errMsg = S.current.emailalreadyused;
            break;
          case "ERROR_WRONG_PASSWORD":
          case "wrong-password":
            errMsg = S.current.wrongemail;
            break;
          case "ERROR_USER_NOT_FOUND":
          case "user-not-found":
            errMsg = S.current.nouserfound;
            break;
          case "ERROR_USER_DISABLED":
          case "user-disabled":
            errMsg = S.current.userdisabled;
            break;
          case "ERROR_TOO_MANY_REQUESTS":
          case "operation-not-allowed":
            errMsg = S.current.toomanyrequests;
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
          case "operation-not-allowed":
            errMsg = S.current.servererror;
            break;
          case "ERROR_INVALID_EMAIL":
          case "invalid-email":
            errMsg = S.current.emailinvalid;
            break;
          case "ERROR_USER_NOT_FOUND":
          case "user-not-found":
            errMsg = S.current.noaccount;
            break;
          default:
            errMsg = S.current.error_occurred;
            break;
        }

        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(errMsg.toString()),
        ));
        print('===========>>::==' + e.code.toString());
      }
    }
  }

  Future createUser(local_user.User user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
      // await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String> signupWithGmail() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User user = authResult.user;

    // if (user != null) {
    //   assert(!user.isAnonymous);
    //   assert(await user.getIdToken() != null);
    //
    //   final User currentUser = FirebaseAuth.instance.currentUser;
    //   assert(user.uid == currentUser.uid);
    //
    //   print('signInWithGoogle succeeded: $user');
    //
    //   return '$user';
    // }

    if (user != null) {
      // _usersCollectionReference = Firestore.instance.collection("users");
      _usersCollectionReference =
          FirebaseFirestore.instance.collection("users");
      await createUser(local_user.User(
        id: user.uid,
        selectedReason: selectedReason,
        selectedType: selectedType,
        fastStart: fastStart,
        fastEnd: fastEnd,
        isSocial: true,
        // name: localUser.name,
        // surname: localUser.surname,
        email: user.email,
        name: '',
        dob: '',
        gender: '',
        // imageUrl: localUser.imageUrl,
        // phoneNumber: localUser.phoneNumber
      ));
      prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", user.email);
      Helper.hideLoader(loader);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Your account has been registered successfully."),
      ));
      signOutGoogle();
      Navigator.of(context).pop();
      Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Home');
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();

    print("User Signed Out");
  }

  Future<void> resetPassword(String email) {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      // Overlay.of(context).insert(loader);

      print("==email==" + emailId);

      try {
        FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailId)
            .then((value) => {
                  scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text(
                        S.current.your_reset_link_has_been_sent_to_your_email),
                    action: SnackBarAction(
                      label: S.current.sign_in,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    duration: Duration(seconds: 10),
                  ))
                })
            .catchError((onError) {
          // loader.remove();
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(onError.toString()),
          ));
          print('======onError=====>>::==' + onError.toString());
        });
      } catch (e) {
        // loader.remove();
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        print('===========>>::==' + e.toString());
      }
    }
  }

  Future chooseFile() async {
    // await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
    //   setState(() {
    //     this.image = image;
    //     scaffoldKey.currentState.showSnackBar(SnackBar(
    //       content: Text("S.current.uploading_img"),
    //     ));
    //     uploadFile();
    //   });
    // });
  }

  Future uploadFile() async {
    // var user = await FirebaseAuth.instance.currentUser();
    // StorageReference storageReference = FirebaseStorage.instance
    //     .ref()
    //     .child('userPics/user_${user.uid}');
    //     // .child('userPics/${Path.basename(image.path)}');
    // StorageUploadTask uploadTask = storageReference.putFile(image);
    // await uploadTask.onComplete;
    // print('File Uploaded');
    // storageReference.getDownloadURL().then((fileURL) {
    //   setState(() {
    //     uploadedFileURL = fileURL;
    //     this.localUser.imageUrl = uploadedFileURL;
    //     updateUser();
    //   });
    // });
  }
}
