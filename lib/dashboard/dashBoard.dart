import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_taxi_user/utility/network/ApiHelper.dart';
import 'package:flutter_taxi_user/widget/drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_taxi_user/utility/network/Constants.dart' as Constants;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_taxi_user/database/triphistorydata.dart';
import 'package:flutter_taxi_user/database/userinfo.dart';

class DashBoard extends StatelessWidget {
  static const String routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DashBoard"),
        ),
        drawer: AppDrawer(),
        body: Center(
          child: GoogleMapWidget(),
        ));
  }
}

class GoogleMapWidget extends StatefulWidget {
  GoogleMapWidget({Key key}) : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State {
  GoogleMapController mapController;

  TextEditingController nameController = TextEditingController();

  StreamSubscription iosSubscription;

  @override
  void initState() {
    super.initState();
    // fetch_Search();
    if (Platform.isIOS) {
      iosSubscription = fcm.onIosSettingsRegistered.listen((data) {
        print(data);
      });
      fcm.requestNotificationPermissions(IosNotificationSettings());
    }
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
                    Map<String, dynamic> data = {
                      "deviceId": fcmToken,
                      "ids": userinfo.ids,
                      "status": "ACCEPT",
                      "tripId": tripid,
                    };
                    ApiHelper.putRequest(
                        Constants.BASE_URL + Constants.BASE_URL_ACCEPT, data);
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
                                Map<String, dynamic> data = {
                                  "deviceId": fcmToken,
                                  "ids": userinfo.ids,
                                  "status": "REJECT",
                                  "tripId": tripid,
                                };
                                ApiHelper.putRequest(
                                    Constants.BASE_URL +
                                        Constants.BASE_URL_ACCEPT,
                                    data);
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

    ApiHelper.getRequest1(
            Constants.BASE_URL + Constants.BASE_URL_GETTRIP + "?id=")
        .then((value) {
      triphistorydata_string = value.data;
    });
  }

  @override
  void dispose() {
    if (iosSubscription != null) iosSubscription.cancel();
    super.dispose();
  }

  fetch_Search() async {
    Map<String, dynamic> data = {
      Constants.category: "TAXI",
      Constants.dateTime: "string",
      Constants.destination: "string",
      Constants.distance: 0,
      Constants.id: 0,
      Constants.km: 0,
      Constants.latitude: "12.312999725341797",
      Constants.longitude: "78.05549621582031",
      Constants.radius: 0,
      Constants.source: "string",
      Constants.type: "string"
    };
    ApiHelper.postRequest(Constants.BASE_URL_AUTO_SEARCH, data).then((data) {
      if (!data.status) {
      } else {
        print(data.message);
        if (data.status) {}
      }
    }).catchError((err) {
      print(err);
    });
  }


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(userinfo.latitude, userinfo.longitude),
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
