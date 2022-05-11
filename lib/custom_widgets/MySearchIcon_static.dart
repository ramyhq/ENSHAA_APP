

import 'package:flutter/material.dart';

class MySearchIconStatic extends StatefulWidget {
   MySearchIconStatic({Key? key}) : super(key: key);

  @override
  _MySearchIconStaticState createState() => _MySearchIconStaticState();
}

class _MySearchIconStaticState extends State<MySearchIconStatic> {
  bool _isSearchClosed = true;
  TextEditingController _searchKeyWord = TextEditingController();

@override
  void dispose() {
    super.dispose();
    _searchKeyWord.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 54 ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow:[
          BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 2,
          spreadRadius: 0.1,
          offset: const Offset(0, 0),
        ),
      ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding:  const EdgeInsets.only(left: 20),
                  child: TextField(
                    onSubmitted: (value){
                      if(_searchKeyWord.text.isNotEmpty){
                        Navigator.of(context).pushNamed('SearchResult',arguments: value.trim());
                      }
                    },
                    controller: _searchKeyWord,
                    decoration:  const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                child: Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    icon:   Icon(Icons.cancel_outlined,),
                    color: Colors.black ,
                    onPressed: () {
                      if(_searchKeyWord.text.isNotEmpty){
                        _searchKeyWord.clear();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              TextButton(
                    child: const Text("search"),
                    onPressed: () {
                      if(_searchKeyWord.text.isNotEmpty){
                        Navigator.of(context).pushNamed('SearchResult',arguments: _searchKeyWord.text.trim());
                      }

                    },
                  ),
            ],
          ),
            ),
      ],
    );
  }
}
