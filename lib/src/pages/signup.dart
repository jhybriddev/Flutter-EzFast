import 'dart:io';

import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/helpers/helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/user_controller.dart';
import '../helpers/app_config.dart' as config;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends StateMVC<SignupScreen> {
  UserController _con;

  SharedPreferences prefs;

  _SignupScreenState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    setUpPrefs();
  }

  setUpPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.containsKey("fast_reason")) _con.selectedReason = prefs.getString("fast_reason");
      else _con.selectedReason = S.current.too_loose_weight;

      if (prefs.containsKey("fast_start")) _con.fastStart = prefs.getString("fast_start");
      else _con.fastStart = "05:00";

      if (prefs.containsKey("fast_end")) _con.fastEnd = prefs.getString("fast_end");
      else _con.fastEnd = "19:00";

      if (prefs.containsKey("fast_type")) _con.selectedType = prefs.getString("fast_type");
      else _con.selectedType = S.current.a_12_4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: Helper.of(context).onWillPop,
        child: Scaffold(
          key: _con.scaffoldKey,
          // resizeToAvoidBottomPadding: false,
          body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 1,
                      left: 2,
                      right: 2,
                      bottom: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.bodyText2.merge(
                            TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/Login');
                        },
                        child: Text(
                          S.current.sign_in,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.bodyText2.merge(
                              TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  color: Colors.black38,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              Helper.IMAGE_SPLASH,
                              width: 100,
                              // color: Colors.grey,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              S.current.couple_details,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline3.merge(
                                  TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w800)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              S.current.create_auto_txt,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .merge(TextStyle(color: Colors.black87)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            (Platform.isAndroid) ? Container() :
                            ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width - 100,
                              child: RaisedButton(
                                onPressed: () {},
                                padding: EdgeInsets.symmetric(vertical: 14),
                                color: Colors.black,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(24.0)),
                                child: Text(
                                  S.current.apple_signup,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            (Platform.isAndroid) ? Container() :
                            SizedBox(
                              height: 10,
                            ),
                            ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width - 100,
                              child: RaisedButton(
                                onPressed: () {},
                                padding: EdgeInsets.symmetric(vertical: 14),
                                color: Colors.blueAccent,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(24.0)),
                                child: Text(
                                  S.current.fb_signin,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width - 100,
                              child: RaisedButton(
                                onPressed: () {
                                  _con.signupWithGmail();
                                },
                                padding: EdgeInsets.symmetric(vertical: 14),
                                color: Colors.redAccent,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(24.0)),
                                child: Text(
                                  S.current.gmail_signin,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              S.current.or_signup,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .merge(TextStyle(color: Colors.black87)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Container(
                            //   // height: 50,
                            //   width: MediaQuery.of(context).size.width - 100,
                            //   alignment: Alignment.center,
                            //   // decoration: BoxDecoration(
                            //   //     borderRadius: new BorderRadius.circular(2.0),
                            //   //     border: Border.all(color: Colors.black87)
                            //   //   // color: Colors.black87
                            //   // ),
                            //   child: TextFormField(
                            //     keyboardType: TextInputType.emailAddress,
                            //     onSaved: (input) => _con.emailId = input,
                            //     validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
                            //     decoration: InputDecoration(
                            //       labelText: S.of(context).email,
                            //       labelStyle: Theme.of(context)
                            //           .textTheme
                            //           .bodyText1
                            //           .merge(TextStyle(color: Colors.black87)),
                            //       contentPadding: EdgeInsets.all(12),
                            //       hintText: 'johndoe@gmail.com',
                            //       hintStyle: Theme.of(context)
                            //           .textTheme
                            //           .bodyText1
                            //           .merge(TextStyle(
                            //           color:
                            //           Colors.black87.withOpacity(0.7))),
                            //       prefixIcon: Icon(Icons.alternate_email,
                            //           color: Colors.black87),
                            //       border: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color:
                            //               Colors.black87.withOpacity(0.2))),
                            //       focusedBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color:
                            //               Colors.black87.withOpacity(0.5))),
                            //       enabledBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color:
                            //               Colors.black87.withOpacity(0.2))),
                            //     ),
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .bodyText1
                            //         .merge(TextStyle(color: Colors.black87)),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            // Container(
                            //   // height: 50,
                            //   width: MediaQuery.of(context).size.width - 100,
                            //   alignment: Alignment.center,
                            //   // decoration: BoxDecoration(
                            //   //     borderRadius: new BorderRadius.circular(2.0),
                            //   //     border: Border.all(color: Colors.black87)
                            //   //   // color: Colors.black87
                            //   // ),
                            //   child: TextFormField(
                            //     obscureText: _con.hidePassword,
                            //     onSaved: (input) => _con.password = input,
                            //     // validator: (input) => input.length < 6 ? S.of(context).should_be_more_than_6_letters : null,
                            //     decoration: InputDecoration(
                            //       labelText: S.of(context).password,
                            //       labelStyle: Theme.of(context)
                            //           .textTheme
                            //           .bodyText1
                            //           .merge(TextStyle(color: Colors.black87)),
                            //       contentPadding: EdgeInsets.all(12),
                            //       hintText: '••••••••••••',
                            //       hintStyle: Theme.of(context)
                            //           .textTheme
                            //           .bodyText1
                            //           .merge(TextStyle(
                            //           color:
                            //           Colors.black87.withOpacity(0.7))),
                            //       prefixIcon: Icon(Icons.lock_outline,
                            //           color: Colors.black87),
                            //       suffixIcon: IconButton(
                            //         onPressed: () {
                            //           setState(() {
                            //             _con.hidePassword = !_con.hidePassword;
                            //           });
                            //         },
                            //         color: Colors.black87,
                            //         icon: Icon(_con.hidePassword
                            //             ? Icons.visibility
                            //             : Icons.visibility_off),
                            //       ),
                            //       border: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color:
                            //               Colors.black87.withOpacity(0.2))),
                            //       focusedBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color:
                            //               Colors.black87.withOpacity(0.5))),
                            //       enabledBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color:
                            //               Colors.black87.withOpacity(0.2))),
                            //     ),
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .bodyText1
                            //         .merge(TextStyle(color: Colors.black87)),
                            //   ),
                            // ),


                            Form(
                              key: _con.loginFormKey,
                              child: Container(
                                margin: EdgeInsets.only(left: 30, right: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // Container(
                                    //   // height: 50,
                                    //   width: MediaQuery.of(context).size.width - 100,
                                    //   alignment: Alignment.center,
                                    //   // decoration: BoxDecoration(
                                    //   //     borderRadius: new BorderRadius.circular(2.0),
                                    //   //     border: Border.all(color: Colors.black87)
                                    //   //   // color: Colors.black87
                                    //   // ),
                                    //   child:
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      onSaved: (input) => _con.emailId = input,
                                      validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
                                      decoration: InputDecoration(
                                        labelText: S.of(context).email,
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(TextStyle(color: Colors.black87)),
                                        contentPadding: EdgeInsets.all(12),
                                        hintText: 'johndoe@gmail.com',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(TextStyle(
                                            color:
                                            Colors.black87.withOpacity(0.7))),
                                        prefixIcon: Icon(Icons.alternate_email,
                                            color: Colors.black87),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                Colors.black87.withOpacity(0.2))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                Colors.black87.withOpacity(0.5))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                Colors.black87.withOpacity(0.2))),
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .merge(TextStyle(color: Colors.black87)),
                                    ),
                                    // ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Container(
                                    //   // height: 50,
                                    //   width: MediaQuery.of(context).size.width - 100,
                                    //   alignment: Alignment.center,
                                    //   // decoration: BoxDecoration(
                                    //   //     borderRadius: new BorderRadius.circular(2.0),
                                    //   //     border: Border.all(color: Colors.black87)
                                    //   //   // color: Colors.black87
                                    //   // ),
                                    //   child:
                                    TextFormField(
                                      obscureText: _con.hidePassword,
                                      onSaved: (input) => _con.password = input,
                                      validator: (input) => input.length < 6 ? S.of(context).should_be_more_than_6_letters : null,
                                      decoration: InputDecoration(
                                        labelText: S.of(context).password,
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(TextStyle(color: Colors.black87)),
                                        contentPadding: EdgeInsets.all(12),
                                        hintText: '••••••••••••',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(TextStyle(
                                            color:
                                            Colors.black87.withOpacity(0.7))),
                                        prefixIcon: Icon(Icons.lock_outline,
                                            color: Colors.black87),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _con.hidePassword = !_con.hidePassword;
                                            });
                                          },
                                          color: Colors.black87,
                                          icon: Icon(_con.hidePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                Colors.black87.withOpacity(0.2))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                Colors.black87.withOpacity(0.5))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                Colors.black87.withOpacity(0.2))),
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .merge(TextStyle(color: Colors.black87)),
                                    ),
                                    // ),

                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 30,
                            ),
                            ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width - 100,
                              child: RaisedButton(
                                onPressed: () {
                                  _con.register();
                                },
                                padding: EdgeInsets.symmetric(vertical: 14),
                                color: Colors.grey,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(24.0)),
                                child: Text(
                                  S.current.sign_up,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/Login');
                              },
                              child: Text(
                                S.current.already_acc,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .merge(TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600)),
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 30, right: 30),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: new TextSpan(
                                  children: [
                                    new TextSpan(
                                      text: S.current.terms1_txt,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12)),
                                    ),
                                    new TextSpan(
                                      text: ' ' + S.current.terms_of_use,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(
                                        TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 12),
                                      ),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          launch('www.google.com');
                                        },
                                    ),
                                    new TextSpan(
                                      text: ' '+ S.current.and,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12)),
                                    ),
                                    new TextSpan(
                                      text: ' ' + S.current.privacy,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(
                                        TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 12),
                                      ),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          launch('https://www.google.com');
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 200,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
