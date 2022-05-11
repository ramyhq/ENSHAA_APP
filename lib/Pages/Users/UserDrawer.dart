// ignore_for_file: prefer_const_constructors
import 'package:inshaa/data_layer/Cashing_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../welcom_login_page/auth_services/auth.dart';
import 'package:flutter/material.dart';

import '../../constants/Colors.dart';

class UserDrawer extends StatefulWidget {
  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  SharedPreferences? prefs;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((p) {
      setState(() => prefs = p);
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthBase authBase = AuthBase();
    String userEmail = prefs!.getString('user_email').toString();
    String userRole = prefs!.getString('user_role').toString();
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(userRole),
              accountName: Text(userEmail),
              currentAccountPicture: CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 70,
                ),
              ),
              decoration: BoxDecoration(
                color: mainBrown,
              ),
            ),
            // Projects or Services ?
            userRole == 'Individual'
                ? InkWell(
                    child: const ListTile(
                      title: Text(
                        "Projects",
                        style: TextStyle(
                            color: drawerText,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                      ),
                      leading: Icon(
                        Icons.workspaces,
                        color: drawerText,
                      ),
                      subtitle: Text("المشاريع"),
                    ),
                    onTap: () {
                        Navigator.of(context).pop();
                    },
                  )
                : InkWell(
                    child: const ListTile(
                      title: Text(
                        "Our Services",
                        style: TextStyle(
                            color: drawerText,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                      ),
                      leading: Icon(
                        Icons.workspaces,
                        color: drawerText,
                      ),
                      subtitle: Text("الخدمات"),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      //Navigator.of(context).pushReplacementNamed('UserHomePage');
                    },
                  ),
            // for Company and individual
            InkWell(
              child: const ListTile(
                title: Text(
                  "Projects Requests",
                  style: TextStyle(
                      color: drawerText,
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
                leading: Icon(
                  Icons.local_offer_sharp,
                  color: drawerText,
                ),
                subtitle: Text("عروض المشاريع"),
              ),
              onTap: () {
                if (userRole == 'Individual') {
                  Navigator.of(context).pushNamed('UserRequestPage');
                }
                if (userRole == 'Company') {
                  Navigator.of(context).pushNamed('CompanyRequestPage');
                }
              },
            ),
            InkWell(
              child: const ListTile(
                title: Text(
                  "How It Works",
                  style: TextStyle(
                      color: drawerText,
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
                leading: Icon(
                  Icons.home,
                  color: drawerText,
                ),
                subtitle: Text("كيف يعمل"),
              ),
              onTap: () {
                if (userRole == 'Individual') {
                  Navigator.of(context).pushNamed('UserWelcomeHome');
                }
                if (userRole == 'Company') {
                  Navigator.of(context).pushNamed('UserWelcomeHome');
                }
              },
            ),

            //this is for later updates
            // InkWell(
            //   child: const ListTile(
            //     title: Text(
            //       "messages",
            //       style: TextStyle(
            //           color: drawerText,
            //           fontSize: 15,
            //           fontStyle: FontStyle.normal),
            //     ),
            //     leading: Icon(
            //       Icons.question_answer,
            //       color: drawerText,
            //     ),
            //     subtitle: Text("رسائل"),
            //   ),
            //   onTap: () {},
            // ),
            const Divider(
              color: Colors.black26,
            ),
            InkWell(
              child: const ListTile(
                title: Text(
                  "Settings",
                  style: TextStyle(
                      color: drawerText,
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
                leading: Icon(
                  Icons.settings,
                  color: drawerText,
                ),
                subtitle: Text("الاعدادات"),
              ),
              onTap: () {},
            ),
            InkWell(
              child: const ListTile(
                title: Text(
                  "Share",
                  style: TextStyle(
                      color: drawerText,
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
                leading: Icon(
                  Icons.share,
                  color: drawerText,
                ),
                subtitle: Text("مشاركة"),
              ),
              onTap: () {},
            ),
            InkWell(
              child: const ListTile(
                title: Text(
                  "Evaluation",
                  style: TextStyle(
                      color: drawerText,
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
                leading: Icon(
                  Icons.logout,
                  color: drawerText,
                ),
                subtitle: Text("تقييم"),
              ),
              onTap: () {},
            ),
            InkWell(
              child: const ListTile(
                title: Text(
                  "Help",
                  style: TextStyle(
                      color: drawerText,
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
                leading: Icon(
                  Icons.help,
                  color: drawerText,
                ),
                subtitle: Text("مساعدة"),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('ContactUS');
              },
            ),
            InkWell(
              child: const ListTile(
                title: Text(
                  "Logout",
                  style: TextStyle(
                      color: drawerText,
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
                leading: Icon(
                  Icons.logout,
                  color: drawerText,
                ),
                subtitle: Text("خروج"),
              ),
              onTap: () {
                authBase.logout();
                Navigator.of(context).pushReplacementNamed('login');
              },
            ),
          ],
        ),
      ), //Carousel
    );
  }
}
