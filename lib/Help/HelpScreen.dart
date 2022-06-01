import 'package:newsmartaquarium/Graph/GraphWidget.dart';
import 'package:flutter/material.dart';

import 'HelpWidget.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Help"),backgroundColor: Colors.lightBlueAccent,),
      body: HelpForm()
    );
  }
}