// ignore_for_file: prefer_const_constructors, avoid_print
//this is first action from the app
//this page to check user login status
//if user logged in will navigate to home screen
//if user not logged in will go (Auth Page)

import 'package:flutter/material.dart';
import 'package:inshaa/custom_widgets/error_widget.dart';
import 'package:inshaa/custom_widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Users/Company/company_home_page.dart';
import '../../Users/Individual/User_home_page.dart';
import '../../Users/UserWelcomeHome.dart';
import '../auth_screen.dart';
import 'auth.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  SharedPreferences? prefs;
  bool isPrefsInit = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
        .then((p) {
      setState(() {
        prefs = p;
        isPrefsInit = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context,);
    final user_role = prefs?.getString('user_role');
    print('Wrapper build is called - $isPrefsInit');
    if (isPrefsInit) {
      //return either home or auth widget
      if (user == null) {
        print('#102 Wrapper say user is null + $user_role');
        return AuthScreen(
          authType: AuthType.login,
        );
      } else
      {
        if (user_role == 'Individual') {
          print('#103 Wrapper say user is here 1 - ${user.role}');
          return UserHomePage();
        }
        if (user_role == 'Company') {
          print('#104 Wrapper say user is here 2 - ${user.role}');
          return CompanyHomePage();
        }
        else {
          return ErrorPage();
        }
      }

    } else {
      return LoadingPage();
    }

  }
}
