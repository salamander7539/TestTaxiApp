import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taxi_final_app/my_address.dart';
import 'package:taxi_final_app/phone_number.dart';
import 'package:taxi_final_app/await_taxi.dart';
import 'package:taxi_final_app/pin_code.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:async';
import 'dart:io';

void main() => runApp(MyApp());

enum Countries { Russia, USA, Japan, China }

var name, fcmToken;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(routes: {
      "/page1": (context) => HomePage(),
      "/page2": (context) => PhonePage(),
      "/page3": (context) => PinInput(),
      "/page4": (context) => MyAddress(),
      "/page5": (context) => AwaitTaxi(),
    }, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future _showNotification(Map<String, dynamic> message) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    'channel id',
    'channel name',
    'channel desc',
    importance: Importance.Max,
    priority: Priority.High,
  );

  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, null);
  await flutterLocalNotificationsPlugin.show(
    0,
    message['notification']['title'],
    message['notification']['body'],
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}

getToken() async {
  String token = await _firebaseMessaging.getToken();
  fcmToken = token;
  print("FCM-token: $fcmToken");
}

Future selectNotification(String payload)async{
  await flutterLocalNotificationsPlugin.cancelAll();
}

@override
void initState() {
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, null);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);
  super.initState();
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      var data = message['data'];
      var payload = json.decode(data['payload']);
      String order_state = payload['state_title'];
      print("ANSWER: $order_state");
//      showDialog(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            title: Text(message['data']['payload'].toString()),
//            content: Text(message['data']['payload'].toString()),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Ok'),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              ),
//            ],
//          );
//        },
//      );
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    },
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
  );
  getToken();
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text(
          "Faem-Такси",
          style: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 100.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Введите ваше имя",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              color: Colors.white,
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                autofocus: true,
                onSubmitted: (String newName) {
                  name = newName;
                  Name myName = Name(myName: name);
                  Navigator.pushNamed(context, "/page2");
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ваше Имя",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Name {
  String myName;

  Name({this.myName});
}