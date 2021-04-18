import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_taxi_user/datamodel/datatypes.dart';
import 'dart:io';

userinfotype userinfo = new userinfotype();
File imagefile;
int selecteditem = 0;
bool imagepicked = false;
FirebaseMessaging fcm = FirebaseMessaging();
String fcmToken = "";
String tripid = "10000000";
