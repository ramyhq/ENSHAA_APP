// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';
import 'package:inshaa/constants/Colors.dart';


class ContactUS extends StatelessWidget {
  const ContactUS({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Enshaa',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40,bottom: 10),
                child: ContactUs(
                  cardColor: Colors.white,
                  textColor: mainBrown,
                  email: 'main@enshaafuture.com',
                  dividerThickness: 3,
                  dividerColor: lightBrown,
                  website: 'https://enshaafuture.com/',
                  phoneNumber: '+968 96585033',
                  taglineColor: mainBrown,
                  companyColor: mainBrown,
                  companyName: 'Enshaa',
                  companyFontSize: 40,
                ),
              ),
              Card(
                elevation: 1,
                margin: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('P.O.Box 123, Al Bustan Place Hotel Road, Al Wadi Al Kabir, Jibroon',
                    textAlign: TextAlign.center,style: TextStyle(color: mainBrown,fontWeight: FontWeight.w400),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
