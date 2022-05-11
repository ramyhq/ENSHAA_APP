import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/position/gf_position.dart';
import 'package:inshaa/Pages/Users/UserDrawer.dart';
import 'package:inshaa/data_layer/Models/Service_model.dart';
import 'package:inshaa/data_layer/firestore/firestore_database_services.dart';
import 'package:provider/provider.dart';

import '../../constants/Colors.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchKeyWord = ModalRoute.of(context)?.settings.arguments as String;
    return StreamProvider<List<Servicee>?>.value(
      value: DatabaseServices().ServicesDataList2(searchKeyWord),
      initialData: null,
      child: Scaffold(
        appBar: AppBar(title: const Text('Search Result'),),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyServicesListView(),
            ],
          ),
        ),
      ),
    );
  }
}


class MyServicesListView extends StatelessWidget {
  const MyServicesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<List<Servicee>?>(context) ??
        [Servicee(
          service_title: 'test_title',
          service_des: 'test_description',
          service_area: 'test_area',
          service_price: 'test_price',
          deadline: '10 days',
        )];

    return ListView.builder(
        physics:  NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: services.length,
        itemBuilder: (context , index){
          return ListTile(service:services[index]);
        });
  }
}

class ListTile extends StatelessWidget {
  const ListTile({Key? key, required this.service}) : super(key: key);
  final Servicee service;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 7.0),
        child: GFCard(
          boxFit: BoxFit.cover,
          margin: EdgeInsets.all(7),
          padding: EdgeInsets.all(1),
          image: Image.network(
            height: MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.width,
            'https://images.pexels.com/photos/4513940/pexels-photo-4513940.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
            fit: BoxFit.cover,
          ),
          showImage: true,
          titlePosition: GFPosition.start,
          title: GFListTile(
            margin: EdgeInsets.all(0),
            titleText: service.service_title.toString(),
            subTitleText: 'Area',
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(service.service_des.toString()),
              SizedBox(height: 15),
              Text("Price : ${service.service_price.toString()} USD "),
              Text("Deadline : ${service.deadline.toString()} Days "),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // GFButton(
                  //   onPressed: () {},
                  //   text: "Delete",
                  //   icon: Icon(Icons.delete),
                  //   textColor: Colors.black54,
                  //   color: Colors.transparent,
                  // ),
                ],
              ),
            ],
          ),
          color: lightBrown,
        ));
  }
}
