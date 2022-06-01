import 'package:newsmartaquarium/Settings/SettingWidget.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Settings"),backgroundColor: Colors.lightBlueAccent,),
        body: SettingForm()
    );
  }
}