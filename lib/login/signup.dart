import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxi_user/routes/Routes.dart';
import 'package:flutter_taxi_user/utility/network/ApiHelper.dart';
import 'package:flutter_taxi_user/utility/network/Constants.dart' as Constants;
import 'package:flutter_taxi_user/database/userinfo.dart';
import 'package:location/location.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';
  @override
  _SignupScreenState createState() => new _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
      "category": userinfo.category,
      "deviceId": fcmToken,
      "domain": userinfo.domain,
      "email": userinfo.email,
      "firstName": userinfo.firstname,
      "Lastname": userinfo.lastname,
      "latituse": "0",
      "longitude": "0",
      "password": userinfo.password,
      "phoneNumber": userinfo.phonenumber,
      "role": userinfo.role,
      "website": userinfo.website,
      "latitude": userinfo.latitude,
      // ignore: equal_keys_in_map
      "longitude": userinfo.longitude
    };

    ApiHelper.postRequest(Constants.BASE_URL_LOGIN, data).then((data) {
      navigationPage();
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
                  margin:EdgeInsets.only(top:20),
                  child: Row(
                    children: [
                      Container(
                        width: size.width / 2 - 10,
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: firstnameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'First name',
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 2 - 10,
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: lastnameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Last Name',
                          ),
                        ),
                      ),
                    ],
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
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phonenumber',
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
                //domain
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        Text(
                          "Domain :      ",
                          style: TextStyle(fontSize: 20),
                        ),
                        DropdownButton<String>(
                          value: userinfo.domain,
                          elevation: 16,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              userinfo.domain = newValue;
                              print(userinfo.domain);
                            });
                          },
                          items: <String>[
                            'TAXIDEALS',
                            'TAXIDEALS1',
                            'TAXIDEALS2'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    )),
                //role
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Row(
                      children: [
                        Text(
                          "Role :            ",
                          style: TextStyle(fontSize: 20),
                        ),
                        DropdownButton<String>(
                          value: userinfo.role,
                          elevation: 16,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              userinfo.role = newValue;
                              print(userinfo.role);
                            });
                          },
                          items: <String>['ROLE_DRIVER', 'ROLE_USER']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    )),
                //cartype

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "TAXI4",
                            style: TextStyle(fontSize: 16),
                          ),
                          Radio(
                              value: "TAXI4",
                              groupValue: userinfo.cartype,
                              onChanged: (value) {
                                setState(() {
                                  userinfo.cartype = value;
                                });
                              })
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "TAXI6",
                            style: TextStyle(fontSize: 16),
                          ),
                          Radio(
                              value: "TAXI6",
                              groupValue: userinfo.cartype,
                              onChanged: (value) {
                                setState(() {
                                  userinfo.cartype = value;
                                });
                              })
                        ],
                      ),
                    ),
                  ],
                ),
                FlatButton(
                  onPressed: () {
                    navigationPage();
                  },
                  textColor: Colors.blue,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Sign Up'),
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

                       // fetchAlbum();
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Do you have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.login);
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
    Navigator.pushReplacementNamed(context, '/setting');
  }
}
