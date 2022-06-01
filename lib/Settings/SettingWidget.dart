import 'dart:async';
import 'dart:io' as io;
//import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:influxdb_client/api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  Timer? timer;
  bool run = false;
  TextEditingController ipController = new TextEditingController();
  String getip(){
    return ipController.text;
  }
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    return SingleChildScrollView(child:
        Column(children:[


        SizedBox(height:20),
          TextField(
            controller: ipController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter IP',
            ),
          ),
          SizedBox(height:20),
          ElevatedButton(

            onPressed: () {},
            child: const Text('OK'),
          ),
      ]
     )
    );
  }
  
}