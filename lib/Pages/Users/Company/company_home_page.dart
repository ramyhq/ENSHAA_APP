// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:inshaa/Pages/Users/Company/edit_service_page.dart';
import 'package:inshaa/Pages/Users/UserDrawer.dart';
import 'package:inshaa/constants/Colors.dart';
import 'package:inshaa/constants/dummy_data.dart';
import 'package:inshaa/custom_widgets/MySearchIconAnimated.dart';
import 'package:inshaa/custom_widgets/dismiss_keyboard.dart';
import 'package:inshaa/custom_widgets/show_Delete_alert.dart';
import 'package:inshaa/data_layer/Models/Service_model.dart';
import 'package:inshaa/data_layer/firestore/firestore_database_services.dart';
import 'package:provider/provider.dart';
import '../../../custom_widgets/MySearchIcon_static.dart';
import 'dart:math';

class CompanyHomePage extends StatefulWidget {
  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  bool _isSearchClosed = true;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Servicee>?>.value(
      value: DatabaseServices().ServicesDataList,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Services'),
        ),
        drawer: UserDrawer(),
        body: DismissKeyboard(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('AddServicePage');
                        },
                        child: const Text('Add Service')),
                    TextButton(onPressed: () {
                      Navigator.of(context).pushNamed('CompanyRequestPage');

                    }, child: const Text('Requests')),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MySearchIconStatic(),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: const Text("Our Services",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),textAlign: TextAlign.center,),
                ),
                Divider(color: Colors.black26,endIndent: 80,indent: 80,),
                MyServicesListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyServicesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Services = Provider.of<List<Servicee>?>(context) ?? [];

    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Services.length,
        itemBuilder: (context, index) {
          return ListTile(service: Services[index]);
        });
  }
}

class ListTile extends StatelessWidget {
  const ListTile({Key? key, required this.service}) : super(key: key);
  final Servicee service;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
        child: GFCard(
          boxFit: BoxFit.cover,
          margin: EdgeInsets.all(7),
          padding: EdgeInsets.all(1),
          image: Image.network(
            height: MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.width,
            randomImagesList[Random().nextInt(3)],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: CircularProgressIndicator());
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!.toDouble()
                      : null,
                ),
              );
            },
          ),
          showImage: true,
          titlePosition: GFPosition.start,
          title: GFListTile(
            margin: EdgeInsets.all(0),
            titleText: service.service_title.toString(),
            subTitleText: service.service_area.toString(),
          ),
          content: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.service_des.toString()),
                SizedBox(height: 15),
                Text("Price : ${service.service_price.toString()} USD "),
                Text("Deadline : ${service.deadline.toString()} Days "),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GFButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder:(c)=>EditServicePage(service: service,)));

                      },
                      text: "Edit",
                      icon: Icon(Icons.edit),
                      textColor: Colors.black54,
                      color: Colors.transparent,
                    ),
                    GFButton(
                      onPressed: ()async {
                        showAlertDialog(
                            context: context,
                            function: () async {
                              try {
                                await DatabaseServices().DeleteServiceData(
                                  service_id: service.service_id.toString(),
                                );
                              } catch (e) {
                                print('# DatabaseServices error : $e');
                              }
                            }
                        );
                      },
                      text: "Delete",
                      icon: Icon(Icons.delete),
                      textColor: Colors.black54,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ],
            ),
          ),
          color: Colors.white,
        ));
  }




}
