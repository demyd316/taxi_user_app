import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_taxi_user/dashboard/dashBoard.dart';
import 'package:flutter_taxi_user/login/Login.dart';
import 'package:flutter_taxi_user/login/Signup.dart';
import 'package:flutter_taxi_user/routes/Routes.dart';
//import 'package:flutter_taxi_user/notification/receivenotification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/triphistory.dart';
import 'package:flutter_taxi_user/screens/setting.dart';
import 'database/userinfo.dart';

void main() {
  runApp(new MaterialApp(
    home: SplashScreen(),
    routes: {
      Routes.dashboard: (context) => DashBoard(),
      Routes.login: (context) => LoginScreen(),
      Routes.signup: (context) => SignupScreen(),
      Routes.splash: (context) => SplashScreen(),
      '/triphistory': (context) => Triphistorypage(),
      Routes.setting: (context) => SettingScreen(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  StreamSubscription iosSubscription;
  @override
  void initState() {
    super.initState();
    startTime();
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        print(data);
        _saveDeviceToken();
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken();
    }

    _fcm.subscribeToTopic("driver_flutter_app");
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
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

  _saveDeviceToken() async {
    // Get the current user
    String uid = 'kni';
    //  FirebaseUser user = await _auth.currentUser();
    // Get the token for this device
    fcmToken = await _fcm.getToken();
    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('users')
          .document(uid)
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "images/logo.png",
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "images/logo_name.png",
              ),
            ),
            Text(
              '@ 2020 Powered by Taxi Deals',
              style: TextStyle(fontSize: 10),
            )
          ],
        ));
  }
}
