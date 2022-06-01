import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsmartaquarium/Pump/Pumpscreen.dart';
import 'package:newsmartaquarium/Settings/SettingScreen.dart';

import 'package:newsmartaquarium/ฺFeeder/FeederScreen.dart';
import 'package:newsmartaquarium/Bulb/bulbScreen.dart';

import '../Graph/GraphScreen.dart';
import '../Help/HelpScreen.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Smart Aquarium"),backgroundColor: Colors.blueAccent,),
        body:Column(

        children:[
        Container(
        padding: const EdgeInsets.only(left: 30),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        //color: Color(0xfffdcfffb)
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xfffb9deed),
                Color(0xfffefefef),
              ])),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        // child: ConstrainedBox(
        //     constraints: BoxConstraints(
        //       maxWidth: MediaQuery.of(context).size.width,
        //     ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Smart".toUpperCase(),
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Aquarium".toUpperCase(),
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   "Thinking of Scuba Diving? Dive with Us DTA.",
                //   style: TextStyle(
                //     fontSize: 21,
                //   ),
                // ),
              ],
            ),
            // Spacer(
            // flex: 2,
            // ),
            SizedBox(width: MediaQuery.of(context).size.width/5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              // children: [
              //   // Text('img'),
              //   Container(
              //     // width: 400,
              //     // height:350,
              //     width: MediaQuery.of(context).size.width / 2,
              //     height: MediaQuery.of(context).size.height / 2.2,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       image: DecorationImage(
              //         image: AssetImage('assets/images/scuba-diving.jpg'),
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ],
            ),
            SizedBox(width: 20),
          ],
        ),
      )
    // )
  )



        ]
        ),




      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              child: Text('Smart Aquarium Menu'),
            ),
            ListTile(
              title: const Text('Home'),

              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            /*ListTile(
              title: const Text('Data'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),*/
            ListTile(
              title: const Text('Graph'),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => GraphScreen()));

              },
            ),
            ListTile(
              title: const Text('Feeder'),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => FeederScreen()));

              },
            ),
            ListTile(
              title: const Text('Pump'),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => PumpScreen()));

              },
            ),
            ListTile(
              title: const Text('Ligth'),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => bulbScreen()));

                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Help'),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => HelpScreen()));

                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      )
    );
}

class InfoCard extends StatefulWidget {
  /*const InfoCard({
    Key key="0",
    this.index!,
  }) : super(key: key);*/

  //final int index;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 320,
        width: 1000,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
                width: 300,
                height: 300,
                child: /*Image.asset(LiveAboardDatas[widget.index].image)),*/
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       /* Text('Liveaboard name : ' +
                            HotelList[0].name),*/

                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('City'),
                            SizedBox(width:20),
                            Text('Country'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        // Text(LiveAboardDatas[widget.index].description),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Text('Total capacity'),

                        SizedBox(
                          height: 10,
                        ),
                        Text('Room type'),
                        SizedBox(
                          height: 10,
                        ),

                        Align(
                            alignment: Alignment.centerRight,
                            child: Text('Price : ' /* LiveAboardDatas[widget.index].price*/)),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                            onPressed: () {
                              /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LiveaboardDetailScreen()));
*/
                            },
                            color: Colors.amber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("View boat"),
                          ),
                        )

                      ],
                    ),
                  )),
            )
            )
          ],
        ),
      ),
    );
  }
}

