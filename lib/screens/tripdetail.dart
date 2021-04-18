import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_taxi_user/database/userinfo.dart';
import 'package:flutter_taxi_user/utility/network/ApiHelper.dart';
import 'package:flutter_taxi_user/widget/drawer.dart';
import 'package:flutter_taxi_user/utility/network/Constants.dart' as Constants;
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:flutter_taxi_user/database/triphistorydata.dart";

class Triphistorydetailpage extends StatelessWidget {
  static const String routeName = '/triphistorydetail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TripDetail"),
        ),
        drawer: AppDrawer(),
        body: Center(
          child: Triphistorydetail(),
        ));
  }
}

class Triphistorydetail extends StatefulWidget {
  Triphistorydetail({Key key}) : super(key: key);

  @override
  _TriphistorydetailState createState() => _TriphistorydetailState();
}

class _TriphistorydetailState extends State<Triphistorydetail> {
  //data
  List<dynamic> hdata = jsonDecode(triphistorydata_string);

  TextEditingController nameController = TextEditingController();
  TextStyle substyle = TextStyle(
    fontSize: 20,
  );

  StreamSubscription iosSubscription;

  @override
  void initState() {
    super.initState();
    //triphistorydata
    List<dynamic> hdata = jsonDecode(triphistorydata_string);
    print(hdata.length);
    print(hdata[0]);
    print(hdata[0]["latitude"]);

    //firebase messaging
    if (Platform.isIOS) {
      iosSubscription = fcm.onIosSettingsRegistered.listen((data) {
        print(data);
      });

      fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {}
    fcm.subscribeToTopic("driver_flutter_app");
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        setState(() {
          tripid = message['data']['tripId'];
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
                title: Text(message['notification']['title']),
                subtitle: Column(
                  children: [
                    Text(message['notification']['body']),
                    Text("source : " + message['data']['source']),
                    Text("dest : " + message['data']['dest']),
                    Text("km : " + message['data']['km']),
                  ],
                )),
            actions: <Widget>[
              FlatButton(
                  color: Colors.green,
                  child: Text("Accept"),
                  onPressed: () {
                    ApiHelper.getRequest1(Constants.BASE_URL +
                            Constants.BASE_URL_ACCEPT +
                            tripid +
                            "/ACCEPT")
                        .then((value) {
                      print(value.toString());
                    });
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  color: Colors.red,
                  child: Text("reject"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: ListTile(
                          title: Text("reason"),
                          subtitle: Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextField(
                                maxLines: 5,
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              )),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              color: Colors.red,
                              child: Text("Send"),
                              onPressed: () {
                                ApiHelper.getRequest1(Constants.BASE_URL +
                                        Constants.BASE_URL_ACCEPT +
                                        tripid +
                                        "/REJECT")
                                    .then((value) {
                                  print(value.toString());
                                });
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  void dispose() {
    if (iosSubscription != null) iosSubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        historyview(selecteditem),
      ],
    );
  }

  Widget historyview(int i) {
    return Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Price      : ' + hdata[i]["price"].toString(),
                  style: substyle,
                ),
                Text('totalPrice : ' + hdata[i]["totalprice"].toString(),
                    style: substyle),
                Text(
                    "startDate  : " +
                        hdata[i]["startDate"].toString() +
                        " destni",
                    style: substyle),
                Text("endDate    : " + hdata[i]["endDate"].toString(),
                    style: substyle),
                Text("Source :" + hdata[i]["source"].toString(),
                    style: substyle),
                Text("destination :" + hdata[i]["destination"].toString(),
                    style: substyle),
                Text("km :" + hdata[i]["km"].toString(), style: substyle)
              ],
            )),
          ],
        ));
  }
}
