import 'package:newsmartaquarium/Graph/GraphWidget.dart';
import 'package:flutter/material.dart';
import 'package:newsmartaquarium/ฺFeeder/FeederWidget.dart';


class FeederScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Feeder"),backgroundColor: Colors.lightBlueAccent,),
        body: FeederWid()
    );
  }
}