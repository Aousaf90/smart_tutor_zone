import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_tutor_zone/AuthenticationPage/LoginPage.dart';
import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
import 'package:smart_tutor_zone/main.dart';
import 'package:smart_tutor_zone/style.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

final studentModel = Student();

class _homePageState extends State<homePage> {
  final String studentName = studentModel.getStudentName();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              child: Text("Hi, $studentName"),
            ),
            Container(
              child: Text("Search Bar"),
            ),
            Container(
              child: Text(
                "Caterogies OPtions ",
              ),
            ),
            Container(
              child: Text(
                "Popular Courses",
              ),
            ),
            Container(
              child: Text(
                "Top Mentor",
              ),
            ),
            ElevatedButton(onPressed: logout, child: Text("Logout"))
          ],
        ),
      ),
    );
  }

  logout() {
    final _auth = FirebaseAuth.instance;
    _auth.signOut();
    helperFunction.deleteStudentData();
    WidgetStyle().NextScreen(context, LoginPage());
  }
}
