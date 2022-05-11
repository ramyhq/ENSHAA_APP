import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:inshaa/Pages/Users/UserDrawer.dart';
import 'package:inshaa/constants/Colors.dart';

class UserWelcomeHome extends StatefulWidget {
  const UserWelcomeHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserWelcomeHomeState();
  }
}

class UserWelcomeHomeState extends State<UserWelcomeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ENSHAA"),
        // centerTitle: true,
        elevation: 6,
        //leading: IconButton(icon: Icon(Icons.search),onPressed: (){})
      ),
      body: ListView(
        children: <Widget>[
          InkWell(
            child: SizedBox(
              height: 300,
              width: double.infinity,
              child: Carousel(
                images: [
                  Image.asset('assets/images/1.jpg', fit: BoxFit.cover),
                  Image.asset('assets/images/2.jpg', fit: BoxFit.cover),
                ],
                dotSize: 8,
                dotIncreaseSize: 2,
                dotSpacing: 20,
                dotColor: Colors.white,
                dotBgColor: Colors.orange.withOpacity(0.5),
                overlayShadow: true,
                overlayShadowColors: Colors.orange,
                overlayShadowSize: 0.2,
                animationDuration: Duration(seconds: 1),
              ),
            ),
            onTap: () {},
          ), //Container
          //End Carousel

          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              "WHO WE ARE",
              style: TextStyle(fontSize: 30),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            child: const Card(
              child:  Padding(
                padding:  EdgeInsets.all(10.0),
                child: Text(
                  "Enshaa is a commercial platform that aims to connect the consumer with companies that are related to the construction sector and such related services and products in order to facilitate communication to reduce time and effort, provide multiple options and provide quality work.",
                  style: TextStyle(fontSize: 14,wordSpacing: 1.5),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/who.jpg',
              width: 500,
              height: 200,
            ),
          ),
          //Start Cat
          const Divider(),

          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1.5,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  const Text(
                    "How it works",textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20,),
                  Card(
                    child: SizedBox(
                        height: 190,
                        width: 100,
                        child: ListTile(
                          title: Image.asset(
                            'assets/images/p1.png',
                            width: 100,
                            height: 100,
                          ),
                          contentPadding: EdgeInsets.all(20),
                          subtitle: const Text(
                            "Connect you with contractors, suppliers and engineering offices ",
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                  Card(
                    child: SizedBox(
                        height: 190,
                        width: 100,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(20),
                          title: Image.asset(
                            'assets/images/p2.png',
                            width: 100,
                            height: 100,
                          ),
                          subtitle: const Text(
                            "Verified icon Verified construction companies. ",
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                  Card(
                    child: SizedBox(
                        height: 190,
                        width: 100,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(20),
                          title: Image.asset(
                            'assets/images/p3.png',
                            width: 100,
                            height: 100,
                          ),
                          subtitle: const Text(
                            "Contractor individual icon Professional individuals in construction fields. ",
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                  Card(
                    child: SizedBox(
                        height: 190,
                        width: 100,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(20),
                          title: Image.asset(
                            'assets/images/p4.png',
                            width: 100,
                            height: 100,
                          ),
                          subtitle: const Text(
                            "Request an RFQ and compare prices ",
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                  Card(
                    child: SizedBox(
                        height: 190,
                        width: 100,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(20),
                          title: Image.asset(
                            'assets/images/p5.png',
                            width: 100,
                            height: 100,
                          ),
                          subtitle: const Text(
                            "Contact with companies and suppliers using our online chatting platform  ",
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
//container
        ],
      ),
    );
  }
}
