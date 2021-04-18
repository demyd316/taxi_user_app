import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxi_user/routes/Routes.dart';
import 'package:flutter_taxi_user/utility/network/ApiHelper.dart';
import 'package:flutter_taxi_user/utility/network/Constants.dart' as Constants;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_taxi_user/database/userinfo.dart';
//import 'package:file_picker/file_picker.dart';
var picker = ImagePicker();
class SettingScreen extends StatefulWidget {
  static const String routeName = '/setting';
  @override
  _SettingScreenState createState() => new _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future _choose(reset) async {
    print("pickfile");
    await picker.getImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        imagefile = File(pickedFile.path);
        imagepicked = true;
        reset();
      } else {
        print('No image selected.');
      }
    });
  }

  void _upload() async {
    ApiHelper.uploadDocument(Constants.BASE_URL, imagefile).then((data) {
      print(data);
      navigationPage();
    }).catchError((err) {
      print(err);
    });
  }

  void reset() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: imagepicked
                      ? Image.file(imagefile)
                      : Image.asset(
                          "images/avatar.png",
                        ),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            _choose(reset).then((value) => {print("completed")});
                          },
                          child: Text('Choose Image'),
                        ),
                        SizedBox(width: 10.0),
                        RaisedButton(
                          onPressed: () {
                            _upload();
                          },
                          child: Text('Upload Image'),
                        ),
                        SizedBox(width: 10.0),
                        RaisedButton(
                          onPressed: () {
                            navigationPage();
                          },
                          child: Text('Not now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )));
  }

  void navigationPage() {
    Navigator.pushReplacementNamed(context, Routes.dashboard);
  }
}
