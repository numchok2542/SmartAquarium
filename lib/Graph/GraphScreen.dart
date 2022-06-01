import 'package:newsmartaquarium/Graph/GraphWidget.dart';
import 'package:flutter/material.dart';

class GraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Graph"),backgroundColor: Colors.lightBlueAccent,),
      body: GraphForm()
    );
  }
}