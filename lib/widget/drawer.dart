import 'package:flutter/material.dart';
import 'package:flutter_taxi_user/database/userinfo.dart';
import 'package:flutter_taxi_user/routes/Routes.dart';
import 'package:flutter_taxi_user/screens/triphistory.dart';
import 'package:flutter_taxi_user/screens/setting.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [_createHeader(), Positioned(
              bottom: 20,
              child: _showprofileimage())],
          ),
          _createDrawerItem(
              icon: Icons.history,
              text: 'My Trip',
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Triphistorypage()))),
          _createDrawerItem(
              icon: Icons.favorite,
              text: 'Favorite',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.dashboard)),
          _createDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () =>
                  Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SettingScreen()))),
          Divider(),
          _createDrawerItem(icon: Icons.help, text: 'Help'),
          _createDrawerItem(icon: Icons.feedback, text: 'Feed back'),
          _createDrawerItem(
            icon: Icons.share,
            text: 'Share',
            // onTap: () =>
            //  Navigator.pushReplacementNamed(context, "/notification")
          ),
          _createDrawerItem(icon: Icons.description, text: 'About'),
          Divider(),
          _createDrawerItem(icon: Icons.all_out, text: 'Logout'),
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/drawer_header_background.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Taxi Deals user",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  _showprofileimage() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: imagepicked
              ? Image.file(imagefile).image
              : Image(
                  image: AssetImage("images/avatar.png",),
                  
                ).image,
        ),
      ),
      width: 130,
      height: 130,
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
