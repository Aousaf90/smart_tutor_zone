import 'package:flutter/material.dart';

class WidgetStyle {
  final buttonBoxDecorator = BoxDecoration(
    color: Colors.blueGrey,
  );

  final mainHeading =
      TextStyle(color: Color.fromARGB(250, 239, 238, 238), fontSize: 22);

  final textInputDecorator = InputDecoration(
    focusColor: Colors.white,
    fillColor: Colors.white,
    hintText: "Email",
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(10),
    prefixIcon: Icon(Icons.email_outlined, size: 22),
  );
  NextScreen(context, PageRoute) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => PageRoute),
      ),
    );
  }

  final buttonStyle = ButtonStyle(
    padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: 130, vertical: 20)),
    backgroundColor: MaterialStateColor.resolveWith(
        (states) => Color.fromARGB(255, 41, 65, 202)),
  );
}
