import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_final_app/countries.dart';
import 'package:taxi_final_app/auth.dart';
import 'package:taxi_final_app/main.dart';

Name myName;
String num;
var transferNumber;
AuthData authCodeData;
String authCode;

class PhonePage extends StatefulWidget {
  PhonePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PhoneNumber createState() => _PhoneNumber();
}

class _PhoneNumber extends State<PhonePage> {
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context).settings;
    myName = settings.arguments;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Введите номер телефона")),
      body: Container(
        margin: EdgeInsets.only(top: 100.0),
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Text(
                "Страна:",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              title: DropDownOptionMenu(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ListTile(
                title: TextField(
                  autofocus: true,
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    prefix: Icon(
                      Icons.add,
                      size: 14,
                    ),
                    labelText: "Номер телефона",
                  ),
                  onSubmitted: (String newNumber) async {
                    num = newNumber;
                    if (num.length == 11) {
                      Number number = Number(number: "+" + num);
                      await loadAuthData(name, "+" + num);
                      transferNumber = "+" + num;
                      Navigator.pushNamed(context, "/page3", arguments: number);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Number {
  final String number;

  Number({this.number});
}
