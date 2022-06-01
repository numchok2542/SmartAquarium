
import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:influxdb_client/api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


List<ChartData> chartData =[];
List<ChartData> chartpH=[];
List<ChartData> chartwat=[];

class GraphForm extends StatefulWidget {
  @override
  _GraphFormState createState() => _GraphFormState();
}

class _GraphFormState extends State<GraphForm> {
  Timer? timer;
  bool run = false;

  ChartSeriesController? _chartSeriesController;
  @override
  void initState() {



      _updateDataSource();
      Timer(Duration(seconds: 5), () {
        setState(() {
          run = true;
        });
            });

      Timer.periodic(const Duration(seconds: 60), (Timer t)
      {
        print(t.tick);
        _updateDataSource();
        print("60 seconds");
        setState(() {
          run = true;
        });
      });
    super.initState();
  }


  var client = InfluxDBClient(
      url: 'http://europe-west1-1.gcp.cloud2.influxdata.com',
      //username: 'ginzazaid@hotmail.com',
      //password: 'Admin1234!',
      token: 'R9ZW4DS1bxxIsYTzs0eChj9neAQmbEE6Ij7Rg3x_sH6J-xC4Z3M1cq17Wk0U00dMiwoYpdMmF96U01cLYUP0vA==',
      org:  "ginzazaid@hotmail.com",
      bucket: "SmartAq",
      debug: true);

  void _updateDataSource() {

      readCSV("temperature");
      readCSV("pH");
     // readCSV("waterlevel");

  }


  void readCSV(String field) async {
    var queryService = client.getQueryService();

    var fluxQuery = '''
      from(bucket: "SmartAq")
      |> range(start: -1h)
      |> filter(fn: (r) => r["_measurement"] == "mem")
      |> filter(fn: (r) => r["_field"] == "'''+field+'''")
      |> aggregateWindow(every: 1m, fn: mean, createEmpty: false)
      |> yield(name: "mean")
      ''';
        print(fluxQuery);
        // query to stream and iterate all records
        var count = 0;
        var recordStream = await queryService.query(fluxQuery);
        await recordStream.forEach((record) {
          if (field =="temperature") {
            chartData.add(ChartData(record['_time'], record['_value']));
          }else if(field =="pH"){
            chartpH.add(ChartData(record['_time'], record['_value']));
          }
          // else if(field =="waterlevel"){
          //   chartwat.add(ChartData(record['_time'], record['_value']));
          // }
          print(
              'record: ${count++} ${record['_time']}: ${record['host1']} ${record[field]} ${record['_value']}');
        });
        print("chartData");
        print(chartData);
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
      Text("Temperature"),
                Container(
                    child:

                        SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: <ChartSeries>[
                            // Renders line chart
                            LineSeries<ChartData, String>(
                            dataSource: chartData,
                                onRendererCreated: (ChartSeriesController controller) {
                                  _chartSeriesController = controller;
                                },
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,

                           )
                          ]

                    )

                  /*SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                            series: <ChartSeries>[
                              // Renders line chart
                              LineSeries<ChartData, String>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y
                              )
                            ]
                        )*/
                    ),
                    chartData.length != 0 ?
                    Text("Latest temperature: "+chartData[chartData.length-1].y.toString()) : Text("No Data"),
                    // Text("Water Level"),
                    // Container(
                    //     child:
                    //     SfCartesianChart(
                    //
                    //         primaryXAxis: CategoryAxis(),
                    //         series: <ChartSeries>[
                    //           // Renders line chart
                    //           LineSeries<ChartData, String>(
                    //               dataSource: chartwat,
                    //               xValueMapper: (ChartData data, _) => data.x,
                    //               yValueMapper: (ChartData data, _) => data.y
                    //           )
                    //         ]
                    //     )
                    // ),
      SizedBox(height:30),
      Text("pH Level"),
      Container(
          child:
          SfCartesianChart(

              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                // Renders line chart
                LineSeries<ChartData, String>(
                    dataSource: chartpH,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,

                )
              ]
            )
           ),
      chartData.length != 0 ?
      Text("Latest pH: "+chartpH[chartData.length-1].y.toString()) : Text("No Data"),]
      )
    );
  }
}
class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}

