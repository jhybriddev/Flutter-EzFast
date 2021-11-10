import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/controllers/welcome_screen_controller.dart';
import 'package:ezfastnow/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Welcome2Widget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  Welcome2Widget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _Welcome2WidgetState createState() => _Welcome2WidgetState();
}

class _Welcome2WidgetState extends StateMVC<Welcome2Widget> {
  WelcomeScreenController _con;

  _Welcome2WidgetState() : super(WelcomeScreenController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        body: Container(
          color: Colors.white,
          child: Center(
            child:
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Helper.IMAGE_INTRO,
                    width: 150,
                    // color: Colors.grey,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    S.current.w2_txt1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3.merge(
                        TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800)),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    S.current.w2_txt2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption.merge(
                        TextStyle(
                            color: Colors.black87)),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
