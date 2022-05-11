import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:inshaa/data_layer/Models/Request_model.dart';
import 'package:inshaa/data_layer/Models/Service_model.dart';
import 'package:inshaa/data_layer/firestore/firestore_database_services.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class CompanyRequestPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('#10222 $customer_email');
    return StreamProvider<List<Request>?>.value(
      value: DatabaseServices()
          .RequestsDataListForMySerivces(customer_email.toString()),
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Our Requests'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children:  [
              Container(
                alignment: Alignment.center,
                height: 70,
                  child: const Text("Customers Requests",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 10,),
              const Divider(),
              MyRequestsListView(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyRequestsListView extends StatelessWidget {
  const MyRequestsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final requests = Provider.of<List<Request>?>(context) ?? [];

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return ListTile(request: requests[index]);
        });
  }
}

class ListTile extends StatelessWidget {
   ListTile({Key? key, required this.request}) : super(key: key);
  final Request request;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Servicee?>.value(
      value: DatabaseServices().getServiceById(request.service_id.toString()),
         initialData: null,
         child: ListTileData(request:request),
    );
  }
}

class ListTileData extends StatelessWidget {
   ListTileData({Key? key, required this.request}) : super(key: key);
  final Request request;
  Servicee? service;

  @override
  Widget build(BuildContext context) {
     service =  Provider.of<Servicee?>(context) ?? Servicee();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
        child: GFCard(
          elevation: 4,
          boxFit: BoxFit.cover,
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          padding: const EdgeInsets.all(1),
          titlePosition: GFPosition.start,

          content: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Service Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                const SizedBox(height: 5),
                Divider(),
                Text("${service?.service_title.toString()}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                Text("Area: ${service?.service_area.toString()}"),
                Text("Our Price: ${service?.service_price.toString()}"),
                Text("Our Deadline: ${service?.deadline.toString()}"),
                Text("Description: ${service?.service_des.toString()}"),
                const Divider(),
                const SizedBox(height: 5),
                const Text("Customer Offer ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                const SizedBox(height: 5),
                Text("Customer Name : ${request.customer_name.toString()}  "),
                Text("Customer Email : ${request.customer_email.toString()}  "),
                Text("Service Area : ${request.service_area.toString()}  "),
                Text("Phone : ${request.mob.toString()}  "),
                Text("Customer offer : ${request.customer_offer.toString()} OMR "),
                Text("Deadline : ${request.deadline.toString()} Days "),
                Text( "Status : ${request.request_status ? 'Approved' : 'Pending'}",style: TextStyle(color:request.request_status ? Colors.green:Colors.amber,fontWeight: FontWeight.w500 ),),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GFButton(
                      onPressed: () async {
                        try{
                          await DatabaseServices().updateRequestStatus(
                            request_id: request.request_id.toString(),
                            request_status: true,
                          );
                        }catch(e){
                          print('#111 add new Service error : $e');
                        }
                      },
                      text: "Approve",
                      icon: const Icon(Icons.done),
                      textColor: Colors.black54,
                      color: Colors.transparent,
                    ),
                    GFButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('CompanyServiceDetails',
                            arguments: service);
                      },
                      text: "Open Service",
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
        ));
  }
}
