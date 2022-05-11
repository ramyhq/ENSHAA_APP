// ignore_for_file: prefer_const_constructors, unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inshaa/constants/Colors.dart';
import 'package:inshaa/custom_widgets/buttons.dart';
import 'package:inshaa/data_layer/firestore/firestore_database_services.dart';
import 'package:inshaa/main.dart';
import 'package:uuid/uuid.dart';

class AddRequestPage extends StatelessWidget {
  AddRequestPage({Key? key}) : super(key: key);

  var uuid = Uuid();
  DatabaseServices dbs = DatabaseServices();
  final _formkey = GlobalKey<FormState>();
  String _customer_name = '',_customer_email = '', _mob = '', _service_area = '',
      _customer_offer = '',_deadline = '',_request_id = '';
  bool _request_status = false;

  @override
  Widget build(BuildContext context) {
    _request_id = uuid.v1();
    var argList = ModalRoute.of(context)?.settings.arguments as List<String>;
    var service_created_by = argList[0];
    var service_id = argList[1];
    _customer_email = customer_email.toString();
        print('$_customer_email is sending a request');
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Request to company'),
        backgroundColor: mainBrown,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5),
                    TextFormField(
                      onChanged: (value) => _customer_name = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your name' : null,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Enter your name',
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      onChanged: (value) => _mob = value,
                      validator: (value) =>
                          value!.isEmpty ? "Your phone can't be empty" : null,
                      decoration: InputDecoration(
                        labelText: 'Enter contact phone',
                        icon: Icon(Icons.phone),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      onChanged: (value) => _service_area = value,
                      validator: (value) =>
                          value!.isEmpty ? "Your Area can't be empty" : null,
                      decoration: InputDecoration(
                        labelText: 'Enter work area',
                        icon: Icon(Icons.description),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) => _customer_offer = value,
                      validator: (value) =>
                          value!.isEmpty ? "Your Area can't be empty" : null,
                      decoration: InputDecoration(
                        labelText: 'Enter your offer',
                        icon: Icon(Icons.attach_money),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    TextFormField(
                      onChanged: (value) => _deadline = value,
                      validator: (value) =>
                      value!.isEmpty ? "please select a deadline" : null,
                      decoration: InputDecoration(
                        labelText: 'Enter your deadline',
                        icon: Icon(Icons.timer),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    SizedBox(height: 15),
                    Button1(
                        text: 'Add',
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            try{
                              await dbs.updateRequestData(
                                service_created_by: service_created_by,
                                service_id: service_id,
                                customer_name: _customer_name,
                                customer_email: _customer_email,
                                mob: _mob,
                                service_area: _service_area,
                                customer_offer: _customer_offer.toString(),
                                deadline: _deadline,
                                request_status: _request_status,
                                request_id: _request_id,
                              );
                            }catch(e){
                              print('#111 add new Service error : $e');
                            }
                            Navigator.pop(context);
                          }
                        },
                        textColor: Colors.white,
                        bgColor: Color(0xFFC7A176)),
                    SizedBox(height: 10),
                    // create an account? & have an account? button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
