import 'dart:io';

import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/controllers/user_controller.dart';
import 'package:ezfastnow/src/helpers/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends StateMVC<LoginScreen> {
  UserController _con;

  LoginScreenState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
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
                              color: Colors.black, fontWeight: FontWeight.w600)),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        S.current.sign_up,
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
                  color: Colors.white,
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
                            S.current.welcome_back,
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
                            S.current.automatically_sync,
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
                                  borderRadius: new BorderRadius.circular(24.0)),
                              child: Text(
                                S.current.apple_signin,
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
                                  borderRadius: new BorderRadius.circular(24.0)),
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
                                  borderRadius: new BorderRadius.circular(24.0)),
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
                            S.current.or_login,
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
                          //     // onSaved: (input) => _con.user.email = input,
                          //     // validator: (input) => !input.contains('@') ? S.of(context).should_be_a_valid_email : null,
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
                          //     // onSaved: (input) => _con.user.password = input,
                          //     // validator: (input) => input.length < 6 ? S.of(context).should_be_more_than_6_letters : null,
                          //     decoration: InputDecoration(
                          //       labelText: S.of(context).password,
                          //       labelStyle: Theme.of(context)
                          //           .textTheme
                          //           .bodyText1
                          //           .merge(TextStyle(
                          //           color: Colors.black87)),
                          //       contentPadding: EdgeInsets.all(12),
                          //       hintText: '••••••••••••',
                          //       hintStyle: Theme.of(context)
                          //           .textTheme
                          //           .bodyText1
                          //           .merge(TextStyle(
                          //           color: Colors.black87
                          //               .withOpacity(0.7))),
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
                          //               color: Colors.black87
                          //                   .withOpacity(0.2))),
                          //       focusedBorder: OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.black87
                          //                   .withOpacity(0.5))),
                          //       enabledBorder: OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.black87
                          //                   .withOpacity(0.2))),
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
                                  SizedBox(
                                    height: 15,
                                  ),
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
                                _con.login();
                              },
                              padding: EdgeInsets.symmetric(vertical: 14),
                              color: Colors.grey,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(24.0)),
                              child: Text(
                                S.current.sign_in,
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
                              Navigator.of(context).pushNamed('/ForgotPassword');
                            },
                            child: Text(
                              S.current.forgot_pass,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.fade,
                              style: Theme.of(context).textTheme.bodyText2.merge(
                                  TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600)),
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
      ),
    );
  }
}
