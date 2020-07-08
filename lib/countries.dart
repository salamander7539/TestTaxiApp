import 'package:flutter/material.dart';

class DropDownOptionMenu extends StatefulWidget {
  @override
  _DropDownMenu createState() => _DropDownMenu();
}

class _DropDownMenu extends State<DropDownOptionMenu> {
  String dropDownValue = "+7(Россия)";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButton<String>(
      value: dropDownValue,
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropDownValue = newValue;
        });
      },
      items: <String>["+7(Россия)", "+81(Япония)", "+86(Китай)"]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
