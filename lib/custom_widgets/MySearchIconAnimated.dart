

import 'package:flutter/material.dart';

class MySearchIconAnimated extends StatefulWidget {
   MySearchIconAnimated({Key? key}) : super(key: key);

  @override
  _MySearchIconAnimatedState createState() => _MySearchIconAnimatedState();
}

class _MySearchIconAnimatedState extends State<MySearchIconAnimated> {
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
        AnimatedContainer(
          duration:  const Duration(milliseconds: 400),
          width: _isSearchClosed ? 54 : MediaQuery.of(context).size.width - 50,
          height: 54 ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: _isSearchClosed ? Colors.white : Colors.white,
            boxShadow:[
          BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 4,
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
                  child: _isSearchClosed
                      ? null : TextField(
                    controller: _searchKeyWord,
                    decoration:  const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none),
                  ),
                ),
              ),
              AnimatedCrossFade(
                duration:const Duration(milliseconds: 600),
                firstChild: Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    icon: Icon( Icons.search ,),
                    color:  Colors.brown,
                    onPressed: () {
                      setState(() {
                        _isSearchClosed = !_isSearchClosed;
                        _searchKeyWord.clear();
                        print(_isSearchClosed);
                      });
                    },
                  ),
                ),
                secondChild: Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    icon:   Icon(Icons.cancel_outlined,),
                    color: Colors.black ,
                    onPressed: () {
                      setState(() {
                        _isSearchClosed = !_isSearchClosed;
                      });
                    },
                  ),
                ),
                crossFadeState: _isSearchClosed ? CrossFadeState.showFirst :CrossFadeState.showSecond,
              ),
            ],
          ),
        ),
        _isSearchClosed
            ? Container() : AnimatedContainer(
          duration: Duration(milliseconds: 400),
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
              TextButton(
                    child: const Text("clear"),
                    onPressed: () {
                      if(_searchKeyWord.text.isNotEmpty){
                        _searchKeyWord.clear();
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
