import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_final_app/cancel_order.dart';
import 'package:taxi_final_app/get_order.dart';
import 'package:taxi_final_app/my_address.dart';


import 'dart:async';

class AwaitTaxi extends StatefulWidget {
  @override
  _TaxiState createState() => _TaxiState();
}

class _TaxiState extends State<AwaitTaxi> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Path path;
  var cancelCodeOrder;
  var awaitButton = "Да";
  var orderState = "";

  @override
  Widget build(BuildContext context) {
    RouteSettings routeSettings = ModalRoute.of(context).settings;
    path = routeSettings.arguments;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(
            "Ожидайте такси",
            style: TextStyle(fontSize: 25.0, color: Colors.white),
          )),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.indigo.shade300,
                  ),
                  padding: EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      leading: Icon(
                        Icons.access_time,
                        size: 50,
                      ),
                      title: Text(
                        "Поиск водителя",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      subtitle: Text(
                        "\n$addUnrestricted_value\n~~~~~~~~~~~~~~~~\n$destUnrestricted_value\nСтоимость: $priceData $currencyData.",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 20.0,
            color: Colors.white,
          ),
          Text(
            "Хотите отменить заказ?",
            style: TextStyle(color: Colors.grey.shade800, fontSize: 20.0),
          ),
          Divider(
            height: 20.0,
            color: Colors.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  cancelCodeOrder = await cancelOrder();
                  setState(() {
                    if (cancelCodeOrder == 200) {
                      awaitButton = "Заказ отменен";
                    }
                  });
                },

                textColor: Colors.white,
                color: Colors.indigo.shade400,
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.indigo.shade400),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    awaitButton,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

