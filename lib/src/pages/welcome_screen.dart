import 'package:ezfastnow/generated/l10n.dart';
import 'package:ezfastnow/src/pages/welcome3_screen.dart';
import 'package:flutter/material.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import 'welcome1_screen.dart';
import 'welcome2_screen.dart';
import 'welcome4_screen.dart';
import 'welcome5_screen.dart';
import 'welcome6_screen.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatefulWidget {
  dynamic currentTab = 0;
  RouteArgument routeArgument;

  // Widget currentPage = HomeWidget();
  Widget currentPage;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  WelcomeScreen({Key key, this.currentTab}) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _WelcomeScreenState createState() {
    return _WelcomeScreenState();
  }
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String currentPageTitle = "";
  String buttonText = "";
  var currentPageValue = 0.0;
  bool showBackBtn = false;
  bool showSkipBtn = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      widget.currentTab = 0;
      currentPageTitle = S.current.welcome1_title;
      buttonText = S.current.get_started;
      showBackBtn = false;
      showSkipBtn = false;
      _selectTab(widget.currentTab);
    });
  }

  @override
  void didUpdateWidget(WelcomeScreen oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage =
              Welcome1Widget(parentScaffoldKey: widget.scaffoldKey);
          currentPageTitle = S.current.welcome1_title;
          buttonText = S.current.get_started;
          showBackBtn = false;
          showSkipBtn = false;
          break;
        case 1:
          widget.currentPage =
              Welcome2Widget(parentScaffoldKey: widget.scaffoldKey);
          currentPageTitle = S.current.welcome2_title;
          buttonText = S.current.next;
          showBackBtn = true;
          showSkipBtn = false;
          break;
        case 2:
          widget.currentPage =
              Welcome3Widget(parentScaffoldKey: widget.scaffoldKey);
          currentPageTitle = S.current.welcome3_title;
          buttonText = S.current.next;
          showBackBtn = true;
          showSkipBtn = false;
          break;
        case 3:
          widget.currentPage =
              Welcome4Widget(parentScaffoldKey: widget.scaffoldKey);
          currentPageTitle = S.current.welcome4_title;
          buttonText = S.current.next;
          showBackBtn = true;
          showSkipBtn = false;
          break;
        case 4:
          widget.currentPage =
              Welcome5Widget(parentScaffoldKey: widget.scaffoldKey);
          currentPageTitle = S.current.welcome5_title;
          buttonText = S.current.next;
          showBackBtn = true;
          showSkipBtn = true;
          break;
        case 5:
          widget.currentPage =
              Welcome6Widget(parentScaffoldKey: widget.scaffoldKey);
          currentPageTitle = S.current.welcome6_title;
          buttonText = S.current.create_account;
          showBackBtn = false;
          showSkipBtn = false;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: Helper.of(context).onWillPop,
        child: Scaffold(
          key: widget.scaffoldKey,
          // resizeToAvoidBottomPadding: false,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 16,
                    left: 16,
                    right: 16,
                    bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      currentPageTitle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyText2.merge(
                          TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: (widget.currentTab >= 0)
                                  ? Theme.of(context).accentColor
                                  : Colors.grey,
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: (widget.currentTab >= 1)
                                  ? Theme.of(context).accentColor
                                  : Colors.grey,
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: (widget.currentTab >= 2)
                                  ? Theme.of(context).accentColor
                                  : Colors.grey,
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: (widget.currentTab >= 3)
                                  ? Theme.of(context).accentColor
                                  : Colors.grey,
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: (widget.currentTab >= 4)
                                  ? Theme.of(context).accentColor
                                  : Colors.grey,
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: (widget.currentTab >= 4)
                                  ? Theme.of(context).accentColor
                                  : Colors.grey,
                              shape: BoxShape.circle),
                        ),
                      ],
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
                child: widget.currentPage,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: Colors.black38,
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (showBackBtn) {
                            if (widget.currentTab > 0) {
                              int x = widget.currentTab;
                              x--;
                              widget.currentTab = x;
                              this._selectTab(widget.currentTab);
                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.current.back,
                            style: Theme.of(context).textTheme.bodyText2.merge(
                                  TextStyle(
                                      color: showBackBtn
                                          ? Colors.black87
                                          : Colors.transparent,
                                      fontWeight: FontWeight.w600),
                                ),
                          ),
                        ),
                    ),
                    SizedBox(width: 30,),
                    Expanded(
                        child: ButtonTheme(
                          // minWidth: 200,
                          child: RaisedButton(
                            onPressed: () {
                              if (widget.currentTab ==3) {
                                _showReminder(context);
                              } else if (widget.currentTab < 5) {
                                int x = widget.currentTab;
                                x++;
                                widget.currentTab = x;
                                this._selectTab(widget.currentTab);
                              } else {
                                Navigator.of(context).pushReplacementNamed('/SignUp');
                              }
                            },
                            padding: EdgeInsets.symmetric(vertical: 14),
                            color: Colors.black54,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(24.0)),
                            child: Text(
                              buttonText,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ),
                    SizedBox(width: 30,),
                    GestureDetector(
                        onTap: () {
                          if (showSkipBtn) {
                            print('---click----');
                          }
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.current.skip,
                            style: Theme.of(context).textTheme.bodyText2.merge(
                              TextStyle(
                                  color: showSkipBtn
                                      ? Colors.black87
                                      : Colors.transparent,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _showReminder(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.transparent,
        context: ctx,
        builder: (ctx) => Container(
          width: 300,
          height: 300,
          // margin: EdgeInsets.only(top: 10),
          // color: Colors.white54,
          // alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text(
                      S.current.should_we_remind,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3.merge(
                          TextStyle(color: Colors.black, fontWeight: FontWeight.w800)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.current.remind_txt,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .merge(TextStyle(color: Colors.black87)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonTheme(
                      minWidth: 250,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          int x = widget.currentTab;
                          x++;
                          widget.currentTab = x;
                          this._selectTab(widget.currentTab);
                        },
                        padding: EdgeInsets.symmetric(vertical: 14),
                        color: Colors.black54,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(24.0)),
                        child: Text(
                          S.current.remind_me,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        int x = widget.currentTab;
                        x++;
                        widget.currentTab = x;
                        this._selectTab(widget.currentTab);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          S.current.skip_for_now,
                          style: Theme.of(context).textTheme.bodyText2.merge(
                            TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Image.asset(
                  //   Helper.IMAGE_SPLASH,
                  //   // width: 40,
                  //   height: 40,
                  //   fit: BoxFit.contain,
                  // ),
                  GestureDetector(
                    onTap: (){
                     Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ));
  }
}
