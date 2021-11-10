import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/controllers/welcome_screen_controller.dart';
import 'package:ezfastnow/src/helpers/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_picker/flutter_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome6Widget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  Welcome6Widget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _Welcome6WidgetState createState() => _Welcome6WidgetState();
}

class _Welcome6WidgetState extends StateMVC<Welcome6Widget> {
  WelcomeScreenController _con;

  SharedPreferences prefs;

  String selectedReason = "";
  String selectedType = "";
  String selectedFastStart = "";
  String selectedFastEnd = "";

  _Welcome6WidgetState() : super(WelcomeScreenController()) {
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
      if (prefs.containsKey("fast_type"))
        selectedType = prefs.getString("fast_type");
      else
        selectedType = S.current.a_12_4;

      if (prefs.containsKey("fast_reason"))
        selectedReason = prefs.getString("fast_reason");
      else
        selectedReason = S.current.too_loose_weight;

      if (prefs.containsKey("fast_start"))
        selectedFastStart = prefs.getString("fast_start");
      else
        selectedFastStart = "05:00";

      if (prefs.containsKey("fast_end"))
        selectedFastEnd = prefs.getString("fast_end");
      else
        selectedFastEnd = "19:00";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.current.you_r_ready,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3.merge(TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800)),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  Helper.IMAGE_GOAL,
                  width: 150,
                  // color: Colors.grey,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  S.current.goal,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline3.merge(TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800)),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Theme.of(context).accentColor, size: 20,),
                    SizedBox(width: 5,),
                    Text(
                      S.current.i_m_fating_to +  " " + selectedReason,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(
                          color: Colors.black)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  S.current.fasting_nutrition,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline3.merge(TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800)),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Theme.of(context).accentColor, size: 20,),
                    SizedBox(width: 5,),
                    Text(
                      S.current.first_meal_at +  " " + selectedFastStart,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(
                          color: Colors.black)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Theme.of(context).accentColor, size: 20,),
                    SizedBox(width: 5,),
                    Text(
                      S.current.last_meal_at +  " " + selectedFastEnd,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(
                          color: Colors.black)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Theme.of(context).accentColor, size: 20,),
                    SizedBox(width: 5,),
                    Text(
                      (S.current.starting_with + " " + selectedType),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(
                          color: Colors.black)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
