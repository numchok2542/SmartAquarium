
import 'package:flutter/material.dart';
import 'PumpWidget.dart';


class PumpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Pump"),backgroundColor: Colors.lightBlueAccent,),
        body: PumpWid(),
    );
  }
}