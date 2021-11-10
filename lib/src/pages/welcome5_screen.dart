import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/controllers/welcome_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome5Widget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  Welcome5Widget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _Welcome5WidgetState createState() => _Welcome5WidgetState();
}

class _Welcome5WidgetState extends StateMVC<Welcome5Widget> {
  WelcomeScreenController _con;

  String selectedType = "";

  SharedPreferences prefs;


  _Welcome5WidgetState() : super(WelcomeScreenController()) {
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
    });
  }

  setFastType(String type) async {
    prefs.setString("fast_type", type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.current.w5_txt1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3.merge(TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w800)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                S.current.w5_txt2,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .merge(TextStyle(color: Colors.black87)),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: ()=> {
                  setState(() {
                    selectedType = S.current.a_12_4;
                    setFastType(selectedType);
                  })
                },
                child: Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.white,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black87),
                      color: (selectedType == S.current.a_12_4)
                          ? Theme.of(context).accentColor
                          : Colors.transparent),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.current.circadian_trf,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    fontSize: 10,
                                    color: (selectedType == S.current.a_12_4)
                                        ? Colors.white
                                        : Theme.of(context).accentColor),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                 "",
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .merge(
                                    TextStyle(
                                        fontSize: 10,
                                        color: (selectedType ==
                                            S.current.a_12_4)
                                            ? Colors.white
                                            : Theme.of(context).accentColor),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Icon(
                                    (selectedType == S.current.a_12_4)
                                        ? Icons.check_circle : Icons.circle,
                                    size: 16,
                                    color: (selectedType == S.current.a_12_4)
                                        ? Colors.white
                                        : Colors.grey)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 2,),
                        Row(
                          children: [
                            Text(
                              S.current.a_12_4,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline1.merge(
                                TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: (selectedType == S.current.a_12_4)
                                        ? Colors.white
                                        : Theme.of(context).accentColor),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              S.current.trf,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    fontSize: 12,
                                    color: (selectedType == S.current.a_12_4)
                                        ? Colors.white
                                        : Theme.of(context).accentColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          S.current.a_12_4_window,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption.merge(
                            TextStyle(
                                fontSize: 10,
                                color: (selectedType == S.current.a_12_4)
                                    ? Colors.white
                                    : Theme.of(context).accentColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: ()=> {
                  setState(() {
                    selectedType = S.current.circadian_rhythm_trf;
                    setFastType(selectedType);
                  })
                },
                child: Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.white,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black87),
                      color: (selectedType == S.current.circadian_rhythm_trf)
                          ? Theme.of(context).accentColor
                          : Colors.transparent),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  S.current.circadian_rhythm_trf,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.headline1.merge(
                                    TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: (selectedType == S.current.circadian_rhythm_trf)
                                            ? Colors.white
                                            : Theme.of(context).accentColor),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                // Text(
                                //   S.current.trf,
                                //   textAlign: TextAlign.center,
                                //   style: Theme.of(context).textTheme.caption.merge(
                                //     TextStyle(
                                //         fontSize: 12,
                                //         color: (selectedType == S.current.a_12_4)
                                //             ? Colors.white
                                //             : Theme.of(context).accentColor),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              S.current.sunset_to_mor,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    fontSize: 10,
                                    color: (selectedType == S.current.circadian_rhythm_trf)
                                        ? Colors.white
                                        : Theme.of(context).accentColor),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "",
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    fontSize: 10,
                                    color: (selectedType == S.current.circadian_rhythm_trf)
                                        ? Colors.white
                                        : Theme.of(context).accentColor),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "",
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .merge(
                                    TextStyle(
                                        fontSize: 10,
                                        color: (selectedType ==
                                            S.current.circadian_rhythm_trf)
                                            ? Colors.white
                                            : Theme.of(context).accentColor),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Icon(
                                    (selectedType == S.current.circadian_rhythm_trf)
                                        ? Icons.check_circle : Icons.circle,
                                    size: 16,
                                    color: (selectedType == S.current.circadian_rhythm_trf)
                                        ? Colors.white
                                        : Colors.grey)
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
