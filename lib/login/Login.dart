import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxi_user/routes/Routes.dart';
import 'package:flutter_taxi_user/utility/network/ApiHelper.dart';
import 'package:flutter_taxi_user/utility/network/Constants.dart' as Constants;
import 'package:flutter_taxi_user/database/userinfo.dart';
import 'package:location/location.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  fetchAlbum() async {
    Map<String, dynamic> data = {
      "deviceId": fcmToken,
      "domain": userinfo.domain,
      "email": userinfo.email,
      "latituse": "0",
      "longitude": "0",
      "password": userinfo.password,
      "phoneNumber": userinfo.phonenumber,
      "role": userinfo.role,
      "website": userinfo.website,
    };

    ApiHelper.postRequest(Constants.BASE_URL_LOGIN, data).then((data) {
      navigationPage();
      userinfo.ids=data.data.ids;
      if (!data.status) {
      } else {
        print(data.message);
        if (data.status) {}
      }
    }).catchError((err) {
      print(err);
    });
  }

  LocationData locationData;
  _getCurrentLocation() async {
    Location location = new Location();
    locationData = await location.getLocation();
    userinfo.longitude = locationData.latitude;
    userinfo.latitude = locationData.latitude;
    print("locatioin :" + locationData.toString());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
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
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50*size.height/750,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () {
                        print(emailController.text);
                        print(passwordController.text);
                        setState(() {
                          userinfo.firstname = firstnameController.text;
                          userinfo.lastname = lastnameController.text;
                          userinfo.email = emailController.text;
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(userinfo.email);
                          userinfo.phonenumber = phoneController.text;
                          userinfo.password = passwordController.text;
                        });
                        fetchAlbum();
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.signup);
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
                SizedBox(
                  height: 50,
                )
              ],
            )));
  }

  void navigationPage() {
    Navigator.pushReplacementNamed(context, Routes.setting);
  }
}
