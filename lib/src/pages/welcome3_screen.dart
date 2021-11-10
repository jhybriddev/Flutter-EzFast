import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/controllers/welcome_screen_controller.dart';
import 'package:ezfastnow/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome3Widget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  Welcome3Widget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _Welcome3WidgetState createState() => _Welcome3WidgetState();
}

class _Welcome3WidgetState extends StateMVC<Welcome3Widget> {
  WelcomeScreenController _con;

  SharedPreferences prefs;

  bool isSelectionView = false;
  String selectedType = "";

  _Welcome3WidgetState() : super(WelcomeScreenController()) {
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
      if (prefs.containsKey("fast_reason"))
        selectedType = prefs.getString("fast_reason");
      else
        selectedType = S.current.too_loose_weight;
    });
  }

  setFastReason(String type) async {
    prefs.setString("fast_reason", type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      // body: Center(
      //   child:
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: isSelectionView
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    S.current.w3_txt1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3.merge(
                        TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => {
                            setState(() {
                              isSelectionView = !isSelectionView;
                              selectedType = S.current.improve_mental_clarity;
                              setFastReason(selectedType);
                            })
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.white,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.black87),
                                color: (selectedType ==
                                        S.current.improve_mental_clarity)
                                    ? Theme.of(context).accentColor
                                    : Colors.transparent),
                            child: Text(
                              S.current.improve_mental_clarity,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.caption.merge(
                                  TextStyle(
                                      color: (selectedType ==
                                              S.current.improve_mental_clarity)
                                          ? Colors.white
                                          : Colors.black87)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () => {
                            setState(() {
                              isSelectionView = !isSelectionView;
                              selectedType = S.current.following_medical_advice;
                              setFastReason(selectedType);
                            })
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.white,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.black87),
                                color: (selectedType ==
                                        S.current.following_medical_advice)
                                    ? Theme.of(context).accentColor
                                    : Colors.transparent),
                            child: Text(
                              S.current.following_medical_advice,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.caption.merge(
                                  TextStyle(
                                      color: (selectedType ==
                                              S.current
                                                  .following_medical_advice)
                                          ? Colors.white
                                          : Colors.black87)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () => {
                            setState(() {
                              isSelectionView = !isSelectionView;
                              selectedType = S.current.too_loose_weight;
                              setFastReason(selectedType);
                            })
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.white,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.black87),
                                color:
                                    (selectedType == S.current.too_loose_weight)
                                        ? Theme.of(context).accentColor
                                        : Colors.transparent),
                            child: Text(
                              S.current.too_loose_weight,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.caption.merge(
                                  TextStyle(
                                      color: (selectedType ==
                                              S.current.too_loose_weight)
                                          ? Colors.white
                                          : Colors.black87)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () => {
                            setState(() {
                              isSelectionView = !isSelectionView;
                              selectedType = S.current.increase_daily_energy;
                              setFastReason(selectedType);
                            })
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.white,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.black87),
                                color: (selectedType ==
                                        S.current.increase_daily_energy)
                                    ? Theme.of(context).accentColor
                                    : Colors.transparent),
                            child: Text(
                              S.current.increase_daily_energy,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.caption.merge(
                                  TextStyle(
                                      color: (selectedType ==
                                              S.current.increase_daily_energy)
                                          ? Colors.white
                                          : Colors.black87)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () => {
                            setState(() {
                              isSelectionView = !isSelectionView;
                              selectedType = S.current.live_longer;
                              setFastReason(selectedType);
                            })
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.white,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.black87),
                                color: (selectedType == S.current.live_longer)
                                    ? Theme.of(context).accentColor
                                    : Colors.transparent),
                            child: Text(
                              S.current.live_longer,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.caption.merge(
                                  TextStyle(
                                      color: (selectedType ==
                                              S.current.live_longer)
                                          ? Colors.white
                                          : Colors.black87)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () => {
                            setState(() {
                              isSelectionView = !isSelectionView;
                              selectedType = S.current.gut_rest;
                              setFastReason(selectedType);
                            })
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.white,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.black87),
                                color: (selectedType == S.current.gut_rest)
                                    ? Theme.of(context).accentColor
                                    : Colors.transparent),
                            child: Text(
                              S.current.gut_rest,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.caption.merge(
                                  TextStyle(
                                      color:
                                          (selectedType == S.current.gut_rest)
                                              ? Colors.white
                                              : Colors.black87)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              )
            : Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    S.current.w3_txt1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3.merge(
                        TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Image.asset(
                        Helper.IMAGE_SPLASH,
                        // width: 150,
                        // color: Colors.grey,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      setState(() {
                        isSelectionView = !isSelectionView;
                      })
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.white,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.black87)
                          // color: Colors.black87
                          ),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 10,),
                              Expanded(child: Container()),
                              SizedBox(width: 10,),

                              Icon(Icons.arrow_forward_ios_rounded, size: 16),
                              SizedBox(width: 10,),

                            ],
                          ),
                          Center(
                            child: Text(
                              selectedType,
                              // (selectedType!=null) ? S.current.too_loose_weight: selectedType,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .merge(TextStyle(color: Colors.black87)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
      // )
    );
  }
}
