// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inshaa/Pages/Contact_us.dart';
import 'package:inshaa/Pages/Users/Company/add_service_page.dart';
import 'package:inshaa/Pages/Users/Company/company_home_page.dart';
import 'package:inshaa/Pages/Users/Company/company_requests_page.dart';
import 'package:inshaa/Pages/Users/SearchResult.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/Catogorie.dart';

import 'Pages/Guest/GuestWelcomeHome.dart';
import 'Pages/Users/Company/company_Service_Details.dart';
import 'Pages/Users/Individual/User_Service_Details.dart';
import 'Pages/Users/Individual/User_home_page.dart';
import 'Pages/Users/Individual/User_requests_page.dart';
import 'Pages/Users/UserWelcomeHome.dart';
import 'Pages/Users/Individual/add_request_page.dart';
import 'Pages/welcom_login_page/auth_screen.dart';
import 'Pages/welcom_login_page/auth_services/auth-wrapper.dart';
import 'Pages/welcom_login_page/auth_services/auth.dart';
import 'constants/Colors.dart';
import 'custom_widgets/error_widget.dart';
import 'custom_widgets/loading_widget.dart';

SharedPreferences? prefs;
bool isPrefsInit = false;
String? customer_email ;

void main() async {
  // initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  final init = Firebase.initializeApp();

   await SharedPreferences.getInstance()
      .then((p) {
      prefs = p;
      customer_email = prefs?.getString('user_email').toString();
      isPrefsInit = true;
  });

  runApp(AppRoot(init: init,));
}

class AppRoot extends StatelessWidget {
  AppRoot({Key? key, this.init}) : super(key: key);
  final Future<FirebaseApp>? init;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MultiProvider(providers: [
            StreamProvider<MyUser?>.value(
                value: AuthBase().userStatusStream,
                initialData: null),
          ], child: const MyApp(),);
        } else if (snapshot.hasError) {
          return ErrorPage();
        } else {
          return LoadingPage();
        }
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //start
      title: "ENSHAA",
      theme: ThemeData(
        primaryColor: mainBrown,
        primarySwatch: Colors.brown,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: mainBrown,
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        // inputDecorationTheme: InputDecorationTheme(
        //     //filled: true,
        //     enabledBorder: OutlineInputBorder(
        //       borderSide: BorderSide(color: Colors.grey),
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //         borderSide: BorderSide(color: Colors.grey),
        //         borderRadius: BorderRadius.circular(50))),
      ),
      home: Wrapper(), //const Wrapper(),
      routes: {
        //Welcome Pages
        'login': (context) => AuthScreen(authType: AuthType.login),
        'register': (context) => AuthScreen(authType: AuthType.register),
        'UserWelcomeHome': (context) => UserWelcomeHome(),
        'GuestWelcomeHome': (context) => GuestWelcomeHome(),
        // company
        'AddServicePage': (context) => AddServicePage(),
        'CompanyHomePage': (context) => CompanyHomePage(),
        'CompanyRequestPage': (context) => CompanyRequestPage(),
        'CompanyServiceDetails': (context) => CompanyServiceDetails(),
        //user
        'AddRequestPage': (context) => AddRequestPage(),
        'UserHomePage': (context) => UserHomePage(),
        'UserRequestPage': (context) => UserRequestPage(),
        'UserServiceDetails': (context) => UserServiceDetails(),
        //Drawer Pages
        'ContactUS': (context) => ContactUS(),
        //others
        'Catogorie': (context) => Catogorie(),
        //Search
        'SearchResult': (context) => SearchResult(),

      },
      //End
    );
  }
}
