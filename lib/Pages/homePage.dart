import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_tutor_zone/AuthenticationPage/LoginPage.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
import 'package:smart_tutor_zone/main.dart';
import 'package:smart_tutor_zone/style.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: logout,
      child: Text("Logout"),
    );
  }

  logout() {
    final _auth = FirebaseAuth.instance;
    _auth.signOut();
    helperFunction.deleteStudentData();
    WidgetStyle().NextScreen(context, LoginPage());
  }
}
