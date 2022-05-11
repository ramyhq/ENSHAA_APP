// ignore_for_file: prefer_const_constructors

import 'package:inshaa/data_layer/Cashing_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../welcom_login_page/auth_services/auth.dart';
import 'package:flutter/material.dart';

import '../../constants/Colors.dart';

class GuestDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: lightBrown,
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(''),
              accountEmail: Text('login please'),
              currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
              decoration: BoxDecoration(
                  color: mainBrown,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://svgsilh.com/svg_v2/1300331.svg"),
                      fit: BoxFit.cover)),
            ),
            InkWell(
              child: const ListTile(
                title: Text(
                  "LogIn",
                  style: TextStyle(
                      color: mainBrown,
                      fontSize: 16,
                      fontStyle: FontStyle.normal),
                ),
                leading: Icon(
                  Icons.login,
                  color: mainBrown,
                ),
                subtitle: Text("تسجيل الدخول"),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('login');
              },
            ),
            const Divider(
              color: Colors.black26,
            ),
            InkWell(
              child: const ListTile(
                title: Text(
                  "Help",
                  style: TextStyle(
                      color: mainBrown,
                      fontSize: 16,
                      fontStyle: FontStyle.normal),
                ),
                leading: Icon(
                  Icons.help,
                  color: mainBrown,
                ),
                subtitle: Text("مساعدة"),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('ContactUS');
              },
            ),
          ],
        ),
      ), //Carousel
    );
  }
}
