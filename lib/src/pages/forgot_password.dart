import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/user_controller.dart';
import '../helpers/app_config.dart' as config;

class ForgotPasswordWidget extends StatefulWidget {
  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends StateMVC<ForgotPasswordWidget> {
  UserController _con;

  _ForgotPasswordWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        key: _con.scaffoldKey,
        // resizeToAvoidBottomPadding: false,
        body: Column(
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
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.keyboard_backspace_rounded
                    ),
                  ),

                  Text(
                    "",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.bodyText2.merge(
                        TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
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
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
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
                          S.current.forgot_pass,
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
                          S.current.enter_email,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .merge(TextStyle(color: Colors.black87)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   width: MediaQuery.of(context).size.width - 100,
                        //   alignment: Alignment.center,
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


                        Form(
                          key: _con.loginFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width - 100,
                                alignment: Alignment.center,
                                child: TextFormField(
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
                              )
                            ],
                          ),
                        ),


                        SizedBox(
                          height: 30,
                        ),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width-100,
                          child: RaisedButton(
                            onPressed: () {
                              _con.resetPassword(_con.emailId);
                            },
                            padding: EdgeInsets.symmetric(vertical: 14),
                            color: Colors.grey,
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(24.0)),
                            child: Text(
                              S.current.reset_pass,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
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
    );
  }

}
