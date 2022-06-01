import 'dart:async';
import 'dart:io';
//import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:influxdb_client/api.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


class PumpWid extends StatefulWidget {
  @override
  _PumpWidState createState() => _PumpWidState();
}

class _PumpWidState extends State<PumpWid> {
  @override
  void initState() {
    //timer = Timer.periodic(const Duration(milliseconds: 100), _updateDataSource);
    mqconn();
    super.initState();

  }
  String ip = "";
  String port = "";
  String keyMac = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDL3mFoX7Gcp9kQU1u5fCU3sZjcpp+"
      "2MrboIKAdt50k6vsEpLOa1L0U1WV35u7345r3JYh5HmvsiWzovV2jczSS6NQAO1/yejNPFTas2PUnCk8Dytl"
      "/4MXx2dCg8TDwVE0yEnJSidv7ONMolgOSGsUCXV9IK4svIv82nWNKH4l8kq2yya0H0T7F8jLBxkFktQbqVsts"
      "4JgFH511HO0aPHpNON26PAcocLhERrSlivh4sSJ5fRxuqAeVoJV2kn1xZyN+XnHDFXHaTTLtpP2mp"
      "TctiqmEV3QgHbqRj+BNoDI8pdU2NMrylo1t4ZsMv4PQPtthITLzGRJzE1Kb1FwBjSjRbV20Op6Jt31DA8qop39x4b"
      "7i5Gjmy3H7L9FIBgGSMjMRfCE7RvVi0KbQKTNxmix33QNbER5BbfpWi6NxksRGv19UNWRh9it2TPCt6LCBBAD3iE"
      "4xd6Cn8kRhf4Ywa/PMmGKt+yGlOnVpaDJnSEhjmEwVyyqheRaQnWzwLs6wRgE= admin@Admins-MacBook-Pro.local";

  String keyPi = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC40ntgGUbrxpmw9twHDeuFf4T2WfDFbf3ZT7ObAe5lx1Xoh4JdLyTOJZgkeUQhiizz+"
      "XlmDZtN+fU7Z6+7tebqixB781VxiylGd+D+0ceJBK8oB7AeqMDX3cHVKhJVD+AZ2UhqRGXYeQMhsktBY+ajDNO8LHi+T9S/TFTyVVeUjMit090Dq"
      "/vvP6jJiie4oEydoK68/PWbawZ0dU6UOp5IUIS+MOGwkPRgCOtlo5XEdXeb1kJqagfNYJS6plbD2muyvmA0mDF0kVSSntPlRyVpcl5Fg6ZxD0bqL+"
      "NrlXIfCz/v21VgwkLcwiS2wbSB137q4SWvy2GDEMDX2ZmpX7GJvU8CbfOc75Ehvg6v0liDwNEV7SC5Ay7FMpFqZcyPcHY7h0Hp4bLday4m4Lr"
      "VDGTa8yEzyEE5TZWt82Q8YHiq4fDgR8PtqoyCCeU5EokKchtZ+S+3xUarE6FGklSLYZdqU1q0QxXxyYVYDORgyVOn2yO7+eWJqMl6z9tac1w+Kq0= pi@numchokpi";

  String keyVM = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDg4FqQc/7tHlrMi/rA5qVXy0RaHgVqrThdE8YKUVCW5XNpvXrRgLlObd0xUxZYDkzvSgGxiReyXtDM"
      "/yPjNDn9/1yGB/3NsfWMDmBtZv2T/wGntfkxpOM03RwoUM4OtEioVkpfJdT5s0OqncpDfhSkGlfT2jSOrroEO3iHv5zud7g+pQFtiP6fig6d1qwUXzZIViYS7mXgpzk"
      "8WNKeDx8K5Evpdic9s/qCzzby/uDUoAa/lh//ugiDCmfudD3i7M4A0huSWL55FhT3DjMyWHT7BQV+3uWNt6WtLrRWlbAuU8pUMVuJkuUMszA176f+342n+"
      "Eo3K5jGgKlsWZn2pIxo4UvxkL+D0dL4KygEe17zkAZOM7ezNNhdkq61l74qydF52nS1m0m6wsw5mk25yCWg/TaLkMXOWa7IiPQmOWLls0Ca89oaqCyrxB4kmNZfUnPHfNOXs"
      "u0FyRSW/65i+CMUqdftu9cO1gk5q2wEk6OFtTJSJ9nLUIzc3VuAGwSQDOE= numchok@numchok-VirtualBox";
  //ip = ipController.Text;
  bool pump = false;
  //var client = MqttServerClient("128.199.159.241", "8883");
  var client = MqttServerClient("broker.emqx.io", "1883");

  //ip and port
  var pongCount = 0; // Pong counter
  Future<int> mqconn() async {
    print("mqconning.....");
    client.logging(on: false);

    /// Set the correct MQTT protocol for mosquito
    client.setProtocolV311();

    /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
    client.keepAlivePeriod = 60;
    //client.username_pw_set(username="numchok",password="training@2022");
    //client.checkCredentials('numchok', 'training@2022');
    /// Add the unsolicited disconnection callback
    //client.secure = true;
    client.onDisconnected = onDisconnected;
    //client.port = 1883;
    //client.useWebSocket = true;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;

    client.pongCallback = pong;
    final connMess = MqttConnectMessage()
        .withClientIdentifier('NumchokMQTTClient106')
        .withWillTopic('TestMQTT') // If you set this you must set a will message
        .withWillMessage('Connecting lose')
        .startClean() // Non persistent session for testing
    //.authenticateAs("numchok", "training@2022")
        .withWillQos(MqttQos.atLeastOnce);
    print('Mosquitto client connecting....');
    client.connectionMessage = connMess;

    try {
      await client.connect(

      );
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('socket exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      //exit(-1);
    }

    /// Ok, lets try a subscription
    print('Subscribing to the test/lol topic');
    const topic = 'Dart/Pumping'; // Not a wildcard topic
    client.subscribe(topic, MqttQos.atMostOnce);
    print("---------------------------------");
    print(client.subscribe(topic, MqttQos.atMostOnce));
    int counter;



    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      setState(() {
        pump=true;
      });
      Timer(Duration(seconds: 2), () {
        print("Yeah, this line is printed after 7 seconds");
        setState(() {
          pump=false;
        });
      });



      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print(
          'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });

    client.published!.listen((MqttPublishMessage message) {
      print(
          'Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
    });
    return 0;
  }

  void pubmessage(String feedbool){

    const pubTopic = 'Dart/Pumping2';
    final builder = MqttClientPayloadBuilder();

    /// Subscribe to it
    print('Subscribing to the Dart/Pumping2 topic');
    client.subscribe(pubTopic, MqttQos.exactlyOnce);

    /// Publish it
    print('Publishing our topic');
    builder.clear();
    builder.addString(feedbool);
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
    print(client.connectionStatus);
    print(MqttDisconnectionOrigin.solicited.toString());
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('OnDisconnected callback is solicited, this is correct');
    } else {
      print(
          'OnDisconnected callback is unsolicited or none, this is incorrect - exiting');
      //exit(-1);
    }
    if (pongCount == 3) {
      print('Pong count is correct');
    } else {
      print('Pong count is incorrect, expected 3. actual $pongCount');
    }
  }

  /// The successful connect callback
  void onConnected() {
    print(
        'OnConnected client callback - Client connection was successful');
  }

  /// Pong callback
  void pong() {
    print('Ping response client callback invoked');
    pongCount++;
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    return Center(child:Column(children:[
      const SizedBox(height: 30),
      Text("Pump Control", style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)),
      const SizedBox(height: 30),
      Text(pump ? "Pump on" : "Pump off", style: TextStyle(fontSize: 30)),
      const SizedBox(height: 30),
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {

        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 5.0, color: Colors.white),
          ),
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Container(
              width: 40.0,
              height: 40.0,
              child: Container(
                decoration: new BoxDecoration(
                  color: pump ? Colors.greenAccent : Colors.red,
                  shape:
                  pump ? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: pump
                      ? BorderRadius.all(Radius.circular(8.0))
                      : null,
                ),
              ),
            ),
          ),
        ),
      ),

      const SizedBox(height: 30),
      Switch(
        value: pump,
        onChanged: (value) {
          setState(() {
            pump = value;
            print(pump);
            pubmessage("True");
            //pubmessage(pump.toString());
          });
        },
        activeTrackColor: Colors.lightGreenAccent,
        activeColor: Colors.green,
      ),
      /*ElevatedButton(

        onPressed: () {
          setState(() {
            pump = true;
            pubmessage("True");
          });
          Timer(Duration(seconds: 5), () {
            setState(() {
              pump = false;
              pubmessage("False");
            });
          });
        },
        child: const Text('Pump on'),
      ),*/
      const SizedBox(height: 30),
      // ElevatedButton(
      //
      //   onPressed: () {
      //     mqconn();
      //   },
      //   child: const Text('Connect MQTT'),
      // ),
      const SizedBox(height: 30),

      Text("Instructions for Pump screen"),
      Container(child: Text("1.The feeder screen first starts in a closed position (Red color)")),
      Container(child: Text("2. Click the switch to activate the pump")),
      Container(child: Text("3. The pump will automatically deactivate after 5 seconds")),
    ]
    )
    );
  }
}


