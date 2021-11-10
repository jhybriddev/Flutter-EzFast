import 'package:ezfastnow/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helpers/app_config.dart' as config;

class ProductsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ProductsWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _ProductsWidgetState createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends StateMVC<ProductsWidget> {
  HomeController _con;

  _ProductsWidgetState() : super(HomeController()) {
    _con = controller;
  }

  Future<void> saveSlimScent(DateTime date) async {
    await _con.saveSlimScent(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => {
                  setState(() {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime.now(), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      saveSlimScent(date);
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  })
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.white,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(8.0),
                      // border: Border.all(color: Colors.black87),
                      color: Theme.of(context).accentColor),
                  child: Text(
                    'Used SlimScents',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .merge(TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => {_launchURL('https://goeasyfasting.com/order-now')},
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.white,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(8.0),
                      // border: Border.all(color: Colors.black87),
                      color: Theme.of(context).accentColor),
                  child: Text(
                    'Order SlimScents',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .merge(TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => {_launchURL('https://goeasyfasting.com/learn-more')},
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.white,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(8.0),
                      // border: Border.all(color: Colors.black87),
                      color: Theme.of(context).accentColor),
                  child: Text(
                    'Learn More',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .merge(TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
