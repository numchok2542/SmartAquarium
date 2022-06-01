
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:influxdb_client/api.dart';



class HelpForm extends StatefulWidget {
  @override
  _HelpFormState createState() => _HelpFormState();
}

class _HelpFormState extends State<HelpForm> {




  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    return SingleChildScrollView(child:
    Column(children:[


      SizedBox(height:20),
      Text("HELP",style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
      Container(child: Text("How to use the smart aquarium",style: TextStyle(fontSize: 30))),
      Container(child: Text("1. Press the menu button on the upper left corner",style: TextStyle(fontSize: 30))),
      Container(child: Text("2. Select one of the tools in the menu",style: TextStyle(fontSize: 30))),
      Container(child: Text("3. Four tools available, Graph, Feeder, Pump and Light ",style: TextStyle(fontSize: 30))),
      Container(child: Text("4. Please check each tool for detailed instructions",style: TextStyle(fontSize: 30))),

      Container(),

                      ]


                )
    );

        }
}
class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}

