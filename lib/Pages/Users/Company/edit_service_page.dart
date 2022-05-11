// ignore_for_file: prefer_const_constructors, unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inshaa/constants/Colors.dart';
import 'package:inshaa/custom_widgets/buttons.dart';
import 'package:inshaa/data_layer/Models/Service_model.dart';
import 'package:inshaa/data_layer/firestore/firestore_database_services.dart';
import 'package:inshaa/main.dart';
import 'package:uuid/uuid.dart';

class EditServicePage extends StatelessWidget {
  EditServicePage({Key? key, required this.service}) : super(key: key);
  Servicee? service; // this to load service exiting data

  var uuid = Uuid();
  DatabaseServices dbs = DatabaseServices();
  final _formkey = GlobalKey<FormState>();
  String _service_title = '',
      _service_des = '',
      _service_area = '',
      _created_by = '',
      _service_id = '';
  double _service_price = 0.0, _deadline = 10;

  @override
  Widget build(BuildContext context) {
    _created_by = customer_email.toString();
    _service_id = uuid.v1();
    print('$_created_by is adding a service');

    _service_title = service!.service_title.toString();
    _service_des = service!.service_des.toString();
    _service_area = service!.service_area.toString();
    _created_by = service!.created_by.toString();
    _service_id = service!.service_id.toString();
    _service_price = double.parse(service!.service_price.toString());
    _deadline = double.parse(service!.deadline.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Service Page'),
        backgroundColor: mainBrown,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5),
                    TextFormField(
                      initialValue: _service_title,
                      onChanged: (value) => _service_title = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter service_title' : null,
                      decoration: InputDecoration(
                        icon: Icon(Icons.title),
                        labelText: 'Enter service_title',
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      initialValue: _service_des,
                      onChanged: (value) => _service_des = value,
                      validator: (value) => value!.isEmpty
                          ? "Your description can't be empty"
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Enter service description',
                        icon: Icon(Icons.description),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      initialValue: _service_area,
                      onChanged: (value) => _service_area = value,
                      validator: (value) =>
                          value!.isEmpty ? "Your Area can't be empty" : null,
                      decoration: InputDecoration(
                        labelText: 'Enter work area',
                        icon: Icon(Icons.description),
                      ),
                    ),
                    TextFormField(
                      initialValue: _service_price.toString(),
                      onChanged: (value) =>
                          _service_price = double.parse(value),
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
                      initialValue: _deadline.toString(),
                      onChanged: (value) => _deadline = double.parse(value),
                      decoration: InputDecoration(
                        labelText: 'Enter deadline',
                        icon: Icon(Icons.calendar_today),
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
                            var stinLowerCase = _service_title.toLowerCase();
                            List<String> stStringLinst = [];
                            for (int i = 1; i < stinLowerCase.length + 1; i++) {
                              stStringLinst.add(stinLowerCase.substring(0, i));
                            }
                            print(stStringLinst);
                            try {
                              await dbs.UpdateServiceData(
                                service_title: _service_title,
                                service_des: _service_des,
                                service_area: _service_area,
                                service_price: _service_price.toString(),
                                deadline: _deadline.toString(),
                                titleAsList: stStringLinst,
                                created_by: _created_by,
                                service_id: _service_id,
                              );
                            } catch (e) {
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
