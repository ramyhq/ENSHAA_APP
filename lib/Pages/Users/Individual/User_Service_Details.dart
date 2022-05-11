
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/badge/gf_button_badge.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:inshaa/constants/Colors.dart';
import 'package:inshaa/data_layer/Models/Service_model.dart';
import 'package:provider/provider.dart';


class UserServiceDetails extends StatelessWidget {
  UserServiceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Servicee? service =
    ModalRoute.of(context)?.settings.arguments as Servicee?;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22)),
              child: Container(
                  decoration: BoxDecoration(
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 0,
                          spreadRadius: 0,
                          offset: const Offset(0, 0),
                        ),
                      ]
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  child: Image.network(
                    'https://images.pexels.com/photos/4513940/pexels-photo-4513940.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  service!.service_title.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text(
                    service.service_des.toString(),
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(height: 20,),
            Wrap(
              children: [
                MyCard(
                    text1:'Area',
                    text2: service.service_area.toString()),

                MyCard(
                    text1: 'our offer',
                    text2: service.service_price.toString()),
                MyCard(
                    text1:'Deadline',
                    text2: service.deadline.toString()),
              ],
            ),
            const SizedBox(height: 20,),

            GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed('ContactUS');
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 40, right: 40, top: 20),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      color: lightBrown,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.40),
                            blurRadius: 1)
                      ]),
                  child:  GFListTile(
                      color: lightBrown,
                      //padding: EdgeInsets.only(left: 65),
                      title: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Contact us',
                          style: TextStyle(color: GFColors.DARK,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                        ),
                      ),
                      ),
                )),

            SizedBox(height: 40,),



          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  MyCard({Key? key,required this.text1,required this.text2}) : super(key: key);
  String text1;
  String text2;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: lightBrown,
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Container(
          padding: EdgeInsets.all(7),
          height: 90,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text1,textAlign: TextAlign.center,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              Text(text2,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
            ],
          )),
    );
  }
}

