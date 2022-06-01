
import 'package:flutter/material.dart';
import 'bulbWidget.dart';


class bulbScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Ligth"),backgroundColor: Colors.lightBlueAccent,),
        body: bulbWid()
    );
  }
}