import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/position/gf_position.dart';
import 'package:inshaa/Pages/Users/UserDrawer.dart';
import 'package:inshaa/constants/dummy_data.dart';
import 'package:inshaa/custom_widgets/MySearchIcon_static.dart';
import 'package:inshaa/custom_widgets/dismiss_keyboard.dart';
import 'package:inshaa/data_layer/Models/Service_model.dart';
import 'package:inshaa/data_layer/firestore/firestore_database_services.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../../../custom_widgets/MySearchIconAnimated.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Servicee>?>.value(
      value: DatabaseServices().ServicesDataList,
      initialData: null,
      child: DismissKeyboard(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Projects'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('UserRequestPage');
                  },
                  child: const Text(
                    'Requests  ',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  )),
            ],
          ),
          drawer: UserDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
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
                  child: const Text(
                    "Projects",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(
                  color: Colors.black26,
                  endIndent: 80,
                  indent: 80,
                ),
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
        physics: const NeverScrollableScrollPhysics(),
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
    print(Random().nextInt(3));
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('UserServiceDetails', arguments: service);
          },
          child: GFCard(
            boxFit: BoxFit.cover,
            margin: const EdgeInsets.all(7),
            padding: const EdgeInsets.all(1),
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
              margin: const EdgeInsets.all(0),
              titleText: service.service_title.toString(),
              subTitleText: service.service_area.toString(),
            ),
            content: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.service_des.toString()),
                  const SizedBox(height: 15),
                  Text("Price : ${service.service_price.toString()} USD "),
                  Text("Deadline : ${service.deadline.toString()} Days "),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GFButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('AddRequestPage',
                              arguments: [
                                service.created_by.toString(),
                                service.service_id.toString()
                              ]);
                        },
                        text: "send offer",
                        icon: const Icon(Icons.send),
                        textColor: Colors.black54,
                        color: Colors.transparent,
                      ),
                      GFButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('UserServiceDetails',
                              arguments: service);
                        },
                        text: "open",
                        icon: const Icon(Icons.open_in_new),
                        textColor: Colors.black54,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            color: Colors.white,
          ),
        ));
  }
}
