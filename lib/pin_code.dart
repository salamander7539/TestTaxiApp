import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:taxi_final_app/main.dart';
import 'package:taxi_final_app/pin_auth.dart';
import 'package:taxi_final_app/refresh.dart';

class PinInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String pin;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text(
          "Введите код",
          style: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "Введит код из СМС, который был выслан по номеру \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    color: Colors.white,
                    height: 20,
                  ),
                  PinInputTextField(
                    pinLength: 4,
                    keyboardType: TextInputType.phone,
                    inputFormatter: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: UnderlineDecoration(),
                    onSubmit: (String newPin) async {
                      pin = newPin;
                      int pinCode = int.parse(pin);
                      await loadCode(name, pinCode);
                      await getTokenData(refToken);
                      if (status == 200) {
                          Navigator.pushNamed(context, "/page4");
                        }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Pin {
  final String pinCode;

  Pin({this.pinCode});
}
