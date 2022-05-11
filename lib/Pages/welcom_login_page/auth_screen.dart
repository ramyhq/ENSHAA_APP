// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'auth_form.dart';


enum AuthType{ login , register}

class AuthScreen extends StatelessWidget {
  final AuthType authType;
  const AuthScreen({Key? key, required this.authType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  //height: MediaQuery.of(context).size.height * 0.2,
                  decoration:BoxDecoration(
                    color: Color(0xFFC7A176),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Image.asset('assets/images/logo.png' , height: 210,),
                      SizedBox(height: 40),
                    ],
                  ),
                ),

              ] ,
            ),
            AuthForm(authType: authType),
          ],
        ),
      ),
    );
  }
}
