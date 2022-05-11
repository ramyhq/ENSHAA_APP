import 'package:flutter/material.dart';

import 'Users/UserDrawer.dart';

class Catogorie extends StatefulWidget {
  const Catogorie({Key? key}) : super(key: key);

  @override
  CatogorieState createState() => CatogorieState();
}

  class CatogorieState extends State<Catogorie> {

  @override
  Widget build(BuildContext context ){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),

      ),
      drawer: UserDrawer(),
      body: Container(),
    );
  }
}

